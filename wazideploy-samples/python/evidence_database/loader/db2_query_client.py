#!/usr/bin/env python3
#*******************************************************************************
# DB2 Evidence Query Client
#
# Execute SQL queries using the same DB2 configuration/loader mechanism
# as db2_evidence_client.py.
#
# Examples:
#   python3 db2_query_client.py -q "SELECT COUNT(*) FROM DEPLOYZ.DEPLOY"
#   python3 db2_query_client.py --json-test
#   python3 db2_query_client.py --deploy-json
#   python3 db2_query_client.py -f query.sql
#   python3 db2_query_client.py -c db2_config.yaml -d jdbc --json-test
#*******************************************************************************

import argparse
import logging
import sys
from typing import Optional, List, Any

from db2_config import load_config


class DB2QueryClient:
    """
    Generic DB2 query client.
    Uses the same loader classes as the evidence loader:
      - db2_evidence_jdbc.DB2EvidenceLoaderJDBC
      - db2_evidence_ibm.DB2EvidenceLoaderIBM
    """

    def __init__(self, config_file: str = "db2_config.yaml", driver: Optional[str] = None):
        self.config_file = config_file
        self.config = load_config(config_file)
        self.loader = None

        if driver:
            self.driver_type = self._normalize_driver(driver)
        else:
            self.driver_type = self._normalize_driver(getattr(self.config, "driver", "jdbc"))

        self._create_loader()

    @staticmethod
    def _normalize_driver(driver: str) -> str:
        driver = driver.lower().strip()
        if driver in ("ibm", "ibm_db"):
            return "ibm"
        if driver == "jdbc":
            return "jdbc"
        logging.warning("Invalid driver '%s', defaulting to jdbc", driver)
        return "jdbc"

    def _create_loader(self):
        logging.info("Creating loader with %s driver", self.driver_type.upper())

        if self.driver_type == "jdbc":
            try:
                from db2_evidence_jdbc import DB2EvidenceLoaderJDBC
                self.loader = DB2EvidenceLoaderJDBC(config_file=self.config_file)
            except ImportError as exc:
                raise RuntimeError(
                    "JDBC driver selected but jaydebeapi is not available. "
                    "Install with: pip install jaydebeapi"
                ) from exc

        elif self.driver_type == "ibm":
            try:
                from db2_evidence_ibm import DB2EvidenceLoaderIBM
                self.loader = DB2EvidenceLoaderIBM(config_file=self.config_file)
            except ImportError as exc:
                raise RuntimeError(
                    "IBM driver selected but ibm_db is not available. "
                    "Install with: pip install ibm_db"
                ) from exc

        else:
            raise ValueError(f"Unknown driver type: {self.driver_type}")

    def close(self):
        if self.loader:
            self.loader.close()

    def _get_connection(self):
        """
        Most existing loaders expose self.conn.
        This method keeps the error explicit if the loader differs.
        """
        conn = getattr(self.loader, "conn", None)
        if conn is None:
            raise RuntimeError("The selected loader does not expose a 'conn' connection object")
        return conn

    def execute_query(self, sql: str, max_width: int = 120):
        """
        Execute SQL and print rows.
        Works for SELECT, VALUES, INSERT, UPDATE, DELETE, SET, etc.
        """
        conn = self._get_connection()
        cursor = conn.cursor()

        print("\nSQL:")
        print(sql.strip())
        print("-" * 100)

        try:
            cursor.execute(sql)

            description = getattr(cursor, "description", None)

            # No result set: INSERT / UPDATE / SET / COMMIT / etc.
            if not description:
                rowcount = getattr(cursor, "rowcount", None)
                print("Statement executed successfully.")
                if rowcount is not None and rowcount >= 0:
                    print(f"Rows affected: {rowcount}")
                return

            columns = [col[0] for col in description]
            rows = cursor.fetchall()

            if not rows:
                print("No rows returned.")
                return

            self._print_table(columns, rows, max_width=max_width)
        except Exception as e:
            raise e
        finally:
            try:
                cursor.close()
            except Exception:
                pass

    @staticmethod
    def _format_value(value: Any, max_width: int) -> str:
        if value is None:
            return "NULL"

        text = str(value)

        # Make multiline values readable
        text = text.replace("\r", "\\r").replace("\n", "\\n")

        if len(text) > max_width:
            return text[: max_width - 3] + "..."

        return text

    def _print_table(self, columns: List[str], rows: List[Any], max_width: int = 120):
        formatted_rows = [
            [self._format_value(value, max_width=max_width) for value in row]
            for row in rows
        ]

        col_widths = []
        for idx, column in enumerate(columns):
            max_len = len(str(column))
            for row in formatted_rows:
                max_len = max(max_len, len(row[idx]))
            col_widths.append(min(max_len, max_width))

        header = " | ".join(str(col).ljust(col_widths[idx]) for idx, col in enumerate(columns))
        sep = "-+-".join("-" * width for width in col_widths)

        print(header)
        print(sep)

        for row in formatted_rows:
            print(" | ".join(row[idx].ljust(col_widths[idx]) for idx in range(len(columns))))

        print(f"\n{len(rows)} row(s).")

    def run_json_smoke_test(self):
        sql = """
    SELECT JSON_VAL(
        SYSTOOLS.JSON2BSON('{"environment_name":"TEST"}'),
        'environment_name',
        's:255'
    ) AS ENV
    FROM SYSIBM.SYSDUMMY1
    """
        self.execute_query(sql)

    def run_deploy_json_query(self):
        sql = """
SELECT
    d.DEPLOY_ID,

    JSON_VAL(
        SYSTOOLS.JSON2BSON(d.DEPLOY_METADATA_ANNOTATIONS),
        'environment_name',
        's:255'
    ) AS ENVIRONMENT_NAME,

    JSON_VAL(
        SYSTOOLS.JSON2BSON(d.DEPLOY_METADATA_ANNOTATIONS),
        'deploy_timestamp',
        's:32'
    ) AS DEPLOY_TIMESTAMP_JSON,

    JSON_VAL(
        SYSTOOLS.JSON2BSON(d.DEPLOY_METADATA_ANNOTATIONS),
        'engine.version',
        's:50'
    ) AS ENGINE_VERSION,

    JSON_VAL(
        SYSTOOLS.JSON2BSON(d.DEPLOY_METADATA_ANNOTATIONS),
        'package.path',
        's:500'
    ) AS PACKAGE_PATH,

    JSON_VAL(
        SYSTOOLS.JSON2BSON(d.DEPLOY_METADATA_ANNOTATIONS),
        'package.sha256',
        's:64'
    ) AS PACKAGE_SHA256,

    JSON_VAL(
        SYSTOOLS.JSON2BSON(d.DEPLOY_METADATA_ANNOTATIONS),
        'runtime_context.zoau_version',
        's:50'
    ) AS ZOAU_VERSION,

    JSON_VAL(
        SYSTOOLS.JSON2BSON(d.DEPLOY_METADATA_ANNOTATIONS),
        'smf_record.status',
        's:50'
    ) AS SMF_STATUS

FROM DEPLOYZ.DEPLOY d
"""
        self.execute_query(sql)


def parse_arguments():
    parser = argparse.ArgumentParser(
        description="DB2 Query Client",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 db2_query_client.py -q "SELECT COUNT(*) FROM DEPLOYZ.DEPLOY"
  python3 db2_query_client.py --json-test
  python3 db2_query_client.py --deploy-json
  python3 db2_query_client.py -f query.sql
  python3 db2_query_client.py -c db2_config.yaml -d jdbc --deploy-json
"""
    )

    parser.add_argument(
        "-c", "--config",
        dest="config_file",
        default="db2_config.yaml",
        help="Path to config file, default: db2_config.yaml"
    )

    parser.add_argument(
        "-d", "--driver",
        choices=["jdbc", "ibm", "ibm_db"],
        help="Driver to use: jdbc, ibm, or ibm_db"
    )

    parser.add_argument(
        "-q", "--query",
        dest="query",
        help="SQL query to execute"
    )

    parser.add_argument(
        "-f", "--sql-file",
        dest="sql_file",
        help="File containing SQL to execute"
    )

    parser.add_argument(
        "--json-test",
        action="store_true",
        help="Run a minimal JSON_VAL / JSON2BSON smoke test"
    )

    parser.add_argument(
        "--deploy-json",
        action="store_true",
        help="Run JSON extraction query against DEPLOYZ.DEPLOY"
    )

    parser.add_argument(
        "--max-width",
        type=int,
        default=120,
        help="Maximum display width per column, default: 120"
    )

    parser.add_argument(
        "-v", "--verbose",
        action="store_true",
        help="Enable debug logging"
    )

    return parser.parse_args()


def main():
    args = parse_arguments()

    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(asctime)s %(levelname)s %(message)s"
    )

    if not args.query and not args.sql_file and not args.json_test and not args.deploy_json:
        print("Nothing to execute. Use -q, -f, --json-test, or --deploy-json.")
        sys.exit(2)

    client = None

    try:
        client = DB2QueryClient(config_file=args.config_file, driver=args.driver)

        if args.deploy_json:
            client.run_deploy_json_query()

        if args.query:
            client.execute_query(args.query, max_width=args.max_width)

        if args.sql_file:
            with open(args.sql_file, "r", encoding="utf-8") as handle:
                sql = handle.read()
            client.execute_query(sql, max_width=args.max_width)

    except Exception as exc:
        print(f"[ERROR] {exc}")
        logging.error("Query failed", exc_info=True)
        sys.exit(1)

    finally:
        if client:
            client.close()


if __name__ == "__main__":
    main()
