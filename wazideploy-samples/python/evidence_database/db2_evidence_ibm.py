#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2023, 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

"""
DB2 Evidence Loader - IBM DB Implementation
Uses ibm_db and ibm_db_dbi drivers
"""

import ibm_db
import ibm_db_dbi
from db2_evidence_loader_base import DB2EvidenceLoaderBase, SQL_GET_IDENTITY


class DB2EvidenceLoaderIBM(DB2EvidenceLoaderBase):
    """DB2 Evidence Loader using ibm_db driver"""

    def __init__(self, db_connection_string: str, schema: str = 'DEPLOYZ'):
        """
        Initialize DB2 connection using ibm_db
        
        Args:
            db_connection_string: DB2 connection string
                Format: "DATABASE=mydb;HOSTNAME=hostname;PORT=50000;PROTOCOL=TCPIP;UID=user;PWD=XXX;"
            schema: DB2 schema name (default: 'DEPLOYZ')
        """
        super().__init__(schema)
        
        self.conn = ibm_db.connect(db_connection_string, "", "")
        self.dbi_conn = ibm_db_dbi.Connection(self.conn)
        self.cursor = self.dbi_conn.cursor()

    def _execute(self, sql: str, params):
        """Execute SQL with parameters"""
        # ibm_db_dbi requires tuple for parameters
        self.cursor.execute(sql, tuple(params))

    def _commit(self):
        """Commit transaction"""
        self.dbi_conn.commit()

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
                
        if self.dbi_conn:
            try:
                self.dbi_conn.close()
            except:
                pass
                
        if self.conn:
            try:
                ibm_db.close(self.conn)
            except:
                pass  # Connection already closed


# Example usage
if __name__ == "__main__":
    import os
    import sys
    
    # Windows DLL loading workaround for ibm_db
    if sys.platform == 'win32':
        clidriver = r'D:\a\Db2\clidriver'
        if os.path.exists(clidriver):
            os.environ['IBM_DB_HOME'] = clidriver
            os.environ['IBM_DB_LIB'] = os.path.join(clidriver, 'lib')
            os.environ['IBM_DB_INCLUDE'] = os.path.join(clidriver, 'include')
            os.environ['PATH'] = os.path.join(clidriver, 'bin\\amd64.VC12.CRT') + ';' + \
                                os.path.join(clidriver, 'bin') + ';' + os.environ.get('PATH', '')
            os.add_dll_directory(os.path.join(clidriver, 'bin'))
    
    # DB2 connection configuration
    DB_CONNECTION = (
        "DATABASE=DEPLOY;"
        "HOSTNAME=localhost;"
        "PORT=50000;"
        "PROTOCOL=TCPIP;"
        "UID=db2inst1;"
        "PWD=password;"
    )
    
    # Path to YAML file
    YAML_FILE = "path/to/evidence.yml"
    
    try:
        # Create loader and load data
        loader = DB2EvidenceLoaderIBM(DB_CONNECTION)
        deploy_id = loader.load_evidence_file(YAML_FILE)
        
        print(f"\n✓ Evidence loaded successfully (Deploy ID: {deploy_id})")
        
        # Close connection
        loader.close()
        
    except Exception as e:
        print(f"✗ Error during loading: {str(e)}")
        raise
