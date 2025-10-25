# Mermaid Flowchart Prompts Template

## Overview
Mermaid flowcharts use simple syntax to create flow diagrams. This template provides the standard prompts for generating and modifying Mermaid flowcharts.

## New Diagram Prompt

```
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
```

## Modify Diagram Prompt

```
You are helping to modify an existing Mermaid flowchart diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid flowchart DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
```

## Configuration

- **Language Key**: LANG_MERMAID
- **SubType Key**: FLOWCHART
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new Mermaid flowcharts from scratch
  - MODIFY: For modifying existing Mermaid flowcharts