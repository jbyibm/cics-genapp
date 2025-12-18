# DB2 Evidence Loader

Python tool to load YAML evidence files into a DB2 database.

**NOTES**:
- In the guide we is fro using Db2 for z/OS only.
- The Python source code, DB2 schema, and configuration files are mentioned solely as example use cases. They should not be interpreted as any form of design commitment.
- This this sample code that may contains issues. Not to use in production.

## Table of Contents

- [Architecture](#architecture)
- [File Structure](#file-structure)
- [Database Schema](#database-schema)
- [Database Setup](#database-setup)
- [Installation and Configuration of the CLI](#installation-and-configuration-of-the-cli)
  - [IBM DB Driver](#ibm-db-driver)
  - [JDBC Driver](#jdbc-driver)
- [CLI Usage](#cli-usage)
  - [Configuration File](#configuration-file)
  - [Using IBM DB Driver](#using-ibm-db-driver)
  - [Using JDBC Driver](#using-jdbc-driver)
- [Querying Samples](#querying-samples)
- [Driver Comparison](#driver-comparison)
- [Additional Resources](#additional-resources)
- [License](#license)

---

## Architecture

The project uses a **Template Method** pattern with:
- **`DB2EvidenceLoaderBase`**: Abstract class containing all business logic
- **`DB2EvidenceLoaderIBM`**: Implementation using `ibm_db` driver
- **`DB2EvidenceLoaderJDBC`**: Implementation using `JayDeBeApi` (JDBC) driver
- **`DB2EvidenceLoaderClient`**: Implementation of the client line command (CLI)

### Artifact Uniqueness

**Important**: Artifacts are identified by their **PATH** (unique constraint):
- Same artifact path = same artifact (reused across multiple steps)
- Many-to-many relationship between STEP and ARTIFACT via `STEP_ARTIFACT` junction table
- When an artifact with the same path is encountered, the existing artifact is linked instead of creating a duplicate

---

## File Structure

```
project/

 db2_config.yaml           # Configuration file (REQUIRED)
 db2_config.py             # Configuration loader
 db2_evidence_base.py      # Abstract base class
 db2_evidence_ibm.py       # IBM DB implementation
 db2_evidence_jdbc.py      # JDBC implementation
 db2_schema_ddl_zos.sql    # Database schema DDL for DB2 z/OS
 db2_evidence_client.py      # Loader CLI
 README.md                 # This file
```

## Database Schema

The database uses the following structure:

```
DEPLOY (1) -> ACTIVITY (N) -> ACTION (N) -> STEP (N)
                                                  | 
             -> PROPERTIES      -> PROPERTIES   | -> STEP_ARTIFACT (junction)
                                                    -> PROPERTIES  |
                                                                     -> ARTIFACT (unique by PATH)
                                                                            -> PROPERTIES
```

**Key Points:**
- **ARTIFACT** table stores unique artifacts identified by `ARTIFACT_PATH` for a given application name
- **STEP_ARTIFACT** junction table creates many-to-many relationship
- Same artifact can be used by multiple steps (no duplication)
- Constraint: `UNIQUE (ARTIFACT_PATH)` ensures artifact uniqueness


## Database Setup

To correctly use a the evidence loader with Db2 for z/OS®, a Db2 storage group and a Db2 database must be created. After the tables are created in the Db2 database, users must be granted to access these tables.

### Create the Db2 storage group and the Db2 database

To do so, you can use the `db2_schema_ddl_zos.sql` script, which is available. This script contains sample commented `CREATE STOGROUP` and `CREATE DATABASE` statements that you can uncomment from the script (if you plan to run this script for the tables creation) or extract from the script and run manually.

The following items give guidelines on how to customize the provided commands:

####  Create a storage group

```sql
CREATE STOGROUP <storage group name> VOLUMES ('*') VCAT <HLQ name>;
```

In this command, specify the following parameters:
* The storage group name.
* The name of the high-level qualifier of your Db2 files. This qualifier must exist on your system, and the the evidence loader user must have full access to it.

#### Create the database statements

To create the database statements, enter the following command.

You must create the database with UNICODE as the CCSID. The following example shows Db2 SQL `create` statements:

```sql
CREATE DATABASE <database name> STOGROUP <storage group name> BUFFERPOOL <buffer pool name> CCSID UNICODE;  
COMMIT;
```

In this command, specify the following parameters:
* The database name. This name is used during table creation so the script must be changed to match.
* The storage group name.
* The buffer pool name. On z/OS, a 16 K page size or larger is required. This buffer pool is used for creating tables. Table spaces are created in the default 16 K buffer pool, unless you selected a larger buffer pool.

#### Create the Db2 tables required by the evidence loader

The minimum authority to create the tables and indexes in the next step requires `DBADM` access to the database and `USE` access to the storage group.

```sql
GRANT USE OF STOGROUP <storage group name> TO <loaderuser>;
GRANT DBADM ON DATABASE <database name> TO <loaderuser>;
```

#### Grant Db2 authorizations to the evidence loader tables

It is recommended to set the minimum authority for users to access the database, which requires DELETE, INSERT, SELECT, and UPDATE on the database tables.


## Installation and Configuration of the CLI

### IBM DB Driver

#### About ibm_db

**ibm_db** is a Python driver that provides interfaces for connecting to IBM Db2 databases for both LUW (Linux, Unix, Windows) and z/OS platforms. It uses the IBM Data Server Driver for ODBC and CLI APIs and includes **ibm_db_dbi**, a Python DB-API 2.0 compliant driver. The package supports SSL connections, various authentication methods, and both synchronous and asynchronous operations for database interactions.

<blockquote>
<strong>⚠️ NOTE</strong><br>
<ul><li>This is the highly recommended option.</li><ul>
</blockquote>

#### Installation on z/OS

For z/OS systems, **ibm_db** requires IBM Python (3.9+) and a properly configured ODBC driver. The ODBC driver must be set up with bound packages (using the DSNTIJCL JCL from SDSNSAMP), and PTFs UI72588 (v11) or UI72589 (v12) must be applied. Environment variables `IBM_DB_HOME` (Db2 HLQ) and `DSNAOINI` (path to odbc.ini configuration file) must be defined. Refer to the [IBM Db2 for z/OS ODBC Guide](https://www.ibm.com/docs/en/SSEPEK_12.0.0/pdf/db2z_12_odbcbook.pdf) for detailed ODBC configuration instructions.

#### Prerequisites

- **Python**: 3.9+

#### Installation

```bash
pip install ibm_db
```

#### Useful Links

- **Official Documentation**: https://github.com/ibmdb/python-ibmdb
- **Official Documentation for z/OS**: https://github.com/ibmdb/python-ibmdb/blob/master/INSTALL.md#inszos
- **API Reference**: https://github.com/ibmdb/python-ibmdb/wiki/APIs
- **Installation Guide**: https://github.com/ibmdb/python-ibmdb#installation
- **Troubleshooting** (usefull for z/OS DB2 support): https://github.com/ibmdb/python-ibmdb/blob/master/README.md#troubleshooting


---

### JDBC Driver

#### About JayDeBeApi

**JayDeBeApi** is a Python module that enables database connectivity using Java JDBC drivers, providing a Python DB-API v2.0 compliant interface. It works with both CPython (via JPype for Java integration) and Jython, allowing unified database access across different Python implementations. The module supports any database with a JDBC driver, requiring only the driver class name, JDBC URL, credentials, and JAR file path. Unlike native drivers like ibm_db, JayDeBeApi offers cross-platform compatibility through JDBC and can connect to any database that has a Java JDBC driver available.



#### Prerequisites

- **IDM Java JDK**: version 8. 
    - **⚠️ NOTE:** Only this version works on z/OS.
- **Python**: 3.9+
- **JAR File**: `db2jcc4.jar` and `db2jcc_license_cisuz.jar`


#### Installation

**For z/OS See:** [Python(R) AI Toolkit for IBM(R) z/OS(R)](https://ibm-z-oss-oda.github.io/python_ai_toolkit_zos/)

```bash
pip install jaydebeapi --index-url https://downloads.pyaitoolkit.ibm.net:443/repository/python_ai_toolkit_zos/simple

```

#### Configuration

1. **Download DB2 JDBC Driver**
   - Download `db2jcc4.jar` from: [IBM Data Server Driver for JDBC](https://www.ibm.com/support/pages/db2-jdbc-driver-versions-and-downloads)
   - Or extract from DB2 installation: `<DB2_HOME>/java/db2jcc4.jar`
   - Save to an accessible directory (e.g., `/u/ibmuser/db2jcc4.jar`)
   - You also need `db2jcc_license_cisuz.jar`. It sould be on you z/OS: `<DB2_HOME>/java/db2jcc_license_cisuz.jar`
   - Save to an accessible directory (e.g., `/u/ibmuser/db2jcc_license_cisuz.jar`)

#### Useful Links

- **JayDeBeApi Documentation**: https://github.com/baztian/jaydebeapi
- **JPype1 Documentation**: https://jpype.readthedocs.io/
- **DB2 JDBC Driver**: https://www.ibm.com/support/pages/db2-jdbc-driver-versions-and-downloads
- **DB2 JDBC Developer Guide**: https://www.ibm.com/docs/en/db2/12.1.x?topic=apis-installing-data-server-driver-jdbc-sqlj
- **JayDeBeApi Examples**: https://github.com/baztian/jaydebeapi/blob/master/README.rst

---

## CLI Usage

### Configuration File

The configuration file supports two connection methods to DB2 for z/OS:
   - ibm_db: Native Python driver using ODBC/CLI (requires configured ODBC)
   - jdbc: Java-based driver using JDBC (requires db2jcc4 and  db2jcc_license_cisuz JAR files)
 
 Set the 'driver' parameter to your preferred method. For z/OS systems,
 Environment variables can be used for sensitive data (${VAR_NAME}).


Update the [`db2_config.yaml`](db2_config.yaml) file with your database connection settings:

### Prerequisites

You need to install PyYAML library
```
pip3 install pyyaml
```


### Using IBM DB Driver


#### Command Line

Before triggering the CLI, ensure that the following environment variables are set and properly adapted to the your DB2 environment.

```bash
export IBM_DB_HOME=DB2V13
export STEPLIB=DBD1.SDSNEXIT:DB2V13.SDSNLOAD:DB2V13.SDSNLOD2
export DSNAOINI=$HOME/odbcini
```
Command Line Syntax:

```bash
usage: db2_evidence_client.py [-h] -e YAML_EVIDENCE_FILE [-c CONFIG_FILE] [-d {ibm_db,jdbc}]

DB2 Evidence Client - Process evidence YAML files

options:
  -h, --help            show this help message and exit
  -e, --evidence YAML_EVIDENCE_FILE
                        Path to evidence YAML file (required)
  -c, --config CONFIG_FILE
                        Path to config file (default: db2_config.yaml)
  -d, --driver {ibm_db,jdbc}
                        Driver to use: 'ibm_db' or 'jdbc' (overrides config file)

Examples:
  python3 db2_evidence_client.py -e evidence.yml
  python3 db2_evidence_client.py -e evidence.yml -c my_config.yaml
  python3 db2_evidence_client.py -e evidence.yml -c my_config.yaml -d jdbc
  python3 db2_evidence_client.py --evidence evidence.yml --driver ibm

Driver selection priority:
  1. Command line argument (if provided)
  2. Config file 'driver' parameter
  3. Default: 'ibm_db'

```


### Using JDBC Driver

#### Command Line

Before triggering the CLI, ensure that the following environment variables are set and properly adapted to the your DB2 environment.



```bash
export DB2_USER=YOUR_DB2_USER
export DB2_PASSWORD=YOUR_DB2_PASSWORD
unset CLASSPATH
export JAVA_HOME=/usr/lpp/java/J8.0_64
export LIBPATH=$JAVA_HOME/bin/j9vm
```

Command Line Syntax:

```bash
usage: db2_evidence_client.py [-h] -e YAML_EVIDENCE_FILE [-c CONFIG_FILE] [-d {ibm_db,jdbc}]

DB2 Evidence Client - Process evidence YAML files

options:
  -h, --help            show this help message and exit
  -e, --evidence YAML_EVIDENCE_FILE
                        Path to evidence YAML file (required)
  -c, --config CONFIG_FILE
                        Path to config file (default: db2_config.yaml)
  -d, --driver {ibm_db,jdbc}
                        Driver to use: 'ibm_db' or 'jdbc' (overrides config file)

Examples:
  python3 db2_evidence_client.py -e evidence.yml
  python3 db2_evidence_client.py -e evidence.yml -c my_config.yaml
  python3 db2_evidence_client.py -e evidence.yml -c my_config.yaml -d jdbc
  python3 db2_evidence_client.py --evidence evidence.yml --driver ibm

Driver selection priority:
  1. Command line argument (if provided)
  2. Config file 'driver' parameter
  3. Default: 'ibm_db'

```

## Querying Samples

```sql
-- =============================================================================
-- Lists all artifacts deployed in a specific environment, including the 
-- application name and version
-- =============================================================================
SELECT DISTINCT 
    d.APPLICATION_NAME,
    d.APPLICATION_VERSION,
    art.ARTIFACT_NAME,
    art.ARTIFACT_TYPE,
    art.ARTIFACT_PATH
FROM DEPLOYZ.DEPLOY d
JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
JOIN DEPLOYZ.ARTIFACT art ON sa.ARTIFACT_ID = art.ARTIFACT_ID
WHERE d.ENVIRONMENT_NAME = 'PROD'
ORDER BY d.APPLICATION_NAME, d.APPLICATION_VERSION, art.ARTIFACT_NAME;

-- =============================================================================
-- In which environments is the artifact named "LGACDB02" deployed
-- =============================================================================
SELECT DISTINCT 
    d.ENVIRONMENT_NAME,
    d.APPLICATION_NAME,
    d.APPLICATION_VERSION,
    d.DEPLOY_TIMESTAMP,
    d.STATUS AS DEPLOY_STATUS
FROM DEPLOYZ.DEPLOY d
JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
JOIN DEPLOYZ.ARTIFACT art ON sa.ARTIFACT_ID = art.ARTIFACT_ID
WHERE art.ARTIFACT_NAME = 'LGACDB02'
ORDER BY d.ENVIRONMENT_NAME, d.DEPLOY_TIMESTAMP DESC;

-- =============================================================================
-- In which environments the artifact named "LGACDB02" of type "CICSLOAD"
-- is deployed
-- =============================================================================
SELECT DISTINCT 
    d.ENVIRONMENT_NAME,
    d.APPLICATION_NAME,
    d.APPLICATION_VERSION,
    d.DEPLOY_TIMESTAMP,
    d.STATUS AS DEPLOY_STATUS,
    art.ARTIFACT_PATH
FROM DEPLOYZ.DEPLOY d
JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
JOIN DEPLOYZ.ARTIFACT art ON sa.ARTIFACT_ID = art.ARTIFACT_ID
WHERE art.ARTIFACT_NAME = 'LGACDB02'
  AND art.ARTIFACT_TYPE = 'CICSLOAD'
ORDER BY d.ENVIRONMENT_NAME, d.DEPLOY_TIMESTAMP DESC;

-- =============================================================================
-- List the properties of a specific artifact (by name and type)
-- =============================================================================

SELECT 
    d.DEPLOY_ID,
    d.ENVIRONMENT_NAME,
    d.DEPLOY_TIMESTAMP,
    art.ARTIFACT_ID,
    art.ARTIFACT_NAME,
    art.ARTIFACT_TYPE,
    p.PROPERTY_KEY,
    p.PROPERTY_VALUE
FROM DEPLOYZ.DEPLOY d
JOIN DEPLOYZ.ARTIFACT art
    ON EXISTS (
        SELECT 1
        FROM DEPLOYZ.STEP_ARTIFACT sa
        JOIN DEPLOYZ.STEP s ON sa.STEP_ID = s.STEP_ID
        JOIN DEPLOYZ.ACTION a ON s.ACTION_ID = a.ACTION_ID
        JOIN DEPLOYZ.ACTIVITY act ON a.ACTIVITY_ID = act.ACTIVITY_ID
        WHERE sa.ARTIFACT_ID = art.ARTIFACT_ID
          AND act.DEPLOY_ID = d.DEPLOY_ID
    )
JOIN DEPLOYZ.PROPERTIES p
    ON p.ENTITY_TYPE = 'ARTIFACT'
   AND p.ENTITY_ID = art.ARTIFACT_ID
   AND p.DEPLOY_ID = d.DEPLOY_ID
WHERE  art.ARTIFACT_NAME = 'LGACDB02'
ORDER BY art.ARTIFACT_ID, p.PROPERTY_KEY;

-- =============================================================================
-- Production Artifacts - Detailed list of ACTIVE and DELETED artifacts
-- Logic: Last action on each artifact determines its status
-- =============================================================================


WITH ARTIFACT_TIMELINE AS (
    SELECT
        art.ARTIFACT_ID,
        art.ARTIFACT_NAME,
        art.ARTIFACT_PATH,
        art.ARTIFACT_TYPE,
        d.APPLICATION_NAME,
        d.DEPLOY_ID,
        d.DEPLOY_TIMESTAMP,
        s.STEP_NAME,
        s.BUILDING_BLOCK,
        CASE
            WHEN s.BUILDING_BLOCK = 'MEMBER_DELETE' THEN 'DELETED'
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
        BUILDING_BLOCK AS LAST_BUILDING_BLOCK,
        MAX(CASE WHEN ACTION_TYPE = 'DELETED' THEN 1 ELSE 0 END)
            OVER (PARTITION BY ARTIFACT_ID) AS HAS_MEMBER_DELETE,
        MAX(CASE WHEN BUILDING_BLOCK = 'MEMBER_COPY' AND ACTION_TYPE = 'DEPLOYED' THEN 1 ELSE 0 END)
            OVER (PARTITION BY ARTIFACT_ID) AS HAS_MEMBER_COPY_AFTER_DELETE
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
        WHEN HAS_MEMBER_DELETE = 1 AND HAS_MEMBER_COPY_AFTER_DELETE = 0
            THEN 'DELETED'
        ELSE 'DEPLOYED'
    END AS STATUS,
    LAST_ACTION_DATE,
    LAST_BUILDING_BLOCK
FROM ARTIFACT_STATUS
ORDER BY
    LAST_ACTION_DATE DESC,
    APPLICATION_NAME,
    ARTIFACT_NAME;


```

---

## Driver Comparison

| Feature | IBM DB (`ibm_db`) | JDBC (`JayDeBeApi`) |
|---------|-------------------|---------------------|
| **Performance** |  Excellent |  Very Good |
| **Installation** |  Medium (requires CLI) |  Easy (just JAR) |
| **Portability** |  OS-dependent |  Cross-platform |
| **Compatibility** |  Native DB2 |  Standard JDBC |
| **z/OS** |  Native For DB2 on z/OS |  Requires Java 8 only |

### When to Use Which Driver?

**Use `ibm_db` if:**
- DB2 CLI is already installed
- Maximum performance required
- Running on Linux/AIX
- Running on z/OS to access DB2 on z/OS
- Need advanced DB2 features

**Use `JayDeBeApi` if:**
- Simplified installation desired
- Cross-database portability needed
- Docker/containerized deployment

---

## Additional Resources

### DB2 Documentation
- [DB2 Knowledge Center](https://www.ibm.com/docs/en/db2/12.1.x)

---

## License

Licensed Materials - Property of IBM  
(c) Copyright IBM Corp. 2025. All Rights Reserved.
