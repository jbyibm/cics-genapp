#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

"""
DB2 Evidence Loader - IBM DB Implementation
Uses ibm_db and ibm_db_dbi drivers
"""

import os
import sys
import logging

from db2_evidence_base import DB2EvidenceLoaderBase, SQL_GET_IDENTITY
from db2_config import load_config

logger = logging.getLogger(__name__)


class DB2EvidenceLoaderIBM(DB2EvidenceLoaderBase):
    """DB2 Evidence Loader using ibm_db driver"""

    def __init__(self, config_file: str='config.yaml'):
        """
        Initialize DB2 connection using ibm_db from configuration file
        
        Args:
            config_file: Path to YAML configuration file
        """
        # Load configuration
        self.config = load_config(config_file)

        # Setup Windows environment if needed
        self._setup_windows_environment()

        # Initialize base class with schema from config
        super().__init__(self.config.schema)

        # Build connection string and connect
        db_connection_string = self.config.get_ibm_db_connection_string()

        import ibm_db
        import ibm_db_dbi
        logger.info("Connecting to DB2 using ibm_db driver...")
        self.conn = ibm_db.connect(db_connection_string, "", "")
        self.dbi_conn = ibm_db_dbi.Connection(self.conn)
        self.cursor = self.dbi_conn.cursor()
        logger.info("Connected successfully")

    def _init_connection(self):
        pass

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
                logger.info("Connection closed")
            except:
                pass  # Connection already closed


# Example usage
if __name__ == "__main__":

    # Check arguments
    if len(sys.argv) < 2:
        print("Usage: python db2_evidence_loader_ibm.py <yaml_evidence_file> [config_file]")
        print("\nExample:")
        print("  python db2_evidence_loader_ibm.py evidence.yml")
        print("  python db2_evidence_loader_ibm.py evidence.yml my_config.yaml")
        sys.exit(1)

    yaml_file = sys.argv[1]
    config_file = sys.argv[2] if len(sys.argv) > 2 else 'db2_config.yaml'

    try:
        logger.info(f"Starting evidence loading from: {yaml_file}")
        logger.info(f"Using configuration: {config_file}")

        # Create loader with config file
        loader = DB2EvidenceLoaderIBM(config_file=config_file)

        # Load evidence file
        deploy_id = loader.load_evidence_file(yaml_file)

        print(f"\n✓ Evidence loaded successfully (Deploy ID: {deploy_id})")
        logger.info(f"Evidence loaded successfully (Deploy ID: {deploy_id})")

        # Close connection
        loader.close()

    except FileNotFoundError as e:
        print(f"✗ File not found: {e}")
        logger.error(f"File not found: {e}")
        sys.exit(1)

    except Exception as e:
        print(f"✗ Error during loading: {str(e)}")
        logger.error(f"Error during loading: {str(e)}", exc_info=True)
        sys.exit(1)
