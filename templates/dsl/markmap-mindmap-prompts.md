# Markmap Mindmap Prompts Template

## Overview
Markmap uses markdown syntax to create mindmaps. This template provides the standard prompts for generating and modifying Markmap mindmaps.

## New Diagram Prompt

```
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
```

## Modify Diagram Prompt

```
You are helping to modify an existing Markmap markdown diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Markmap markdown according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified markdown in a code block.
```

## Configuration

- **Language Key**: LANG_MARKMAP
- **SubType Key**: MINDMAP
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new Markmap mindmaps from scratch
  - MODIFY: For modifying existing Markmap mindmaps