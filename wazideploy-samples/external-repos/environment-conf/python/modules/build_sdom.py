#*******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corp. 2025. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#*******************************************************************************

from wazideploy_translator.service.evidences import EvidenceStatus
from wazideploy_translator.service.python_module import PythonModule
import os
from wazideploy_translator.deploy import Translator
import json
import yaml
from datetime import datetime, timezone

class IncludeVars (PythonModule):
    '''
    IncludeVars module reads the variables that are contained in external .yml files
    and adds these variables to the environment variables file that is used by the Wazi Deploy building blocks.

    Its extend the base PythonModule class
    '''
    def __init__(self):
        super().__init__()

    def process(self, deployment_plan, activity, action, step, environment, working_folder, extra_vars, dry_run, verbose, evidences, **kwargs):
        '''
        Build de Wazi Deploy SDOM File

        Returns
        =======
        list[status, status message, evidences collected]

        Parameters
        ==========
        `deployment_plan` : dict
            The Full Deployment Plan
        `activity` : dict
            The current activity in the Deployment Plan
        `action` : dict
            The current action in the Deployment Plan
        `step` : dict
            The current step in the Deployment Plan
        `environment` : dict
            The environment configuration (--envFile option of wazi-deploy)
        `working_folder` : str
            The current working folder (--workingFolder option of wazi-deploy)
        `extra_vars` : dict
            The extra environment variables (--extraVars option of wazi-deploy)
        `evidences` : dict
            The evidences at the beginning of the execution of the building bloc

        Other Parameters
        ================
        `dry_run` : bool
            Dry run (must not modify the target)

        `verbose` : bool
            Enable verbose messages
        '''
        super().process(deployment_plan, activity, action, step, environment, working_folder, extra_vars, dry_run, verbose, evidences)
        step_success = True
        step_msg = 'Building block include_vars succeeded'
        step_results = []
        parameters = []
        result={"status": step_success, "msg": step_msg, "args": parameters, "results": []}
        self.build_sdom(deployment_plan, environment, working_folder, evidences, verbose)
        step_results.append(result)
        return[step_success, step_msg, step_results]
        
    # Can be reuse for Ansible PATH
    def build_sdom(self, deployment_plan, environment, working_folder, evidences, verbose):
        import jmespath
        sdom = {
              "bomFormat": "ConcertDef",
              "specVersion": environment['metadata']['version'],
              "metadata": {
                "timestamp": datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3],
                "type": "deploy",
                "environment": environment['metadata']['name'],
                "component": {
                  "deploy-number": "190",
                  "change-request-url": "https://us-south.git.cloud.ibm.com/rong/concert-sample-devsecops-change/issues/101",
                  "name": "concert-sample-devsecops",
                  "version": "1.0.0"
                }
              },
              "components": []
            }

        deployed_artifacts = []
        for  deployed_step_artifacts in jmespath.search("activities[].actions[].steps[].artifacts", deployment_plan):
            for deployed_step_artifact in deployed_step_artifacts:
                if deployed_step_artifact not in deployed_artifacts:
                    deployed_artifacts.append(deployed_step_artifact)
        for deployed_artifact in deployed_artifacts:
            deploy_type = list(filter(lambda prop: ('type' == prop['key']), deployed_artifact['properties']))[0]['value']
            component =  {
                  "type": "code",
                  "name": f"{deployed_artifact['name']}.{deploy_type}",
                  "purl": "https://github.ibm.com/rong/concert-sample-devsecops-deployment",
                  "commit_sha": "c637635161906c6c7c4bfa104d83f98c176e9892",
                  "branch": "master"
                }
            sdom["components"].append(component)
        # Hard Coded but file can be in the environment file
        print(f"*** Generate SBOM to {os.path.abspath('sdom.json')}")
        with open('sdom.json','w') as outfile:
            json.dump(sdom,outfile,indent=4)
        with open('sdom.json','r') as infile:
            dict_from_file=json.load(infile)
        print(f"*** Generate SBOM to {os.path.abspath('sdom.yml')}")
        with open('sdom.yml','w') as outfile:
            yaml.dump(dict_from_file, outfile)
