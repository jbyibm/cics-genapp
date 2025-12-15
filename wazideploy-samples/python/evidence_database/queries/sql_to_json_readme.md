# SQL to JSON - Simple Query Tool

Ultra-simple tool: SQL file in → JSON out

## 🚀 Quick Start

```bash
# Execute SQL and print JSON to stdout
python sql_to_json.py query.sql

# Save JSON to file
python sql_to_json.py query.sql result.json

# Use custom config
python sql_to_json.py query.sql result.json my_config.yaml
```

## 📝 Usage

### Syntax

```bash
python sql_to_json.py <sql_file> [output_file] [config_file]
```

### Arguments

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `sql_file` | **Yes** | - | SQL file to execute |
| `output_file` | No | stdout | Output JSON file |
| `config_file` | No | `config.yaml` | Database configuration |

### Examples

#### Example 1: Print to stdout

```bash
python sql_to_json.py queries/list_deployments.sql
```

**Output:**
```json
[
  {
    "DEPLOY_ID": 3,
    "EVIDENCE_NAME": "prod-deploy-003",
    "DESCRIPTION": "Production deployment",
    "ENVIRONMENT_NAME": "PRODUCTION",
    "DEPLOY_TIMESTAMP": "2025-12-05T14:30:00",
    "STATUS": "SUCCESS",
    "ENGINE_VERSION": "v2.1.0"
  },
  {
    "DEPLOY_ID": 2,
    "EVIDENCE_NAME": "test-deploy-002",
    "DESCRIPTION": "Test deployment",
    "ENVIRONMENT_NAME": "TEST",
    "DEPLOY_TIMESTAMP": "2025-12-05T10:15:00",
    "STATUS": "FAILED",
    "ENGINE_VERSION": "v2.0.5"
  }
]
```

#### Example 2: Save to file

```bash
python sql_to_json.py queries/deployment_statistics.sql stats.json
```

**Output:**
```
✓ Results written to: stats.json
  Records: 1
```

**stats.json:**
```json
[
  {
    "TOTAL_DEPLOYMENTS": 150,
    "SUCCESSFUL": 142,
    "FAILED": 8,
    "ENVIRONMENTS": 3,
    "FIRST_DEPLOYMENT": "2025-01-15T09:00:00",
    "LAST_DEPLOYMENT": "2025-12-05T14:30:00"
  }
]
```

#### Example 3: Use with pipes

```bash
# Filter with jq
python sql_to_json.py queries/list_deployments.sql | jq '.[] | select(.STATUS == "FAILED")'

# Count results
python sql_to_json.py queries/shared_artifacts.sql | jq 'length'

# Extract specific field
python sql_to_json.py queries/deployment_statistics.sql | jq '.[0].TOTAL_DEPLOYMENTS'
```

## 📂 Example Queries

### 1. List All Deployments

**File:** `queries/list_deployments.sql`

```sql
SELECT 
    DEPLOY_ID,
    EVIDENCE_NAME,
    ENVIRONMENT_NAME,
    DEPLOY_TIMESTAMP,
    STATUS
FROM DEPLOYZ.DEPLOY
ORDER BY DEPLOY_TIMESTAMP DESC
FETCH FIRST 20 ROWS ONLY;
```

**Run:**
```bash
python sql_to_json.py queries/list_deployments.sql
```

### 2. Deployment Statistics

**File:** `queries/deployment_statistics.sql`

```sql
SELECT 
    COUNT(*) AS TOTAL_DEPLOYMENTS,
    COUNT(CASE WHEN STATUS = 'SUCCESS' THEN 1 END) AS SUCCESSFUL,
    COUNT(CASE WHEN STATUS = 'FAILED' THEN 1 END) AS FAILED
FROM DEPLOYZ.DEPLOY;
```

**Run:**
```bash
python sql_to_json.py queries/deployment_statistics.sql stats.json
```

### 3. Failed Steps

**File:** `queries/failed_steps.sql`

```sql
SELECT 
    d.EVIDENCE_NAME,
    s.STEP_NAME,
    s.MESSAGE
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.ACTION a ON s.ACTION_ID = a.ACTION_ID
INNER JOIN DEPLOYZ.ACTIVITY act ON a.ACTIVITY_ID = act.ACTIVITY_ID
INNER JOIN DEPLOYZ.DEPLOY d ON act.DEPLOY_ID = d.DEPLOY_ID
WHERE s.STATUS = 'FAILED';
```

**Run:**
```bash
python sql_to_json.py queries/failed_steps.sql failed.json
```

### 4. Shared Artifacts

**File:** `queries/shared_artifacts.sql`

```sql
SELECT 
    a.ARTIFACT_PATH,
    COUNT(DISTINCT sa.STEP_ID) AS USAGE_COUNT
FROM DEPLOYZ.ARTIFACT a
INNER JOIN DEPLOYZ.STEP_ARTIFACT sa ON a.ARTIFACT_ID = sa.ARTIFACT_ID
GROUP BY a.ARTIFACT_PATH
HAVING COUNT(DISTINCT sa.STEP_ID) > 1
ORDER BY USAGE_COUNT DESC;
```

**Run:**
```bash
python sql_to_json.py queries/shared_artifacts.sql
```

## 💡 Tips & Tricks

### Tip 1: Schema Placeholder

Use `DEPLOYZ` in your SQL (or your actual schema name). The tool doesn't do automatic replacement - use your real schema name.

```sql
-- Good
SELECT * FROM DEPLOYZ.DEPLOY;

-- Also good (if you want dynamic schema)
-- Modify sql_to_json.py to replace {schema} with actual schema
SELECT * FROM {schema}.DEPLOY;
```

### Tip 2: Format JSON Output

Use `jq` for pretty formatting:

```bash
python sql_to_json.py query.sql | jq '.'
```

### Tip 3: Extract Single Value

Get just one value:

```bash
# Get total count
python sql_to_json.py queries/deployment_statistics.sql | jq '.[0].TOTAL_DEPLOYMENTS'

# Output: 150
```

### Tip 4: Filter Results

Filter with `jq`:

```bash
# Get only failed deployments
python sql_to_json.py queries/list_deployments.sql | jq '.[] | select(.STATUS == "FAILED")'

# Get deployments from PRODUCTION
python sql_to_json.py queries/list_deployments.sql | jq '.[] | select(.ENVIRONMENT_NAME == "PRODUCTION")'
```

### Tip 5: Combine Multiple Queries

```bash
# Create a report
echo "{" > report.json
echo '"deployments":' >> report.json
python sql_to_json.py queries/list_deployments.sql >> report.json
echo ',' >> report.json
echo '"statistics":' >> report.json
python sql_to_json.py queries/deployment_statistics.sql >> report.json
echo "}" >> report.json
```

### Tip 6: Convert to CSV

Use `jq` to convert to CSV:

```bash
python sql_to_json.py query.sql | jq -r '.[] | [.DEPLOY_ID, .EVIDENCE_NAME, .STATUS] | @csv'
```

## 🔧 Creating Your Own Queries

### Simple Query

**File:** `my_query.sql`

```sql
SELECT 
    DEPLOY_ID,
    EVIDENCE_NAME,
    STATUS
FROM DEPLOYZ.DEPLOY
WHERE STATUS = 'SUCCESS';
```

**Run:**
```bash
python sql_to_json.py my_query.sql
```

### Query with WHERE Clause

**File:** `production_deploys.sql`

```sql
SELECT *
FROM DEPLOYZ.DEPLOY
WHERE ENVIRONMENT_NAME = 'PRODUCTION'
ORDER BY DEPLOY_TIMESTAMP DESC
FETCH FIRST 10 ROWS ONLY;
```

**Run:**
```bash
python sql_to_json.py production_deploys.sql prod.json
```

### Complex Query with JOINs

**File:** `deployment_details.sql`

```sql
SELECT 
    d.DEPLOY_ID,
    d.EVIDENCE_NAME,
    COUNT(DISTINCT s.STEP_ID) AS TOTAL_STEPS,
    SUM(s.DURATION) AS TOTAL_DURATION
FROM DEPLOYZ.DEPLOY d
LEFT JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
LEFT JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
LEFT JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
GROUP BY d.DEPLOY_ID, d.EVIDENCE_NAME;
```

**Run:**
```bash
python sql_to_json.py deployment_details.sql details.json
```

## 🐍 Using in Python Scripts

You can also use the generic client directly in Python:

```python
from db2_generic_client import DB2GenericClient
import json

# Read SQL from file
with open('queries/list_deployments.sql', 'r') as f:
    sql = f.read()

# Execute and get JSON
with DB2GenericClient() as client:
    results = client.execute_query(sql)
    json_output = json.dumps(results, indent=2)
    print(json_output)
```

## 📋 Available Query Examples

The `queries/` directory contains example SQL files:

| File | Description |
|------|-------------|
| `list_deployments.sql` | List all deployments |
| `deployment_by_id.sql` | Get specific deployment |
| `failed_deployments.sql` | Get failed deployments |
| `deployment_statistics.sql` | Overall statistics |
| `shared_artifacts.sql` | Artifacts used multiple times |
| `deployment_hierarchy.sql` | Complete hierarchy |
| `failed_steps.sql` | All failed steps |
| `artifacts_by_deployment.sql` | Artifacts in deployment |
| `environment_comparison.sql` | Compare environments |
| `deployment_summary.sql` | Detailed summary |
| `recent_deployments.sql` | Recent deployments (7 days) |
| `artifact_usage.sql` | Where artifact is used |

## ⚙️ Configuration

The tool uses the same `config.yaml` as the loader:

```yaml
driver: jdbc
schema: DEPLOYZ

jdbc:
  url: jdbc:db2://localhost:50000/DEPLOY
  username: db2inst1
  password: password
  driver_paths: /path/to/db2jcc4.jar
```

## 🔍 Troubleshooting

### Error: SQL file not found

```
Error: SQL file not found: query.sql
```

**Solution:** Check the file path and ensure it exists.

### Error: Connection failed

```
Error executing query: Could not connect to database
```

**Solution:** Verify your `config.yaml` settings and database is running.

### Empty Result

```
[]
```

**Solution:** This means the query returned no rows. Check your WHERE conditions.

### JSON Syntax Error

If you get JSON parsing errors when piping to `jq`:

```bash
# Add error checking
python sql_to_json.py query.sql 2>&1 | jq '.'
```

## 📖 See Also

- [README.md](README.md) - Main documentation
- [QUERY_CLIENT.md](QUERY_CLIENT.md) - Full query client with predefined methods
- [db2_generic_client.py](db2_generic_client.py) - Python API for custom queries

---

**Simple, efficient, and straightforward: SQL in → JSON out!** ✨
