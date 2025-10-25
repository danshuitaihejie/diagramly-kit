---
description: Analyze user intent and generate DSL, PNG, and Markdown diagram files for understanding files or projects. Creates all files in a single timestamped user directory. Supports Mermaid, PlantUML, Graphviz, ZenUML, DrawIO, Markmap, and others. Uses local tools when available, with Kroki.io service as fallback.
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

The user has provided requirements for a diagram. Users may want to generate diagrams to help understand files or even the entire project. Your task is to analyze their intent and create both the DSL and image files. You will:
1. Analyze user intent to determine diagram type and simple description
2. Create a single timestamped directory
3. Generate appropriate DSL code using the templates in `/templates/dsl/`
4. Convert the DSL to an image using the appropriate script
5. Present the resulting image to the user

Follow this execution flow:

1. **Analyze User Intent**: Parse the user input to understand what kind of diagram they want to create and generate a simple description.
   - For file understanding: Generate diagrams that visualize the structure, flow, or relationships in specific files
   - For project understanding: Generate high-level diagrams showing architecture, dependencies, workflows, or system interactions
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
   - Create a single timestamped directory: `.diagramly/user/{{yyyy-MM-dd-HHMMSSff}}/`
   - No other directories should be created

5. **Generate DSL File**: Save the generated DSL code to the timestamped directory with the naming pattern:
   - Place the file in the single directory: `.diagramly/user/{{yyyy-MM-dd-HHMMSSff}}/`
   - Name the DSL file using the pattern: `{{diagram_type}}-{{simple_description}}.{{extension}}`
   - Use correct file extensions as supported by the scripts: `.mmd`/`.mermaid` (Mermaid), `.puml`/`.plantuml` (PlantUML), `.dot`/`.gv` (Graphviz), `.zenuml` (ZenUML), `.drawio`/`.xml` (DrawIO), `.mm`/`.markmap` (Markmap)
   - The extension must match the actual diagram type (mermaid, plantuml, graphviz, etc.) and be from the supported list
   - Example: `.diagramly/user/2025-01-15-14302256/flowchart-user-journey.mmd`

6. **Convert to Image**: Execute the appropriate script to convert the DSL file to an image in the same directory (PNG creation MUST ONLY use the designated scripts):
   - Only use the scripts defined in the header: `scripts/bash/diagram-dsl-to-image.sh` (for sh) or `scripts/powershell/diagram-dsl-to-image.ps1` (for ps)
   - Run `{SCRIPT}` with arguments: `[DSL_FILE_PATH] [OUTPUT_FORMAT] [OUTPUT_DIR]`
   - OUTPUT_FORMAT: "png" 
   - OUTPUT_DIR: Same directory as the DSL file (the timestamped directory)
   - Name the image file using the pattern: `{{diagram_type}}-{{simple_description}}.png`
   - The DSL file must have a supported extension (.mmd, .mermaid, .puml, .plantuml, .dot, .gv, .zenuml, .drawio, .xml, .mm, .markmap)
   - Example: `{SCRIPT} .diagramly/user/2025-01-15-14302256/flowchart-user-journey.mmd png .diagramly/user/2025-01-15-14302256/`
   - Wait for successful completion before proceeding

7. **Generate Documentation File**: Create a markdown file in the same directory that documents the diagram:
   - Place the file in the same directory: `.diagramly/user/{{yyyy-MM-dd-HHMMSSff}}/`
   - Name the documentation file using the pattern: `{{diagram_type}}-{{simple_description}}.md`
   - Include the DSL code in a code block for reference
   - Example: `.diagramly/user/2025-01-15-14302256/flowchart-user-journey.md`

8. **Validate Output**: Ensure all three files were generated successfully in the timestamped directory.
   - Verify the `.dsl`, `.png`, and `.md` files exist in the same directory
   - Check that the image file has appropriate size (not zero bytes)

9. **Present Result**: Show the generated image to the user and provide:
   - The DSL code that was generated (for reference)
   - Information about the image format and location (`.diagramly/user/{{yyyy-MM-dd-HHMMSSff}}/`)
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
- Example: `{SCRIPT} .diagramly/user/2025-01-15-14302256/flowchart-user-journey.mmd png .diagramly/user/2025-01-15-14302256/`

### For PowerShell (ps) users:
- Command: `{SCRIPT} -InputFile "[input_file]" [-OutputFormat "[output_format]"] [-OutputDir "[output_dir]"]`
- Example: `{SCRIPT} -InputFile ".diagramly/user/2025-01-15-14302256/flowchart-user-journey.mmd" -OutputFormat "png" -OutputDir ".diagramly/user/2025-01-15-14302256/"`

## Error Handling and Validation

- **DSL Generation Validation**: Before saving the DSL file:
  - Check for syntax errors based on the selected diagram type
  - Ensure required elements are present (e.g., @startuml/@enduml for PlantUML, proper graph structure for Graphviz)
  - Verify the syntax matches the expected format for the chosen DSL type
  - If errors found, regenerate with corrections before proceeding

- **File Creation Validation**: Ensure all three files were properly created:
  - Verify the DSL file exists at the specified path with correct content and a supported extension (.mmd, .mermaid, .puml, .plantuml, .dot, .gv, .zenuml, .drawio, .xml, .mm, .markmap)
  - Verify the PNG file exists at the specified path with valid image data
  - Verify the MD file exists at the specified path with proper documentation
  - Check that all files have content and correct extensions

- **Output Validation**:
  - After script execution, verify all three files were created in the expected timestamped directory (.diagramly/user/{{yyyy-MM-dd-HHMMSSff}}/)
  - Check that all files follow the naming convention: `{{diagram_type}}-{{simple_description}}.{{extension}}` (with supported extension), `{{diagram_type}}-{{simple_description}}.png`, and `{{diagram_type}}-{{simple_description}}.md`
  - The DSL file must have a supported extension (.mmd, .mermaid, .puml, .plantuml, .dot, .gv, .zenuml, .drawio, .xml, .mm, .markmap)
  - Check that the image file is not zero bytes and contains valid image data
  - If image generation fails, report the issue and suggest alternatives (different output format, different diagram structure)
  - If the timestamped directory doesn't exist, create it before running the conversion script

- **User Communication**:
  - Always validate the output before presenting to user
  - If issues occur, communicate clearly what went wrong and the next steps
  - Provide both the successful elements and any errors encountered

## User Interaction

If the initial requirements are unclear, ask specific questions:
- "What type of diagram do you want to create? (flowchart, sequence diagram, mind map, etc.)"
- "What elements/components should be included?"
- "Do you have any specific styling preferences?"