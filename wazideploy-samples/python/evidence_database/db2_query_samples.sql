-- =============================================================================
-- QUERY EXAMPLES TO RETRIEVE ACTIVITIES WITH A SPECIFIC TAG
-- =============================================================================

-- ============================================================================
-- EXAMPLE 1: Simple query - Activities with tag "db2"
-- ============================================================================
SELECT DISTINCT 
    a.ACTIVITY_ID,
    a.ACTIVITY_NAME,
    a.SHORT_NAME,
    a.STATUS,
    a.MESSAGE
FROM DEPLOYZ.ACTIVITY a
INNER JOIN DEPLOYZ.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
INNER JOIN DEPLOYZ.TAG t ON at.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'db2'
ORDER BY a.ACTIVITY_ID;


-- ============================================================================
-- EXAMPLE 2: Activities with tag "cics" AND their associated tags (view)
-- ============================================================================
SELECT 
    a.ACTIVITY_ID,
    a.ACTIVITY_NAME,
    a.SHORT_NAME,
    a.STATUS,
    v.TAGS
FROM DEPLOYZ.ACTIVITY a
INNER JOIN DEPLOYZ.V_ACTIVITY_TAGS v ON a.ACTIVITY_ID = v.ACTIVITY_ID
INNER JOIN DEPLOYZ.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
INNER JOIN DEPLOYZ.TAG t ON at.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'cics'
ORDER BY a.ACTIVITY_ID;


-- ============================================================================
-- EXAMPLE 3: Activities with tag "cics" + complete info (deploy)
-- ============================================================================
SELECT DISTINCT
    d.DEPLOY_ID,
    d.APPLICATION_NAME,
    d.ENVIRONMENT_NAME,
    d.DEPLOY_TIMESTAMP,
    a.ACTIVITY_ID,
    a.ACTIVITY_NAME,
    a.SHORT_NAME,
    a.STATUS,
    a.MESSAGE
FROM DEPLOYZ.DEPLOY d
INNER JOIN DEPLOYZ.ACTIVITY a ON d.DEPLOY_ID = a.DEPLOY_ID
INNER JOIN DEPLOYZ.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
INNER JOIN DEPLOYZ.TAG t ON at.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'cics'
ORDER BY d.DEPLOY_ID, a.ACTIVITY_ID;


-- ============================================================================
-- EXAMPLE 4: Count the number of activities with tag "cics"
-- ============================================================================
SELECT COUNT(DISTINCT a.ACTIVITY_ID) AS ACTIVITIES_COUNT
FROM DEPLOYZ.ACTIVITY a
INNER JOIN DEPLOYZ.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
INNER JOIN DEPLOYZ.TAG t ON at.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'cics';


-- ============================================================================
-- EXAMPLE 5: Activities with MULTIPLE tags ("package" AND "full")
-- ============================================================================
SELECT DISTINCT 
    a.ACTIVITY_ID,
    a.ACTIVITY_NAME,
    a.SHORT_NAME,
    v.TAGS
FROM DEPLOYZ.ACTIVITY a
INNER JOIN DEPLOYZ.V_ACTIVITY_TAGS v ON a.ACTIVITY_ID = v.ACTIVITY_ID
WHERE a.ACTIVITY_ID IN (
    SELECT DISTINCT a2.ACTIVITY_ID
    FROM DEPLOYZ.ACTIVITY a2
    INNER JOIN DEPLOYZ.ACTIVITY_TAG at2 ON a2.ACTIVITY_ID = at2.ACTIVITY_ID
    INNER JOIN DEPLOYZ.TAG t2 ON at2.TAG_ID = t2.TAG_ID
    WHERE t2.TAG_NAME = 'package'
)
AND a.ACTIVITY_ID IN (
    SELECT DISTINCT a3.ACTIVITY_ID
    FROM DEPLOYZ.ACTIVITY a3
    INNER JOIN DEPLOYZ.ACTIVITY_TAG at3 ON a3.ACTIVITY_ID = at3.ACTIVITY_ID
    INNER JOIN DEPLOYZ.TAG t3 ON at3.TAG_ID = t3.TAG_ID
    WHERE t3.TAG_NAME = 'full'
)
ORDER BY a.ACTIVITY_ID;


-- ============================================================================
-- EXAMPLE 6: Activities with tag "db2" + their actions and steps
-- ============================================================================
SELECT DISTINCT
    a.ACTIVITY_ID,
    a.ACTIVITY_NAME,
    a.SHORT_NAME,
    a.STATUS,
    ac.ACTION_ID,
    ac.ACTION_NAME,
    ac.SHORT_NAME AS ACTION_SHORT_NAME,
    s.STEP_ID,
    s.STEP_NAME,
    s.SHORT_NAME AS STEP_SHORT_NAME
FROM DEPLOYZ.ACTIVITY a
INNER JOIN DEPLOYZ.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
INNER JOIN DEPLOYZ.TAG t ON at.TAG_ID = t.TAG_ID
LEFT JOIN DEPLOYZ.ACTION ac ON a.ACTIVITY_ID = ac.ACTIVITY_ID
LEFT JOIN DEPLOYZ.STEP s ON ac.ACTION_ID = s.ACTION_ID
WHERE t.TAG_NAME = 'db2'
ORDER BY a.ACTIVITY_ID, ac.ACTION_ID, s.STEP_ID;


-- ============================================================================
-- EXAMPLE 7: All activities with tag "db2" by application and environment
-- ============================================================================
SELECT DISTINCT
    d.APPLICATION_NAME,
    d.ENVIRONMENT_NAME,
    COUNT(DISTINCT a.ACTIVITY_ID) AS ACTIVITY_COUNT,
    LISTAGG(DISTINCT a.ACTIVITY_NAME, ', ') WITHIN GROUP (ORDER BY a.ACTIVITY_NAME) AS ACTIVITIES
FROM DEPLOYZ.DEPLOY d
INNER JOIN DEPLOYZ.ACTIVITY a ON d.DEPLOY_ID = a.DEPLOY_ID
INNER JOIN DEPLOYZ.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
INNER JOIN DEPLOYZ.TAG t ON at.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'db2'
GROUP BY d.APPLICATION_NAME, d.ENVIRONMENT_NAME
ORDER BY d.APPLICATION_NAME, d.ENVIRONMENT_NAME;


-- ============================================================================
-- EXAMPLE 8: Activities with tag "db2" and all their tags
-- ============================================================================
SELECT DISTINCT 
    a.ACTIVITY_ID,
    a.ACTIVITY_NAME,
    a.SHORT_NAME,
    a.STATUS,
    a.MESSAGE
FROM DEPLOYZ.ACTIVITY a
INNER JOIN DEPLOYZ.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
INNER JOIN DEPLOYZ.TAG t ON at.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'db2'
ORDER BY a.ACTIVITY_ID;


-- =============================================================================
-- QUERY EXAMPLES TO RETRIEVE STEPS WITH A SPECIFIC TAG
-- =============================================================================

-- ============================================================================
-- EXAMPLE 1: Simple query - Steps with tag "XX"
-- ============================================================================
SELECT DISTINCT 
    s.STEP_ID,
    s.STEP_NAME,
    s.SHORT_NAME,
    s.STATUS,
    s.MESSAGE
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.STEP_TAG st ON s.STEP_ID = st.STEP_ID
INNER JOIN DEPLOYZ.TAG t ON st.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'XX'
ORDER BY s.STEP_ID;


-- ============================================================================
-- EXAMPLE 2: Steps with tag "XX" AND their associated tags (view)
-- ============================================================================
SELECT 
    s.STEP_ID,
    s.STEP_NAME,
    s.SHORT_NAME,
    s.STATUS,
    v.TAGS
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.V_STEP_TAGS v ON s.STEP_ID = v.STEP_ID
INNER JOIN DEPLOYZ.STEP_TAG st ON s.STEP_ID = st.STEP_ID
INNER JOIN DEPLOYZ.TAG t ON st.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'XX'
ORDER BY s.STEP_ID;


-- ============================================================================
-- EXAMPLE 3: Steps with tag "XX" + complete info (action, activity, deploy)
-- ============================================================================
SELECT DISTINCT
    d.DEPLOY_ID,
    d.APPLICATION_NAME,
    d.ENVIRONMENT_NAME,
    act.ACTIVITY_ID,
    act.ACTIVITY_NAME,
    a.ACTION_ID,
    a.ACTION_NAME,
    s.STEP_ID,
    s.STEP_NAME,
    s.SHORT_NAME,
    s.STATUS,
    s.MESSAGE
FROM DEPLOYZ.DEPLOY d
INNER JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
INNER JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
INNER JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
INNER JOIN DEPLOYZ.STEP_TAG st ON s.STEP_ID = st.STEP_ID
INNER JOIN DEPLOYZ.TAG t ON st.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'XX'
ORDER BY d.DEPLOY_ID, act.ACTIVITY_ID, a.ACTION_ID, s.STEP_ID;


-- ============================================================================
-- EXAMPLE 4: Count the number of steps with tag "XX"
-- ============================================================================
SELECT COUNT(DISTINCT s.STEP_ID) AS STEPS_COUNT
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.STEP_TAG st ON s.STEP_ID = st.STEP_ID
INNER JOIN DEPLOYZ.TAG t ON st.TAG_ID = t.TAG_ID
WHERE t.TAG_NAME = 'XX';


-- ============================================================================
-- EXAMPLE 5: Steps with MULTIPLE tags ("XX" AND "YY")
-- ============================================================================
SELECT DISTINCT 
    s.STEP_ID,
    s.STEP_NAME,
    s.SHORT_NAME,
    v.TAGS
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.V_STEP_TAGS v ON s.STEP_ID = v.STEP_ID
WHERE s.STEP_ID IN (
    SELECT DISTINCT s2.STEP_ID
    FROM DEPLOYZ.STEP s2
    INNER JOIN DEPLOYZ.STEP_TAG st2 ON s2.STEP_ID = st2.STEP_ID
    INNER JOIN DEPLOYZ.TAG t2 ON st2.TAG_ID = t2.TAG_ID
    WHERE t2.TAG_NAME = 'XX'
)
AND s.STEP_ID IN (
    SELECT DISTINCT s3.STEP_ID
    FROM DEPLOYZ.STEP s3
    INNER JOIN DEPLOYZ.STEP_TAG st3 ON s3.STEP_ID = st3.STEP_ID
    INNER JOIN DEPLOYZ.TAG t3 ON st3.TAG_ID = t3.TAG_ID
    WHERE t3.TAG_NAME = 'YY'
)
ORDER BY s.STEP_ID;


-- ============================================================================
-- EXAMPLE 6: Steps with tag "XX" + their artifacts
-- ============================================================================
SELECT DISTINCT
    s.STEP_ID,
    s.STEP_NAME,
    s.SHORT_NAME,
    s.STATUS,
    art.ARTIFACT_ID,
    art.ARTIFACT_NAME,
    art.ARTIFACT_PATH,
    art.ARTIFACT_TYPE
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.STEP_TAG st ON s.STEP_ID = st.STEP_ID
INNER JOIN DEPLOYZ.TAG t ON st.TAG_ID = t.TAG_ID
LEFT JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
LEFT JOIN DEPLOYZ.ARTIFACT art ON sa.ARTIFACT_ID = art.ARTIFACT_ID
WHERE t.TAG_NAME = 'XX'
ORDER BY s.STEP_ID, art.ARTIFACT_ID;


-- ============================================================================
-- EXAMPLE 7: All available tags
-- ============================================================================
SELECT DISTINCT TAG_ID, TAG_NAME
FROM DEPLOYZ.TAG
ORDER BY TAG_NAME;


-- ============================================================================
-- EXAMPLE 8: Steps with tag "XX" and their results
-- ============================================================================
SELECT DISTINCT
    s.STEP_ID,
    s.STEP_NAME,
    s.SHORT_NAME,
    s.STATUS,
    srd.RESULT_ID,
    srd.STATUS AS RESULT_STATUS,
    srd.MESSAGE,
    srd.COMMAND
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.STEP_TAG st ON s.STEP_ID = st.STEP_ID
INNER JOIN DEPLOYZ.TAG t ON st.TAG_ID = t.TAG_ID
LEFT JOIN DEPLOYZ.STEP_RESULT_DETAIL srd ON s.STEP_ID = srd.STEP_ID
WHERE t.TAG_NAME = 'XX'
ORDER BY s.STEP_ID, srd.RESULT_ID;



-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- Shows all artifacts with their current state in production
-- =============================================================================

-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- MEMBER_DELETE step is PRIORITAIRE: if an artifact ever appears in MEMBER_DELETE,
-- it's considered DELETED regardless of other steps
-- =============================================================================

-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- MEMBER_DELETE step is PRIORITAIRE: if an artifact ever appears in MEMBER_DELETE,
-- it's considered DELETED regardless of other steps
-- =============================================================================
-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- MEMBER_DELETE step is PRIORITAIRE: if an artifact ever appears in MEMBER_DELETE,
-- it's considered DELETED regardless of other steps
-- =============================================================================

-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- MEMBER_DELETE step is PRIORITAIRE: if an artifact ever appears in MEMBER_DELETE,
-- it's considered DELETED regardless of other steps
-- =============================================================================

-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- MEMBER_DELETE step is PRIORITAIRE: if an artifact ever appears in MEMBER_DELETE,
-- it's considered DELETED regardless of other steps
-- =============================================================================

-- First, let's check what data we have
-- Uncomment to debug:
-- SELECT COUNT(*) AS TOTAL_ARTIFACTS FROM DEPLOYZ.ARTIFACT;
-- SELECT COUNT(*) AS ARTIFACT_LINKS FROM DEPLOYZ.STEP_ARTIFACT;
-- SELECT COUNT(*) AS DEPLOYMENTS_IN_PROD FROM DEPLOYZ.DEPLOY WHERE ENVIRONMENT_NAME = 'production';

-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- MEMBER_DELETE step is PRIORITAIRE: if an artifact ever appears in MEMBER_DELETE,
-- it's considered DELETED regardless of other steps
-- =============================================================================

-- First, let's check what data we have
-- Uncomment to debug:
-- SELECT COUNT(*) AS TOTAL_ARTIFACTS FROM DEPLOYZ.ARTIFACT;
-- SELECT COUNT(*) AS ARTIFACT_LINKS FROM DEPLOYZ.STEP_ARTIFACT;
-- SELECT COUNT(*) AS DEPLOYMENTS_IN_PROD FROM DEPLOYZ.DEPLOY WHERE ENVIRONMENT_NAME = 'production';

-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- MEMBER_DELETE can be overridden by later DEPLOYED steps
-- Logic: Last action on each artifact determines its status
-- =============================================================================

-- =============================================================================
-- Production Artifacts - MEMBER_DELETE has priority except if MEMBER_COPY after
-- Logic: 
--   1. If MEMBER_COPY appears after MEMBER_DELETE -> DEPLOYED
--   2. If MEMBER_DELETE appears and no MEMBER_COPY after -> DELETED
--   3. Otherwise -> DEPLOYED (based on last action)
-- =============================================================================

-- =============================================================================
-- Production Artifacts - MEMBER_DELETE has priority except if MEMBER_COPY after
-- Logic based on BUILDING_BLOC field:
--   1. If MEMBER_COPY appears after MEMBER_DELETE -> DEPLOYED
--   2. If MEMBER_DELETE appears and no MEMBER_COPY after -> DELETED
--   3. Otherwise -> DEPLOYED (based on last action)
-- =============================================================================

WITH ARTIFACT_TIMELINE AS (
    -- Get ALL actions on artifacts with their chronological order
    SELECT 
        art.ARTIFACT_ID,
        art.ARTIFACT_NAME,
        art.ARTIFACT_PATH,
        art.ARTIFACT_TYPE,
        d.APPLICATION_NAME,
        d.DEPLOY_ID,
        d.DEPLOY_TIMESTAMP,
        s.STEP_NAME,
        s.BUILDING_BLOC,
        CASE 
            WHEN s.BUILDING_BLOC = 'MEMBER_DELETE' THEN 'DELETED'
            ELSE 'DEPLOYED'
        END AS ACTION_TYPE,
        ROW_NUMBER() OVER (
            PARTITION BY art.ARTIFACT_ID 
            ORDER BY d.DEPLOY_TIMESTAMP DESC
        ) AS RECENCY_RANK
    FROM DEPLOYZ.DEPLOY d
    INNER JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
    INNER JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
    INNER JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
    INNER JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
    INNER JOIN DEPLOYZ.ARTIFACT art ON sa.ARTIFACT_ID = art.ARTIFACT_ID
    WHERE d.ENVIRONMENT_NAME = 'PROD'
),
ARTIFACT_STATUS AS (
    SELECT 
        APPLICATION_NAME,
        ARTIFACT_ID,
        ARTIFACT_NAME,
        ARTIFACT_PATH,
        ARTIFACT_TYPE,
        DEPLOY_TIMESTAMP AS LAST_ACTION_DATE,
        BUILDING_BLOC AS LAST_BUILDING_BLOC,
        -- Check if MEMBER_DELETE exists for this artifact
        MAX(CASE WHEN ACTION_TYPE = 'DELETED' THEN 1 ELSE 0 END) OVER (PARTITION BY ARTIFACT_ID) AS HAS_MEMBER_DELETE,
        -- Check if MEMBER_COPY appears AFTER MEMBER_DELETE
        MAX(CASE WHEN BUILDING_BLOC = 'MEMBER_COPY' AND ACTION_TYPE = 'DEPLOYED' THEN 1 ELSE 0 END) OVER (
            PARTITION BY ARTIFACT_ID 
            ORDER BY DEPLOY_TIMESTAMP DESC 
            ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
        ) AS HAS_MEMBER_COPY_AFTER_DELETE
    FROM ARTIFACT_TIMELINE
    WHERE RECENCY_RANK = 1
)
SELECT 
    APPLICATION_NAME,
    ARTIFACT_ID,
    ARTIFACT_NAME,
    ARTIFACT_PATH,
    ARTIFACT_TYPE,
    CASE 
        WHEN HAS_MEMBER_DELETE = 1 AND HAS_MEMBER_COPY_AFTER_DELETE = 0 THEN 'DELETED'
        ELSE 'DEPLOYED'
    END AS STATUS,
    LAST_ACTION_DATE,
    LAST_BUILDING_BLOC
FROM ARTIFACT_STATUS
ORDER BY 
    APPLICATION_NAME,
    CASE 
        WHEN HAS_MEMBER_DELETE = 1 AND HAS_MEMBER_COPY_AFTER_DELETE = 0 THEN 1 
        ELSE 0 
    END DESC,
    ARTIFACT_NAME;