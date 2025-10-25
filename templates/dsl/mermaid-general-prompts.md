/**
 * Mermaid General Diagram Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * Mermaid General 新建图表 Prompt
 */
export const MERMAID_GENERAL_NEW_PROMPT = `
Generate Mermaid DSL for the given instruction and image(if provided).

Mermaid is a versatile component that allows you to create various types of diagrams from a simple textual description.

## Key Features
- Flowcharts
- Sequence diagrams
- Gantt charts
- Class diagrams
- State diagrams
- Pie charts
- And more...

## Basic Syntax
- The specific syntax depends on the diagram type requested.

### Example (Flowchart)
----------------------------------
flowchart TD
    A[Start] --> B{Is it?};
    B -- Yes --> C[OK];
    B -- No --> D[Rethink];
----------------------------------

### Example (Sequence Diagram)
----------------------------------
sequenceDiagram
    Alice->>John: Hello John, how are you?
    John-->>Alice: Great!
----------------------------------

Please generate the appropriate Mermaid DSL based on the user's request.
Output the DSL in a code block.
`;

/**
 * Mermaid General 修改图表 Prompt
 */
export const MERMAID_GENERAL_MODIFY_PROMPT = `
You are helping to modify an existing Mermaid diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
`;

/**
 * Mermaid General Prompt 配置
 */
export const MERMAID_GENERAL_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_MERMAID",
	subTypeKey: "GENERAL",
	prompts: {
		[PromptTemplate.NEW]: MERMAID_GENERAL_NEW_PROMPT,
		[PromptTemplate.MODIFY]: MERMAID_GENERAL_MODIFY_PROMPT,
	},
};
