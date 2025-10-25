---
description: Analyze user intent and generate both DSL and PNG diagram files in a single timestamped directory. Supports Mermaid, PlantUML, Graphviz, ZenUML, DrawIO, Markmap, and others. Uses local tools when available, with Kroki.io service as fallback.
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

The user has provided requirements for a diagram. Your task is to analyze their intent and create both the DSL and image files. You will:
1. Analyze user intent to determine diagram type and simple description
2. Create a single timestamped directory
3. Generate appropriate DSL code using the templates in `/templates/dsl/`
4. Convert the DSL to an image using the appropriate script
5. Present the resulting image to the user

Follow this execution flow:

1. **Analyze User Intent**: Parse the user input to understand what kind of diagram they want to create and generate a simple description.
   - Identify the purpose: flowchart, sequence diagram, UML diagram, mind map, etc.
   - Determine a simple, concise description of the diagram intent
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

4. **Analyze User Intent and Create Single Directory**: 
   - First analyze the user's intent to determine the diagram type and simple description
   - Create a single timestamped directory: `.diagramly/{{yyyy-MM-dd-HHMMSSff}}/`
   - No other directories should be created

5. **Generate DSL File**: Save the generated DSL code to the timestamped directory with the naming pattern:
   - Place the file in the single directory: `.diagramly/{{yyyy-MM-dd-HHMMSSff}}/`
   - Name the DSL file using the pattern: `{{diagram_type}}-{{simple_description}}.dsl`
   - Use the actual detected diagram type (mermaid, plantuml, graphviz, etc.) and simple description from user intent
   - Example: `.diagramly/2025-01-15-14302256/flowchart-user-journey.dsl`

6. **Convert to Image**: Execute the appropriate script to convert the DSL file to an image in the same directory:
   - Run `{SCRIPT}` with arguments: `[DSL_FILE_PATH] [OUTPUT_FORMAT] [OUTPUT_DIR]`
   - OUTPUT_FORMAT: "png" 
   - OUTPUT_DIR: Same directory as the DSL file (the timestamped directory)
   - Name the image file using the pattern: `{{diagram_type}}-{{simple_description}}.png`
   - Example: `{SCRIPT} .diagramly/2025-01-15-14302256/flowchart-user-journey.dsl png .diagramly/2025-01-15-14302256/`
   - Wait for successful completion before proceeding

7. **Validate Output**: Ensure both files were generated successfully in the timestamped directory.
   - Verify both the `.dsl` and `.png` files exist in the same directory
   - Check that the image file has appropriate size (not zero bytes)

8. **Present Result**: Show the generated image to the user and provide:
   - The DSL code that was generated (for reference)
   - Information about the image format and location (`.diagramly/{{yyyy-MM-dd-HHMMSSff}}/`)
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
- Example: `{SCRIPT} .diagramly/2025-01-15-14302256/flowchart-user-journey.dsl png .diagramly/2025-01-15-14302256/`

### For PowerShell (ps) users:
- Command: `{SCRIPT} -InputFile "[input_file]" [-OutputFormat "[output_format]"] [-OutputDir "[output_dir]"]`
- Example: `{SCRIPT} -InputFile ".diagramly/2025-01-15-14302256/flowchart-user-journey.dsl" -OutputFormat "png" -OutputDir ".diagramly/2025-01-15-14302256/"`

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
  - If image conversion tool is missing, the bash script will automatically fall back to Kroki.io service
  - If image conversion tool is missing, provide installation instructions for the specific tool as additional option:
    - Mermaid: `npm install -g @mermaid-js/mermaid-cli`
    - PlantUML: `brew install plantuml` (macOS) or download from http://plantuml.com/download
    - Graphviz: `brew install graphviz` (macOS) or install graphviz package (Linux/Windows)
  - If the script execution fails, report the error message and suggest troubleshooting:
    - Check DSL syntax: Re-validate the generated DSL against template syntax requirements
    - Check file permissions: Ensure the DSL file is readable
    - Check tool installation: Verify the conversion tool is properly installed and accessible
    - Retry the conversion with potential fixes based on error message
  - Both bash and PowerShell scripts now use Kroki.io service as fallback when local tools aren't available

- **Output Validation**:
  - After script execution, verify both files were created in the expected timestamped directory (.diagramly/{{yyyy-MM-dd-HHMMSSff}}/)
  - Check that both files follow the naming convention: `{{diagram_type}}-{{simple_description}}.dsl` and `{{diagram_type}}-{{simple_description}}.png`
  - Check that the image file is not zero bytes and contains valid image data
  - If image generation fails, report the issue and suggest alternatives (different output format, different diagram structure)
  - If the timestamped directory doesn't exist, create it before running the conversion script

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