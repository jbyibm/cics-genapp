#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2023, 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

import os
import sys

# Windows DLL loading workaround for ibm_db
if sys.platform == 'win32':
    clidriver = r'D:\a\Db2\clidriver'
    os.environ['IBM_DB_HOME'] = clidriver
    os.environ['IBM_DB_LIB'] = os.path.join(clidriver, 'lib')
    os.environ['IBM_DB_INCLUDE'] = os.path.join(clidriver, 'include')
    os.environ['PATH'] = os.path.join(clidriver, 'bin\\amd64.VC12.CRT') + ';' + os.path.join(clidriver, 'bin') + ';' + os.environ.get('PATH', '')
    os.add_dll_directory(os.path.join(clidriver, 'bin'))

import yaml
import ibm_db
import ibm_db_dbi
from datetime import datetime
from typing import Dict, Any, Optional

# SQL Constants
SQL_GET_IDENTITY = "VALUES IDENTITY_VAL_LOCAL()"


class DB2EvidenceLoader:
    """Class to load YAML evidence into DB2"""

    def __init__(self, db_connection_string: str, schema: str='DEPLOYZ'):
        """
        Initialize DB2 connection
        
        Args:
            db_connection_string: DB2 connection string
                Format: "DATABASE=mydb;HOSTNAME=hostname;PORT=50000;PROTOCOL=TCPIP;UID=user;PWD=password;"
            schema: DB2 schema name (default: 'DEPLOYZ')
        """
        self.conn = ibm_db.connect(db_connection_string, "", "")
        self.dbi_conn = ibm_db_dbi.Connection(self.conn)
        self.cursor = self.dbi_conn.cursor()
        self.schema = schema

    def parse_timestamp(self, timestamp_str: str) -> Optional[datetime]:
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

            return datetime(year, month, day, hour, minute, second)
        except (ValueError, IndexError):
            return None

    def insert_deploy(self, evidence: Dict[str, Any]) -> int:
        """
        Insert main DEPLOY record
        
        Args:
            evidence: Dictionary containing YAML data
            
        Returns:
            Generated deploy_id
        """
        metadata = evidence.get('metadata', {})
        annotations = metadata.get('annotations', {})
        engine = annotations.get('engine', {})
        package = annotations.get('package', {})
        runtime_ctx = annotations.get('runtime_context', {})
        smf_record = annotations.get('smf_record', {})

        sql = f"""
        INSERT INTO {self.schema}.DEPLOY (
            EVIDENCE_NAME, DESCRIPTION, ENVIRONMENT_NAME, DEPLOY_TIMESTAMP,
            CREATION_TIMESTAMP, STATUS, ENGINE_VERSION, ENGINE_BUILD,
            ENGINE_DATE, PACKAGE_PATH, PACKAGE_SHA256, ZOAU_VERSION,
            SMF_RECORD_STATUS
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """

        params = (
            metadata.get('name', ''),
            metadata.get('description', ''),
            annotations.get('environment_name', ''),
            self.parse_timestamp(annotations.get('deploy_timestamp', '')),
            self.parse_timestamp(annotations.get('creation_timestamp', '')),
            evidence.get('status', ''),
            engine.get('version', ''),
            engine.get('build', ''),
            self.parse_timestamp(engine.get('date', '')) if isinstance(engine.get('date'), str) else None,
            package.get('path', ''),
            package.get('sha256', ''),
            runtime_ctx.get('zoau_version', ''),
            smf_record.get('status', '')
        )

        self.cursor.execute(sql, params)
        self.dbi_conn.commit()

        # Retrieve generated ID
        self.cursor.execute(SQL_GET_IDENTITY)
        return self.cursor.fetchone()[0]

    def insert_property(self, entity_type: str, entity_id: int, prop: Dict[str, str]):
        """
        Insert a property into the generic PROPERTIES table
        
        Args:
            entity_type: Type of entity ('ACTIVITY', 'ACTION', or 'STEP')
            entity_id: ID of the entity
            prop: Dictionary containing 'key' and 'value'
        """
        sql = f"""
        INSERT INTO {self.schema}.PROPERTIES (ENTITY_TYPE, ENTITY_ID, PROPERTY_KEY, PROPERTY_VALUE)
        VALUES (?, ?, ?, ?)
        """
        self.cursor.execute(sql, (entity_type, entity_id, prop.get('key', ''), prop.get('value', '')))
        self.dbi_conn.commit()

    def insert_activity(self, deploy_id: int, activity: Dict[str, Any]) -> int:
        """
        Insert an activity
        
        Args:
            deploy_id: Parent deployment ID
            activity: Activity dictionary
            
        Returns:
            Generated activity_id
        """
        activity_result = activity.get('activity_result', {})

        sql = f"""
        INSERT INTO {self.schema}.ACTIVITY (
            DEPLOY_ID, ACTIVITY_NAME, SHORT_NAME, DESCRIPTION,
            STATUS, MESSAGE, LOOP_INDEX
        ) VALUES (?, ?, ?, ?, ?, ?, ?)
        """

        params = (
            deploy_id,
            activity.get('name', ''),
            activity.get('short_name', ''),
            activity.get('description', ''),
            activity_result.get('status', ''),
            activity_result.get('msg', ''),
            activity.get('loop_index', 0)
        )

        self.cursor.execute(sql, params)
        self.dbi_conn.commit()

        self.cursor.execute(SQL_GET_IDENTITY)
        activity_id = self.cursor.fetchone()[0]

        # Insert properties using generic table
        for prop in activity.get('properties', []):
            self.insert_property('ACTIVITY', activity_id, prop)

        return activity_id

    def insert_action(self, activity_id: int, action: Dict[str, Any]) -> int:
        """
        Insert an action
        
        Args:
            activity_id: Parent activity ID
            action: Action dictionary
            
        Returns:
            Generated action_id
        """
        action_result = action.get('action_result', {})

        sql = f"""
        INSERT INTO {self.schema}.ACTION (
            ACTIVITY_ID, ACTION_NAME, DESCRIPTION,
            STATUS, MESSAGE, LOOP_INDEX
        ) VALUES (?, ?, ?, ?, ?, ?)
        """

        params = (
            activity_id,
            action.get('name', ''),
            action.get('description', ''),
            action_result.get('status', ''),
            action_result.get('msg', ''),
            action.get('loop_index', 0)
        )

        self.cursor.execute(sql, params)
        self.dbi_conn.commit()

        self.cursor.execute(SQL_GET_IDENTITY)
        action_id = self.cursor.fetchone()[0]

        # Insert properties using generic table
        for prop in action.get('properties', []):
            self.insert_property('ACTION', action_id, prop)

        return action_id

    def insert_step(self, action_id: int, step: Dict[str, Any]) -> int:
        """
        Insert a step
        
        Args:
            action_id: Parent action ID
            step: Step dictionary
            
        Returns:
            Generated step_id
        """
        step_result = step.get('step_result', {})

        sql = f"""
        INSERT INTO {self.schema}.STEP (
            ACTION_ID, STEP_NAME, DESCRIPTION,
            STATUS, MESSAGE, DURATION, LOOP_INDEX
        ) VALUES (?, ?, ?, ?, ?, ?, ?)
        """

        params = (
            action_id,
            step.get('name', ''),
            step.get('description', ''),
            step_result.get('status', ''),
            step_result.get('msg', ''),
            step_result.get('duration', None),
            step.get('loop_index', 0)
        )

        self.cursor.execute(sql, params)
        self.dbi_conn.commit()

        self.cursor.execute(SQL_GET_IDENTITY)
        step_id = self.cursor.fetchone()[0]

        # Insert properties using generic table
        for prop in step.get('properties', []):
            self.insert_property('STEP', step_id, prop)

        return step_id

    def insert_artifact(self, step_id: int, artifact: Dict[str, Any]):
        """
        Insert an artifact
        
        Args:
            step_id: Parent step ID
            artifact: Artifact dictionary
        """
        # Extract artifact properties
        properties = {prop['key']: prop['value'] for prop in artifact.get('properties', [])}

        sql = f"""
        INSERT INTO {self.schema}.ARTIFACT (
            STEP_ID, ARTIFACT_NAME, ARTIFACT_HASH,
            ARTIFACT_PATH, ARTIFACT_TYPE, WD_MANIFEST_INDEX
        ) VALUES (?, ?, ?, ?, ?, ?)
        """

        params = (
            step_id,
            artifact.get('name', ''),
            artifact.get('hash', ''),
            properties.get('path', ''),
            properties.get('type', ''),
            int(properties.get('wd_manifest_index', 0)) if properties.get('wd_manifest_index') else None
        )

        self.cursor.execute(sql, params)
        self.dbi_conn.commit()

    def insert_step_result_detail(self, step_id: int, result: Dict[str, Any]):
        """
        Insert step result details
        
        Args:
            step_id: Parent step ID
            result: Result dictionary
        """
        results_data = result.get('results', {})

        sql = f"""
        INSERT INTO {self.schema}.STEP_RESULT_DETAIL (
            STEP_ID, STATUS, MESSAGE, COMMAND, RESULT_COMMAND, RETURN_CODE
        ) VALUES (?, ?, ?, ?, ?, ?)
        """

        params = (
            step_id,
            result.get('status', ''),
            result.get('msg', ''),
            results_data.get('command', ''),
            results_data.get('result_command', ''),
            results_data.get('rc', None)
        )

        self.cursor.execute(sql, params)
        self.dbi_conn.commit()

        self.cursor.execute(SQL_GET_IDENTITY)

    def load_evidence_file(self, yaml_file_path: str) -> int:
        """
        Load a YAML evidence file into the database
        
        Args:
            yaml_file_path: Path to YAML file
            
        Returns:
            Created deploy_id
        """
        # Load YAML file
        with open(yaml_file_path, 'r') as f:
            evidence = yaml.safe_load(f)

        print(f"Loading evidence: {evidence['metadata']['name']}")

        # Insert main deployment
        deploy_id = self.insert_deploy(evidence)
        print(f"  Deploy ID created: {deploy_id}")

        # Process activities
        for activity in evidence.get('activities', []):
            activity_name = activity.get('name', '')
            print(f"  Processing activity: {activity_name}")
            activity_id = self.insert_activity(deploy_id, activity)

            # Process actions
            for action in activity.get('actions', []):
                action_name = action.get('name', '')
                print(f"    Processing action: {action_name}")
                action_id = self.insert_action(activity_id, action)

                # Process steps
                for step in action.get('steps', []):
                    step_name = step.get('name', '')
                    print(f"      Processing step: {step_name}")
                    step_id = self.insert_step(action_id, step)

                    # Process artifacts
                    for artifact in step.get('artifacts', []):
                        self.insert_artifact(step_id, artifact)

                    # Process results
                    step_result = step.get('step_result', {})
                    for result in step_result.get('results', []):
                        self.insert_step_result_detail(step_id, result)

        print("Loading completed successfully!")
        return deploy_id

    def close(self):
        """Close database connections"""
        if self.cursor:
            self.cursor.close()
        if self.dbi_conn:
            self.dbi_conn.close()
        if self.conn:
            try:
                ibm_db.close(self.conn)
            except:
                pass  # Connection already closed


def main():
    """Main function"""
    # DB2 connection configuration
    DB_CONNECTION = (
        "DATABASE=DEPLOY;"
        "HOSTNAME=127.0.0.1;"
        "PORT=50000;"
        "PROTOCOL=TCPIP;"
        "UID=db2inst1;"
        "PWD=password;"
    )

    # Path to YAML file
    YAML_FILE = "C:/Users/Jean-YvesBaudy/git/wazi-deploy-samples/samples/environments/evidences/data/python/tivlp02.pok.stglabs.ibm.com_evidences_20251123_044148.yml"

    try:
        # Create loader and load data
        loader = DB2EvidenceLoader(DB_CONNECTION)
        deploy_id = loader.load_evidence_file(YAML_FILE)

        print(f"\n✓ Evidence loaded successfully (Deploy ID: {deploy_id})")

        # Close connection
        loader.close()

    except Exception as e:
        print(f"✗ Error during loading: {str(e)}")
        raise


if __name__ == "__main__":
    main()
