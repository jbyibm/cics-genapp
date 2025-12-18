classDiagram

class Deploy {
  DEPLOY_ID
  APPLICATION_NAME
  ENVIRONMENT_NAME
  DEPLOY_TIMESTAMP
}

class Activity {
  ACTIVITY_ID
  DEPLOY_ID
}

class Action {
  ACTION_ID
  ACTIVITY_ID
}

class Step {
  STEP_ID
  ACTION_ID
  BUILDING_BLOCK
  CRUD_ACTION
}

class Artifact {
  ARTIFACT_ID
  APPLICATION_NAME
  ARTIFACT_PATH
}

class StepArtifact {
  STEP_ID
  ARTIFACT_ID
}

class State {
  STATE_ID
  STATE_NAME
}

class ActionState {
  ACTION_ID
  STATE_ID
}

class Tag {
  TAG_ID
  TAG_NAME
}

class Properties {
  PROPERTY_ID
  ENTITY_TYPE
  ENTITY_ID
}

class StepResultDetail {
  RESULT_ID
  STEP_ID
}

Deploy "1" --> "*" Activity
Activity "1" --> "*" Action
Action "1" --> "*" Step

Step "*" --> "*" Artifact : via STEP_ARTIFACT

Action "*" --> "*" State : via ACTION_STATE

Activity "*" --> "*" Tag
Action "*" --> "*" Tag
Step "*" --> "*" Tag

Step "1" --> "*" StepResultDetail
```

👉 **Résultat :** GitHub affichera automatiquement le diagramme.

---

## 2️⃣ deployz.puml (PlantUML – source riche et versionnable)

➡️ Crée le fichier : `/erd/deployz.puml`

```plantuml
@startuml
!define TABLE(x) class x << (T,#FFEEEE) >>

TABLE(DEPLOY) {
  DEPLOY_ID : PK
  APPLICATION_NAME
  ENVIRONMENT_NAME
  DEPLOY_TIMESTAMP
}

TABLE(ACTIVITY) {
  ACTIVITY_ID : PK
  DEPLOY_ID : FK
}

TABLE(ACTION) {
  ACTION_ID : PK
  ACTIVITY_ID : FK
}

TABLE(STEP) {
  STEP_ID : PK
  ACTION_ID : FK
  BUILDING_BLOCK
  CRUD_ACTION
}

TABLE(ARTIFACT) {
  ARTIFACT_ID : PK
  APPLICATION_NAME
  ARTIFACT_PATH
}

TABLE(STEP_ARTIFACT) {
  STEP_ID : FK
  ARTIFACT_ID : FK
}

TABLE(STATE) {
  STATE_ID : PK
  STATE_NAME
}

TABLE(ACTION_STATE) {
  ACTION_ID : FK
  STATE_ID : FK
}

TABLE(TAG) {
  TAG_ID : PK
  TAG_NAME
}

TABLE(PROPERTIES) {
  PROPERTY_ID : PK
  ENTITY_TYPE
  ENTITY_ID
}

TABLE(STEP_RESULT_DETAIL) {
  RESULT_ID : PK
  STEP_ID : FK
}

DEPLOY ||--o{ ACTIVITY
ACTIVITY ||--o{ ACTION
ACTION ||--o{ STEP
STEP ||--o{ STEP_ARTIFACT
ARTIFACT ||--o{ STEP_ARTIFACT

ACTION ||--o{ ACTION_STATE
STATE ||--o{ ACTION_STATE

ACTIVITY ||--o{ TAG
ACTION ||--o{ TAG
STEP ||--o{ TAG

STEP ||--o{ STEP_RESULT_DETAIL
@enduml
