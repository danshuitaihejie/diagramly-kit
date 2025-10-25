/**
 * Mermaid Gantt Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * Mermaid Gantt 新建图表 Prompt
 */
export const MERMAID_GANTT_NEW_PROMPT = `
Generate Mermaid Gantt chart DSL for the given instruction and image(if provided).

Mermaid Gantt charts use simple syntax to create project timelines:
- Title: title Project Timeline
- Date format: dateFormat YYYY-MM-DD
- Sections: section Section Name
- Tasks: Task Name :status, id, start-date, duration
- Status can be: done, active, crit (critical), milestone

Example:

----------------------------------
gantt
    title Project Development Timeline
    dateFormat YYYY-MM-DD
    
    section Planning
    Requirements    :done, req, 2024-01-01, 5d
    Design         :active, design, after req, 10d
    
    section Development
    Backend        :dev1, after design, 15d
    Frontend       :dev2, after design, 12d
    
    section Testing
    Unit Tests     :test1, after dev1, 5d
    Integration    :crit, test2, after dev2, 7d
----------------------------------

Please generate Mermaid Gantt chart DSL based on the provided requirements.
Output the DSL in a code block.
`;

/**
 * Mermaid Gantt 修改图表 Prompt
 */
export const MERMAID_GANTT_MODIFY_PROMPT = `
You are helping to modify an existing Mermaid Gantt chart.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid Gantt chart DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
`;

/**
 * Mermaid Gantt Prompt 配置
 */
export const MERMAID_GANTT_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_MERMAID",
	subTypeKey: "GANTT",
	prompts: {
		[PromptTemplate.NEW]: MERMAID_GANTT_NEW_PROMPT,
		[PromptTemplate.MODIFY]: MERMAID_GANTT_MODIFY_PROMPT,
	},
};
