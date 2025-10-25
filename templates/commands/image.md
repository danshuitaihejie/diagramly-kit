---
description: Generate an image from DSL diagram code based on user requirements. Supports Mermaid, PlantUML, Graphviz, ZenUML, DrawIO, and others.
scripts:
  sh: scripts/bash/diagram-dsl-to-image.sh
  ps: scripts/powershell/diagram-dsl-to-image.ps1
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The user has provided requirements for a diagram/image. Your task is to:
1. Determine the best diagram type based on user requirements
2. Generate appropriate DSL code using the templates in `/templates/dsl/`
3. Convert the DSL to an image using the appropriate script
4. Present the resulting image to the user

Follow this execution flow:

1. **Analyze User Requirements**: Parse the user input to understand what kind of diagram they want to create.
   - Identify the purpose: flowchart, sequence diagram, UML diagram, mind map, etc.
   - Determine the content: components, relationships, processes, etc.
   - Consider the audience and context

2. **Select Diagram Language and Type**: Choose the most appropriate diagram language from:
   - Mermaid: For flowcharts, sequence diagrams, mind maps, class diagrams, etc.
   - PlantUML: For UML diagrams (class, sequence, use case, activity, etc.)
   - Graphviz: For graph-based diagrams (network diagrams, dependency graphs, etc.)
   - ZenUML: For sequence diagrams
   - DrawIO: For general-purpose diagrams
   - Markmap: For mindmaps from markdown

3. **Generate DSL Code**: 
   - Use the appropriate template from `/templates/dsl/` to generate DSL code
   - For NEW diagrams, use the NEW prompt template from the corresponding DSL file
   - Fill in the DSL based on user requirements
   - Validate the generated DSL is syntactically correct for the chosen format

4. **Create DSL File**: Save the generated DSL code to an appropriately named file:
   - Use the correct extension: `.mmd` for Mermaid, `.puml` for PlantUML, `.dot` for Graphviz, etc.
   - Place the file in an appropriate directory like `/diagrams/generated/`
   - Name the DSL file to match the expected image output pattern:
     - For single diagram: `{{yyyy-MM-dd-HHMMSSff}}-{{description}}.{{extension}}`
     - For multiple diagrams: `{{yyyy-MM-dd-HHMMSSff}}-{{description}}-{{number}}.{{extension}}`
   - Example: `2025-01-15-14302256-flowchart.mmd`

5. **Convert to Image**: Execute the appropriate script to convert the DSL file to an image:
   - Run `{SCRIPT}` with arguments: `[DSL_FILE_PATH] [OUTPUT_FORMAT] [OUTPUT_DIR]`
   - Default OUTPUT_FORMAT: "png" 
   - Default OUTPUT_DIR: ".diagramly/images" (create directory if it doesn't exist)
   - For single diagram: Save as `.diagramly/images/{{yyyy-MM-dd-HHMMSSff}}-{{description}}.png`
   - For multiple diagrams: Save as `.diagramly/images/{{yyyy-MM-dd-HHMMSSff}}-{{description}}-{{number}}.png`
   - Example: `{SCRIPT} diagrams/generated/flow.mmd png .diagramly/images`
   - Wait for successful completion before proceeding

6. **Validate Output**: Ensure the image was generated successfully and is accessible.
   - Verify the image file exists at the expected location
   - Check that the image file has appropriate size (not zero bytes)

7. **Present Result**: Show the generated image to the user and provide:
   - The DSL code that was generated (for reference)
   - Information about the image format and location (.diagramly/images/)
   - Options for modifications if needed

## Diagram Generation Process

### For each supported diagram type:

1. **Identify the appropriate template** in `/templates/dsl/`:
   - `mermaid-flowchart-prompts.md` for flowcharts
   - `mermaid-sequence-prompts.md` for sequence diagrams
   - `mermaid-mindmap-prompts.md` for mindmaps
   - `plantuml-class-prompts.md` for class diagrams
   - `plantuml-sequence-prompts.md` for PlantUML sequence diagrams
   - `plantuml-usecase-prompts.md` for use case diagrams
   - `graphviz-general-prompts.md` for graphviz diagrams
   - `zenuml-general-prompts.md` for ZenUML diagrams
   - `drawio-general-prompts.md` for DrawIO diagrams
   - `markmap-mindmap-prompts.md` for Markmap diagrams

2. **Extract NEW diagram prompt** from the appropriate template file and customize it with user requirements

3. **Generate the DSL code** following the template guidelines:
   - Use the NEW diagram prompt template from the appropriate file
   - Replace any placeholders like `{CURRENT_CODE}` or `{COMMAND}` with actual values from user requirements
   - Follow the specific syntax requirements for each diagram type as outlined in the templates
   - Ensure the output is in the proper DSL format (no additional text, just the DSL code)

4. **Ensure correct file extension and format** based on the selected language:
   - `.mmd` or `.mermaid` for Mermaid
   - `.puml` or `.plantuml` for PlantUML
   - `.dot` or `.gv` for Graphviz
   - `.zenuml` for ZenUML
   - `.drawio` or `.xml` for DrawIO
   - `.mm` or `.markmap` for Markmap

5. **Validate DSL syntax** before saving:
   - Ensure the DSL follows the correct syntax for the chosen type
   - For Mermaid: Check flowchart/sequence diagram syntax
   - For PlantUML: Check for proper `@startuml` and `@enduml` tags
   - For Graphviz: Check for correct `digraph`/`graph` structure
   - For DrawIO: Ensure proper XML structure with mxGraphModel

## Script Execution

### For Bash (sh) users:
- Command: `{SCRIPT} [input_file] [output_format] [output_dir]`
- Example: `{SCRIPT} diagrams/generated/diagram.mmd png .diagramly/images`

### For PowerShell (ps) users:
- Command: `{SCRIPT} -InputFile "[input_file]" [-OutputFormat "[output_format]"] [-OutputDir "[output_dir]"]`
- Example: `{SCRIPT} -InputFile "diagrams/generated/diagram.mmd" -OutputFormat "png" -OutputDir ".diagramly/images"`

## Error Handling and Validation

- **DSL Generation Validation**: Before saving the DSL file:
  - Check for syntax errors based on the selected diagram type
  - Ensure required elements are present (e.g., @startuml/@enduml for PlantUML, proper graph structure for Graphviz)
  - Verify the syntax matches the expected format for the chosen DSL type
  - If errors found, regenerate with corrections before proceeding

- **File Creation Validation**: Ensure the DSL file was properly created:
  - Verify the file exists at the specified path
  - Check that the file has content
  - Confirm the file extension matches the diagram type

- **Script Execution Error Handling**:
  - If DSL generation fails, identify the specific error and return to step 3 with specific correction needed
  - If image conversion tool is missing, provide installation instructions for the specific tool:
    - Mermaid: `npm install -g @mermaid-js/mermaid-cli`
    - PlantUML: `brew install plantuml` (macOS) or download from http://plantuml.com/download
    - Graphviz: `brew install graphviz` (macOS) or install graphviz package (Linux/Windows)
  - If the script execution fails, report the error message and suggest troubleshooting:
    - Check DSL syntax: Re-validate the generated DSL against template syntax requirements
    - Check file permissions: Ensure the DSL file is readable
    - Check tool installation: Verify the conversion tool is properly installed and accessible
    - Retry the conversion with potential fixes based on error message
  - For PowerShell script failures, consider using the fallback Kroki.io service approach if local tools aren't available

- **Output Validation**:
  - After script execution, verify the image file was created in the expected output directory (.diagramly/images/)
  - Check that the image file follows the naming convention: `{{yyyy-MM-dd-HHMMSSff}}-{{description}}.png` or `{{yyyy-MM-dd-HHMMSSff}}-{{description}}-{{number}}.png`
  - Check that the image file is not zero bytes and contains valid image data
  - If image generation fails, report the issue and suggest alternatives (different output format, different diagram structure)
  - If the .diagramly/images directory doesn't exist, create it before running the conversion script

- **Fallback Options**:
  - If local tools fail, consider using online services (like Kroki.io) as a fallback
  - Provide the raw DSL code to the user so they can try converting manually if needed
  - Offer to try a different diagram type that might work better with available tools

- **User Communication**:
  - Always validate the output before presenting to user
  - If issues occur, communicate clearly what went wrong and the next steps
  - Provide both the successful elements and any errors encountered

## User Interaction

If the initial requirements are unclear, ask specific questions:
- "What type of diagram do you want to create? (flowchart, sequence diagram, mind map, etc.)"
- "What elements/components should be included?"
- "Do you have any specific styling preferences?"