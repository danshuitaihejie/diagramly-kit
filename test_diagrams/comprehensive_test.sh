#!/bin/bash

# Comprehensive test for diagram-dsl-to-image.sh script functionality
# Tests each supported diagram type

set -e

echo "=== Comprehensive Diagram DSL to Image Script Test ==="
echo ""

# Create test directories
TEST_DIR="/Users/fengruixiang/Documents/projects/diagramly-kit/test_diagrams"
OUTPUT_BASE="/Users/fengruixiang/Documents/projects/diagramly-kit/test_outputs"
SCRIPT_PATH="/Users/fengruixiang/Documents/projects/diagramly-kit/scripts/bash/diagram-dsl-to-image.sh"

echo "Test directory: $TEST_DIR"
echo "Output directory: $OUTPUT_BASE" 
echo "Script path: $SCRIPT_PATH"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Test which local tools are available
echo "Checking for available local diagram tools..."
tools_found=()
if command_exists mmdc; then
    echo "  ✓ Mermaid CLI (mmdc) found"
    tools_found+=("mmdc")
else
    echo "  ✗ Mermaid CLI (mmdc) not found"
fi

if command_exists plantuml; then
    echo "  ✓ PlantUML found"
    tools_found+=("plantuml") 
else
    echo "  ✗ PlantUML not found"
fi

if command_exists dot; then
    echo "  ✓ GraphViz (dot) found"
    tools_found+=("dot")
else
    echo "  ✗ GraphViz (dot) not found"
fi
echo ""

# Test configuration
test_files=(
    "sample.mmd"
    "sample.puml" 
    "sample.dot"
    "sample.zenuml"
    "sample.xml"
    "sample.mm"
)

test_names=(
    "Mermaid"
    "PlantUML"
    "GraphViz" 
    "ZenUML"
    "DrawIO"
    "Markmap"
)

# Test each diagram type
successful_tests=0
total_tests=${#test_files[@]}

for i in "${!test_files[@]}"; do
    diagram_type="${test_names[$i]}"
    file_name="${test_files[$i]}"
    input_path="$TEST_DIR/$file_name"
    output_dir="$OUTPUT_BASE/$(echo $diagram_type | tr '[:upper:]' '[:lower:]')"  # Convert to lowercase
    
    echo "Testing $diagram_type diagram conversion..."
    echo "  Input: $input_path"
    echo "  Output directory: $output_dir"
    
    # Create output directory
    mkdir -p "$output_dir"
    
    if [ -f "$input_path" ]; then
        echo -n "  Running command... "
        
        # Try to convert the diagram
        if "$SCRIPT_PATH" "$input_path" "png" "$output_dir" 2>/dev/null; then
            echo "✓ SUCCESS"
            # Check if output file was created
            expected_output="$output_dir/${file_name%.*}.png"
            if [ -f "$expected_output" ]; then
                echo "  ✓ Output file created: $(basename "$expected_output") ($(du -h "$expected_output" | cut -f1))"
                ((successful_tests++))
            else
                echo "  ✗ Output file not created at expected location"
            fi
        else
            echo "✗ FAILED (script returned error)"
            # Show detailed error output
            echo "  Detailed output:"
            "$SCRIPT_PATH" "$input_path" "png" "$output_dir" 2>&1 | sed 's/^/    /'
        fi
    else
        echo "  ✗ Input file does not exist: $input_path"
    fi
    echo ""
done

# Summary
echo "=== Test Summary ==="
echo "Total tests: $total_tests"
echo "Successful: $successful_tests"
echo "Failed: $((total_tests - successful_tests))"

if [ $successful_tests -eq $total_tests ]; then
    echo "🎉 All tests passed!"
    exit 0
else
    echo "⚠️  Some tests failed."
    echo ""
    echo "Note: If tests failed due to external service (Kroki.io) connectivity,"
    echo "install local tools for better offline testing:"
    echo "  Mermaid: npm install -g @mermaid-js/mermaid-cli"
    echo "  PlantUML: brew install plantuml"
    echo "  GraphViz: brew install graphviz"
    exit 1
fi