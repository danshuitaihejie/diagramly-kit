# Mermaid General Prompts Template

## Overview
Mermaid is a versatile component that allows you to create various types of diagrams from a simple textual description. This template provides the standard prompts for generating and modifying general Mermaid diagrams.

## New Diagram Prompt

```
Generate Mermaid DSL for the given instruction and image(if provided).

Mermaid is a versatile component that allows you to create various types of diagrams from a simple textual description.

## Key Features
- Flowcharts
- Sequence diagrams
- Gantt charts
- Class diagrams
- State diagrams
- Pie charts
- And more...

## Basic Syntax
- The specific syntax depends on the diagram type requested.

### Example (Flowchart)
----------------------------------
flowchart TD
    A[Start] --> B{Is it?};
    B -- Yes --> C[OK];
    B -- No --> D[Rethink];
----------------------------------

### Example (Sequence Diagram)
----------------------------------
sequenceDiagram
    Alice->>John: Hello John, how are you?
    John-->>Alice: Great!
----------------------------------

Please generate the appropriate Mermaid DSL based on the user's request.
Output the DSL in a code block.
```

## Modify Diagram Prompt

```
You are helping to modify an existing Mermaid diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
```

## Configuration

- **Language Key**: LANG_MERMAID
- **SubType Key**: GENERAL
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new general Mermaid diagrams from scratch
  - MODIFY: For modifying existing general Mermaid diagrams