#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

import yaml
from datetime import datetime
from typing import Dict, Any, Optional
from abc import ABC, abstractmethod
import json

# SQL Constants
SQL_GET_IDENTITY = "VALUES IDENTITY_VAL_LOCAL()"


class DB2EvidenceLoaderBase(ABC):
    """Base class to load YAML evidence into DB2"""

    def __init__(self, schema: str='DEPLOYZ'):
        """
        Initialize base loader
        
        Args:
            schema: DB2 schema name (default: 'DEPLOYZ')
        """
        self.schema = schema
        self.conn = None
        self.cursor = None

    @abstractmethod
    def _init_connection(self, *args, **kwargs):
        """Initialize database connection - to be implemented by subclasses"""
        pass

    @abstractmethod
    def _execute(self, sql: str, params):
        """Execute SQL with parameters - to be implemented by subclasses"""
        pass

    @abstractmethod
    def _commit(self):
        """Commit transaction - to be implemented by subclasses"""
        pass

    @abstractmethod
    def _get_identity(self) -> int:
        """Get last inserted identity value - to be implemented by subclasses"""
        pass

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

        sql = f"""
        INSERT INTO {self.schema}.DEPLOY (
            DESCRIPTION, ENVIRONMENT_NAME, DEPLOY_TIMESTAMP,
            CREATION_TIMESTAMP, STATUS, ENGINE_VERSION, ENGINE_BUILD,
            ENGINE_DATE, PACKAGE_PATH, PACKAGE_SHA256
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """

        params = [
            metadata.get('description', ''),
            annotations.get('environment_name', ''),
            self.parse_timestamp(annotations.get('deploy_timestamp', '')),
            self.parse_timestamp(annotations.get('creation_timestamp', '')),
            evidence.get('status', ''),
            engine.get('version', ''),
            engine.get('build', ''),
            self.parse_timestamp(engine.get('date', '')) if isinstance(engine.get('date'), str) else None,
            package.get('path', ''),
            package.get('sha256', '')
        ]

        self._execute(sql, params)
        self._commit()

        return self._get_identity()

    def insert_property(self, entity_type: str, entity_id: int, deploy_id:int, prop: Dict[str, str]):
        """
        Insert a property into the generic PROPERTIES table
        
        Args:
            entity_type: Type of entity ('ACTIVITY', 'ACTION', or 'STEP')
            entity_id: ID of the entity
            prop: Dictionary containing 'key' and 'value'
        """
        sql = f"""
        INSERT INTO {self.schema}.PROPERTIES (ENTITY_TYPE, ENTITY_ID, PROPERTY_KEY, PROPERTY_VALUE, DEPLOY_ID)
        VALUES (?, ?, ?, ?, ?)
        """
        self._execute(sql, [entity_type, entity_id, prop.get('key', ''), prop.get('value', ''), deploy_id])
        self._commit()

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
            STATUS, MESSAGE
        ) VALUES (?, ?, ?, ?, ?, ?)
        """

        params = [
            deploy_id,
            activity.get('name', ''),
            activity.get('short_name', ''),
            activity.get('description', ''),
            activity_result.get('status', ''),
            activity_result.get('msg', '')
        ]

        self._execute(sql, params)
        self._commit()

        activity_id = self._get_identity()

        # Insert properties using generic table
        for prop in activity.get('properties', []):
            self.insert_property('ACTIVITY', activity_id, deploy_id, prop)

        return activity_id

    def insert_action(self, activity_id: int, deploy_id: int, action: Dict[str, Any]) -> int:
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
            STATUS, MESSAGE
        ) VALUES (?, ?, ?, ?, ?)
        """

        params = [
            activity_id,
            action.get('name', ''),
            action.get('description', ''),
            action_result.get('status', ''),
            action_result.get('msg', '')
        ]

        self._execute(sql, params)
        self._commit()

        action_id = self._get_identity()

        # Insert properties using generic table
        for prop in action.get('properties', []):
            self.insert_property('ACTION', action_id, deploy_id, prop)

        return action_id

    def insert_step(self, action_id: int, deploy_id: int, step: Dict[str, Any]) -> int:
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
            STATUS, MESSAGE
        ) VALUES (?, ?, ?, ?, ?)
        """

        params = [
            action_id,
            step.get('name', ''),
            step.get('description', ''),
            step_result.get('status', ''),
            step_result.get('msg', '')
        ]

        self._execute(sql, params)
        self._commit()

        step_id = self._get_identity()

        # Insert properties using generic table
        for prop in step.get('properties', []):
            self.insert_property('STEP', step_id, deploy_id, prop)

        return step_id

    def insert_artifact(self, step_id: int, deploy_id: int, artifact: Dict[str, Any]) -> int:
        """
        Insert an artifact or return existing artifact_id if path already exists
        Uniqueness is based on ARTIFACT_PATH
        
        Args:
            step_id: Parent step ID
            artifact: Artifact dictionary
            
        Returns:
            artifact_id (new or existing)
        """
        # Extract artifact properties
        properties = {prop['key']: prop['value'] for prop in artifact.get('properties', [])}
        artifact_path = properties.get('path', '')

        # Check if artifact with this path already exists
        check_sql = f"""
        SELECT ARTIFACT_ID FROM {self.schema}.ARTIFACT 
        WHERE ARTIFACT_PATH = ?
        """

        self._execute(check_sql, [artifact_path])
        existing = self.cursor.fetchone()

        if existing:
            # Artifact already exists, return existing ID
            artifact_id = existing[0]
            print(f"        Artifact already exists: {artifact_path} (ID: {artifact_id})")

            # Insert properties using generic table
            for prop in artifact.get('properties', []):
                self.insert_property('ARTIFACT', artifact_id, deploy_id, prop)

            # Create link between step and existing artifact
            self._link_step_artifact(step_id, artifact_id)
            return artifact_id

        # Insert new artifact
        sql = f"""
        INSERT INTO {self.schema}.ARTIFACT (
            ARTIFACT_NAME, ARTIFACT_PATH, ARTIFACT_TYPE
        ) VALUES (?, ?, ?)
        """

        params = [
            artifact.get('name', ''),
            artifact_path,
            properties.get('type', '')
        ]

        self._execute(sql, params)
        self._commit()

        artifact_id = self._get_identity()

        # Link step to artifact
        self._link_step_artifact(step_id, artifact_id)

        # Insert properties using generic table
        for prop in artifact.get('properties', []):
            self.insert_property('ARTIFACT', artifact_id, deploy_id, prop)

        return artifact_id

    def _link_step_artifact(self, step_id: int, artifact_id: int):
        """
        Create link between step and artifact in junction table
        
        Args:
            step_id: Step ID
            artifact_id: Artifact ID
        """
        sql = f"""
        INSERT INTO {self.schema}.STEP_ARTIFACT (STEP_ID, ARTIFACT_ID)
        VALUES (?, ?)
        """

        try:
            self._execute(sql, [step_id, artifact_id])
            self._commit()
        except:
            # Link may already exist, ignore duplicate key error
            pass

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
            STEP_ID, STATUS, MESSAGE, COMMAND, RESULT_COMMAND
        ) VALUES (?, ?, ?, ?, ?)
        """

        params = [
            int(step_id),  # STEP_ID INTEGER
            str(result.get('status', ''))[:50],  # STATUS VARCHAR(50)
            str(result.get('msg', ''))[:2000],  # MESSAGE VARCHAR(2000)
            str(results_data.get('command', ''))[:4000],  # COMMAND VARCHAR(4000)
            json.dumps(results_data)[:4000]  # RESULT_COMMAND VARCHAR(4000)
        ]

        self._execute(sql, params)
        self._commit()

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
                action_id = self.insert_action(activity_id, deploy_id, action)

                # Process steps
                for step in action.get('steps', []):
                    step_name = step.get('name', '')
                    print(f"      Processing step: {step_name}")
                    step_id = self.insert_step(action_id, deploy_id, step)

                    # Process artifacts
                    for artifact in step.get('artifacts', []):
                        self.insert_artifact(step_id, deploy_id, artifact)

                    # Process results
                    step_result = step.get('step_result', {})
                    for result in step_result.get('results', []):
                        self.insert_step_result_detail(step_id, result)

        print("Loading completed successfully!")
        return deploy_id

    @abstractmethod
    def close(self):
        """Close database connections - to be implemented by subclasses"""
        pass
