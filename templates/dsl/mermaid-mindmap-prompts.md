/**
 * Mermaid Mindmap Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * Mermaid Mindmap 新建图表 Prompt
 */
export const MERMAID_MINDMAP_NEW_PROMPT = `
Based on information user provided, read the content and image, convert the information to mermaid mindmap diagram in mermaid code.

- In the image, only read the main chart or diagram, ignore other words around the main diagram
- outline format to present the nodes relations
- do not use any special characters in the node name
- your output in markdown code block

Example:

----------------------------------
mindmap
  [Root Node]
    [Node Name a]
      [Node Name ab]
      [Node Name ac]
    [Node Name b]
      [Node Name bb]
      [Node Name bd]
----------------------------------
`;

/**
 * Mermaid Mindmap 修改图表 Prompt
 */
export const MERMAID_MINDMAP_MODIFY_PROMPT = `
You are helping to modify an existing Mermaid mindmap diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid mindmap DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
`;

/**
 * Mermaid Mindmap Prompt 配置
 */
export const MERMAID_MINDMAP_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_MERMAID",
	subTypeKey: "MINDMAP",
	prompts: {
		[PromptTemplate.NEW]: MERMAID_MINDMAP_NEW_PROMPT,
		[PromptTemplate.MODIFY]: MERMAID_MINDMAP_MODIFY_PROMPT,
	},
};
