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
from db2_evidence_client import DB2EvidenceLoaderClient
import datetime
import logging


class DB2JSONEncoder(json.JSONEncoder):
    """Custom JSON encoder for DB2 data types"""

    def default(self, obj):
        if isinstance(obj, (datetime.date, datetime.datetime)):
            return obj.isoformat()
        elif isinstance(obj, decimal.Decimal):
            return float(obj)
        elif isinstance(obj, bytes):
            return obj.decode('utf-8', errors='replace')
        elif hasattr(obj, '__dict__'):
            return obj.__dict__
        return super().default(obj)


def escape_html(text):
    """Escape HTML special characters"""
    import html
    return html.escape(str(text))


def generate_html(data, title="JSON Table"):
    """Generate HTML table code from JSON data (using IBM Carbon styles via CDN)"""

    headers = []
    table_data = []

    # Process JSON data
    if isinstance(data, list) and len(data) > 0:
        headers = list(data[0].keys())
        table_data = data
    elif isinstance(data, dict):
        headers = ['Key', 'Value']
        table_data = [{'Key': key, 'Value': json.dumps(value, ensure_ascii=False)}
                      for key, value in data.items()]
    else:
        raise ValueError("Unsupported JSON format. Use an array of objects or a single object.")

    # Generate table rows
    header_rows = '\n'.join(f'                  <th scope="col" class="bx--table-header">{escape_html(h)}</th>' for h in headers)

    body_rows = []
    for row in table_data:
        cells = '\n'.join(f'                  <td class="bx--table-column">{escape_html(row.get(h, ""))}</td>' for h in headers)
        body_rows.append(f'                <tr class="bx--table-row">\n{cells}\n                </tr>')

    body_html = '\n'.join(body_rows)
    now = datetime.datetime.now().strftime('%m/%d/%Y %H:%M:%S')

    # Use Carbon CDN CSS (unpkg) and minimal layout wrapper
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>{escape_html(title)}</title>

  <!-- IBM Carbon CSS (via CDN) -->
  <link rel="stylesheet" href="https://unpkg.com/carbon-components/css/carbon-components.min.css" />

  <!-- Optional: IBM Plex font (Carbon often uses it) -->
  <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600&display=swap" rel="stylesheet">

  <style>
    /* Small layout helpers - Carbon provides most visual styling */
    html, body {{
      height: 100%;
      margin: 0;
      font-family: 'IBM Plex Sans', -apple-system, 'Segoe UI', Roboto, sans-serif;
      background-color: #f4f6f8;
      padding: 32px;
    }}
    .container {{
      max-width:  100%;
      margin: 0 auto;
    }}
    .card {{
      background: #ffffff;
      border-radius: 6px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08);
      overflow: hidden;
    }}
    .card-header {{
      padding: 1rem 1.25rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #e0e0e0;
    }}
    .card-header h1 {{
      margin: 0;
      font-size: 1.125rem;
      font-weight: 600;
    }}
    .card-body {{
      padding: 1rem;
    }}
    .meta {{
      font-size: 0.875rem;
      color: #525252;
    }}

    /* Make table horizontally scrollable on small viewports */
    .table-scroll {{
      overflow-x: auto;
    }}

    /* Small padding tweak for carbon table cells so content breathes */
    .bx--table-header,
    .bx--table-column {{
      padding: 12px 16px;
    }}
  </style>
</head>
<body>
  <div class="container">
    <div class="card">
      <div class="card-header">
        <h1>{escape_html(title)}</h1>
        <div class="meta">{len(table_data)} row(s) * {len(headers)} column(s)</div>
      </div>
      <div class="card-body">
        <!-- Carbon data table container -->
        <div class="bx--data-table-container table-scroll" data-table>
          <table class="bx--data-table" data-table>
            <thead class="bx--data-table-header">
              <tr class="bx--table-head-row">
{header_rows}
              </tr>
            </thead>
            <tbody>
{body_html}
            </tbody>
          </table>
        </div>
      </div>
      <div class="card-footer" style="padding:12px 16px; border-top:1px solid #eee; font-size:0.875rem; color:#666;">
        Generated on {now}
      </div>
    </div>
  </div>

  <!-- Optional: include Carbon JS if you want interactive components (data-table behaviors, etc.) -->
  <!-- <script src="https://unpkg.com/carbon-components/scripts/carbon-components.min.js"></script> -->
</body>
</html>"""


import argparse


def parse_args():
    parser = argparse.ArgumentParser(
        description="Execute SQL file and output results as JSON or HTML."
    )

    parser.add_argument('-sf', '--sqlFile', required=True,
                       help='SQL file to execute (required)')

    parser.add_argument('-of', '--outputFile', default='ResultTable.html',
                       help='Output JSON file (optional, default: stdout)')

    parser.add_argument('-cf', '--configFile', default='db2_config.yaml',
                       help='Configuration file (optional, default: db2_config.yaml)')

    parser.add_argument('-t', '--title', default='Result Table',
                       help='Table title (default: "Result Table")')

    return parser.parse_args()


def main():
    """Main function"""

    args = parse_args()
    logging.info("SQL file:", args.sqlFile)
    logging.info("Output file:", args.outputFile)
    logging.info("Config file:", args.configFile)

    # Parse arguments
    sql_file = args.sqlFile
    output_file = args.outputFile
    config_file = args.configFile
    table_tiltle = args.title

    # Check SQL file exists
    sql_path = Path(sql_file)
    if not sql_path.exists():
        logging.info(f"Error: SQL file not found: {sql_file}", file=sys.stderr)
        sys.exit(1)

    try:
        # Read SQL
        sql = sql_path.read_text(encoding='utf-8')

        # Create client
        client = DB2EvidenceLoaderClient(config_file=config_file)

        # Display driver info
        info = client.get_driver_info()
        logging.info("[Chart] Driver Info:")
        logging.info(f"  Type: {info['driver_type'].upper()}")
        logging.info(f"  Schema: {info['schema']}")
        logging.info(f"  Config: {info['config_file']}")

        # Execute Query
        results = client.loader._query(sql.strip(), [])

        if results is None:
            logging.info("[X] Error: No results")
            sys.exit(1)

        # Convert to JSON
        json_output = json.dumps(results, indent=2, ensure_ascii=False, cls=DB2JSONEncoder)

        # Output
        if output_file:
            # Write to file
            if "html" in output_file:
                import html
                html_output = generate_html(json.loads(json_output), table_tiltle)
                Path(output_file).write_text(html_output, encoding='utf-8')
            elif "yaml" in output_file or "yml" in output_file:
                import yaml
                with open(output_file, 'w') as outfile:
                    yaml.dump(results, outfile, default_flow_style=False)
            else:
                Path(output_file).write_text(json_output, encoding='utf-8')
            logging.info(f"[OK] Results written to: {output_file}")
            logging.info(f"  Records: {len(results)}")
        else:
            # logging.info to stdout
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
