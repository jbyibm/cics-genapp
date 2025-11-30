# DB2 Evidence Loader

Python tool to load YAML evidence files into a DB2 database.

## 📋 Table of Contents

- [Architecture](#architecture)
- [Installation and Configuration](#installation-and-configuration)
  - [Option 1: IBM DB Driver (ibm_db)](#option-1-ibm-db-driver-ibm_db)
  - [Option 2: JDBC Driver (JayDeBeApi)](#option-2-jdbc-driver-jaydebeapi)
- [Usage](#usage)
  - [Using IBM DB Driver](#using-ibm-db-driver)
  - [Using JDBC Driver](#using-jdbc-driver)
- [File Structure](#file-structure)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)

---

## 🏗️ Architecture

The project uses a **Template Method** pattern with:
- **`DB2EvidenceLoaderBase`**: Abstract class containing all business logic
- **`DB2EvidenceLoaderIBM`**: Implementation using `ibm_db` driver
- **`DB2EvidenceLoaderJDBC`**: Implementation using `JayDeBeApi` (JDBC) driver

### Artifact Uniqueness

**Important**: Artifacts are identified by their **PATH** (unique constraint):
- Same artifact path = same artifact (reused across multiple steps)
- Many-to-many relationship between STEP and ARTIFACT via `STEP_ARTIFACT` junction table
- When an artifact with the same path is encountered, the existing artifact is linked instead of creating a duplicate
- The `ARTIFACT_HASH` field has been removed from the schema

---

## ⚙️ Installation and Configuration

### Option 1: IBM DB Driver (ibm_db)

#### 📦 Installation

```bash
pip install ibm_db
```

#### 🔧 Configuration (Windows)

The IBM DB driver requires DB2 CLI libraries on Windows:

1. **Download DB2 CLI Driver**
   - Download from: [IBM Data Server Driver Package](https://www.ibm.com/support/pages/download-initial-version-115-clients-and-drivers)
   - Extract to `C:\clidriver` (or another directory)

2. **Environment Variables Configuration** (automatic in code):
   ```python
   import os
   import sys
   
   if sys.platform == 'win32':
       clidriver = r'C:\clidriver'
       os.environ['IBM_DB_HOME'] = clidriver
       os.environ['IBM_DB_LIB'] = os.path.join(clidriver, 'lib')
       os.environ['PATH'] = os.path.join(clidriver, 'bin') + ';' + os.environ['PATH']
       os.add_dll_directory(os.path.join(clidriver, 'bin'))
   ```

#### 📚 Useful Links

- **Official Documentation**: https://github.com/ibmdb/python-ibmdb
- **API Reference**: https://github.com/ibmdb/python-ibmdb/wiki/APIs
- **DB2 CLI Driver**: https://www.ibm.com/support/pages/download-db2-fix-packs-version-db2-linux-unix-and-windows
- **Installation Guide**: https://github.com/ibmdb/python-ibmdb#installation
- **Troubleshooting**: https://github.com/ibmdb/python-ibmdb/blob/master/README.md#troubleshooting

#### ⚠️ Prerequisites

- **Windows**: Visual C++ Redistributable 2015-2019
- **Linux**: `gcc`, `python-dev`
- **Python**: 3.6+

---

### Option 2: JDBC Driver (JayDeBeApi)

#### 📦 Installation

```bash
pip install JayDeBeApi
pip install JPype1  # Required for JayDeBeApi
```

#### 🔧 Configuration

1. **Download DB2 JDBC Driver**
   - Download `db2jcc4.jar` from: [IBM Data Server Driver for JDBC](https://www.ibm.com/support/pages/db2-jdbc-driver-versions-and-downloads)
   - Or extract from DB2 installation: `<DB2_HOME>/java/db2jcc4.jar`
   - Save to an accessible directory (e.g., `C:\drivers\db2jcc4.jar`)

2. **Install Java JDK**
   - Recommended version: Java 8 or higher
   - Download: https://www.oracle.com/java/technologies/downloads/
   - Verify installation: `java -version`

#### 📚 Useful Links

- **JayDeBeApi Documentation**: https://github.com/baztian/jaydebeapi
- **JPype1 Documentation**: https://jpype.readthedocs.io/
- **DB2 JDBC Driver**: https://www.ibm.com/support/pages/db2-jdbc-driver-versions-and-downloads
- **DB2 JDBC Developer Guide**: https://www.ibm.com/docs/en/db2/11.5?topic=apis-jdbc-sqlj-driver
- **JayDeBeApi Examples**: https://github.com/baztian/jaydebeapi/blob/master/README.rst

#### ⚠️ Prerequisites

- **Java JDK**: 8 or higher (JRE is sufficient)
- **Python**: 3.6+
- **JAR File**: `db2jcc4.jar` or `db2jcc.jar`

---

## 🚀 Usage

### Configuration File

Create a `config.yaml` file with your database connection settings:

```yaml
# Driver selection: ibm_db or jdbc
driver: jdbc

# Database schema
schema: DEPLOYZ

# IBM DB configuration (if driver: ibm_db)
ibm_db:
  database: DEPLOY
  hostname: localhost
  port: 50000
  protocol: TCPIP
  uid: db2inst1
  pwd: password

# JDBC configuration (if driver: jdbc)
jdbc:
  url: jdbc:db2://localhost:50000/DEPLOY
  username: db2inst1
  password: password
  driver_path: C:/drivers/db2jcc4.jar
  driver_class: com.ibm.db2.jcc.DB2Driver

# Logging
logging:
  level: INFO
  format: '%(asctime)s - %(levelname)s - %(message)s'

# Options
options:
  verbose: true
  stop_on_error: false
```

### Using IBM DB Driver

#### Command Line

```bash
# Using default config.yaml
python db2_evidence_loader_ibm.py evidence.yml

# Using custom config file
python db2_evidence_loader_ibm.py evidence.yml my_config.yaml
```

#### Python Code

```python
from db2_evidence_loader_ibm import DB2EvidenceLoaderIBM

# Using default config.yaml
loader = DB2EvidenceLoaderIBM()

# Using custom config file
loader = DB2EvidenceLoaderIBM(config_file='my_config.yaml')

# Load evidence file
try:
    deploy_id = loader.load_evidence_file("evidence.yml")
    print(f"✓ Evidence loaded (Deploy ID: {deploy_id})")
finally:
    loader.close()
```

### Using JDBC Driver

#### Command Line

```bash
# Using default config.yaml
python db2_evidence_loader_jdbc.py evidence.yml

# Using custom config file
python db2_evidence_loader_jdbc.py evidence.yml my_config.yaml
```

#### Python Code

```python
from db2_evidence_loader_jdbc import DB2EvidenceLoaderJDBC

# Using default config.yaml
loader = DB2EvidenceLoaderJDBC()

# Using custom config file
loader = DB2EvidenceLoaderJDBC(config_file='my_config.yaml')

# Load evidence file
try:
    deploy_id = loader.load_evidence_file("evidence.yml")
    print(f"✓ Evidence loaded (Deploy ID: {deploy_id})")
finally:
    loader.close()
```

### Using Environment Variables in Configuration

You can use environment variables in your `config.yaml`:

```yaml
jdbc:
  url: jdbc:db2://${DB_HOST}:${DB_PORT}/${DB_NAME}
  username: ${DB_USER}
  password: ${DB_PASSWORD}
  driver_path: ${JDBC_DRIVER_PATH}
```

Then set the environment variables:

```bash
# Linux/Mac
export DB_HOST=localhost
export DB_PORT=50000
export DB_NAME=DEPLOY
export DB_USER=db2inst1
export DB_PASSWORD=secret
export JDBC_DRIVER_PATH=/path/to/db2jcc4.jar

# Windows
set DB_HOST=localhost
set DB_PORT=50000
set DB_NAME=DEPLOY
set DB_USER=db2inst1
set DB_PASSWORD=secret
set JDBC_DRIVER_PATH=C:\drivers\db2jcc4.jar
```

### Using Context Manager

```python
from db2_evidence_loader_jdbc import DB2EvidenceLoaderJDBC

# Add context manager support
class DB2EvidenceLoaderJDBC(DB2EvidenceLoaderJDBC):
    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

# Usage
with DB2EvidenceLoaderJDBC('config.yaml') as loader:
    deploy_id = loader.load_evidence_file("evidence.yml")
    print(f"Deploy ID: {deploy_id}")
```

---

## 📁 File Structure

```
project/
│
├── config.yaml                      # Configuration file (REQUIRED)
├── db2_config.py                    # Configuration loader
├── db2_evidence_loader_base.py      # Abstract base class
├── db2_evidence_loader_ibm.py       # IBM DB implementation
├── db2_evidence_loader_jdbc.py      # JDBC implementation
├── db2_schema.sql                   # Database schema DDL
└── README.md                        # This file
```

### Database Schema

The database uses the following structure:

```
DEPLOY (1) ──┬──→ ACTIVITY (N) ──┬──→ ACTION (N) ──┬──→ STEP (N)
             │                    │                  │
             │                    │                  └──→ STEP_ARTIFACT (junction)
             │                    │                            │
             │                    └──→ PROPERTIES              └──→ ARTIFACT (unique by PATH)
             │
             └──→ PROPERTIES
```

**Key Points:**
- **ARTIFACT** table stores unique artifacts identified by `ARTIFACT_PATH`
- **STEP_ARTIFACT** junction table creates many-to-many relationship
- Same artifact can be used by multiple steps (no duplication)
- Constraint: `UNIQUE (ARTIFACT_PATH)` ensures artifact uniqueness

### File Dependencies

```
db2_evidence_loader_ibm.py
    └── import from db2_evidence_loader_base

db2_evidence_loader_jdbc.py
    └── import from db2_evidence_loader_base
```

---

## 📝 Examples

### Complete Example with Configuration File

**config.yaml:**
```yaml
driver: jdbc
schema: DEPLOYZ

jdbc:
  url: jdbc:db2://localhost:50000/DEPLOY
  username: db2inst1
  password: mypassword
  driver_path: /opt/drivers/db2jcc4.jar

logging:
  level: INFO
  file: evidence_loader.log

options:
  verbose: true
```

**Python script:**
```python
import sys
from db2_evidence_loader_jdbc import DB2EvidenceLoaderJDBC

def main():
    if len(sys.argv) < 2:
        print("Usage: python load_evidence.py <yaml_file>")
        sys.exit(1)
    
    yaml_file = sys.argv[1]
    
    try:
        # Load using config.yaml
        loader = DB2EvidenceLoaderJDBC()
        deploy_id = loader.load_evidence_file(yaml_file)
        print(f"✓ Success! Deploy ID: {deploy_id}")
        
    except Exception as e:
        print(f"✗ Error: {e}")
        sys.exit(1)
    
    finally:
        if 'loader' in locals():
            loader.close()

if __name__ == "__main__":
    main()
```

**Run:**
```bash
python load_evidence.py evidence.yml
```

### Multiple Configuration Files

You can maintain different configurations for different environments:

**config_dev.yaml:**
```yaml
driver: jdbc
schema: DEPLOYZ

jdbc:
  url: jdbc:db2://dev-server:50000/DEPLOY
  username: dev_user
  password: dev_pass
  driver_path: /opt/drivers/db2jcc4.jar
```

**config_prod.yaml:**
```yaml
driver: jdbc
schema: DEPLOYZ

jdbc:
  url: jdbc:db2://prod-server:50000/DEPLOY
  username: prod_user
  password: ${PROD_PASSWORD}  # From environment
  driver_path: /opt/drivers/db2jcc4.jar

options:
  stop_on_error: true
```

**Usage:**
```bash
# Development
python db2_evidence_loader_jdbc.py evidence.yml config_dev.yaml

# Production
export PROD_PASSWORD=secret
python db2_evidence_loader_jdbc.py evidence.yml config_prod.yaml
```

### Batch Processing Multiple Evidence Files

```python
import os
import glob
from db2_evidence_loader_jdbc import DB2EvidenceLoaderJDBC

def load_all_evidence(evidence_dir, config_file='config.yaml'):
    """Load all YAML evidence files from a directory"""
    
    # Create loader once
    loader = DB2EvidenceLoaderJDBC(config_file=config_file)
    
    try:
        # Find all YAML files
        yaml_files = glob.glob(os.path.join(evidence_dir, '*.yml'))
        
        results = []
        for yaml_file in yaml_files:
            try:
                print(f"Loading {yaml_file}...")
                deploy_id = loader.load_evidence_file(yaml_file)
                results.append((yaml_file, deploy_id, 'SUCCESS'))
                print(f"  ✓ Deploy ID: {deploy_id}")
            except Exception as e:
                results.append((yaml_file, None, f'ERROR: {e}'))
                print(f"  ✗ Error: {e}")
        
        # Summary
        print(f"\n{'='*60}")
        print(f"Loaded {sum(1 for r in results if r[2] == 'SUCCESS')} / {len(results)} files")
        print(f"{'='*60}")
        
        return results
        
    finally:
        loader.close()

# Usage
if __name__ == "__main__":
    results = load_all_evidence('/path/to/evidence_files')
```

### Error Handling and Logging

```python
import logging
from db2_evidence_loader_ibm import DB2EvidenceLoaderIBM

# Configure detailed logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('evidence_loader.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

def load_with_retry(yaml_file, config_file='config.yaml', max_retries=3):
    """Load evidence with retry logic"""
    
    for attempt in range(1, max_retries + 1):
        try:
            logger.info(f"Attempt {attempt}/{max_retries} to load {yaml_file}")
            
            loader = DB2EvidenceLoaderIBM(config_file=config_file)
            deploy_id = loader.load_evidence_file(yaml_file)
            loader.close()
            
            logger.info(f"Successfully loaded (Deploy ID: {deploy_id})")
            return deploy_id
            
        except Exception as e:
            logger.error(f"Attempt {attempt} failed: {e}")
            if attempt == max_retries:
                logger.error(f"All {max_retries} attempts failed")
                raise
            
            # Wait before retry
            import time
            time.sleep(2 ** attempt)  # Exponential backoff

# Usage
deploy_id = load_with_retry('evidence.yml')
```

---

## 🔧 Troubleshooting

```python
import sys
from db2_evidence_loader_jdbc import DB2EvidenceLoaderJDBC

def load_evidence(yaml_file, jdbc_url, driver_path, username, password):
    """
    Load an evidence file into DB2
    
    Args:
        yaml_file: Path to YAML file
        jdbc_url: JDBC connection URL
        driver_path: Path to db2jcc4.jar
        username: DB2 username
        password: Password
    
    Returns:
        deploy_id or None on error
    """
    loader = None
    try:
        print(f"Connecting to database...")
        loader = DB2EvidenceLoaderJDBC(
            db_connection_string=jdbc_url,
            jdbc_driver_path=driver_path,
            username=username,
            password=password
        )
        
        print(f"Loading {yaml_file}...")
        deploy_id = loader.load_evidence_file(yaml_file)
        
        print(f"✓ Evidence loaded successfully (Deploy ID: {deploy_id})")
        return deploy_id
        
    except FileNotFoundError:
        print(f"✗ Error: File {yaml_file} not found")
        return None
        
    except Exception as e:
        print(f"✗ Error during loading: {str(e)}")
        import traceback
        traceback.print_exc()
        return None
        
    finally:
        if loader:
            loader.close()
            print("Connection closed")

# Usage
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <yaml_file>")
        sys.exit(1)
    
    result = load_evidence(
        yaml_file=sys.argv[1],
        jdbc_url="jdbc:db2://localhost:50000/DEPLOY",
        driver_path="C:/drivers/db2jcc4.jar",
        username="db2inst1",
        password="password"
    )
    
    sys.exit(0 if result else 1)
```

### Example with Logging

```python
import logging
from db2_evidence_loader_ibm import DB2EvidenceLoaderIBM

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

DB_CONNECTION = "DATABASE=DEPLOY;HOSTNAME=localhost;..."

try:
    logger.info("Starting evidence loading")
    
    loader = DB2EvidenceLoaderIBM(DB_CONNECTION)
    deploy_id = loader.load_evidence_file("evidence.yml")
    
    logger.info(f"Evidence loaded successfully (Deploy ID: {deploy_id})")
    
except Exception as e:
    logger.error(f"Error during loading: {str(e)}", exc_info=True)
    raise
finally:
    if 'loader' in locals():
        loader.close()
        logger.info("Connection closed")
```

---

## 🔧 Troubleshooting

### IBM DB Driver

#### Error: "DLL load failed"
```
ImportError: DLL load failed while importing _ibm_db
```
**Solution**:
- Verify DB2 CLI Driver is installed
- Check environment variables (`IBM_DB_HOME`, `PATH`)
- Install Visual C++ Redistributable 2015-2019

#### Error: "SQL1336N"
```
SQL1336N  The remote host was not found
```
**Solution**:
- Verify hostname and port
- Test network connectivity: `ping hostname`
- Check firewall settings

#### Error: "SQL30081N"
```
SQL30081N  A communication error has been detected
```
**Solution**:
- Verify DB2 is running
- Check port (default: 50000)
- Test with `db2 connect to database`

### JDBC Driver

#### Error: "No suitable driver"
```
java.sql.SQLException: No suitable driver found
```
**Solution**:
- Verify `db2jcc4.jar` exists
- Check JAR file path
- Verify Java is installed: `java -version`

#### Error: "ClassNotFoundException: com.ibm.db2.jcc.DB2Driver"
```
java.lang.ClassNotFoundException: com.ibm.db2.jcc.DB2Driver
```
**Solution**:
- Use correct class name: `com.ibm.db2.jcc.DB2Driver`
- Verify JAR is not corrupted
- Try with full JAR: `db2jcc4.jar` instead of `db2jcc.jar`

#### Error: "Unable to start JVM"
```
RuntimeError: Unable to start JVM
```
**Solution**:
- Install Java JDK (not just JRE)
- Set `JAVA_HOME`: `export JAVA_HOME=/path/to/jdk`
- Reinstall JPype1: `pip install --upgrade JPype1`

#### Error: "Connection refused"
```
com.ibm.db2.jcc.am.DisconnectNonTransientConnectionException
```
**Solution**:
- Verify DB2 is listening on the correct port
- Check JDBC URL: `jdbc:db2://HOST:PORT/DATABASE`
- Test with native DB2 client

---

## 🗄️ Database Schema Setup

Before using the evidence loader, you must create the database schema:

```bash
# Connect to DB2
db2 connect to DEPLOY user db2inst1

# Create schema
db2 -tvf db2_schema.sql

# Verify tables
db2 "SELECT TABNAME FROM SYSCAT.TABLES WHERE TABSCHEMA = 'DEPLOYZ'"
```

### Important Schema Features

1. **Artifact Uniqueness by PATH**
   ```sql
   -- Artifacts are unique by their path
   CONSTRAINT UQ_ARTIFACT_PATH UNIQUE (ARTIFACT_PATH)
   ```

2. **Many-to-Many Relationship**
   ```sql
   -- Multiple steps can share the same artifact
   STEP (N) ←→ STEP_ARTIFACT (junction) ←→ ARTIFACT (1)
   ```

3. **Automatic Artifact Reuse**
   - If artifact with same path exists → reuse existing artifact
   - If artifact is new → create new artifact entry
   - No duplicate artifacts in database

### Querying Artifacts

```sql
-- Find all artifacts used more than once
SELECT * FROM DEPLOYZ.V_ARTIFACT_USAGE 
WHERE USAGE_COUNT > 1;

-- Find all steps using a specific artifact
SELECT s.* 
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
INNER JOIN DEPLOYZ.ARTIFACT a ON sa.ARTIFACT_ID = a.ARTIFACT_ID
WHERE a.ARTIFACT_PATH = '/path/to/your/artifact';

-- Find shared artifacts across deployments
SELECT 
    a.ARTIFACT_PATH,
    COUNT(DISTINCT d.DEPLOY_ID) AS DEPLOY_COUNT,
    COUNT(DISTINCT sa.STEP_ID) AS STEP_COUNT
FROM DEPLOYZ.ARTIFACT a
INNER JOIN DEPLOYZ.STEP_ARTIFACT sa ON a.ARTIFACT_ID = sa.ARTIFACT_ID
INNER JOIN DEPLOYZ.STEP s ON sa.STEP_ID = s.STEP_ID
INNER JOIN DEPLOYZ.ACTION act ON s.ACTION_ID = act.ACTION_ID
INNER JOIN DEPLOYZ.ACTIVITY actv ON act.ACTIVITY_ID = actv.ACTIVITY_ID
INNER JOIN DEPLOYZ.DEPLOY d ON actv.DEPLOY_ID = d.DEPLOY_ID
GROUP BY a.ARTIFACT_PATH
HAVING COUNT(DISTINCT d.DEPLOY_ID) > 1;
```

---

## 📊 Driver Comparison

| Feature | IBM DB (`ibm_db`) | JDBC (`JayDeBeApi`) |
|---------|-------------------|---------------------|
| **Performance** | ⭐⭐⭐⭐⭐ Excellent | ⭐⭐⭐⭐ Very Good |
| **Installation** | ⭐⭐⭐ Medium (requires CLI) | ⭐⭐⭐⭐ Easy (just JAR) |
| **Portability** | ⭐⭐⭐ OS-dependent | ⭐⭐⭐⭐⭐ Cross-platform |
| **Compatibility** | ⭐⭐⭐⭐⭐ Native DB2 | ⭐⭐⭐⭐ Standard JDBC |
| **Windows** | ⭐⭐⭐ Complex setup | ⭐⭐⭐⭐⭐ Simple |
| **Linux** | ⭐⭐⭐⭐⭐ Native | ⭐⭐⭐⭐ Requires Java |

### When to Use Which Driver?

**Use `ibm_db` if:**
- DB2 CLI is already installed
- Maximum performance required
- Running on Linux/AIX
- Need advanced DB2 features

**Use `JayDeBeApi` if:**
- Simplified installation desired
- Windows environment
- Cross-database portability needed
- Docker/containerized deployment

---

## 📚 Additional Resources

### DB2 Documentation
- [DB2 Knowledge Center](https://www.ibm.com/docs/en/db2/11.5)
- [DB2 Connection Strings](https://www.ibm.com/docs/en/db2/11.5?topic=applications-connecting-data-source)
- [DB2 SQL Reference](https://www.ibm.com/docs/en/db2/11.5?topic=reference-sql)

### Community
- [Stack Overflow - ibm-db tag](https://stackoverflow.com/questions/tagged/ibm-db)
- [Stack Overflow - jaydebeapi tag](https://stackoverflow.com/questions/tagged/jaydebeapi)
- [IBM DB GitHub Issues](https://github.com/ibmdb/python-ibmdb/issues)

---

## 📄 License

Licensed Materials - Property of IBM  
(c) Copyright IBM Corp. 2023, 2025. All Rights Reserved.

---

## 👥 Support

For questions or issues:
1. Check the [Troubleshooting](#troubleshooting) section first
2. Review [GitHub issues](https://github.com/ibmdb/python-ibmdb/issues)
3. Contact IBM support if needed