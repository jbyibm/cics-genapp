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
    """Generate HTML table code from JSON data"""

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
    header_rows = '\n'.join(f'            <th>{escape_html(h)}</th>' for h in headers)

    body_rows = []
    for row in table_data:
        cells = '\n'.join(f'            <td>{escape_html(row.get(h, ""))}</td>' for h in headers)
        body_rows.append(f'          <tr>\n{cells}\n          </tr>')

    body_html = '\n'.join(body_rows)
    now = datetime.now().strftime('%m/%d/%Y %H:%M:%S')

    return f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{escape_html(title)}</title>
  <style>
    * {{
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }}
    body {{
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      padding: 40px;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }}
    .container {{
      background: white;
      border-radius: 16px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      overflow: hidden;
      max-width: 1200px;
      width: 100%;
    }}
    .header {{
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      padding: 30px;
      color: white;
    }}
    .header h1 {{
      font-size: 28px;
      font-weight: 600;
      margin-bottom: 8px;
    }}
    .header p {{
      opacity: 0.9;
      font-size: 14px;
    }}
    .table-wrapper {{
      overflow-x: auto;
      padding: 30px;
    }}
    table {{
      width: 100%;
      border-collapse: collapse;
      background: white;
    }}
    thead {{
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }}
    th {{
      padding: 16px 20px;
      text-align: left;
      color: white;
      font-weight: 600;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }}
    td {{
      padding: 16px 20px;
      border-bottom: 1px solid #f0f0f0;
      color: #333;
      font-size: 15px;
    }}
    tbody tr {{
      transition: all 0.2s ease;
    }}
    tbody tr:hover {{
      background: #f8f9ff;
      transform: scale(1.01);
    }}
    tbody tr:last-child td {{
      border-bottom: none;
    }}
    .stats {{
      padding: 20px 30px;
      background: #f8f9ff;
      border-top: 1px solid #e0e0e0;
      color: #666;
      font-size: 14px;
    }}
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>📊 {escape_html(title)}</h1>
      <p>Automatically generated table from JSON</p>
    </div>
    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
{header_rows}
          </tr>
        </thead>
        <tbody>
{body_html}
        </tbody>
      </table>
    </div>
    <div class="stats">
      {len(table_data)} row(s) • {len(headers)} column(s) • Generated on {now}
    </div>
  </div>
</body>
</html>"""


def main():
    parser = argparse.ArgumentParser(
        description='📊 Convert JSON file to HTML table',
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
        print(f"❌ Error: File '{args.input}' does not exist.")
        sys.exit(1)

    try:
        # Read and parse JSON
        print(f"📖 Reading {args.input}...")
        with open(input_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

        # Generate HTML
        print(f"⚙️  Generating HTML table...")
        html_content = generate_html(data, args.title)

        # Write output file
        output_path = Path(args.output)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html_content)

        print(f"✅ Table successfully generated: {args.output}")
        print(f"🌐 Open it in your browser to view!")

    except json.JSONDecodeError as e:
        print(f"❌ Error: Invalid JSON - {e}")
        sys.exit(1)
    except ValueError as e:
        print(f"❌ Error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()
