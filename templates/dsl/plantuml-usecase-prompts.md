# PlantUML Use Case Prompts Template

## Overview
PlantUML use case diagrams use simple syntax to create UML use case diagrams. This template provides the standard prompts for generating and modifying PlantUML use case diagrams.

## New Diagram Prompt

```
Generate PlantUML use case diagram DSL for the given instruction and image(if provided).

PlantUML use case diagrams use simple syntax to create UML use case diagrams:

## Key Features
- Actors (users, systems, external entities)
- Use cases (system functions)
- Relationships: associations, includes, extends
- System boundaries
- Notes and comments

## Basic Syntax

### Actors
----------------------------------
actor "Actor Name" as A
actor :Another Actor: as AA
----------------------------------

### Use Cases
----------------------------------
usecase "Use Case Name" as UC1
usecase (Another Use Case) as UC2
----------------------------------

### Relationships
- Association: Actor -- UseCase
- Include: UseCase1 .> UseCase2 : <<include>>
- Extend: UseCase1 <. UseCase2 : <<extend>>
- Inheritance: Actor1 --|> Actor2

### System Boundaries
----------------------------------
rectangle "System Name" {
  usecase "Internal Use Case" as UC
}
----------------------------------

Example:

----------------------------------
@startuml
actor "Customer" as C
actor "Admin" as A

rectangle "E-commerce System" {
  usecase "Browse Products" as UC1
  usecase "Add to Cart" as UC2
  usecase "Checkout" as UC3
  usecase "Manage Products" as UC4
  usecase "Process Payment" as UC5
}

C -- UC1
C -- UC2
C -- UC3
A -- UC4

UC3 .> UC5 : <<include>>
@enduml
----------------------------------

Please generate PlantUML use case diagram DSL based on the provided requirements.
Make sure the DSL starts with @startuml and ends with @enduml.
Output the DSL in a code block.
```

## Modify Diagram Prompt

```
You are helping to modify an existing PlantUML use case diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the PlantUML use case diagram DSL according to the request while maintaining the existing structure and style where appropriate.
Make sure the output starts with @startuml and ends with @enduml.
Output the complete modified DSL in a code block.
```

## Configuration

- **Language Key**: LANG_PLANTUML
- **SubType Key**: USECASE
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new PlantUML use case diagrams from scratch
  - MODIFY: For modifying existing PlantUML use case diagrams