#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************
import argparse

"""
DB2 Evidence Loader - Generic Client
Uses driver specified in config file (default: jdbc)
"""

import sys
import logging
from typing import Optional
from db2_config import load_config


class DB2EvidenceClient:
    """
    Generic client for loading evidence files into DB2.
    Uses driver specified in config file (default: jdbc).
    Can be overridden via command line argument.
    """

    def __init__(self, config_file: str='db2_config.yaml', driver: Optional[str]=None):
        """
        Initialize the DB2 Evidence client
        
        Args:
            config_file: Path to YAML configuration file
            driver: Driver to use ('ibm' or 'jdbc'). If None, reads from config file (default: jdbc)
        """
        self.config_file = config_file
        self.loader = None
        self.driver_type = None

        # Load configuration to check parameters
        self.config = load_config(config_file)

        # Determine which driver to use
        # Priority: 1) Command line arg, 2) Config file, 3) Default to 'jdbc'
        if driver:
            self.driver_type = driver.lower()
        else:
            self.driver_type = getattr(self.config, 'driver', 'jdbc').lower()

        # Validate driver type
        if self.driver_type not in ['ibm', 'jdbc']:
            logging.warning(f"Invalid driver '{self.driver_type}' in config, defaulting to 'jdbc'")
            self.driver_type = 'jdbc'

        # Create the appropriate loader
        self._create_loader()

    def _create_loader(self):
        """Create the appropriate loader based on driver type"""
        logging.info(f"Creating loader with {self.driver_type.upper()} driver...")

        if self.driver_type == 'ibm':
            try:
                from db2_evidence_ibm import DB2EvidenceLoaderIBM
                self.loader = DB2EvidenceLoaderIBM(config_file=self.config_file)
                logging.info("IBM driver loader created successfully")
            except ImportError as e:
                logging.error(f"Failed to import IBM driver: {e}")
                raise RuntimeError(
                    "IBM driver selected but ibm_db module not available. "
                    "Install with: pip install ibm_db"
                )

        elif self.driver_type == 'jdbc':
            try:
                from db2_evidence_jdbc import DB2EvidenceLoaderJDBC
                self.loader = DB2EvidenceLoaderJDBC(config_file=self.config_file)
                logging.info("JDBC driver loader created successfully")
            except ImportError as e:
                logging.error(f"Failed to import JDBC driver: {e}")
                raise RuntimeError(
                    "JDBC driver selected but jaydebeapi module not available. "
                    "Install with: pip install jaydebeapi"
                )

        else:
            raise ValueError(f"Unknown driver type: {self.driver_type}")

    def load_evidence_file(self, yaml_file: str) -> str:
        """
        Load evidence from YAML file into DB2
        
        Args:
            yaml_file: Path to the evidence YAML file
            
        Returns:
            Deploy ID of the loaded evidence
        """
        if not self.loader:
            raise RuntimeError("Loader not initialized")

        logging.info(f"Loading evidence file: {yaml_file}")
        deploy_id = self.loader.load_evidence_file(yaml_file)
        logging.info(f"Evidence loaded successfully with Deploy ID: {deploy_id}")

        return deploy_id

    def close(self):
        """Close database connections"""
        if self.loader:
            self.loader.close()
            logging.info("Client connections closed")

    def get_driver_info(self) -> dict:
        """
        Get information about the current driver
        
        Returns:
            Dictionary with driver information
        """
        return {
            'driver_type': self.driver_type,
            'config_file': self.config_file,
            'schema': self.config.schema if self.config else None
        }


def parse_arguments():
    """Parse command line arguments using argparse."""
    parser = argparse.ArgumentParser(
        description='DB2 Evidence Client - Process evidence YAML files',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python db2_evidence_client.py -e evidence.yml
  python db2_evidence_client.py -e evidence.yml -c my_config.yaml
  python db2_evidence_client.py -e evidence.yml -c my_config.yaml -d jdbc
  python db2_evidence_client.py --evidence evidence.yml --driver ibm

Driver selection priority:
  1. Command line argument (if provided)
  2. Config file 'driver' parameter
  3. Default: 'jdbc'
        """
    )

    parser.add_argument(
        '-e', '--evidence',
        dest='yaml_evidence_file',
        required=True,
        help='Path to evidence YAML file (required)'
    )

    parser.add_argument(
        '-c', '--config',
        dest='config_file',
        default='db2_config.yaml',
        help='Path to config file (default: db2_config.yaml)'
    )

    parser.add_argument(
        '-d', '--driver',
        choices=['ibm_db', 'jdbc'],
        help="Driver to use: 'ibm_db' or 'jdbc' (overrides config file)"
    )

    return parser.parse_args()


# Usage in your main code
if __name__ == '__main__':
    args = parse_arguments()

    yaml_file = args.yaml_evidence_file
    config_file = args.config_file
    driver = args.driver

    try:
        # Create client
        client = DB2EvidenceClient(config_file=config_file, driver=driver)

        logging.info("Starting DB2 Evidence Client...")
        logging.info(f"Evidence file: {yaml_file}")
        logging.info(f"Configuration: {config_file}")
        if driver:
            logging.info(f"Driver: {driver} (override)")
        else:
            logging.info("Driver: from config file (or default: jdbc)")

        # Display driver info
        info = client.get_driver_info()
        logging.info("[Chart] Driver Info:")
        logging.info(f"  Type: {info['driver_type'].upper()}")
        logging.info(f"  Schema: {info['schema']}")
        logging.info(f"  Config: {info['config_file']}")

        # Load evidence file
        deploy_id = client.load_evidence_file(yaml_file)

        logging.info("[OK] Evidence loaded successfully!")
        logging.info(f"   Deploy ID: {deploy_id}")
        logging.info(f"Evidence loaded successfully (Deploy ID: {deploy_id})")

        # Close connection
        client.close()

    except FileNotFoundError as e:
        logging.info(f"[X] File not found: {e}")
        logging.error(f"File not found: {e}")
        sys.exit(1)

    except Exception as e:
        logging.info(f"[X] Error: {str(e)}")
        logging.error(f"Error during loading: {str(e)}", exc_info=True)
        sys.exit(1)
