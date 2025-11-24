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

import ibm_db

# ----------------------------------------------------
# Connect to DB2 database
# ----------------------------------------------------
dsn = (
    "DATABASE=DEPLOY;"  # Database name
    "HOSTNAME=127.0.0.1;"  # DB2 server address
    "PORT=50000;"  # DB2 port
    "PROTOCOL=TCPIP;"
    "UID=db2inst1;"  # Username
    "PWD=password;"  # Password
)

try:
    conn = ibm_db.connect(dsn, "", "")
    ibm_db.exec_immediate(conn, "SET CURRENT SCHEMA DEPLOYZ")
    print("✅ Connected successfully to DB2")
except Exception as e:
    print("❌ Connection error:", e)
    exit(1)


# ----------------------------------------------------
# Utility function to run queries
# ----------------------------------------------------
def run_query(sql, params=None):
    try:
        stmt = ibm_db.prepare(conn, sql)
        if params:
            ibm_db.execute(stmt, params)
        else:
            ibm_db.execute(stmt)
        result = []
        row = ibm_db.fetch_assoc(stmt)
        while row:
            result.append(row)
            row = ibm_db.fetch_assoc(stmt)
        return result
    except Exception as e:
        print("⚠️ Error executing query:", e)
        return []


# ----------------------------------------------------
# 1. List recent deployments
# ----------------------------------------------------
sql_deploys = """
SELECT DEPLOY_ID, EVIDENCE_NAME, ENVIRONMENT_NAME, DEPLOY_TIMESTAMP, STATUS
FROM DEPLOY
ORDER BY DEPLOY_TIMESTAMP DESC
FETCH FIRST 10 ROWS ONLY
"""
print("\n--- Recent deployments ---")
for row in run_query(sql_deploys):
    print(row)

# ----------------------------------------------------
# 2. Activities for a given deployment
# ----------------------------------------------------
sql_activities = """
SELECT ACTIVITY_ID, ACTIVITY_NAME, STATUS, MESSAGE
FROM ACTIVITY
WHERE DEPLOY_ID = ?
ORDER BY ACTIVITY_ID
"""
print("\n--- Activities for deployment 1 ---")
for row in run_query(sql_activities, (1,)):
    print(row)

# ----------------------------------------------------
# 3. Number of activities per status
# ----------------------------------------------------
sql_activity_status = """
SELECT STATUS, COUNT(*) AS NB_ACTIVITIES
FROM ACTIVITY
WHERE DEPLOY_ID = ?
GROUP BY STATUS
"""
print("\n--- Activity status counts for deployment 1 ---")
for row in run_query(sql_activity_status, (1,)):
    print(row)

# ----------------------------------------------------
# 4. Average step duration per action
# ----------------------------------------------------
sql_avg_duration = """
SELECT ACTION_ID, AVG(DURATION) AS AVG_DURATION
FROM STEP
GROUP BY ACTION_ID
"""
print("\n--- Average step duration per action ---")
for row in run_query(sql_avg_duration):
    print(row)

# ----------------------------------------------------
# 5. Actions and steps for a deployment
# ----------------------------------------------------
sql_actions_steps = """
SELECT D.DEPLOY_ID, A.ACTIVITY_NAME, AC.ACTION_NAME, S.STEP_NAME, S.STATUS, S.DURATION
FROM DEPLOY D
JOIN ACTIVITY A ON D.DEPLOY_ID = A.DEPLOY_ID
JOIN ACTION AC ON A.ACTIVITY_ID = AC.ACTIVITY_ID
JOIN STEP S ON AC.ACTION_ID = S.ACTION_ID
WHERE D.DEPLOY_ID = ?
ORDER BY A.ACTIVITY_NAME, AC.ACTION_NAME, S.STEP_NAME
"""
print("\n--- Actions and steps for deployment 1 ---")
for row in run_query(sql_actions_steps, (1,)):
    print(row)

# ----------------------------------------------------
# 6. Artifacts deployed for an environment
# ----------------------------------------------------
sql_artifacts = """
SELECT D.ENVIRONMENT_NAME, ART.ARTIFACT_NAME, ART.ARTIFACT_TYPE, ART.ARTIFACT_PATH
FROM DEPLOY D
JOIN ACTIVITY A ON D.DEPLOY_ID = A.DEPLOY_ID
JOIN ACTION AC ON A.ACTIVITY_ID = AC.ACTIVITY_ID
JOIN STEP S ON AC.ACTION_ID = S.ACTION_ID
JOIN ARTIFACT ART ON S.STEP_ID = ART.STEP_ID
WHERE D.ENVIRONMENT_NAME = ?
"""
print("\n--- Artifacts deployed in tivlp02.pok.stglabs.ibm.com ---")
for row in run_query(sql_artifacts, ("tivlp02.pok.stglabs.ibm.com",)):
    print(row)

# ----------------------------------------------------
# 7. Deployments with at least one failed activity
# ----------------------------------------------------
sql_failed_deploys = """
SELECT DISTINCT D.DEPLOY_ID, D.EVIDENCE_NAME, D.ENVIRONMENT_NAME, D.DEPLOY_TIMESTAMP
FROM DEPLOY D
JOIN ACTIVITY A ON D.DEPLOY_ID = A.DEPLOY_ID
WHERE A.STATUS NOT IN ('Ok', 'Skipped')
"""
print("\n--- Deployments with failed activities ---")
for row in run_query(sql_failed_deploys):
    print(row)

# ----------------------------------------------------
# 8. Steps with non-zero return codes
# ----------------------------------------------------
sql_failed_steps = """
SELECT S.STEP_NAME, R.RETURN_CODE, R.MESSAGE
FROM STEP S
JOIN STEP_RESULT_DETAIL R ON S.STEP_ID = R.STEP_ID
WHERE R.RETURN_CODE <> 0
"""
print("\n--- Steps with non-zero return codes ---")
for row in run_query(sql_failed_steps):
    print(row)

# ----------------------------------------------------
# 9. Deployment summary (view)
# ----------------------------------------------------
sql_summary = "SELECT * FROM V_DEPLOY_SUMMARY ORDER BY DEPLOY_TIMESTAMP DESC"
print("\n--- Deployment summary ---")
for row in run_query(sql_summary):
    print(row)

# ----------------------------------------------------
# 10. Deployed artifacts (view)
# ----------------------------------------------------
sql_artifacts_view = "SELECT * FROM V_ARTIFACTS_DEPLOYED WHERE ENVIRONMENT_NAME = ?"
print("\n--- Artifacts deployed in TEST ---")
for row in run_query(sql_artifacts_view, ("TEST",)):
    print(row)

# ----------------------------------------------------
# Close connection
# ----------------------------------------------------
ibm_db.close(conn)
print("\n🔒 Connection closed")
