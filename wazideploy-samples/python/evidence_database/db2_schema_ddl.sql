-- *******************************************************************************
-- Licensed Materials - Property of IBM
-- (c) Copyright IBM Corp. 2023, 2025. All Rights Reserved.
--
-- Note to U.S. Government Users Restricted Rights:
-- Use, duplication or disclosure restricted by GSA ADP Schedule
-- Contract with IBM Corp.
-- *******************************************************************************

-- DB2 Evidence Loader - Database Schema
-- This script creates the database structure for storing deployment evidence

-- =============================================================================
-- 1. DEPLOY TABLE (Main deployment information)
-- =============================================================================

CREATE TABLE DEPLOYZ.DEPLOY (
    DEPLOY_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    DESCRIPTION VARCHAR(1000),
    ENVIRONMENT_NAME VARCHAR(255),
    DEPLOY_TIMESTAMP TIMESTAMP,
    CREATION_TIMESTAMP TIMESTAMP,
    STATUS VARCHAR(50),
    ENGINE_VERSION VARCHAR(50),
    ENGINE_BUILD VARCHAR(50),
    ENGINE_DATE TIMESTAMP,
    PACKAGE_PATH VARCHAR(500),
    PACKAGE_SHA256 VARCHAR(64),
    PRIMARY KEY (DEPLOY_ID)
);

COMMENT ON TABLE DEPLOYZ.DEPLOY IS 'Main deployment records';
COMMENT ON COLUMN DEPLOYZ.DEPLOY.DEPLOY_ID IS 'Unique deployment identifier';
COMMENT ON COLUMN DEPLOYZ.DEPLOY.PACKAGE_PATH IS 'Full path to the artifact';

-- =============================================================================
-- 2. ACTIVITY TABLE
-- =============================================================================

CREATE TABLE DEPLOYZ.ACTIVITY (
    ACTIVITY_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    DEPLOY_ID INTEGER NOT NULL,
    ACTIVITY_NAME VARCHAR(255),
    SHORT_NAME VARCHAR(100),
    DESCRIPTION VARCHAR(1000),
    STATUS VARCHAR(50),
    MESSAGE VARCHAR(2000),
    PRIMARY KEY (ACTIVITY_ID),
    FOREIGN KEY (DEPLOY_ID) REFERENCES DEPLOYZ.DEPLOY(DEPLOY_ID) ON DELETE CASCADE
);

CREATE INDEX DEPLOYZ.IDX_ACTIVITY_DEPLOY ON DEPLOYZ.ACTIVITY(DEPLOY_ID);

COMMENT ON TABLE DEPLOYZ.ACTIVITY IS 'Deployment activities';

-- =============================================================================
-- 3. ACTION TABLE
-- =============================================================================

CREATE TABLE DEPLOYZ.ACTION (
    ACTION_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ACTIVITY_ID INTEGER NOT NULL,
    ACTION_NAME VARCHAR(255),
    DESCRIPTION VARCHAR(1000),
    STATUS VARCHAR(50),
    MESSAGE VARCHAR(2000),
    PRIMARY KEY (ACTION_ID),
    FOREIGN KEY (ACTIVITY_ID) REFERENCES DEPLOYZ.ACTIVITY(ACTIVITY_ID) ON DELETE CASCADE
);

CREATE INDEX DEPLOYZ.IDX_ACTION_ACTIVITY ON DEPLOYZ.ACTION(ACTIVITY_ID);

COMMENT ON TABLE DEPLOYZ.ACTION IS 'Deployment actions';

-- =============================================================================
-- 4. STEP TABLE
-- =============================================================================

CREATE TABLE DEPLOYZ.STEP (
    STEP_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ACTION_ID INTEGER NOT NULL,
    STEP_NAME VARCHAR(255),
    DESCRIPTION VARCHAR(1000),
    STATUS VARCHAR(50),
    MESSAGE VARCHAR(2000),
    PRIMARY KEY (STEP_ID),
    FOREIGN KEY (ACTION_ID) REFERENCES DEPLOYZ.ACTION(ACTION_ID) ON DELETE CASCADE
);

CREATE INDEX DEPLOYZ.IDX_STEP_ACTION ON DEPLOYZ.STEP(ACTION_ID);

COMMENT ON TABLE DEPLOYZ.STEP IS 'Deployment steps';

-- =============================================================================
-- 5. ARTIFACT TABLE (Unique artifacts by PATH)
-- =============================================================================

CREATE TABLE DEPLOYZ.ARTIFACT (
    ARTIFACT_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ARTIFACT_NAME VARCHAR(255),
    ARTIFACT_PATH VARCHAR(1000) NOT NULL,
    ARTIFACT_TYPE VARCHAR(100),
    PRIMARY KEY (ARTIFACT_ID),
    CONSTRAINT UQ_ARTIFACT_PATH UNIQUE (ARTIFACT_PATH)
);

CREATE UNIQUE INDEX DEPLOYZ.IDX_ARTIFACT_PATH ON DEPLOYZ.ARTIFACT(ARTIFACT_PATH);

COMMENT ON TABLE DEPLOYZ.ARTIFACT IS 'Unique artifacts identified by their path';
COMMENT ON COLUMN DEPLOYZ.ARTIFACT.ARTIFACT_PATH IS 'Unique path to the artifact (enforces uniqueness)';

-- =============================================================================
-- 6. STEP_ARTIFACT TABLE (Many-to-Many relationship)
-- =============================================================================

CREATE TABLE DEPLOYZ.STEP_ARTIFACT (
    STEP_ID INTEGER NOT NULL,
    ARTIFACT_ID INTEGER NOT NULL,
    PRIMARY KEY (STEP_ID, ARTIFACT_ID),
    FOREIGN KEY (STEP_ID) REFERENCES DEPLOYZ.STEP(STEP_ID) ON DELETE CASCADE,
    FOREIGN KEY (ARTIFACT_ID) REFERENCES DEPLOYZ.ARTIFACT(ARTIFACT_ID) ON DELETE CASCADE
);

CREATE INDEX DEPLOYZ.IDX_STEP_ARTIFACT_STEP ON DEPLOYZ.STEP_ARTIFACT(STEP_ID);
CREATE INDEX DEPLOYZ.IDX_STEP_ARTIFACT_ARTIFACT ON DEPLOYZ.STEP_ARTIFACT(ARTIFACT_ID);

COMMENT ON TABLE DEPLOYZ.STEP_ARTIFACT IS 'Junction table linking steps to artifacts (many-to-many)';

-- =============================================================================
-- 7. PROPERTIES TABLE (Generic key-value properties)
-- =============================================================================

CREATE TABLE DEPLOYZ.PROPERTIES (
    PROPERTY_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ENTITY_TYPE VARCHAR(50) NOT NULL,
    ENTITY_ID INTEGER NOT NULL,
    PROPERTY_KEY VARCHAR(255) NOT NULL,
    PROPERTY_VALUE VARCHAR(4000),
    PRIMARY KEY (PROPERTY_ID)
);

CREATE INDEX DEPLOYZ.IDX_PROPERTIES_ENTITY ON DEPLOYZ.PROPERTIES(ENTITY_TYPE, ENTITY_ID);
CREATE INDEX DEPLOYZ.IDX_PROPERTIES_KEY ON DEPLOYZ.PROPERTIES(PROPERTY_KEY);

COMMENT ON TABLE DEPLOYZ.PROPERTIES IS 'Generic properties for activities, actions, and steps';
COMMENT ON COLUMN DEPLOYZ.PROPERTIES.ENTITY_TYPE IS 'Type of entity: ACTIVITY, ACTION, or STEP';
COMMENT ON COLUMN DEPLOYZ.PROPERTIES.ENTITY_ID IS 'ID of the related entity';

ALTER TABLE DEPLOYZ.PROPERTIES
ADD CONSTRAINT CK_PROPERTIES_ENTITY_TYPE 
CHECK (ENTITY_TYPE IN ('ACTIVITY', 'ACTION', 'STEP', 'ARTIFACT'));

-- =============================================================================
-- 8. STEP_RESULT_DETAIL TABLE
-- =============================================================================

CREATE TABLE DEPLOYZ.STEP_RESULT_DETAIL (
    RESULT_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    STEP_ID INTEGER NOT NULL,
    STATUS VARCHAR(50),
    MESSAGE VARCHAR(2000),
    COMMAND VARCHAR(4000),
    RESULT_COMMAND VARCHAR(4000),
    PRIMARY KEY (RESULT_ID),
    FOREIGN KEY (STEP_ID) REFERENCES DEPLOYZ.STEP(STEP_ID) ON DELETE CASCADE
);

CREATE INDEX DEPLOYZ.IDX_RESULT_STEP ON DEPLOYZ.STEP_RESULT_DETAIL(STEP_ID);

COMMENT ON TABLE DEPLOYZ.STEP_RESULT_DETAIL IS 'Detailed results for each step';

-- =============================================================================
-- VIEWS FOR EASIER QUERYING
-- =============================================================================

-- View: All artifacts with their usage count
CREATE VIEW DEPLOYZ.V_ARTIFACT_USAGE AS
SELECT 
    a.ARTIFACT_ID,
    a.ARTIFACT_NAME,
    a.ARTIFACT_PATH,
    a.ARTIFACT_TYPE,
    COUNT(DISTINCT sa.STEP_ID) AS USAGE_COUNT
FROM DEPLOYZ.ARTIFACT a
LEFT JOIN DEPLOYZ.STEP_ARTIFACT sa ON a.ARTIFACT_ID = sa.ARTIFACT_ID
GROUP BY a.ARTIFACT_ID, a.ARTIFACT_NAME, a.ARTIFACT_PATH, a.ARTIFACT_TYPE;

-- View: Complete deployment hierarchy
CREATE VIEW DEPLOYZ.V_DEPLOYMENT_HIERARCHY AS
SELECT 
    d.DEPLOY_ID,
    d.ENVIRONMENT_NAME,
    d.DEPLOY_TIMESTAMP,
    d.STATUS AS DEPLOY_STATUS,
    act.ACTIVITY_ID,
    act.ACTIVITY_NAME,
    act.STATUS AS ACTIVITY_STATUS,
    a.ACTION_ID,
    a.ACTION_NAME,
    a.STATUS AS ACTION_STATUS,
    s.STEP_ID,
    s.STEP_NAME,
    s.STATUS AS STEP_STATUS
FROM DEPLOYZ.DEPLOY d
LEFT JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
LEFT JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
LEFT JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID;

-- View: Steps with their artifacts
CREATE VIEW DEPLOYZ.V_STEP_ARTIFACTS AS
SELECT 
    s.STEP_ID,
    s.STEP_NAME,
    s.STATUS AS STEP_STATUS,
    art.ARTIFACT_ID,
    art.ARTIFACT_NAME,
    art.ARTIFACT_PATH,
    art.ARTIFACT_TYPE
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
INNER JOIN DEPLOYZ.ARTIFACT art ON sa.ARTIFACT_ID = art.ARTIFACT_ID;


-- =============================================================================
-- SAMPLE QUERIES
-- =============================================================================

-- Find all deployments for a specific environment
-- SELECT * FROM DEPLOYZ.DEPLOY WHERE ENVIRONMENT_NAME = 'PRODUCTION';

-- Find all artifacts used more than once (shared artifacts)
-- SELECT * FROM DEPLOYZ.V_ARTIFACT_USAGE WHERE USAGE_COUNT > 1;

-- Find all steps that use a specific artifact
-- SELECT s.* 
-- FROM DEPLOYZ.STEP s
-- INNER JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
-- INNER JOIN DEPLOYZ.ARTIFACT a ON sa.ARTIFACT_ID = a.ARTIFACT_ID
-- WHERE a.ARTIFACT_PATH = '/path/to/artifact';

-- Find deployment hierarchy for specific deploy
-- SELECT * FROM DEPLOYZ.V_DEPLOYMENT_HIERARCHY WHERE DEPLOY_ID = 1;

-- =============================================================================
-- GRANTS (adjust as needed for your security model)
-- =============================================================================

-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.DEPLOY TO USER deployer;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.ACTIVITY TO USER deployer;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.ACTION TO USER deployer;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.STEP TO USER deployer;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.ARTIFACT TO USER deployer;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.STEP_ARTIFACT TO USER deployer;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.PROPERTIES TO USER deployer;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON DEPLOYZ.STEP_RESULT_DETAIL TO USER deployer;

-- =============================================================================
-- END OF SCHEMA
-- =============================================================================
