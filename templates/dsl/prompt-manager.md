import { DiagramLanguageHandler } from "../../diagram/language-handlers/diagram-language-handler";
import { AIScenario } from "../value-objects";
import { PromptTemplate } from "../value-objects/prompt-config";
import { promptConfigManager } from "./prompt-config-manager";

// =============================================================================
// CONSTANTS
// =============================================================================

/**
 * JSON format instructions appended to all prompts
 */
const JSON_FORMAT_INSTRUCTIONS = `
Return a JSON object with "code" and "title" fields. 
Output raw JSON only - no markdown code blocks, no backticks, no explanatory text.
Your response should start with { and end with }.`;

// =============================================================================
// LEGACY TYPES AND MAPPINGS
// =============================================================================

/**
 * Legacy DiagramType enum for backward compatibility
 */
export enum DiagramType {
	FLOW_CHART = "flow",
	SEQUENCE_DIAGRAM = "sequence",
	MINDMAP = "mindmap",
	LANG_PLANTUML = "PlantUML",
	MARKMAP = "markmap",
	LANG_MERMAID = "mermaid",
	LANG_ZENUML = "zenuml",
	LANG_MARKMAP = "lang_markmap",
	LANG_GRAPHVIZ = "graphviz",
	LANG_DRAWIO = "drawio",
}

/**
 * Legacy mapping from DiagramType to language and subtype
 */
const DIAGRAM_TYPE_MAPPING: Record<
	DiagramType,
	{ languageKey: string; subTypeKey: string }
> = {
	[DiagramType.FLOW_CHART]: {
		languageKey: "LANG_MERMAID",
		subTypeKey: "FLOWCHART",
	},
	[DiagramType.SEQUENCE_DIAGRAM]: {
		languageKey: "LANG_ZENUML",
		subTypeKey: DiagramLanguageHandler.DEFAULT_SUB_TYPE_KEY,
	},
	[DiagramType.MINDMAP]: { languageKey: "LANG_MERMAID", subTypeKey: "MINDMAP" },
	[DiagramType.LANG_PLANTUML]: {
		languageKey: "LANG_PLANTUML",
		subTypeKey: "CLASS",
	},
	[DiagramType.MARKMAP]: { languageKey: "LANG_MARKMAP", subTypeKey: "MINDMAP" },
	[DiagramType.LANG_MERMAID]: {
		languageKey: "LANG_MERMAID",
		subTypeKey: "FLOWCHART",
	},
	[DiagramType.LANG_ZENUML]: {
		languageKey: "LANG_ZENUML",
		subTypeKey: DiagramLanguageHandler.DEFAULT_SUB_TYPE_KEY,
	},
	[DiagramType.LANG_MARKMAP]: {
		languageKey: "LANG_MARKMAP",
		subTypeKey: "MINDMAP",
	},
	[DiagramType.LANG_GRAPHVIZ]: {
		languageKey: "LANG_GRAPHVIZ",
		subTypeKey: "DIGRAPH",
	},
	[DiagramType.LANG_DRAWIO]: {
		languageKey: "LANG_DRAWIO",
		subTypeKey: "GENERAL",
	},
};
// =============================================================================
// UTILITY FUNCTIONS
// =============================================================================

/**
 * Replaces template variables in a prompt string
 */
function replaceVariables(
	prompt: string,
	variables: { currentCode?: string; command?: string }
): string {
	let result = prompt;
	if (variables.currentCode) {
		result = result.replace("{CURRENT_CODE}", variables.currentCode);
	}
	if (variables.command) {
		result = result.replace("{COMMAND}", variables.command);
	}
	return result;
}

/**
 * Maps AI scenario to prompt template
 */
function getTemplateForScenario(scenario: AIScenario): PromptTemplate {
	switch (scenario) {
		case AIScenario.NEW_DIAGRAM:
			return PromptTemplate.NEW;
		case AIScenario.MODIFY_DIAGRAM:
			return PromptTemplate.MODIFY;
		case AIScenario.GENERATE_TITLE:
			// GENERATE_TITLE doesn't use prompt templates
			throw new Error(`No prompt template defined for scenario: ${scenario}`);
		default:
			throw new Error(`Unknown AI scenario: ${scenario}`);
	}
}

// =============================================================================
// PUBLIC API
// =============================================================================

/**
 * 获取场景化提示词
 * @deprecated Use getTwoLevelPrompt instead
 */
export function getScenarioPrompt(
	diagramType: DiagramType,
	scenario: AIScenario,
	currentCode?: string,
	command?: string,
): string {
	const mapping = DIAGRAM_TYPE_MAPPING[diagramType];
	if (!mapping) return "";

	const template = getTemplateForScenario(scenario);
	const prompt = promptConfigManager.getPrompt(
		mapping.languageKey,
		mapping.subTypeKey,
		template,
	) || "";

	const processedPrompt = replaceVariables(prompt, { currentCode, command });
	return processedPrompt + JSON_FORMAT_INSTRUCTIONS;
}

/**
 * 根据语言类型和子类型获取提示词（新的两级选择方式）
 */
export function getTwoLevelPrompt(
	languageKey: string,
	subTypeKey: string,
	scenario: AIScenario = AIScenario.NEW_DIAGRAM,
	currentCode?: string,
	command?: string,
): string {
	const template = getTemplateForScenario(scenario);
	let prompt = promptConfigManager.getPrompt(languageKey, subTypeKey, template);

	if (!prompt) {
		// 如果没有找到对应的 prompt，回退到原有的 DiagramType 方式
		const diagramType = mapToLegacyDiagramType(languageKey, subTypeKey);
		return getScenarioPrompt(diagramType, scenario, currentCode, command);
	}

	// 替换模板变量并添加格式指令
	const processedPrompt = replaceVariables(prompt, { currentCode, command });
	return processedPrompt + JSON_FORMAT_INSTRUCTIONS;
}

/**
 * 将新的两级选择映射到原有的 DiagramType（兼容性函数）
 */
function mapToLegacyDiagramType(
	languageKey: string,
	subTypeKey: string,
): DiagramType {
	// 根据语言类型和子类型映射到对应的 DiagramType
	if (languageKey === "LANG_MERMAID") {
		switch (subTypeKey) {
			case "FLOWCHART":
				return DiagramType.FLOW_CHART;
			case "SEQUENCE":
				return DiagramType.SEQUENCE_DIAGRAM;
			case "MINDMAP":
				return DiagramType.MINDMAP;
			default:
				return DiagramType.LANG_MERMAID;
		}
	}

	if (languageKey === "LANG_ZENUML") {
		return DiagramType.LANG_ZENUML;
	}

	if (languageKey === "LANG_MARKMAP") {
		return DiagramType.LANG_MARKMAP;
	}

	if (languageKey === "LANG_PLANTUML") {
		return DiagramType.LANG_PLANTUML;
	}

	if (languageKey === "LANG_GRAPHVIZ") {
		return DiagramType.LANG_GRAPHVIZ;
	}

	// 默认返回流程图
	return DiagramType.FLOW_CHART;
}
