#!/usr/bin/env python3

import json
import sys
import argparse
from datetime import datetime
from pathlib import Path
import html


def escape_html(text):
    """Escape HTML special characters"""
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
    now = datetime.now().strftime('%m/%d/%Y %H:%M:%S')

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
      max-width: 1200px;
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


def main():
    parser = argparse.ArgumentParser(
        description='[Chart] Convert JSON file to HTML table',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python json2table.py data.json
  python json2table.py data.json -o table.html
  python json2table.py data.json -t "My Data" -o result.html
        """
    )

    parser.add_argument('input', help='Input JSON file')
    parser.add_argument('-o', '--output', default='output.html',
                       help='Output HTML file (default: output.html)')
    parser.add_argument('-t', '--title', default='JSON Table',
                       help='Table title (default: "JSON Table")')

    args = parser.parse_args()

    # Check if file exists
    input_path = Path(args.input)
    if not input_path.exists():
        print(f"[X] Error: File '{args.input}' does not exist.")
        sys.exit(1)

    try:
        # Read and parse JSON
        print(f"[Book] Reading {args.input}...")
        with open(input_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

        # Generate HTML
        print(f"[Settings]  Generating HTML table...")
        html_content = generate_html(data, args.title)

        # Write output file
        output_path = Path(args.output)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html_content)

        print(f"[OK] Table successfully generated: {args.output}")
        print(f"[Globe] Open it in your browser to view!")

    except json.JSONDecodeError as e:
        print(f"[X] Error: Invalid JSON - {e}")
        sys.exit(1)
    except ValueError as e:
        print(f"[X] Error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"[X] Unexpected error: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()
