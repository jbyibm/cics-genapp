#!/usr/bin/env python3
#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2023, 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

"""
Simple SQL to JSON converter
Execute SQL from file and output JSON result
"""

import sys
import json
from pathlib import Path
from db2_evidence_client import DB2GenericClient


def main():
    """Main function"""

    # Check arguments
    if len(sys.argv) < 2:
        print("Usage: python sql_to_json.py <sql_file> [output_file] [config_file]")
        print()
        print("Arguments:")
        print("  sql_file      : SQL file to execute (required)")
        print("  output_file   : Output JSON file (optional, default: stdout)")
        print("  config_file   : Configuration file (optional, default: config.yaml)")
        print()
        print("Examples:")
        print("  python sql_to_json.py query.sql")
        print("  python sql_to_json.py query.sql result.json")
        print("  python sql_to_json.py query.sql result.json my_config.yaml")
        sys.exit(1)

    # Parse arguments
    sql_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else None
    config_file = sys.argv[3] if len(sys.argv) > 3 else 'db2_config.yaml'

    # Check SQL file exists
    sql_path = Path(sql_file)
    if not sql_path.exists():
        print(f"Error: SQL file not found: {sql_file}", file=sys.stderr)
        sys.exit(1)

    try:
        # Read SQL
        sql = sql_path.read_text(encoding='utf-8')

        # Execute query
        with DB2GenericClient(config_file=config_file) as client:
            results = client.execute_query(sql)

        # Convert to JSON
        json_output = json.dumps(results, indent=2, ensure_ascii=False)

        # Output
        if output_file:
            # Write to file
            Path(output_file).write_text(json_output, encoding='utf-8')
            print(f"✓ Results written to: {output_file}")
            print(f"  Records: {len(results)}")
        else:
            # Print to stdout
            print(json_output)

    except FileNotFoundError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    except Exception as e:
        print(f"Error executing query: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
