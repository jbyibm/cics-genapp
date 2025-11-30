#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

"""
Configuration loader for DB2 Evidence Loader
"""

import os
import yaml
import logging
from typing import Dict, Any
from pathlib import Path


class DB2Config:
    """Load and manage DB2 Evidence Loader configuration"""

    def __init__(self, config_file: str='config.yaml'):
        """
        Load configuration from YAML file
        
        Args:
            config_file: Path to configuration YAML file
        """
        self.config_file = config_file
        self.config = self._load_config()
        self._setup_logging()
        self._expand_env_vars()

    def _load_config(self) -> Dict[str, Any]:
        """Load YAML configuration file"""
        config_path = Path(self.config_file)

        if not config_path.exists():
            raise FileNotFoundError(f"Configuration file not found: {self.config_file}")

        with open(config_path, 'r') as f:
            config = yaml.safe_load(f)

        if not config:
            raise ValueError(f"Empty configuration file: {self.config_file}")

        return config

    def _expand_env_vars(self):
        """Expand environment variables in configuration values"""
        self._expand_dict(self.config)

    def _expand_dict(self, d: Dict[str, Any]):
        """Recursively expand environment variables in dictionary"""
        for key, value in d.items():
            if isinstance(value, str):
                # Replace ${VAR} or $VAR with environment variable
                if '${' in value or value.startswith('$'):
                    var_name = value.replace('${', '').replace('}', '').replace('$', '')
                    d[key] = os.environ.get(var_name, value)
            elif isinstance(value, dict):
                self._expand_dict(value)

    def _setup_logging(self):
        """Setup logging based on configuration"""
        log_config = self.config.get('logging', {})
        level = getattr(logging, log_config.get('level', 'INFO'))
        format_str = log_config.get('format', '%(asctime)s - %(name)s - %(levelname)s - %(message)s')

        logging.basicConfig(
            level=level,
            format=format_str,
            filename=log_config.get('file')
        )

    @property
    def driver(self) -> str:
        """Get selected driver: 'ibm_db' or 'jdbc'"""
        return self.config.get('driver', 'jdbc')

    @property
    def schema(self) -> str:
        """Get database schema name"""
        return self.config.get('schema', 'DEPLOYZ')

    def get_ibm_db_connection_string(self) -> str:
        """
        Build IBM DB connection string from configuration
        
        Returns:
            Connection string for ibm_db driver
        """
        ibm_config = self.config.get('ibm_db', {})

        conn_parts = [
            f"DATABASE={ibm_config.get('database', 'DEPLOY')}",
            f"HOSTNAME={ibm_config.get('hostname', 'localhost')}",
            f"PORT={ibm_config.get('port', 50000)}",
            f"PROTOCOL={ibm_config.get('protocol', 'TCPIP')}",
            f"UID={ibm_config.get('uid', '')}",
            f"PWD={ibm_config.get('pwd', '')}"
        ]

        return ';'.join(conn_parts) + ';'

    def get_jdbc_config(self) -> Dict[str, Any]:
        """
        Get JDBC configuration
        
        Returns:
            Dictionary with JDBC configuration
        """
        jdbc_config = self.config.get('jdbc', {})

        # Build JDBC URL if components provided
        if 'url' not in jdbc_config and 'hostname' in jdbc_config:
            hostname = jdbc_config.get('hostname', 'localhost')
            port = jdbc_config.get('port', 50000)
            database = jdbc_config.get('database', 'DEPLOY')
            jdbc_url = f"jdbc:db2://{hostname}:{port}/{database}"

            # Add SSL parameters if configured
            ssl_config = jdbc_config.get('ssl', {})
            if ssl_config.get('enabled'):
                ssl_params = [
                    "sslConnection=true",
                    f"sslTrustStoreLocation={ssl_config.get('trust_store', '')}",
                    f"sslTrustStorePassword={ssl_config.get('trust_store_password', '')}"
                ]
                jdbc_url += ':' + ';'.join(ssl_params) + ';'
        else:
            jdbc_url = jdbc_config.get('url', 'jdbc:db2://localhost:50000/DEPLOY')

        return {
            'url': jdbc_url,
            'username': jdbc_config.get('username', ''),
            'password': jdbc_config.get('password', ''),
            'driver_path': jdbc_config.get('driver_path'),
            'driver_class': jdbc_config.get('driver_class', 'com.ibm.db2.jcc.DB2Driver')
        }

    def get_windows_config(self) -> Dict[str, Any]:
        """Get Windows-specific configuration"""
        return self.config.get('windows', {})

    def get_options(self) -> Dict[str, Any]:
        """Get processing options"""
        return self.config.get('options', {})

    def is_verbose(self) -> bool:
        """Check if verbose mode is enabled"""
        return self.get_options().get('verbose', True)

    def should_stop_on_error(self) -> bool:
        """Check if should stop on first error"""
        return self.get_options().get('stop_on_error', False)

    def get_batch_size(self) -> int:
        """Get batch commit size"""
        return self.get_options().get('batch_size', 0)

    def __str__(self) -> str:
        """String representation (masks passwords)"""
        config_copy = self.config.copy()

        # Mask sensitive data
        if 'ibm_db' in config_copy:
            config_copy['ibm_db']['pwd'] = '***'
        if 'jdbc' in config_copy:
            config_copy['jdbc']['password'] = '***'

        return yaml.dump(config_copy, default_flow_style=False)


def load_config(config_file: str='db2_config.yaml') -> DB2Config:
    """
    Convenience function to load configuration
    
    Args:
        config_file: Path to configuration file
        
    Returns:
        DB2Config instance
    """
    return DB2Config(config_file)
