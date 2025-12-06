#!/bin/bash
#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2023, 2025. All Rights Reserved.
#*******************************************************************************

# Create queries directory and example SQL files

echo "Creating queries directory structure..."

# Create directory
mkdir -p queries

# Create example queries

# 1. List deployments
cat > queries/list_deployments.sql << 'EOF'
-- Get all deployments with basic info
SELECT 
    DEPLOY_ID,
    EVIDENCE_NAME,
    DESCRIPTION,
    ENVIRONMENT_NAME,
    DEPLOY_TIMESTAMP,
    STATUS,
    ENGINE_VERSION
FROM DEPLOYZ.DEPLOY
ORDER BY DEPLOY_TIMESTAMP DESC
FETCH FIRST 20 ROWS ONLY;
EOF

# 2. Deployment statistics
cat > queries/deployment_statistics.sql << 'EOF'
-- Get overall deployment statistics
SELECT 
    COUNT(*) AS TOTAL_DEPLOYMENTS,
    COUNT(CASE WHEN STATUS = 'SUCCESS' THEN 1 END) AS SUCCESSFUL,
    COUNT(CASE WHEN STATUS = 'FAILED' THEN 1 END) AS FAILED,
    COUNT(DISTINCT ENVIRONMENT_NAME) AS ENVIRONMENTS,
    MIN(DEPLOY_TIMESTAMP) AS FIRST_DEPLOYMENT,
    MAX(DEPLOY_TIMESTAMP) AS LAST_DEPLOYMENT
FROM DEPLOYZ.DEPLOY;
EOF

# 3. Failed deployments
cat > queries/failed_deployments.sql << 'EOF'
-- Get all failed deployments with step counts
SELECT 
    d.DEPLOY_ID,
    d.EVIDENCE_NAME,
    d.ENVIRONMENT_NAME,
    d.DEPLOY_TIMESTAMP,
    d.STATUS,
    COUNT(DISTINCT s.STEP_ID) AS TOTAL_STEPS,
    COUNT(DISTINCT CASE WHEN s.STATUS = 'FAILED' THEN s.STEP_ID END) AS FAILED_STEPS
FROM DEPLOYZ.DEPLOY d
LEFT JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
LEFT JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
LEFT JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
WHERE d.STATUS = 'FAILED'
GROUP BY d.DEPLOY_ID, d.EVIDENCE_NAME, d.ENVIRONMENT_NAME, d.DEPLOY_TIMESTAMP, d.STATUS
ORDER BY d.DEPLOY_TIMESTAMP DESC;
EOF

# 4. Shared artifacts
cat > queries/shared_artifacts.sql << 'EOF'
-- Get artifacts used by multiple steps
SELECT 
    a.ARTIFACT_ID,
    a.ARTIFACT_NAME,
    a.ARTIFACT_PATH,
    a.ARTIFACT_TYPE,
    COUNT(DISTINCT sa.STEP_ID) AS USAGE_COUNT,
    COUNT(DISTINCT d.DEPLOY_ID) AS DEPLOYMENT_COUNT
FROM DEPLOYZ.ARTIFACT a
INNER JOIN DEPLOYZ.STEP_ARTIFACT sa ON a.ARTIFACT_ID = sa.ARTIFACT_ID
INNER JOIN DEPLOYZ.STEP s ON sa.STEP_ID = s.STEP_ID
INNER JOIN DEPLOYZ.ACTION act ON s.ACTION_ID = act.ACTION_ID
INNER JOIN DEPLOYZ.ACTIVITY actv ON act.ACTIVITY_ID = actv.ACTIVITY_ID
INNER JOIN DEPLOYZ.DEPLOY d ON actv.DEPLOY_ID = d.DEPLOY_ID
GROUP BY a.ARTIFACT_ID, a.ARTIFACT_NAME, a.ARTIFACT_PATH, a.ARTIFACT_TYPE
HAVING COUNT(DISTINCT sa.STEP_ID) > 1
ORDER BY USAGE_COUNT DESC;
EOF

# 5. Failed steps
cat > queries/failed_steps.sql << 'EOF'
-- Get all failed steps with context
SELECT 
    d.DEPLOY_ID,
    d.EVIDENCE_NAME,
    d.ENVIRONMENT_NAME,
    act.ACTIVITY_NAME,
    a.ACTION_NAME,
    s.STEP_ID,
    s.STEP_NAME,
    s.STATUS,
    s.MESSAGE,
    s.DURATION
FROM DEPLOYZ.STEP s
INNER JOIN DEPLOYZ.ACTION a ON s.ACTION_ID = a.ACTION_ID
INNER JOIN DEPLOYZ.ACTIVITY act ON a.ACTIVITY_ID = act.ACTIVITY_ID
INNER JOIN DEPLOYZ.DEPLOY d ON act.DEPLOY_ID = d.DEPLOY_ID
WHERE s.STATUS = 'FAILED'
ORDER BY d.DEPLOY_TIMESTAMP DESC, s.STEP_ID;
EOF

# 6. Environment comparison
cat > queries/environment_comparison.sql << 'EOF'
-- Compare deployments across environments
SELECT 
    ENVIRONMENT_NAME,
    COUNT(*) AS TOTAL_DEPLOYMENTS,
    COUNT(CASE WHEN STATUS = 'SUCCESS' THEN 1 END) AS SUCCESSFUL,
    COUNT(CASE WHEN STATUS = 'FAILED' THEN 1 END) AS FAILED,
    ROUND(COUNT(CASE WHEN STATUS = 'SUCCESS' THEN 1 END) * 100.0 / COUNT(*), 2) AS SUCCESS_RATE
FROM DEPLOYZ.DEPLOY
GROUP BY ENVIRONMENT_NAME
ORDER BY ENVIRONMENT_NAME;
EOF

# 7. Recent deployments
cat > queries/recent_deployments.sql << 'EOF'
-- Get deployments from last 7 days
SELECT 
    DEPLOY_ID,
    EVIDENCE_NAME,
    ENVIRONMENT_NAME,
    DEPLOY_TIMESTAMP,
    STATUS,
    ENGINE_VERSION
FROM DEPLOYZ.DEPLOY
WHERE DEPLOY_TIMESTAMP >= CURRENT_TIMESTAMP - 7 DAYS
ORDER BY DEPLOY_TIMESTAMP DESC;
EOF

# 8. Deployment summary
cat > queries/deployment_summary.sql << 'EOF'
-- Get detailed summary for deployment ID 1
SELECT 
    d.DEPLOY_ID,
    d.EVIDENCE_NAME,
    d.STATUS AS DEPLOY_STATUS,
    COUNT(DISTINCT act.ACTIVITY_ID) AS TOTAL_ACTIVITIES,
    COUNT(DISTINCT a.ACTION_ID) AS TOTAL_ACTIONS,
    COUNT(DISTINCT s.STEP_ID) AS TOTAL_STEPS,
    COUNT(DISTINCT art.ARTIFACT_ID) AS TOTAL_ARTIFACTS,
    SUM(CASE WHEN s.STATUS = 'SUCCESS' THEN 1 ELSE 0 END) AS SUCCESSFUL_STEPS,
    SUM(CASE WHEN s.STATUS = 'FAILED' THEN 1 ELSE 0 END) AS FAILED_STEPS,
    SUM(s.DURATION) AS TOTAL_DURATION
FROM DEPLOYZ.DEPLOY d
LEFT JOIN DEPLOYZ.ACTIVITY act ON d.DEPLOY_ID = act.DEPLOY_ID
LEFT JOIN DEPLOYZ.ACTION a ON act.ACTIVITY_ID = a.ACTIVITY_ID
LEFT JOIN DEPLOYZ.STEP s ON a.ACTION_ID = s.ACTION_ID
LEFT JOIN DEPLOYZ.STEP_ARTIFACT sa ON s.STEP_ID = sa.STEP_ID
LEFT JOIN DEPLOYZ.ARTIFACT art ON sa.ARTIFACT_ID = art.ARTIFACT_ID
WHERE d.DEPLOY_ID = 1
GROUP BY d.DEPLOY_ID, d.EVIDENCE_NAME, d.STATUS;
EOF

# Create README for queries
cat > queries/README.md << 'EOF'
# Example SQL Queries

This directory contains example SQL queries for the Evidence database.

## Usage

```bash
# Execute query and print JSON
python sql_to_json.py queries/list_deployments.sql

# Save to file
python sql_to_json.py queries/deployment_statistics.sql stats.json
```

## Available Queries

- **list_deployments.sql** - List all deployments
- **deployment_statistics.sql** - Overall statistics
- **failed_deployments.sql** - Failed deployments with details
- **shared_artifacts.sql** - Artifacts used multiple times
- **failed_steps.sql** - All failed steps
- **environment_comparison.sql** - Compare environments
- **recent_deployments.sql** - Recent deployments (7 days)
- **deployment_summary.sql** - Detailed deployment summary

## Creating Custom Queries

1. Create a `.sql` file in this directory
2. Write your SQL query
3. Run with: `python sql_to_json.py queries/your_query.sql`

See [SQL_TO_JSON.md](../SQL_TO_JSON.md) for more details.
EOF

echo "✓ Created queries directory with example files:"
ls -la queries/

echo ""
echo "You can now run queries like:"
echo "  python sql_to_json.py queries/list_deployments.sql"
echo "  python sql_to_json.py queries/deployment_statistics.sql stats.json"