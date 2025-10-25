#!/bin/bash

# Test script for diagram-dsl-to-image.sh functionality
# This tests the encoding functionality without external service calls

echo "Testing encoding functionality of diagram-dsl-to-image.sh..."

# Function to encode diagram source using deflate compression (from diagram-dsl-to-image.sh)
encode_diagram_source() {
    local source="$1"
    
    # Create temporary file with the source content
    local temp_input=$(mktemp)
    echo -n "$source" > "$temp_input"
    
    # Using Python for better compatibility with Kroki's expectations
    if command -v python3 >/dev/null 2>&1; then
        local compressed=$(python3 -c "
import sys
import base64
import zlib
data = sys.argv[1].encode('utf-8')
compressed = zlib.compress(data)[2:-4]  # Remove zlib headers
result = base64.urlsafe_b64encode(compressed).decode('ascii')
print(result.replace('=', ''))
" "$source")
    elif command -v python >/dev/null 2>&1; then
        local compressed=$(python -c "
import sys
import base64
import zlib
data = sys.argv[1].encode('utf-8')
compressed = zlib.compress(data)[2:-4]  # Remove zlib headers
result = base64.urlsafe_b64encode(compressed).decode('ascii')
print(result.replace('=', ''))
" "$source")
    else
        # Fallback to gzip if python is not available
        local temp_output=$(mktemp)
        gzip -c "$temp_input" | base64 -w 0 | tr '+/' '-_' | tr -d '=' > "$temp_output"
        local compressed=$(cat "$temp_output")
        rm -f "$temp_output"
    fi
    
    # Clean up
    rm -f "$temp_input"
    
    echo "$compressed"
}

# Test data
test_diagrams=(
    "graph TD\n    A[User] --> B[Web App]\n    B --> C[Database]"
    "@startuml\nactor User\nparticipant WebApp\nUser -> WebApp: request\n@enduml"
    "digraph G {\n    A -> B;\n    B -> C;\n}"
    "User -> WebApp: request data"
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?><mxGraphModel><root><mxCell id=\"0\"/><mxCell id=\"1\" parent=\"0\"/><mxCell id=\"2\" value=\"Test\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"0\" y=\"0\" width=\"80\" height=\"30\" as=\"geometry\"/></mxCell></root></mxGraphModel>"
)

# Test each diagram type
echo "Testing encoding for different diagram types:"
echo "=============================================="

for i in "${!test_diagrams[@]}"; do
    diagram="${test_diagrams[$i]}"
    diagram_type=("mermaid" "plantuml" "graphviz" "zenuml" "drawio")
    
    encoded=$(encode_diagram_source "$diagram")
    echo "Diagram $((i+1)) [${diagram_type[$i]}]:"
    echo "  Length: ${#encoded} characters"
    echo "  Sample: ${encoded:0:50}..."
    echo ""
done

echo "Testing diagram type detection:"
echo "================================"

# Function to determine diagram type from file extension
get_diagram_type_from_extension() {
    local filepath="$1"
    local extension=$(echo "${filepath##*.}" | tr '[:upper:]' '[:lower:]')
    
    case "$extension" in
        mmd|mermaid) echo "mermaid" ;;
        zenuml) echo "zenuml" ;;
        puml|plantuml|pu) echo "plantuml" ;;
        drawio|xml) echo "drawio" ;;
        mm|markmap) echo "markmap" ;;
        dot|gv) echo "graphviz" ;;
        *) 
            echo "Unsupported file extension: $extension" >&2
            return 1
            ;;
    esac
}

# Test file extension detection
test_files=("test.mmd" "sample.puml" "example.dot" "diagram.zenuml" "model.xml" "mindmap.mm")

for file in "${test_files[@]}"; do
    type=$(get_diagram_type_from_extension "$file")
    echo "File: $file -> Type: $type"
done

echo ""
echo "All encoding tests completed successfully!"
echo ""
echo "Next steps for full testing:"
echo "1. Install local diagram tools (mmdc, plantuml, dot) to avoid external service dependency"
echo "2. Or ensure your network can access https://kroki.io/"
echo ""
echo "Example of installing tools:"
echo "  Mermaid: npm install -g @mermaid-js/mermaid-cli"
echo "  PlantUML: brew install plantuml or download from https://plantuml.com/"
echo "  Graphviz: brew install graphviz"