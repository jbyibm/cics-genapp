#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

import logging
from db2_evidence_base import DB2EvidenceLoaderBase
from db2_config import load_config
import re
import os
import sys


class DB2EvidenceLoaderIBM(DB2EvidenceLoaderBase):

    def __init__(self, config_file='db2_config.yaml'):
        self.config = load_config(config_file)
        super().__init__(self.config.schema)
        if sys.platform == 'win32':
            self._setup_windows_environment()
        import ibm_db
        conn_str = self.config.get_ibm_db_connection_string()
        logging.info("Connecting to DB2 using ibm_db driver...")
        self.conn = ibm_db.connect(conn_str, "", "")
        if not self.conn:
            raise RuntimeError("DB2 connection failed")

        logging.info("Connected using ibm_db")

    def _setup_windows_environment(self):
        """Setup Windows DLL environment for ibm_db"""
        if sys.platform != 'win32':
            return

        win_config = self.config.get_windows_config()
        if not win_config.get('auto_configure', True):
            return

        clidriver = win_config.get('clidriver', r'C:\clidriver')

        if not os.path.exists(clidriver):
            logging.warning(f"CLI driver not found at: {clidriver}")
            return

        logging.info(f"Configuring Windows environment for CLI driver: {clidriver}")
        os.environ['IBM_DB_HOME'] = clidriver
        os.environ['IBM_DB_LIB'] = os.path.join(clidriver, 'lib')
        os.environ['IBM_DB_INCLUDE'] = os.path.join(clidriver, 'include')
        os.environ['PATH'] = (os.path.join(clidriver, 'bin\\amd64.VC12.CRT') + ';' +
                             os.path.join(clidriver, 'bin') + ';' +
                             os.environ.get('PATH', ''))

        try:
            os.add_dll_directory(os.path.join(clidriver, 'bin'))
        except (AttributeError, OSError) as e:
            logging.warning(f"Could not add DLL directory: {e}")

    def _execute(self, sql: str, params):
        import ibm_db
        stmt = ibm_db.prepare(self.conn, sql)
        if not stmt:
            raise Exception(f"Prepare failed: {ibm_db.stmt_errormsg()}")
        if not ibm_db.execute(stmt, tuple(params or ())):
            raise Exception(f"Execute failed: {ibm_db.stmt_errormsg()}")
        return stmt

    def _query(self, sql: str, params):
        import ibm_db
        results = []
        stmt = self._execute(sql, params)
        num_fields = ibm_db.num_fields(stmt)
        column_names = []
        try:
            column_names = [ibm_db.field_name(stmt, i) for i in range(num_fields)]
        except (UnicodeDecodeError, SystemError):
            sql_clean = ' '.join(sql.split())
            match = re.search(r'SELECT\s+(.*?)\s+FROM', sql_clean, re.IGNORECASE)
            if match:
                columns_str = match.group(1).strip()
                cols = [col.strip() for col in columns_str.split(',')]
                column_names = []
                for col in cols:
                    parts = col.split()
                    if 'AS' in [p.upper() for p in parts]:
                        column_names.append(parts[-1])
                    else:
                        column_names.append(parts[-1].split('.')[-1])
            else:
                column_names = [f"COLUMN_{i}" for i in range(num_fields)]
        results = []
        row = ibm_db.fetch_tuple(stmt)
        while row:
            row_dict = dict(zip(column_names, row))
            results.append(row_dict)
            row = ibm_db.fetch_tuple(stmt)
        return results

    def _commit(self):
        import ibm_db
        ibm_db.commit(self.conn)

    def close(self):
        import ibm_db
        ibm_db.close(self.conn)
