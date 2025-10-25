# Mermaid Mindmap Prompts Template

## Overview
Mermaid mindmaps use simple syntax to create hierarchical diagrams. This template provides the standard prompts for generating and modifying Mermaid mindmaps.

## New Diagram Prompt

```
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
```

## Modify Diagram Prompt

```
You are helping to modify an existing Mermaid mindmap diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid mindmap DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
```

## Configuration

- **Language Key**: LANG_MERMAID
- **SubType Key**: MINDMAP
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new Mermaid mindmaps from scratch
  - MODIFY: For modifying existing Mermaid mindmaps