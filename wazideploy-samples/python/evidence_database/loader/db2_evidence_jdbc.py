#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************
from typing import Optional
from datetime import datetime
import sys

"""
DB2 Evidence Loader - JDBC Implementation
Uses JayDeBeApi (JDBC) driver
"""

import logging
import jaydebeapi
from db2_evidence_base import DB2EvidenceLoaderBase
from db2_config import load_config

logger = logging.getLogger(__name__)


class DB2EvidenceLoaderJDBC(DB2EvidenceLoaderBase):
    """DB2 Evidence Loader using JayDeBeApi (JDBC)"""

    def __init__(self, config_file: str='db2_config.yaml'):
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
        driver_path_separator = ':'
        if sys.platform == 'win32':
            driver_path_separator = ';'
        driver_paths = driver_path_separator.join(jdbc_config['driver_paths'])
        driver_class = jdbc_config['driver_class']

        # Log connection (mask password)
        logger.info("Connecting to DB2 using JDBC driver...")
        logger.info(f"  URL: {jdbc_url}")
        logger.info(f"  Username: {username}")
        logger.info(f"  Driver: {driver_class}")
        if driver_paths:
            logger.info(f"  JAR: {driver_paths}")

        # Initialize connection
        if driver_paths:
            self.conn = jaydebeapi.connect(
                driver_class,
                jdbc_url,
                [username, password] if username else [],
                driver_paths
            )
        else:
            self.conn = jaydebeapi.connect(
                driver_class,
                jdbc_url,
                [username, password] if username else []
            )

        self.cursor = self.conn.cursor()
        logger.info("Connected successfully")

    def _init_connection(self):
        # Nothing to do but we need to override the super abstract method.
        pass

    def _execute(self, sql: str, params):
        """Execute SQL with parameters"""
        # JayDeBeApi accepts list for parameters
        self.cursor.execute(sql, params)

    def _commit(self):
        """Commit transaction"""
        self.conn.commit()

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

    def parse_timestamp(self, timestamp_str: str) -> Optional[str]:
        """
        Convert timestamp from YYYYMMDD.HHMMSS.mmm format to datetime
        
        Args:
            timestamp_str: Timestamp string (e.g. "20251123.082744.513")
            
        Returns:
            datetime object or None if invalid
        """
        if not timestamp_str:
            return None

        try:
            # Format: YYYYMMDD.HHMMSS.mmm
            date_part, time_part = timestamp_str.split('.')[:2]
            year = int(date_part[:4])
            month = int(date_part[4:6])
            day = int(date_part[6:8])
            hour = int(time_part[:2])
            minute = int(time_part[2:4])
            second = int(time_part[4:6])

            date_time = datetime(year, month, day, hour, minute, second)
            iso_str = date_time.strftime("%Y-%m-%d %H:%M:%S")
            return iso_str
        except (ValueError, IndexError):
            return None
