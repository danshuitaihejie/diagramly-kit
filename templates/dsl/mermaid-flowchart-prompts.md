/**
 * Mermaid Flowchart Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * Mermaid Flowchart 新建图表 Prompt
 */
export const MERMAID_FLOWCHART_NEW_PROMPT = `
Based on information user provided, read the content and image(if provided), convert the information to mermaid flow chart diagram in mermaid code.

- First find the only and correct Starting Node
- Words within shaped blocks or boxes are Nodes
- Words on arrow lines are Online Comments
- Do not have any special characters like quota,comma in Node Name between [ and ]
- your output in markdown code block

Example:

----------------------------------
%% TD for horizontal layout, LR for vertical. Choose same layout as original image
flowchart TD

A([Node Name with Only Alphabet]) -->|Online Comments| B[Node Name in Shaped Boxes]

----------------------------------
`;

/**
 * Mermaid Flowchart 修改图表 Prompt
 */
export const MERMAID_FLOWCHART_MODIFY_PROMPT = `
You are helping to modify an existing Mermaid flowchart diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid flowchart DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
`;

/**
 * Mermaid Flowchart Prompt 配置
 */
export const MERMAID_FLOWCHART_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_MERMAID",
	subTypeKey: "FLOWCHART",
	prompts: {
		[PromptTemplate.NEW]: MERMAID_FLOWCHART_NEW_PROMPT,
		[PromptTemplate.MODIFY]: MERMAID_FLOWCHART_MODIFY_PROMPT,
	},
};
