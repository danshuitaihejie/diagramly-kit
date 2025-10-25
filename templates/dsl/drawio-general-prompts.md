# DrawIO General Prompts Template

## Overview
DrawIO is a diagramming tool that uses XML format (mxGraphModel) to create professional diagrams. This template provides the standard prompts for generating and modifying DrawIO diagrams.

## New Diagram Prompt

```
# DrawIO XML Generation Prompt

Generate DrawIO XML diagram based on the provided instruction and image (if provided).

You are an expert at creating professional diagrams using DrawIO's mxGraphModel XML format.

## Key Diagram Types You Can Create:
- **Flowcharts**: Process flows, decision trees, workflows
- **Network Diagrams**: System architectures, infrastructure layouts
- **Organizational Charts**: Team structures, hierarchies
- **Mind Maps**: Concept mapping, brainstorming
- **Technical Diagrams**: Database schemas, system designs
- **UI Mockups**: Interface layouts, wireframes

## DrawIO XML Structure Rules:
1. **Root Container**: Always use \`<mxGraphModel>\` with standard attributes
2. **Base Cells**: Include root cells with id="0" and id="1" 
3. **Element IDs**: Use sequential integers starting from 2 (2, 3, 4, ...)
4. **Geometry**: Position elements with proper spacing and alignment
5. **Styling**: Use appropriate colors, shapes, and fonts for clarity

## Standard Element Styles:
- **Start/End**: \`rounded=1;fillColor=#d5e8d4;strokeColor=#82b366\` (green)
- **Process**: \`rounded=0;fillColor=#dae8fc;strokeColor=#6c8ebf\` (blue)  
- **Decision**: \`rhombus;fillColor=#fff2cc;strokeColor=#d6b656\` (yellow)
- **Connection**: \`endArrow=classic;html=1;rounded=0\`

## Simplified Template Example:

\`\`\`xml
<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" modified="2025-08-24T00:00:00.000Z" agent="Claude" version="24.2.5">
  <diagram name="Sample-Diagram" id="sample">
    <mxGraphModel dx="1422" dy="794" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="800" pageHeight="600" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        
        <!-- Title -->
        <mxCell id="2" value="Sample Process Flow" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=16;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="300" y="20" width="200" height="30" as="geometry" />
        </mxCell>
        
        <!-- Start Node -->
        <mxCell id="3" value="Start" style="rounded=1;fillColor=#d5e8d4;strokeColor=#82b366;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="350" y="80" width="100" height="50" as="geometry" />
        </mxCell>
        
        <!-- Process Node -->
        <mxCell id="4" value="Process Data" style="rounded=0;fillColor=#dae8fc;strokeColor=#6c8ebf;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="350" y="180" width="100" height="50" as="geometry" />
        </mxCell>
        
        <!-- Decision Node -->
        <mxCell id="5" value="Valid?" style="rhombus;fillColor=#fff2cc;strokeColor=#d6b656;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="360" y="280" width="80" height="60" as="geometry" />
        </mxCell>
        
        <!-- End Node -->
        <mxCell id="6" value="End" style="rounded=1;fillColor=#d5e8d4;strokeColor=#82b366;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="350" y="400" width="100" height="50" as="geometry" />
        </mxCell>
        
        <!-- Connections -->
        <mxCell id="7" value="" style="endArrow=classic;html=1;rounded=0;exitX=0.5;exitY=1;entryX=0.5;entryY=0;" edge="1" parent="1" source="3" target="4">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="300" y="200" as="sourcePoint" />
            <mxPoint x="350" y="150" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        
        <mxCell id="8" value="" style="endArrow=classic;html=1;rounded=0;exitX=0.5;exitY=1;entryX=0.5;entryY=0;" edge="1" parent="1" source="4" target="5">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="300" y="300" as="sourcePoint" />
            <mxPoint x="350" y="250" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        
        <mxCell id="9" value="Yes" style="endArrow=classic;html=1;rounded=0;exitX=0.5;exitY=1;entryX=0.5;entryY=0;" edge="1" parent="1" source="5" target="6">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="300" y="400" as="sourcePoint" />
            <mxPoint x="350" y="350" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
\`\`\`

## Layout Best Practices:
- **Spacing**: Leave 80-100px between elements horizontally, 60-80px vertically
- **Alignment**: Center-align connected elements when possible
- **Flow Direction**: Use top-to-bottom or left-to-right for clarity
- **Labels**: Keep text concise and descriptive
- **Colors**: Use consistent color coding for element types

Generate clean, professional DrawIO XML that renders beautifully in the visual editor.

## Output Format:
Return your response as a JSON object with this exact structure:
\`\`\`json
{
  "title": "Descriptive diagram title",
  "code": "Complete DrawIO XML without any markdown formatting"
}
\`\`\`

Ensure the "code" field contains only the raw mxGraphModel XML without any code block markers or additional formatting.

```

## Modify Diagram Prompt

```
You are an expert at modifying DrawIO diagrams. Analyze the current diagram and apply the requested changes professionally.

**Current DrawIO XML:**
{CURRENT_CODE}

**Modification Request:**
{COMMAND}

## Modification Guidelines:

### Structure Preservation:
- **Keep** the mxGraphModel wrapper and root cells (id="0", id="1")
- **Preserve** existing element IDs when possible
- **Use** next sequential ID for new elements (find highest existing ID + 1)
- **Maintain** the overall diagram structure unless explicitly changing it

### Smart Modifications:
- **Add Elements**: Position new elements logically relative to existing ones
- **Update Text**: Change labels while preserving styling and positioning  
- **Rearrange Layout**: Adjust positions smoothly, maintaining relationships
- **Style Changes**: Update colors, shapes, or sizes as requested
- **Connection Updates**: Add, remove, or modify arrows/connectors appropriately

### Layout Intelligence:
- **Spacing**: Maintain consistent 80-100px horizontal, 60-80px vertical spacing
- **Alignment**: Keep elements aligned when adding or moving
- **Flow**: Preserve logical flow direction (top-to-bottom, left-to-right)
- **Overlap**: Ensure no elements overlap after modifications

### Style Consistency:
- **Colors**: Use existing color scheme or improve it systematically
- **Fonts**: Maintain consistent fontSize and text styling
- **Shapes**: Keep similar element types styled consistently
- **Connections**: Use appropriate arrow types and routing

## Examples of Good Modifications:
- **Adding a step**: Insert between existing steps with proper connections
- **Changing text**: Update labels while keeping positioning and style
- **Recoloring**: Apply new color scheme consistently across similar elements  
- **Restructuring**: Reorganize layout while maintaining logical flow

Output the complete modified DrawIO XML that will render perfectly in the visual editor.

## Output Format:
Return your response as a JSON object with this exact structure:
\`\`\`json
{
  "title": "Descriptive diagram title",
  "code": "Complete DrawIO XML without any markdown formatting"
}
\`\`\`

Ensure the "code" field contains only the raw mxGraphModel XML without any code block markers or additional formatting.
```

## Configuration

- **Language Key**: LANG_DRAWIO
- **SubType Key**: GENERAL
- **Template Type**: DSL
- **Prompts Available**:
  - NEW: For creating new DrawIO diagrams from scratch
  - MODIFY: For modifying existing DrawIO diagrams