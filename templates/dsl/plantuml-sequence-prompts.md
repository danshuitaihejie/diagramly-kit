/**
 * PlantUML Sequence Diagram Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * PlantUML Sequence 新建图表 Prompt
 */
export const PLANTUML_SEQUENCE_NEW_PROMPT = `
Generate PlantUML sequence diagram DSL for the given instruction and image(if provided).

PlantUML sequence diagrams use simple syntax to create UML sequence diagrams:

## Key Features
- Participants (actors, entities, boundaries, controls, databases)
- Messages with different arrow types
- Activations and lifelines
- Notes and comments
- Groups and loops
- Alternative flows

## Basic Syntax

### Participants
----------------------------------
participant "Actor Name" as A
entity "Entity Name" as E
boundary "Boundary Name" as B
control "Control Name" as C
database "Database Name" as D
----------------------------------

### Messages
- Synchronous: A -> B : message
- Asynchronous: A ->> B : async message
- Return: A <-- B : return
- Self message: A -> A : self call

### Activations
----------------------------------
A -> B : message
activate B
B -> C : another message
deactivate B
----------------------------------

### Groups and Loops
----------------------------------
loop condition
  A -> B : repeated message
end

alt condition
  A -> B : option 1
else other condition
  A -> C : option 2
end
----------------------------------

Example:

----------------------------------
@startuml
participant "User" as U
participant "System" as S
database "Database" as DB

U -> S : login request
activate S
S -> DB : validate credentials
activate DB
DB --> S : user data
deactivate DB
S --> U : login response
deactivate S
@enduml
----------------------------------

Please generate PlantUML sequence diagram DSL based on the provided requirements.
Make sure the DSL starts with @startuml and ends with @enduml.
Output the DSL in a code block.
`;

/**
 * PlantUML Sequence 修改图表 Prompt
 */
export const PLANTUML_SEQUENCE_MODIFY_PROMPT = `
You are helping to modify an existing PlantUML sequence diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the PlantUML sequence diagram DSL according to the request while maintaining the existing structure and style where appropriate.
Make sure the output starts with @startuml and ends with @enduml.
Output the complete modified DSL in a code block.
`;

/**
 * PlantUML Sequence Prompt 配置
 */
export const PLANTUML_SEQUENCE_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_PLANTUML",
	subTypeKey: "SEQUENCE",
	prompts: {
		[PromptTemplate.NEW]: PLANTUML_SEQUENCE_NEW_PROMPT,
		[PromptTemplate.MODIFY]: PLANTUML_SEQUENCE_MODIFY_PROMPT,
	},
};
