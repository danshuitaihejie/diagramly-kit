/**
 * Mermaid Sequence Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * Mermaid Sequence 新建图表 Prompt
 */
export const MERMAID_SEQUENCE_NEW_PROMPT = `
Generate Mermaid sequence diagram DSL for the given instruction and image(if provided).

Mermaid sequence diagrams use simple syntax to create sequence diagrams:
- Participants are automatically created when first used
- Messages: A->>B: message
- Activations: activate/deactivate
- Notes: Note over A: note text
- Loops: loop condition ... end
- Alternatives: alt condition ... else ... end

Example:

----------------------------------
sequenceDiagram
    participant A as Alice
    participant B as Bob
    
    A->>B: Hello Bob, how are you?
    activate B
    B-->>A: Great!
    deactivate B
----------------------------------

Please generate Mermaid sequence diagram DSL based on the provided requirements.
Output the DSL in a code block.
`;

/**
 * Mermaid Sequence 修改图表 Prompt
 */
export const MERMAID_SEQUENCE_MODIFY_PROMPT = `
You are helping to modify an existing Mermaid sequence diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid sequence diagram DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
`;

/**
 * Mermaid Sequence Prompt 配置
 */
export const MERMAID_SEQUENCE_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_MERMAID",
	subTypeKey: "SEQUENCE",
	prompts: {
		[PromptTemplate.NEW]: MERMAID_SEQUENCE_NEW_PROMPT,
		[PromptTemplate.MODIFY]: MERMAID_SEQUENCE_MODIFY_PROMPT,
	},
};
