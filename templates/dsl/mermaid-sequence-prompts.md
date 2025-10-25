# Mermaid Sequence Prompts Template

## Overview
Mermaid sequence diagrams use simple syntax to create sequence diagrams. This template provides the standard prompts for generating and modifying Mermaid sequence diagrams.

## New Diagram Prompt

```
Generate Mermaid sequence diagram DSL for the given instruction and image(if provided).

Mermaid sequence diagrams use simple syntax to create sequence diagrams:
- Participants are automatically created when first used
- Messages: A->>B: message
- Activations: activate/deactivate
- Notes: Note over A: note text
- Loops: loop condition ... end
- Alternatives: alt condition ... else ... end

Example:

----------------------------------
sequenceDiagram
    participant A as Alice
    participant B as Bob
    
    A->>B: Hello Bob, how are you?
    activate B
    B-->>A: Great!
    deactivate B
----------------------------------

Please generate Mermaid sequence diagram DSL based on the provided requirements.
Output the DSL in a code block.
```

## Modify Diagram Prompt

```
You are helping to modify an existing Mermaid sequence diagram.

Current diagram:
{CURRENT_CODE}

Modification request:
{COMMAND}

Please update the Mermaid sequence diagram DSL according to the request while maintaining the existing structure and style where appropriate.
Output the complete modified DSL in a code block.
```

## Configuration

- **Language Key**: LANG_MERMAID
- **SubType Key**: SEQUENCE
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new Mermaid sequence diagrams from scratch
  - MODIFY: For modifying existing Mermaid sequence diagrams