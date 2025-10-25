/**
 * Prompt 配置管理器
 */
import type {
	DiagramPromptConfig,
	IPromptConfigManager,
	PromptTemplate,
} from "../value-objects/prompt-config";

import { DRAWIO_GENERAL_CONFIG } from "./drawio-general-prompts";
import { GRAPHVIZ_GENERAL_CONFIG } from "./graphviz-general-prompts";
import { MARKMAP_MINDMAP_CONFIG } from "./markmap-mindmap-prompts";
// Import all prompt configurations
import { MERMAID_FLOWCHART_CONFIG } from "./mermaid-flowchart-prompts";
import { MERMAID_GANTT_CONFIG } from "./mermaid-gantt-prompts";
import { MERMAID_GENERAL_CONFIG } from "./mermaid-general-prompts";
import { MERMAID_MINDMAP_CONFIG } from "./mermaid-mindmap-prompts";
import { MERMAID_SEQUENCE_CONFIG } from "./mermaid-sequence-prompts";
import { PLANTUML_CLASS_CONFIG } from "./plantuml-class-prompts";
import { PLANTUML_GENERAL_CONFIG } from "./plantuml-general-prompts";
import { PLANTUML_SEQUENCE_CONFIG } from "./plantuml-sequence-prompts";
import { PLANTUML_USECASE_CONFIG } from "./plantuml-usecase-prompts";
import { ZENUML_GENERAL_CONFIG } from "./zenuml-general-prompts";

/**
 * Prompt 配置管理器实现
 */
export class PromptConfigManager implements IPromptConfigManager {
	private static instance: PromptConfigManager;
	private readonly configs: DiagramPromptConfig[];

	private constructor() {
		this.configs = [
			MERMAID_GENERAL_CONFIG,
			MERMAID_FLOWCHART_CONFIG,
			MERMAID_MINDMAP_CONFIG,
			MERMAID_SEQUENCE_CONFIG,
			MERMAID_GANTT_CONFIG,
			ZENUML_GENERAL_CONFIG,
			MARKMAP_MINDMAP_CONFIG,
			PLANTUML_GENERAL_CONFIG,
			PLANTUML_CLASS_CONFIG,
			PLANTUML_SEQUENCE_CONFIG,
			PLANTUML_USECASE_CONFIG,
			GRAPHVIZ_GENERAL_CONFIG,
			DRAWIO_GENERAL_CONFIG,
		];
	}

	/**
	 * Get singleton instance
	 */
	public static getInstance(): PromptConfigManager {
		if (!PromptConfigManager.instance) {
			PromptConfigManager.instance = new PromptConfigManager();
		}
		return PromptConfigManager.instance;
	}

	/**
	 * Get prompt for specific language and subtype combination
	 */
	public getPrompt(
		languageKey: string,
		subTypeKey: string,
		template: PromptTemplate,
	): string | undefined {
		const config = this.configs.find(
			(c) => c.languageKey === languageKey && c.subTypeKey === subTypeKey,
		);
		return config?.prompts[template];
	}

	/**
	 * Get all available prompt configurations
	 */
	public getAllConfigs(): DiagramPromptConfig[] {
		return [...this.configs];
	}

	/**
	 * Check if language and subtype combination is supported
	 */
	public isSupported(languageKey: string, subTypeKey: string): boolean {
		return this.configs.some(
			(c) => c.languageKey === languageKey && c.subTypeKey === subTypeKey,
		);
	}

	/**
	 * Get all supported language keys
	 */
	public getSupportedLanguages(): string[] {
		const languages = new Set(this.configs.map((c) => c.languageKey));
		return Array.from(languages);
	}

	/**
	 * Get supported subtypes for a specific language
	 */
	public getSupportedSubTypes(languageKey: string): string[] {
		return this.configs
			.filter((c) => c.languageKey === languageKey)
			.map((c) => c.subTypeKey);
	}

	/**
	 * Get configuration for specific language and subtype
	 */
	public getConfig(
		languageKey: string,
		subTypeKey: string,
	): DiagramPromptConfig | undefined {
		return this.configs.find(
			(c) => c.languageKey === languageKey && c.subTypeKey === subTypeKey,
		);
	}
}

/**
 * Export singleton instance for easy access
 */
export const promptConfigManager = PromptConfigManager.getInstance();
