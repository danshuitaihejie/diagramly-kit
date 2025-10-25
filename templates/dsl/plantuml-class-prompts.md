/**
 * PlantUML Class Diagram Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * PlantUML Class 新建图表 Prompt
 */
export const PLANTUML_CLASS_NEW_PROMPT = `
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
`;

/**
 * PlantUML Class 修改图表 Prompt
 */
export const PLANTUML_CLASS_MODIFY_PROMPT = `
You are helping to modify an existing PlantUML class diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the PlantUML class diagram DSL according to the request while maintaining the existing structure and style where appropriate.
Make sure the output starts with @startuml and ends with @enduml.
Output the complete modified DSL in a code block.
`;

/**
 * PlantUML Class Prompt 配置
 */
export const PLANTUML_CLASS_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_PLANTUML",
	subTypeKey: "CLASS",
	prompts: {
		[PromptTemplate.NEW]: PLANTUML_CLASS_NEW_PROMPT,
		[PromptTemplate.MODIFY]: PLANTUML_CLASS_MODIFY_PROMPT,
	},
};
