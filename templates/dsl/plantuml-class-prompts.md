# PlantUML Class Prompts Template

## Overview
PlantUML class diagrams use simple syntax to create UML class diagrams. This template provides the standard prompts for generating and modifying PlantUML class diagrams.

## New Diagram Prompt

```
Generate PlantUML class diagram DSL for the given instruction and image(if provided).

PlantUML class diagrams use simple syntax to create UML class diagrams:

## Key Features
- Classes with attributes and methods
- Relationships: inheritance, composition, aggregation, association
- Visibility modifiers: +public, -private, #protected, ~package
- Abstract classes and interfaces
- Notes and comments

## Basic Syntax

### Classes
----------------------------------
class ClassName {
  +publicAttribute : Type
  -privateAttribute : Type
  #protectedMethod() : ReturnType
  +publicMethod(param : Type) : ReturnType
}
----------------------------------

### Relationships
- Inheritance: Child --|> Parent
- Implementation: Class ..|> Interface
- Composition: Whole *-- Part
- Aggregation: Container o-- Element
- Association: ClassA -- ClassB
- Dependency: ClassA ..> ClassB

### Interfaces
\`\`\`
interface InterfaceName {
  +method() : ReturnType
}
\`\`\`

Example:

\`\`\`plantuml
@startuml
class Animal {
  -name : String
  -age : int
  +getName() : String
  +setAge(age : int) : void
}

class Dog {
  -breed : String
  +bark() : void
}

class Cat {
  +meow() : void
}

Animal <|-- Dog
Animal <|-- Cat
@enduml
\`\`\`

Please generate PlantUML class diagram DSL based on the provided requirements.
Make sure the DSL starts with @startuml and ends with @enduml.
Output the DSL in a code block.
```

## Modify Diagram Prompt

```
You are helping to modify an existing PlantUML class diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the PlantUML class diagram DSL according to the request while maintaining the existing structure and style where appropriate.
Make sure the output starts with @startuml and ends with @enduml.
Output the complete modified DSL in a code block.
```

## Configuration

- **Language Key**: LANG_PLANTUML
- **SubType Key**: CLASS
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new PlantUML class diagrams from scratch
  - MODIFY: For modifying existing PlantUML class diagrams