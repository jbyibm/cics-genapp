#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

import logging
import ibm_db
from db2_evidence_base import DB2EvidenceLoaderBase
from db2_config import load_config

logger = logging.getLogger(__name__)


class DB2EvidenceLoaderIBM(DB2EvidenceLoaderBase):

    def __init__(self, config_file='db2_config.yaml'):
        self.config = load_config(config_file)
        super().__init__(self.config.schema)

        conn_str = self.config.get_ibm_db_connection_string()
        self.conn = ibm_db.connect(conn_str, "", "")
        if not self.conn:
            raise RuntimeError("DB2 connection failed")

        logger.info("Connected using ibm_db")

    def _execute(self, sql: str, params):
        stmt = ibm_db.prepare(self.conn, sql)
        ibm_db.execute(stmt, tuple(params or ()))

    def _query(self, sql: str, params):
        stmt = ibm_db.prepare(self.conn, sql)
        ibm_db.execute(stmt, tuple(params or ()))

        results = []
        row = ibm_db.fetch_assoc(stmt)
        while row:
            results.append(row)
            row = ibm_db.fetch_assoc(stmt)
        return results

    def _commit(self):
        ibm_db.commit(self.conn)

    def close(self):
        ibm_db.close(self.conn)
