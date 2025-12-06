#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************
import os
import sys

"""
DB2 Generic Client - Execute arbitrary SQL queries and return JSON
"""

import json
import logging
from typing import List, Dict, Any, Optional, Union
from datetime import datetime, date
from decimal import Decimal
from db2_config import load_config

logger = logging.getLogger(__name__)


class DB2GenericClient:
    """Generic client to execute SQL queries and return JSON results"""

    def __init__(self, config_file: str='db2_config.yaml'):
        """
        Initialize client from configuration file
        
        Args:
            config_file: Path to YAML configuration file
        """
        self.config = load_config(config_file)
        self.schema = self.config.schema
        self.conn = None
        self.cursor = None
        self._connect()

    def _connect(self):
        """Establish database connection based on driver configuration"""
        driver = self.config.driver

        if driver == 'ibm_db':
            self._connect_ibm_db()
        elif driver == 'jdbc':
            self._connect_jdbc()
        else:
            raise ValueError(f"Unknown driver: {driver}")

        logger.info("Connected to database")

    def _connect_ibm_db(self):
        """Connect using IBM DB driver"""
        self._setup_windows_environment()
        import ibm_db
        import ibm_db_dbi

        conn_string = self.config.get_ibm_db_connection_string()
        self.conn = ibm_db.connect(conn_string, "", "")
        self.dbi_conn = ibm_db_dbi.Connection(self.conn)
        self.cursor = self.dbi_conn.cursor()

    def _connect_jdbc(self):
        """Connect using JDBC driver"""
        import jaydebeapi

        jdbc_config = self.config.get_jdbc_config()

        if jdbc_config['driver_path']:
            self.conn = jaydebeapi.connect(
                jdbc_config['driver_class'],
                jdbc_config['url'],
                [jdbc_config['username'], jdbc_config['password']] if jdbc_config['username'] else [],
                jdbc_config['driver_path']
            )
        else:
            self.conn = jaydebeapi.connect(
                jdbc_config['driver_class'],
                jdbc_config['url'],
                [jdbc_config['username'], jdbc_config['password']] if jdbc_config['username'] else []
            )

        self.cursor = self.conn.cursor()

    def _setup_windows_environment(self):
        """Setup Windows DLL environment for ibm_db"""
        if sys.platform != 'win32':
            return

        win_config = self.config.get_windows_config()
        if not win_config.get('auto_configure', True):
            return

        clidriver = win_config.get('clidriver', r'C:\clidriver')

        if not os.path.exists(clidriver):
            logger.warning(f"CLI driver not found at: {clidriver}")
            return

        logger.info(f"Configuring Windows environment for CLI driver: {clidriver}")
        os.environ['IBM_DB_HOME'] = clidriver
        os.environ['IBM_DB_LIB'] = os.path.join(clidriver, 'lib')
        os.environ['IBM_DB_INCLUDE'] = os.path.join(clidriver, 'include')
        os.environ['PATH'] = (os.path.join(clidriver, 'bin\\amd64.VC12.CRT') + ';' +
                             os.path.join(clidriver, 'bin') + ';' +
                             os.environ.get('PATH', ''))

        try:
            os.add_dll_directory(os.path.join(clidriver, 'bin'))
        except (AttributeError, OSError) as e:
            logger.warning(f"Could not add DLL directory: {e}")

    def _convert_value(self, value: Any) -> Any:
        """
        Convert database value to JSON-serializable type
        
        Args:
            value: Database value
            
        Returns:
            JSON-serializable value
        """
        if value is None:
            return None
        elif isinstance(value, (datetime, date)):
            return value.isoformat()
        elif isinstance(value, Decimal):
            return float(value)
        elif isinstance(value, bytes):
            return value.decode('utf-8', errors='ignore')
        elif isinstance(value, (int, float, str, bool)):
            return value
        else:
            return str(value)

    def execute_query(self,
                     sql: str,
                     params: List=None,
                     as_dict: bool=True) -> Union[List[Dict[str, Any]], List[List[Any]]]:
        """
        Execute SQL query and return results
        
        Args:
            sql: SQL query to execute
            params: Optional query parameters
            as_dict: If True, return list of dicts; if False, return list of lists
            
        Returns:
            Query results as list of dictionaries or list of lists
            
        Example:
            >>> client.execute_query("SELECT * FROM DEPLOYZ.DEPLOY WHERE DEPLOY_ID = ?", [1])
            [{'DEPLOY_ID': 1, 'EVIDENCE_NAME': 'test', ...}]
        """
        try:
            # Replace {schema} placeholder with actual schema
            sql = sql.replace('{schema}', self.schema)

            # Execute query
            if params:
                self.cursor.execute(sql, params)
            else:
                self.cursor.execute(sql)

            # Fetch results
            rows = self.cursor.fetchall()

            if not rows:
                return []

            # Get column names
            columns = [desc[0] for desc in self.cursor.description]

            # Convert to desired format
            if as_dict:
                results = []
                for row in rows:
                    row_dict = {}
                    for col, val in zip(columns, row):
                        row_dict[col] = self._convert_value(val)
                    results.append(row_dict)
                return results
            else:
                return [[self._convert_value(val) for val in row] for row in rows]

        except Exception as e:
            logger.error(f"Query execution failed: {e}")
            logger.error(f"SQL: {sql}")
            logger.error(f"Params: {params}")
            raise

    def execute_query_to_json(self,
                             sql: str,
                             params: List=None,
                             indent: int=2) -> str:
        """
        Execute SQL query and return results as JSON string
        
        Args:
            sql: SQL query to execute
            params: Optional query parameters
            indent: JSON indentation (None for compact)
            
        Returns:
            JSON string
            
        Example:
            >>> json_str = client.execute_query_to_json("SELECT * FROM DEPLOYZ.DEPLOY LIMIT 5")
            >>> print(json_str)
        """
        results = self.execute_query(sql, params, as_dict=True)
        return json.dumps(results, indent=indent, ensure_ascii=False)

    def execute_query_single(self,
                            sql: str,
                            params: List=None) -> Optional[Dict[str, Any]]:
        """
        Execute SQL query and return single result
        
        Args:
            sql: SQL query to execute
            params: Optional query parameters
            
        Returns:
            Single result as dictionary or None
            
        Example:
            >>> result = client.execute_query_single("SELECT * FROM DEPLOYZ.DEPLOY WHERE DEPLOY_ID = ?", [1])
        """
        results = self.execute_query(sql, params, as_dict=True)
        return results[0] if results else None

    def execute_update(self,
                      sql: str,
                      params: List=None) -> int:
        """
        Execute UPDATE, INSERT, or DELETE statement
        
        Args:
            sql: SQL statement to execute
            params: Optional statement parameters
            
        Returns:
            Number of affected rows
            
        Example:
            >>> rows = client.execute_update("DELETE FROM DEPLOYZ.DEPLOY WHERE STATUS = ?", ['FAILED'])
        """
        try:
            # Replace {schema} placeholder
            sql = sql.replace('{schema}', self.schema)

            # Execute statement
            if params:
                self.cursor.execute(sql, params)
            else:
                self.cursor.execute(sql)

            # Commit
            if hasattr(self, 'dbi_conn'):
                self.dbi_conn.commit()
            else:
                self.conn.commit()

            # Return row count
            return self.cursor.rowcount if hasattr(self.cursor, 'rowcount') else 0

        except Exception as e:
            logger.error(f"Update execution failed: {e}")
            logger.error(f"SQL: {sql}")
            logger.error(f"Params: {params}")
            raise

    def execute_query_with_metadata(self,
                                   sql: str,
                                   params: List=None) -> Dict[str, Any]:
        """
        Execute SQL query and return results with metadata
        
        Args:
            sql: SQL query to execute
            params: Optional query parameters
            
        Returns:
            Dictionary with 'columns', 'data', and 'count' keys
            
        Example:
            >>> result = client.execute_query_with_metadata("SELECT * FROM DEPLOYZ.DEPLOY LIMIT 5")
            >>> print(result['columns'])  # ['DEPLOY_ID', 'EVIDENCE_NAME', ...]
            >>> print(result['count'])     # 5
        """
        results = self.execute_query(sql, params, as_dict=True)

        columns = []
        if results:
            columns = list(results[0].keys())

        return {
            'columns': columns,
            'data': results,
            'count': len(results)
        }

    def get_table_schema(self, table_name: str) -> List[Dict[str, Any]]:
        """
        Get table schema information
        
        Args:
            table_name: Table name (without schema)
            
        Returns:
            List of column definitions
            
        Example:
            >>> schema = client.get_table_schema('DEPLOY')
            >>> for col in schema:
            ...     print(f"{col['COLUMN_NAME']}: {col['DATA_TYPE']}")
        """
        sql = """
        SELECT 
            COLNAME AS COLUMN_NAME,
            TYPENAME AS DATA_TYPE,
            LENGTH AS MAX_LENGTH,
            SCALE AS DECIMAL_SCALE,
            NULLS AS IS_NULLABLE,
            DEFAULT AS COLUMN_DEFAULT
        FROM SYSCAT.COLUMNS
        WHERE TABSCHEMA = ? AND TABNAME = ?
        ORDER BY COLNO
        """

        return self.execute_query(sql, [self.schema, table_name.upper()])

    def get_tables(self) -> List[str]:
        """
        Get list of tables in schema
        
        Returns:
            List of table names
            
        Example:
            >>> tables = client.get_tables()
            >>> print(tables)
            ['DEPLOY', 'ACTIVITY', 'ACTION', 'STEP', 'ARTIFACT', ...]
        """
        sql = """
        SELECT TABNAME
        FROM SYSCAT.TABLES
        WHERE TABSCHEMA = ? AND TYPE = 'T'
        ORDER BY TABNAME
        """

        results = self.execute_query(sql, [self.schema])
        return [row['TABNAME'] for row in results]

    def get_views(self) -> List[str]:
        """
        Get list of views in schema
        
        Returns:
            List of view names
        """
        sql = """
        SELECT VIEWNAME
        FROM SYSCAT.VIEWS
        WHERE VIEWSCHEMA = ?
        ORDER BY VIEWNAME
        """

        results = self.execute_query(sql, [self.schema])
        return [row['VIEWNAME'] for row in results]

    def describe_table(self, table_name: str) -> str:
        """
        Get human-readable table description
        
        Args:
            table_name: Table name
            
        Returns:
            Formatted table description
        """
        schema = self.get_table_schema(table_name)

        if not schema:
            return f"Table {table_name} not found in schema {self.schema}"

        output = [f"\nTable: {self.schema}.{table_name}"]
        output.append("=" * 80)
        output.append(f"{'Column':<30} {'Type':<20} {'Nullable':<10}")
        output.append("-" * 80)

        for col in schema:
            col_name = col['COLUMN_NAME']
            data_type = col['DATA_TYPE']

            if col['MAX_LENGTH']:
                data_type += f"({col['MAX_LENGTH']})"

            nullable = "YES" if col['IS_NULLABLE'] == 'Y' else "NO"

            output.append(f"{col_name:<30} {data_type:<20} {nullable:<10}")

        return "\n".join(output)

    def close(self):
        """Close database connection"""
        if self.cursor:
            try:
                self.cursor.close()
            except:
                pass

        if hasattr(self, 'dbi_conn'):
            try:
                self.dbi_conn.close()
            except:
                pass

        if self.conn:
            try:
                self.conn.close()
            except:
                pass

        logger.info("Connection closed")

    def __enter__(self):
        """Context manager entry"""
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        self.close()


# Example usage
if __name__ == "__main__":

    with DB2GenericClient() as client:

        # Example 1: Simple query
        print("=" * 80)
        print("Example 1: Simple query")
        print("=" * 80)

        schema = "DEPLOYZ"
        sql = f"SELECT DEPLOY_ID, APPLICATION_NAME, STATUS FROM {schema}.DEPLOY ORDER BY DEPLOY_ID DESC FETCH FIRST 5 ROWS ONLY"
        results = client.execute_query(sql)
        print(json.dumps(results, indent=2))

        # Example 2: Query with parameters
        print("\n" + "=" * 80)
        print("Example 2: Query with parameters")
        print("=" * 80)

        sql = f"SELECT * FROM {schema}.DEPLOY WHERE DEPLOY_ID = ?"
        result = client.execute_query_single(sql, [1])
        print(json.dumps(result, indent=2))

        # Example 3: Get JSON string
        print("\n" + "=" * 80)
        print("Example 3: Get JSON string")
        print("=" * 80)

        sql = f"SELECT COUNT(*) AS TOTAL FROM {schema}.DEPLOY"
        json_str = client.execute_query_to_json(sql)
        print(json_str)

        # Example 4: Get metadata
        print("\n" + "=" * 80)
        print("Example 4: Query with metadata")
        print("=" * 80)

        sql = f"SELECT * FROM {schema}.DEPLOY FETCH FIRST 3 ROWS ONLY"
        result = client.execute_query_with_metadata(sql)
        print(f"Columns: {result['columns']}")
        print(f"Count: {result['count']}")
        print(f"Data: {json.dumps(result['data'], indent=2)}")

        # Example 5: List tables
        print("\n" + "=" * 80)
        print("Example 5: List tables")
        print("=" * 80)

        tables = client.get_tables()
        print(f"Tables in {client.schema}: {tables}")

        # Example 6: Describe table
        print("\n" + "=" * 80)
        print("Example 6: Describe table")
        print("=" * 80)

        print(client.describe_table('DEPLOY'))
