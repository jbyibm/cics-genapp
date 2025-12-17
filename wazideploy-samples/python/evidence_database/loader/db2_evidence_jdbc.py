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
        logging.info("Connecting to DB2 using JDBC driver...")
        logging.info(f"  URL: {jdbc_url}")
        logging.info(f"  Username: {username}")
        logging.info(f"  Driver: {driver_class}")
        if driver_paths:
            logging.info(f"  JAR: {driver_paths}")

        jdbc_url = f"{jdbc_url}:"
        url_options = jdbc_config.get('url_options', [])
        if len(url_options) > 0:
            jdbc_url += ";".join(url_options) + ";"

        jvm_args = jdbc_config.get('jvm_args', [])

        self.conn = jaydebeapi.connect(
            driver_class,
            jdbc_url,
            [username, password] if username else [],
            driver_paths,
            jvm_args
        )
        self.cursor = self.conn.cursor()
        logging.info("Connected successfully")

    def _execute(self, sql: str, params):
        """Execute SQL with parameters"""
        # JayDeBeApi accepts list for parameters
        self.cursor.execute(sql, params)

    def _query(self, sql: str, params):
        """Execute SQL with parameters and return results"""
        sql = sql.strip()
        self.cursor.execute(sql, params)

        # Check if it's a SELECT query
        if self.cursor.description is None:
            return None

        # Get column names and convert Java strings to Python strings
        columns = [str(desc[0]) for desc in self.cursor.description]  # <- str() conversion

        # Fetch all rows
        rows = self.cursor.fetchall()

        # Convert to list of dictionaries
        results = []
        for row in rows:
            row_dict = {}
            for col_name, value in zip(columns, row):
                # Convert value if it's a Java object
                if value is not None:
                    if hasattr(value, '__class__') and 'java' in str(value.__class__):
                        value = str(value)  # Convert Java objects to string
                row_dict[col_name] = value
            results.append(row_dict)

        return results

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
                logging.info("Connection closed")
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
