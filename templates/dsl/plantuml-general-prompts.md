# PlantUML General Prompts Template

## Overview
PlantUML is a versatile component that allows you to create various types of diagrams from a simple textual description. This template provides the standard prompts for generating and modifying general PlantUML diagrams.

## New Diagram Prompt

```
Generate PlantUML DSL for the given instruction and image(if provided).

PlantUML is a versatile component that allows you to create various types of diagrams from a simple textual description.

## Key Features
- Sequence diagrams
- Usecase diagrams
- Class diagrams
- Activity diagrams
- Component diagrams
- State diagrams
- Object diagrams
- And more...

## Basic Syntax
- All diagrams start with \`@startuml\` and end with \`@enduml\`.
- The specific syntax depends on the diagram type requested.

### Example (Sequence Diagram)
----------------------------------
@startuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response
@enduml
----------------------------------

### Example (Class Diagram)
----------------------------------
@startuml
class Animal
class Dog
Animal <|-- Dog
@enduml
----------------------------------

Please generate the appropriate PlantUML DSL based on the user's request.
Make sure the DSL starts with @startuml and ends with @enduml.
Output the DSL in a code block.
```

## Modify Diagram Prompt

```
You are helping to modify an existing PlantUML diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the PlantUML DSL according to the request while maintaining the existing structure and style where appropriate.
Make sure the output starts with @startuml and ends with @enduml.
Output the complete modified DSL in a code block.
```

## Configuration

- **Language Key**: LANG_PLANTUML
- **SubType Key**: GENERAL
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new general PlantUML diagrams from scratch
  - MODIFY: For modifying existing general PlantUML diagrams