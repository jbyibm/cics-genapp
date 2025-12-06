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
