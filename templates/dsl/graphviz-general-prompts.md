/**
 * Graphviz General Graph Prompts
 */
import {
	type DiagramPromptConfig,
	PromptTemplate,
} from "../value-objects/prompt-config";

/**
 * Graphviz General 新建图表 Prompt
 */
export const GRAPHVIZ_GENERAL_NEW_PROMPT = `
Generate Graphviz DOT language graph for the given instruction and image(if provided).

Graphviz DOT language can be used to create both directed (digraph) and undirected (graph) graphs.

## Key Features
- Directed graphs (using '->') and undirected graphs (using '--')
- Nodes with various shapes and styles
- Edges with labels and attributes
- Subgraphs and clusters
- Various layout algorithms (dot, neato, fdp, etc.)

## Basic Syntax

### Directed Graph (digraph)
----------------------------------
digraph DirectedExample {
  rankdir=TB;
  node1 -> node2;
}
----------------------------------

### Undirected Graph (graph)
\`\`\`dot
graph UndirectedExample {
  layout=neato;
  node1 -- node2;
}
\`\`\`

## Common Attributes
- \`rankdir\`: TB (top to bottom), LR (left to right)
- \`layout\`: dot (for directed), neato, fdp (for undirected)
- \`node [\`shape\`=box, \`style\`=rounded]\`: default node attributes
- \`edge [\`color\`=blue]\`: default edge attributes

Example (you can choose digraph or graph based on the request):

\`\`\`dot
digraph ProcessFlow {
  rankdir=TB;
  node [shape=box, style=rounded];
  
  start [label="Start", shape=ellipse, style=filled, fillcolor=lightgreen];
  process1 [label="Process 1"];
  decision [label="Decision?", shape=diamond];
  end [label="End", shape=ellipse, style=filled, fillcolor=lightcoral];
  
  start -> process1 -> decision;
  decision -> end [label="No"];
}
\`\`\`

Please generate the appropriate Graphviz DOT code (digraph or graph) based on the user's request.
Output the DOT code in a code block.
`;

/**
 * Graphviz General 修改图表 Prompt
 */
export const GRAPHVIZ_GENERAL_MODIFY_PROMPT = `
You are helping to modify an existing Graphviz graph.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Graphviz DOT code according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DOT code in a code block.
`;

/**
 * Graphviz General Prompt 配置
 */
export const GRAPHVIZ_GENERAL_CONFIG: DiagramPromptConfig = {
	languageKey: "LANG_GRAPHVIZ",
	subTypeKey: "GENERAL",
	prompts: {
		[PromptTemplate.NEW]: GRAPHVIZ_GENERAL_NEW_PROMPT,
		[PromptTemplate.MODIFY]: GRAPHVIZ_GENERAL_MODIFY_PROMPT,
	},
};
