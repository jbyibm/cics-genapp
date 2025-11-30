#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

"""
DB2 Evidence Loader - JDBC Implementation
Uses JayDeBeApi (JDBC) driver
"""

import logging
import jaydebeapi
from db2_evidence_loader_base import DB2EvidenceLoaderBase, SQL_GET_IDENTITY
from db2_config import DB2Config, load_config

logger = logging.getLogger(__name__)


class DB2EvidenceLoaderJDBC(DB2EvidenceLoaderBase):
    """DB2 Evidence Loader using JayDeBeApi (JDBC)"""

    def __init__(self, config_file: str='config.yaml'):
        """
        Initialize DB2 connection using JayDeBeApi from configuration file
        
        Args:
            config_file: Path to YAML configuration file
        """
        # Load configuration
        self.config = load_config(config_file)

        # Initialize base class with schema from config
        super().__init__(self.config.schema)

        # Get JDBC configuration
        jdbc_config = self.config.get_jdbc_config()

        jdbc_url = jdbc_config['url']
        username = jdbc_config['username']
        password = jdbc_config['password']
        driver_path = jdbc_config['driver_path']
        driver_class = jdbc_config['driver_class']

        # Log connection (mask password)
        logger.info(f"Connecting to DB2 using JDBC driver...")
        logger.info(f"  URL: {jdbc_url}")
        logger.info(f"  Username: {username}")
        logger.info(f"  Driver: {driver_class}")
        if driver_path:
            logger.info(f"  JAR: {driver_path}")

        # Initialize connection
        if driver_path:
            self.conn = jaydebeapi.connect(
                driver_class,
                jdbc_url,
                [username, password] if username else [],
                driver_path
            )
        else:
            self.conn = jaydebeapi.connect(
                driver_class,
                jdbc_url,
                [username, password] if username else []
            )

        self.cursor = self.conn.cursor()
        logger.info("Connected successfully")

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
                logger.info("Connection closed")
            except:
                pass


# Example usage
if __name__ == "__main__":
    import sys

    # Check arguments
    if len(sys.argv) < 2:
        print("Usage: python db2_evidence_loader_jdbc.py <yaml_evidence_file> [config_file]")
        print("\nExample:")
        print("  python db2_evidence_loader_jdbc.py evidence.yml")
        print("  python db2_evidence_loader_jdbc.py evidence.yml my_config.yaml")
        sys.exit(1)

    yaml_file = sys.argv[1]
    config_file = sys.argv[2] if len(sys.argv) > 2 else 'config.yaml'

    try:
        logger.info(f"Starting evidence loading from: {yaml_file}")
        logger.info(f"Using configuration: {config_file}")

        # Create loader with config file
        loader = DB2EvidenceLoaderJDBC(config_file=config_file)

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
