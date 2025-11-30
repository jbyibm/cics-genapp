#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2023, 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

"""
DB2 Evidence Loader - JDBC Implementation
Uses JayDeBeApi (JDBC) driver
"""

import jaydebeapi
from db2_evidence_loader_base import DB2EvidenceLoaderBase, SQL_GET_IDENTITY


class DB2EvidenceLoaderJDBC(DB2EvidenceLoaderBase):
    """DB2 Evidence Loader using JayDeBeApi (JDBC)"""

    def __init__(self, db_connection_string: str, schema: str = 'DEPLOYZ',
                 jdbc_driver_path: str = None, 
                 jdbc_driver_class: str = 'com.ibm.db2.jcc.DB2Driver',
                 username: str = None,
                 password: str = None):
        """
        Initialize DB2 connection using JayDeBeApi
        
        Args:
            db_connection_string: JDBC connection string
                Format: "jdbc:db2://hostname:port/database"
                Or old format: "DATABASE=mydb;HOSTNAME=hostname;PORT=50000;..."
            schema: DB2 schema name (default: 'DEPLOYZ')
            jdbc_driver_path: Path to DB2 JDBC driver JAR file (db2jcc4.jar)
            jdbc_driver_class: JDBC driver class name (default: 'com.ibm.db2.jcc.DB2Driver')
            username: Database username (optional if in connection string)
            password: Database password (optional if in connection string)
        """
        super().__init__(schema)
        
        # Parse connection parameters from connection string if in old format
        if not db_connection_string.startswith('jdbc:'):
            # Convert from ibm_db format to JDBC format
            params = dict(item.split('=') for item in db_connection_string.split(';') if '=' in item)
            jdbc_url = (f"jdbc:db2://{params.get('HOSTNAME', 'localhost')}:"
                       f"{params.get('PORT', '50000')}/{params.get('DATABASE', 'DEPLOY')}")
            username = username or params.get('UID', '')
            password = password or params.get('PWD', '')
        else:
            jdbc_url = db_connection_string

        # Initialize connection
        if jdbc_driver_path:
            self.conn = jaydebeapi.connect(
                jdbc_driver_class,
                jdbc_url,
                [username, password] if username else [],
                jdbc_driver_path
            )
        else:
            self.conn = jaydebeapi.connect(
                jdbc_driver_class,
                jdbc_url,
                [username, password] if username else []
            )

        self.cursor = self.conn.cursor()

    def _execute(self, sql: str, params):
        """Execute SQL with parameters"""
        # JayDeBeApi accepts list for parameters
        self.cursor.execute(sql, params)

    def _commit(self):
        """Commit transaction"""
        self.conn.commit()

    def _get_identity(self) -> int:
        """Get last inserted identity value"""
        self.cursor.execute(SQL_GET_IDENTITY)
        return self.cursor.fetchone()[0]

    def close(self):
        """Close database connections"""
        if self.cursor:
            try:
                self.cursor.close()
            except:
                pass
                
        if self.conn:
            try:
                self.conn.close()
            except:
                pass


# Example usage
if __name__ == "__main__":
    # JDBC connection configuration
    JDBC_URL = "jdbc:db2://localhost:50000/DEPLOY"
    JDBC_DRIVER_PATH = "C:/path/to/db2jcc4.jar"  # Update this path
    USERNAME = "db2inst1"
    PASSWORD = "password"
    
    # Path to YAML file
    YAML_FILE = "path/to/evidence.yml"
    
    print("Example 1: Using JDBC URL format")
    print("-" * 80)
    
    try:
        # Create loader with JDBC URL
        loader = DB2EvidenceLoaderJDBC(
            db_connection_string=JDBC_URL,
            jdbc_driver_path=JDBC_DRIVER_PATH,
            username=USERNAME,
            password=PASSWORD
        )
        
        deploy_id = loader.load_evidence_file(YAML_FILE)
        print(f"\n✓ Evidence loaded successfully (Deploy ID: {deploy_id})")
        
        loader.close()
        
    except Exception as e:
        print(f"✗ Error during loading: {str(e)}")
    
    
    print("\n\nExample 2: Using old connection string format (auto-converted)")
    print("-" * 80)
    
    # Old format connection string (will be converted automatically)
    DB_CONNECTION_OLD = (
        "DATABASE=DEPLOY;"
        "HOSTNAME=localhost;"
        "PORT=50000;"
        "PROTOCOL=TCPIP;"
        "UID=db2inst1;"
        "PWD=password;"
    )
    
    try:
        # Create loader - connection string will be converted to JDBC format
        loader = DB2EvidenceLoaderJDBC(
            db_connection_string=DB_CONNECTION_OLD,
            jdbc_driver_path=JDBC_DRIVER_PATH
        )
        
        deploy_id = loader.load_evidence_file(YAML_FILE)
        print(f"\n✓ Evidence loaded successfully (Deploy ID: {deploy_id})")
        
        loader.close()
        
    except Exception as e:
        print(f"✗ Error during loading: {str(e)}")
