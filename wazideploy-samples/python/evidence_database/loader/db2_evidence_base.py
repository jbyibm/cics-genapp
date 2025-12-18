#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#*******************************************************************************

import yaml
import json
from datetime import datetime
from typing import Dict, Any, Optional, List
from abc import ABC, abstractmethod
import logging


class DB2EvidenceLoaderBase(ABC):
    """
    Base class to load YAML evidence into DB2.
    Fully DB-agnostic (JDBC / ibm_db).
    """

    def __init__(self, schema: str='DPYZ'):
        """
        Initialize base loader
        
        Args:
            schema: DB2 schema name (default: 'DEPLOYZ')
        """
        self.schema = schema
        self.current_application_name = None
        self.tag_cache = {}

    # ------------------------------------------------------------------
    # Abstract DB interface
    # ------------------------------------------------------------------

    @abstractmethod
    def _execute(self, sql: str, params):
        pass

    @abstractmethod
    def _query(self, sql: str, params, return_ids:bool=True):
        pass

    @abstractmethod
    def _commit(self):
        pass

    @abstractmethod
    def close(self):
        pass

    # ------------------------------------------------------------------
    # Helpers
    # ------------------------------------------------------------------

    def parse_timestamp(self, timestamp_str: str) -> Optional[datetime]:
        if not timestamp_str:
            return None
        try:
            date_part, time_part = timestamp_str.split('.')[:2]
            return datetime(
                int(date_part[:4]),
                int(date_part[4:6]),
                int(date_part[6:8]),
                int(time_part[:2]),
                int(time_part[2:4]),
                int(time_part[4:6])
            )
        except Exception:
            return None

    def get_building_block(self, item: Dict[str, Any]) -> str:
        for prop in item.get("properties", []):
            if prop.get("name") == "template" and prop.get("value"):
                return prop["value"]
        if item.get("short_bname"):
            return item["short_bname"]
        return item.get("name", "")

    # ------------------------------------------------------------------
    # TAGS
    # ------------------------------------------------------------------

    def get_or_create_tag(self, tag_name: str) -> int:
        if tag_name in self.tag_cache:
            return self.tag_cache[tag_name]

        sql = f"""
        SELECT TAG_ID FROM {self.schema}.TAG WHERE TAG_NAME = ?
        """
        rows = self._query(sql, [tag_name])
        if rows:
            tag_id = int(rows[0]['TAG_ID'])
            self.tag_cache[tag_name] = tag_id
            return tag_id

        sql = f"""
        SELECT TAG_ID FROM FINAL TABLE (
            INSERT INTO {self.schema}.TAG (TAG_NAME) VALUES (?)
        )
        """
        rows = self._query(sql, [tag_name])
        self._commit()

        tag_id = int(rows[0]['TAG_ID'])
        self.tag_cache[tag_name] = tag_id
        return tag_id

    def _link_entity_tags(self, entity_type: str, entity_id: int, tags: List[str]):
        table_map = {
            'ACTIVITY': 'ACTIVITY_TAG',
            'ACTION': 'ACTION_TAG',
            'STEP': 'STEP_TAG'
        }

        table = table_map.get(entity_type)
        if not table or not tags:
            return

        id_col = f"{entity_type}_ID"

        for tag in tags:
            tag_id = self.get_or_create_tag(tag)
            try:
                self._execute(
                    f"""
                    INSERT INTO {self.schema}.{table} ({id_col}, TAG_ID)
                    VALUES (?, ?)
                    """,
                    [entity_id, tag_id]
                )
                self._commit()
            except Exception:
                pass  # duplicate key

    # ------------------------------------------------------------------
    # DEPLOY / ACTIVITY / ACTION / STEP
    # ------------------------------------------------------------------

    def insert_deploy(self, evidence: Dict[str, Any]) -> int:
        metadata = evidence.get('metadata', {})
        annotations = metadata.get('annotations', {})
        self.current_application_name = metadata.get('name', 'NONAME')

        sql = f"""
        SELECT DEPLOY_ID FROM FINAL TABLE (
            INSERT INTO {self.schema}.DEPLOY (
                DESCRIPTION, APPLICATION_NAME, APPLICATION_VERSION,
                ENVIRONMENT_NAME, DEPLOY_TIMESTAMP, CREATION_TIMESTAMP,
                STATUS
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
        )
        """

        rows = self._query(sql, [
            metadata.get('description', ''),
            self.current_application_name,
            metadata.get('version', ''),
            annotations.get('environment_name', ''),
            self.parse_timestamp(annotations.get('deploy_timestamp')),
            self.parse_timestamp(annotations.get('creation_timestamp')),
            evidence.get('status', '')
        ])
        self._commit()
        return int(rows[0]['DEPLOY_ID'])

    def insert_activity(self, deploy_id: int, activity: Dict[str, Any]) -> int:
        result = activity.get('activity_result', {})

        rows = self._query(
            f"""
            SELECT ACTIVITY_ID FROM FINAL TABLE (
                INSERT INTO {self.schema}.ACTIVITY (
                    DEPLOY_ID, ACTIVITY_NAME, SHORT_NAME,
                    DESCRIPTION, STATUS, MESSAGE
                ) VALUES (?, ?, ?, ?, ?, ?)
            )
            """,
            [
                deploy_id,
                activity.get('name', ''),
                activity.get('short_name', '')[:50],
                activity.get('description', ''),
                result.get('status', ''),
                result.get('msg', '')
            ]
        )
        self._commit()

        activity_id = int(rows[0]['ACTIVITY_ID'])

        for prop in activity.get('properties', []):
            self.insert_property('ACTIVITY', activity_id, deploy_id, prop)

        self._link_entity_tags('ACTIVITY', activity_id, activity.get('tags', []))
        return activity_id

    def insert_action(self, activity_id: int, deploy_id: int, action: Dict[str, Any]) -> int:
        result = action.get('action_result', {})

        rows = self._query(
            f"""
            SELECT ACTION_ID FROM FINAL TABLE (
                INSERT INTO {self.schema}.ACTION (
                    ACTIVITY_ID, ACTION_NAME, SHORT_NAME,
                    DESCRIPTION, STATUS, MESSAGE
                ) VALUES (?, ?, ?, ?, ?, ?)
            )
            """,
            [
                activity_id,
                action.get('name', ''),
                action.get('short_name', '')[:50],
                action.get('description', ''),
                result.get('status', ''),
                result.get('msg', '')
            ]
        )
        self._commit()

        action_id = int(rows[0]['ACTION_ID'])

        for prop in action.get('properties', []):
            self.insert_property('ACTION', action_id, deploy_id, prop)

        self._link_entity_tags('ACTION', action_id, action.get('tags', []))

        # Link states to action
        self._link_action_states(action_id, action.get('states', []))

        return action_id

    def _link_action_states(self, action_id: int, states: List[str]):
        """Link states to an action via ACTION_STATE table"""
        if not states:
            return

        # Remove duplicates
        unique_states = list(set(states))

        for state_name in unique_states:
            # Get STATE_ID from STATE table
            state_rows = self._query(
                f"""
                SELECT STATE_ID FROM {self.schema}.STATE
                WHERE STATE_NAME = ?
                """,
                [state_name]
            )

            if state_rows:
                state_id = int(state_rows[0]['STATE_ID'])

                # Check if already exists
                existing = self._query(
                    f"""
                    SELECT 1 FROM {self.schema}.ACTION_STATE
                    WHERE ACTION_ID = ? AND STATE_ID = ?
                    """,
                    [action_id, state_id]
                )

                # Only insert if not exists
                if not existing:
                    self._query(
                        f"""
                        INSERT INTO {self.schema}.ACTION_STATE (ACTION_ID, STATE_ID)
                        VALUES (?, ?)
                        """,
                        [action_id, state_id],
                        False
                    )

        self._commit()

    def insert_step(self, action_id: int, deploy_id: int, step: Dict[str, Any]) -> int:
        result = step.get('step_result', {})
        building_block = step.get('building_block') or self.get_building_block(step)
        if 'MEMBER_DELETE' == building_block:
            crud_action = 'DELETE'
        else:
            crud_action = 'UPDATE'

        rows = self._query(
            f"""
            SELECT STEP_ID FROM FINAL TABLE (
                INSERT INTO {self.schema}.STEP (
                    ACTION_ID, STEP_NAME, SHORT_NAME,
                    DESCRIPTION, STATUS, MESSAGE, CRUD_ACTION, BUILDING_BLOCK
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            )
            """,
            [
                action_id,
                step.get('name', ''),
                step.get('short_name', '')[:50],
                step.get('description', ''),
                result.get('status', ''),
                result.get('msg', ''),
                crud_action,
                building_block[:100].upper()
            ]
        )
        self._commit()

        step_id = int(rows[0]['STEP_ID'])

        for prop in step.get('properties', []):
            self.insert_property('STEP', step_id, deploy_id, prop)

        self._link_entity_tags('STEP', step_id, step.get('tags', []))
        return step_id

    # ------------------------------------------------------------------
    # ARTIFACT
    # ------------------------------------------------------------------

    def insert_artifact(self, step_id: int, deploy_id: int, artifact: Dict[str, Any]) -> int:
        props = {p['key']: p['value'] for p in artifact.get('properties', [])}
        artifact_path = props.get('path', '')

        rows = self._query(
            f"""
            SELECT ARTIFACT_ID FROM {self.schema}.ARTIFACT
            WHERE APPLICATION_NAME = ?
              AND ARTIFACT_PATH = ?
            """,
            [self.current_application_name, artifact_path]
        )

        if rows:
            artifact_id = int(rows[0]['ARTIFACT_ID'])
            logging.info(
                f"        Artifact already exists for {self.current_application_name}: "
                f"{artifact_path} (ID: {artifact_id})"
            )
            self._link_step_artifact(step_id, artifact_id)
            for prop in artifact.get('properties', []):
                self.insert_property('ARTIFACT', artifact_id, deploy_id, prop)
            return artifact_id

        rows = self._query(
            f"""
            SELECT ARTIFACT_ID FROM FINAL TABLE (
                INSERT INTO {self.schema}.ARTIFACT (
                    APPLICATION_NAME, ARTIFACT_NAME,
                    ARTIFACT_PATH, ARTIFACT_TYPE
                ) VALUES (?, ?, ?, ?)
            )
            """,
            [
                self.current_application_name,
                artifact.get('name', ''),
                artifact_path,
                props.get('type', '')
            ]
        )
        self._commit()

        artifact_id = int(rows[0]['ARTIFACT_ID'])
        self._link_step_artifact(step_id, artifact_id)

        for prop in artifact.get('properties', []):
            self.insert_property('ARTIFACT', artifact_id, deploy_id, prop)

        return artifact_id

    def _link_step_artifact(self, step_id: int, artifact_id: int):
        try:
            self._execute(
                f"""
                INSERT INTO {self.schema}.STEP_ARTIFACT (STEP_ID, ARTIFACT_ID)
                VALUES (?, ?)
                """,
                [step_id, artifact_id]
            )
            self._commit()
        except Exception:
            pass

    # ------------------------------------------------------------------
    # STEP RESULT DETAIL
    # ------------------------------------------------------------------

    def insert_step_result_detail(self, step_id: int, result: Dict[str, Any]):
        results_data = result.get('results', {})

        self._execute(
            f"""
            INSERT INTO {self.schema}.STEP_RESULT_DETAIL (
                STEP_ID, STATUS, MESSAGE, COMMAND, RESULT_COMMAND
            ) VALUES (?, ?, ?, ?, ?)
            """,
            [
                step_id,
                str(result.get('status', ''))[:50],
                str(result.get('msg', ''))[:2000],
                str(results_data.get('command', ''))[:4000]
                if isinstance(results_data, dict) else '',
                json.dumps(results_data)[:4000]
            ]
        )
        self._commit()

    def insert_property(
        self,
        entity_type: str,
        entity_id: int,
        deploy_id: int,
        prop: Dict[str, Any]
    ):
        """
        Insert a property for any entity type.
        """

        # Ignore technical keys
        if prop.get('key') in ('wd_manifest_index',):
            return

        self._execute(
            f"""
            INSERT INTO {self.schema}.PROPERTIES
            (ENTITY_TYPE, ENTITY_ID, PROPERTY_KEY, PROPERTY_VALUE, DEPLOY_ID)
            VALUES (?, ?, ?, ?, ?)
            """,
            [
                entity_type,
                entity_id,
                prop.get('key', ''),
                prop.get('value', ''),
                deploy_id
            ]
        )
        self._commit()

    # ------------------------------------------------------------------
    # YAML LOADER
    # ------------------------------------------------------------------

    def load_evidence_file(self, yaml_file_path: str) -> int:
        with open(yaml_file_path, 'r') as f:
            evidence = yaml.safe_load(f)
        logging.info(f"Loading evidence: {evidence['metadata']['name']}")

        deploy_id = self.insert_deploy(evidence)
        logging.info(f"  Deploy ID created: {deploy_id} for application: {self.current_application_name}")

        for activity in evidence.get('activities', []):
            activity_name = activity.get('name', '')
            logging.info(f"  Processing activity: {activity_name}")
            activity_id = self.insert_activity(deploy_id, activity)

            for action in activity.get('actions', []):
                action_name = action.get('name', '')
                logging.info(f"    Processing action: {action_name}")
                action_id = self.insert_action(activity_id, deploy_id, action)

                for step in action.get('steps', []):
                    step_name = step.get('name', '')
                    logging.info(f"      Processing step: {step_name}")
                    step_id = self.insert_step(action_id, deploy_id, step)

                    for artifact in step.get('artifacts', []):
                        self.insert_artifact(step_id, deploy_id, artifact)

                    for result in step.get('step_result', {}).get('results', []):
                        self.insert_step_result_detail(step_id, result)

        return deploy_id
