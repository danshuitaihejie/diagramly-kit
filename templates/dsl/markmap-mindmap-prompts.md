/**
 * Markmap Mindmap Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * Markmap Mindmap 新建图表 Prompt
 */
export const MARKMAP_MINDMAP_NEW_PROMPT = `
Generate Markmap markdown for the given instruction and image(if provided). 
Markmap uses markdown syntax to create mindmaps.

## Key Features
- Uses standard markdown syntax
- Hierarchical structure with headers
- Support for lists and nested items
- Clean and simple syntax

## Basic Syntax
- Use # for main topics (level 1)
- Use ## for subtopics (level 2)
- Use ### for sub-subtopics (level 3)
- Use - or * for list items
- Nested lists for hierarchical structure

Example:

----------------------------------
# Central Topic

## Main Branch 1
- Sub item 1
- Sub item 2
  - Nested item A
  - Nested item B

## Main Branch 2
- Sub item A
- Sub item B
  - Sub sub item
    - Deep nested item

## Main Branch 3
- Another sub item
- Final sub item
----------------------------------

Please generate Markmap markdown based on the provided requirements.
Output the markdown in a code block.
`;

/**
 * Markmap Mindmap 修改图表 Prompt
 */
export const MARKMAP_MINDMAP_MODIFY_PROMPT = `
You are helping to modify an existing Markmap markdown diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Markmap markdown according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified markdown in a code block.
`;

/**
 * Markmap Mindmap Prompt 配置
 */
export const MARKMAP_MINDMAP_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_MARKMAP",
	subTypeKey: "MINDMAP",
	prompts: {
		[PromptTemplate.NEW]: MARKMAP_MINDMAP_NEW_PROMPT,
		[PromptTemplate.MODIFY]: MARKMAP_MINDMAP_MODIFY_PROMPT,
	},
};
