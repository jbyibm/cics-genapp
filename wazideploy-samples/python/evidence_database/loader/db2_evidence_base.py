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
from typing import Dict, Any, Optional, List
from abc import ABC, abstractmethod
import json


class DB2EvidenceLoaderBase(ABC):
    """Base class to load YAML evidence into DB2"""

    def __init__(self, schema: str='DPYZ'):
        """
        Initialize base loader
        
        Args:
            schema: DB2 schema name (default: 'DEPLOYZ')
        """
        self.schema = schema
        self.conn = None
        self.cursor = None
        self.current_application_name = None  # Track current application
        self.tag_cache = {}  # Cache for tag_id by tag_name

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

    def get_or_create_tag(self, tag_name: str) -> int:
        """
        Get an existing tag or create a new one if it does not exist.
    
        Uses an in-memory cache to reduce database calls.
        Uses DB2 FINAL TABLE to safely retrieve the generated IDENTITY value.
        """
        # Check local cache first
        if tag_name in self.tag_cache:
            return self.tag_cache[tag_name]

        cursor = self.conn.cursor()

        # Check if the tag already exists in the database
        check_sql = f"""
        SELECT TAG_ID
        FROM {self.schema}.TAG
        WHERE TAG_NAME = ?
        """
        cursor.execute(check_sql, [tag_name])
        existing = cursor.fetchone()

        if existing:
            tag_id = int(existing[0])
            self.tag_cache[tag_name] = tag_id
            return tag_id

        # Insert a new tag and retrieve the generated TAG ID
        insert_sql = f"""
        SELECT TAG_ID
        FROM FINAL TABLE (
            INSERT INTO {self.schema}.TAG (TAG_NAME)
            VALUES (?)
        )
        """
        cursor.execute(insert_sql, [tag_name])
        self._commit()

        tag_id = int(cursor.fetchone()[0])

        # Update cache
        self.tag_cache[tag_name] = tag_id

        return tag_id

    def _link_entity_tags(self, entity_type: str, entity_id: int, tags: List[str]):
        """
        Link entity to tags
        
        Args:
            entity_type: Type of entity ('ACTIVITY', 'ACTION', or 'STEP')
            entity_id: ID of the entity
            tags: List of tag names
        """
        if not tags:
            return

        table_map = {
            'ACTIVITY': 'ACTIVITY_TAG',
            'ACTION': 'ACTION_TAG',
            'STEP': 'STEP_TAG'
        }

        if entity_type not in table_map:
            return

        junction_table = table_map[entity_type]
        entity_id_column = entity_type.lower() + '_id'

        for tag_name in tags:
            tag_id = self.get_or_create_tag(tag_name)

            sql = f"""
            INSERT INTO {self.schema}.{junction_table} ({entity_id_column}, TAG_ID)
            VALUES (?, ?)
            """

            try:
                self._execute(sql, [entity_id, tag_id])
                self._commit()
            except:
                # Link may already exist, ignore duplicate key error
                pass

    def insert_deploy(self, evidence: Dict[str, Any]) -> int:
        """
        Insert main DEPLOY record and return generated deploy_id
        """
        metadata = evidence.get('metadata', {})
        annotations = metadata.get('annotations', {})
        engine = annotations.get('engine', {})
        package = annotations.get('package', {})

        self.current_application_name = metadata.get('name', 'NONAME')

        sql = f"""
        SELECT DEPLOY_ID
        FROM FINAL TABLE (
            INSERT INTO {self.schema}.DEPLOY (
                DESCRIPTION,
                APPLICATION_NAME,
                APPLICATION_VERSION,
                ENVIRONMENT_NAME,
                DEPLOY_TIMESTAMP,
                CREATION_TIMESTAMP,
                STATUS,
                ENGINE_VERSION,
                ENGINE_BUILD,
                ENGINE_DATE,
                PACKAGE_PATH,
                PACKAGE_SHA256
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        )
        """

        params = [
            metadata.get('description', ''),
            self.current_application_name,
            metadata.get('version', '1.0.0'),
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

        cursor = self.conn.cursor()
        cursor.execute(sql, params)
        self._commit()

        deploy_id = cursor.fetchone()[0]
        return int(deploy_id)

    def insert_property(self, entity_type: str, entity_id: int, deploy_id: int, prop: Dict[str, str]):
        """
        Insert a property into the generic PROPERTIES table
        
        Args:
            entity_type: Type of entity ('ACTIVITY', 'ACTION', 'STEP', or 'ARTIFACT')
            entity_id: ID of the entity
            deploy_id: ID of the deployment
            prop: Dictionary containing 'key' and 'value'
        """
        # Skip wd_manifest_index property
        if prop.get('key', '') == 'wd_manifest_index':
            return

        sql = f"""
        INSERT INTO {self.schema}.PROPERTIES (ENTITY_TYPE, ENTITY_ID, PROPERTY_KEY, PROPERTY_VALUE, DEPLOY_ID)
        VALUES (?, ?, ?, ?, ?)
        """
        self._execute(sql, [entity_type, entity_id, prop.get('key', ''), prop.get('value', ''), deploy_id])
        self._commit()

    def insert_activity(self, deploy_id: int, activity: Dict[str, Any]) -> int:
        """
        Insert an activity record and return the generated activity_id.
        Uses DB2 FINAL TABLE to safely retrieve the IDENTITY value.
        """
        activity_result = activity.get('activity_result', {})

        sql = f"""
        SELECT ACTIVITY_ID
        FROM FINAL TABLE (
            INSERT INTO {self.schema}.ACTIVITY (
                DEPLOY_ID,
                ACTIVITY_NAME,
                SHORT_NAME,
                DESCRIPTION,
                STATUS,
                MESSAGE
            ) VALUES (?, ?, ?, ?, ?, ?)
        )
        """

        params = [
            deploy_id,
            activity.get('name', ''),
            activity.get('short_name', '')[:50],
            activity.get('description', ''),
            activity_result.get('status', ''),
            activity_result.get('msg', '')
        ]

        cursor = self.conn.cursor()
        cursor.execute(sql, params)
        self._commit()

        # Retrieve the generated ACTIVITY ID
        activity_id = int(cursor.fetchone()[0])

        # Insert activity properties (generic PROPERTY table)
        for prop in activity.get('properties', []):
            self.insert_property('ACTIVITY', activity_id, deploy_id, prop)

        # Link activity to tags
        tags = activity.get('tags', [])
        if tags:
            self._link_entity_tags('ACTIVITY', activity_id, tags)

        return activity_id

    def insert_action(self, activity_id: int, deploy_id: int, action: Dict[str, Any]) -> int:
        """
        Insert an action record and return the generated action_id.
        Uses DB2 FINAL TABLE to safely retrieve the IDENTITY value.
        """
        action_result = action.get('action_result', {})

        sql = f"""
        SELECT ACTION_ID
        FROM FINAL TABLE (
            INSERT INTO {self.schema}.ACTION (
                ACTIVITY_ID,
                ACTION_NAME,
                SHORT_NAME,
                DESCRIPTION,
                STATUS,
                MESSAGE
            ) VALUES (?, ?, ?, ?, ?, ?)
        )
        """

        params = [
            activity_id,
            action.get('name', ''),
            action.get('short_name', '')[:50],
            action.get('description', ''),
            action_result.get('status', ''),
            action_result.get('msg', '')
        ]

        cursor = self.conn.cursor()
        cursor.execute(sql, params)
        self._commit()

        # Retrieve the generated ACTION ID
        action_id = int(cursor.fetchone()[0])

        # Insert action properties
        for prop in action.get('properties', []):
            self.insert_property('ACTION', action_id, deploy_id, prop)

        # Link action to tags
        tags = action.get('tags', [])
        if tags:
            self._link_entity_tags('ACTION', action_id, tags)

        return action_id

    def get_building_block(self, item: dict) -> str:
        """
        Determine the building_block following these rules (in order):
        1. properties.template
        2. short_bname
        3. name
        """

        for prop in item.get("properties", []):
            if prop.get("name") == "template" and prop.get("value"):
                return prop["value"]
        if item.get("short_bname"):
            return item["short_bname"]
        return item.get("name")

    def insert_step(self, action_id: int, deploy_id: int, step: Dict[str, Any]) -> int:
        """
        Insert a step record and return the generated step_id.
        Uses DB2 FINAL TABLE to safely retrieve the IDENTITY value.
        """
        step_result = step.get('step_result', {})

        sql = f"""
        SELECT STEP_ID
        FROM FINAL TABLE (
            INSERT INTO {self.schema}.STEP (
                ACTION_ID,
                STEP_NAME,
                SHORT_NAME,
                DESCRIPTION,
                STATUS,
                MESSAGE,
                BUILDING_BLOCK
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
        )
        """
        building_block = step.get('building_block', None)
        if building_block is None:
            building_block = self.get_building_block(step)
        params = [
            action_id,
            step.get('name', ''),
            step.get('short_name', '')[:50],
            step.get('description', ''),
            step_result.get('status', ''),
            step_result.get('msg', ''),
            building_block[:100].upper()
        ]

        cursor = self.conn.cursor()
        cursor.execute(sql, params)
        self._commit()

        # Retrieve the generated STEP ID
        step_id = int(cursor.fetchone()[0])

        # Insert step properties
        for prop in step.get('properties', []):
            self.insert_property('STEP', step_id, deploy_id, prop)

        # Link step to tags
        tags = step.get('tags', [])
        if tags:
            self._link_entity_tags('STEP', step_id, tags)

        return step_id

    def insert_artifact(self, step_id: int, deploy_id: int, artifact: Dict[str, Any]) -> int:
        """
        Insert an artifact or return an existing artifact_id if the artifact already exists
        for the same application.
    
        Uniqueness rule:
            APPLICATION_NAME + ARTIFACT_PATH
    
        Uses DB2 FINAL TABLE to safely retrieve the generated IDENTITY value.
        """
        # Extract artifact properties into a dictionary
        properties = {prop['key']: prop['value'] for prop in artifact.get('properties', [])}
        artifact_path = properties.get('path', '')

        # Check if an artifact with the same path already exists for this application
        check_sql = f"""
        SELECT ARTIFACT_ID
        FROM {self.schema}.ARTIFACT
        WHERE APPLICATION_NAME = ?
          AND ARTIFACT_PATH = ?
        """

        cursor = self.conn.cursor()
        cursor.execute(check_sql, [self.current_application_name, artifact_path])
        existing = cursor.fetchone()

        if existing:
            # Artifact already exists → reuse existing ID
            artifact_id = int(existing[0])

            print(
                f"        Artifact already exists for {self.current_application_name}: "
                f"{artifact_path} (ID: {artifact_id})"
            )

            # Insert artifact properties (generic PROPERTY table)
            for prop in artifact.get('properties', []):
                self.insert_property('ARTIFACT', artifact_id, deploy_id, prop)

            # Link the existing artifact to the step
            self._link_step_artifact(step_id, artifact_id)

            return artifact_id

        # Insert a new artifact and retrieve the generated ARTIFACT ID
        insert_sql = f"""
        SELECT ARTIFACT_ID
        FROM FINAL TABLE (
            INSERT INTO {self.schema}.ARTIFACT (
                APPLICATION_NAME,
                ARTIFACT_NAME,
                ARTIFACT_PATH,
                ARTIFACT_TYPE
            ) VALUES (?, ?, ?, ?)
        )
        """

        params = [
            self.current_application_name,
            artifact.get('name', ''),
            artifact_path,
            properties.get('type', '')
        ]

        cursor.execute(insert_sql, params)
        self._commit()

        # Retrieve the generated ARTIFACT ID
        artifact_id = int(cursor.fetchone()[0])

        # Link step to the newly created artifact
        self._link_step_artifact(step_id, artifact_id)

        # Insert artifact properties
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

        if isinstance(results_data, dict):
            params = [
                int(step_id),  # STEP_ID INTEGER
                str(result.get('status', ''))[:50],  # STATUS VARCHAR(50)
                str(result.get('msg', ''))[:2000],  # MESSAGE VARCHAR(2000)
                str(results_data.get('command', ''))[:4000],  # COMMAND VARCHAR(4000)
                json.dumps(results_data)[:4000]  # RESULT_COMMAND VARCHAR(4000)
            ]
        else:
            params = [
                int(step_id),  # STEP_ID INTEGER
                str(result.get('status', ''))[:50],  # STATUS VARCHAR(50)
                str(result.get('msg', ''))[:2000],  # MESSAGE VARCHAR(2000)
                "",  # NO COMMAND
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

        # Insert main deployment (sets self.current_application_name)
        deploy_id = self.insert_deploy(evidence)
        print(f"  Deploy ID created: {deploy_id} for application: {self.current_application_name}")

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

    def get_activity_with_tags(self, activity_id: int) -> Dict[str, Any]:
        """
        Retrieve activity with aggregated tags
        
        Args:
            activity_id: Activity ID
            
        Returns:
            Dictionary with activity data and tags
        """
        sql = f"""
        SELECT ACTIVITY_ID, ACTIVITY_NAME, SHORT_NAME, TAGS
        FROM {self.schema}.V_ACTIVITY_TAGS
        WHERE ACTIVITY_ID = ?
        """
        self._execute(sql, [activity_id])
        result = self.cursor.fetchone()

        if result:
            return {
                'activity_id': result[0],
                'activity_name': result[1],
                'short_name': result[2],
                'tags': result[3].split(',') if result[3] else []
            }
        return None

    def get_action_with_tags(self, action_id: int) -> Dict[str, Any]:
        """
        Retrieve action with aggregated tags
        
        Args:
            action_id: Action ID
            
        Returns:
            Dictionary with action data and tags
        """
        sql = f"""
        SELECT ACTION_ID, ACTION_NAME, SHORT_NAME, TAGS
        FROM {self.schema}.V_ACTION_TAGS
        WHERE ACTION_ID = ?
        """
        self._execute(sql, [action_id])
        result = self.cursor.fetchone()

        if result:
            return {
                'action_id': result[0],
                'action_name': result[1],
                'short_name': result[2],
                'tags': result[3].split(',') if result[3] else []
            }
        return None

    def get_step_with_tags(self, step_id: int) -> Dict[str, Any]:
        """
        Retrieve step with aggregated tags
        
        Args:
            step_id: Step ID
            
        Returns:
            Dictionary with step data and tags
        """
        sql = f"""
        SELECT STEP_ID, STEP_NAME, SHORT_NAME, TAGS
        FROM {self.schema}.V_STEP_TAGS
        WHERE STEP_ID = ?
        """
        self._execute(sql, [step_id])
        result = self.cursor.fetchone()

        if result:
            return {
                'step_id': result[0],
                'step_name': result[1],
                'short_name': result[2],
                'tags': result[3].split(',') if result[3] else []
            }
        return None

    def get_all_activities_with_tags(self) -> List[Dict[str, Any]]:
        """
        Retrieve all activities with aggregated tags
        
        Returns:
            List of dictionaries with activity data and tags
        """
        sql = f"""
        SELECT ACTIVITY_ID, ACTIVITY_NAME, SHORT_NAME, TAGS
        FROM {self.schema}.V_ACTIVITY_TAGS
        ORDER BY ACTIVITY_ID
        """
        self._execute(sql, [])
        results = self.cursor.fetchall()

        activities = []
        for row in results:
            activities.append({
                'activity_id': row[0],
                'activity_name': row[1],
                'short_name': row[2],
                'tags': row[3].split(',') if row[3] else []
            })
        return activities

    def get_all_actions_with_tags(self) -> List[Dict[str, Any]]:
        """
        Retrieve all actions with aggregated tags
        
        Returns:
            List of dictionaries with action data and tags
        """
        sql = f"""
        SELECT ACTION_ID, ACTION_NAME, SHORT_NAME, TAGS
        FROM {self.schema}.V_ACTION_TAGS
        ORDER BY ACTION_ID
        """
        self._execute(sql, [])
        results = self.cursor.fetchall()

        actions = []
        for row in results:
            actions.append({
                'action_id': row[0],
                'action_name': row[1],
                'short_name': row[2],
                'tags': row[3].split(',') if row[3] else []
            })
        return actions

    def get_all_steps_with_tags(self) -> List[Dict[str, Any]]:
        """
        Retrieve all steps with aggregated tags
        
        Returns:
            List of dictionaries with step data and tags
        """
        sql = f"""
        SELECT STEP_ID, STEP_NAME, SHORT_NAME, TAGS
        FROM {self.schema}.V_STEP_TAGS
        ORDER BY STEP_ID
        """
        self._execute(sql, [])
        results = self.cursor.fetchall()

        steps = []
        for row in results:
            steps.append({
                'step_id': row[0],
                'step_name': row[1],
                'short_name': row[2],
                'tags': row[3].split(',') if row[3] else []
            })
        return steps

    def get_entities_by_tag(self, tag_name: str) -> Dict[str, List[Dict[str, Any]]]:
        """
        Retrieve all activities, actions, and steps having a specific tag
        
        Args:
            tag_name: Name of the tag to search for
            
        Returns:
            Dictionary with lists of entities grouped by type
        """
        result = {
            'activities': [],
            'actions': [],
            'steps': []
        }

        # Get activities with this tag
        activities_sql = f"""
        SELECT DISTINCT a.ACTIVITY_ID, a.ACTIVITY_NAME, a.SHORT_NAME
        FROM {self.schema}.ACTIVITY a
        INNER JOIN {self.schema}.ACTIVITY_TAG at ON a.ACTIVITY_ID = at.ACTIVITY_ID
        INNER JOIN {self.schema}.TAG t ON at.TAG_ID = t.TAG_ID
        WHERE t.TAG_NAME = ?
        ORDER BY a.ACTIVITY_ID
        """
        self._execute(activities_sql, [tag_name])
        for row in self.cursor.fetchall():
            result['activities'].append({
                'id': row[0],
                'name': row[1],
                'short_name': row[2]
            })

        # Get actions with this tag
        actions_sql = f"""
        SELECT DISTINCT ac.ACTION_ID, ac.ACTION_NAME, ac.SHORT_NAME
        FROM {self.schema}.ACTION ac
        INNER JOIN {self.schema}.ACTION_TAG act ON ac.ACTION_ID = act.ACTION_ID
        INNER JOIN {self.schema}.TAG t ON act.TAG_ID = t.TAG_ID
        WHERE t.TAG_NAME = ?
        ORDER BY ac.ACTION_ID
        """
        self._execute(actions_sql, [tag_name])
        for row in self.cursor.fetchall():
            result['actions'].append({
                'id': row[0],
                'name': row[1],
                'short_name': row[2]
            })

        # Get steps with this tag
        steps_sql = f"""
        SELECT DISTINCT s.STEP_ID, s.STEP_NAME, s.SHORT_NAME
        FROM {self.schema}.STEP s
        INNER JOIN {self.schema}.STEP_TAG st ON s.STEP_ID = st.STEP_ID
        INNER JOIN {self.schema}.TAG t ON st.TAG_ID = t.TAG_ID
        WHERE t.TAG_NAME = ?
        ORDER BY s.STEP_ID
        """
        self._execute(steps_sql, [tag_name])
        for row in self.cursor.fetchall():
            result['steps'].append({
                'id': row[0],
                'name': row[1],
                'short_name': row[2]
            })

        return result

    @abstractmethod
    def close(self):
        """Close database connections - to be implemented by subclasses"""
        pass
