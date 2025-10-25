#!/bin/bash

# Script to convert DSL files to images
# Usage: ./diagram-dsl-to-image.sh [input_file] [output_format] [output_dir]
# Example: ./diagram-dsl-to-image.sh input.mmd png ./output

set -e  # Exit on any error

# Default values
DEFAULT_OUTPUT_FORMAT="png"
DEFAULT_OUTPUT_DIR="./output"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to display help
show_help() {
    echo "Usage: $0 [input_file] [output_format] [output_dir]"
    echo ""
    echo "Convert DSL files to images using appropriate tools"
    echo ""
    echo "Arguments:"
    echo "  input_file      Path to the DSL file to convert"
    echo "  output_format   Output format (png, svg, pdf) - default: png"
    echo "  output_dir      Output directory - default: ./output"
    echo ""
    echo "Supported DSL types:"
    echo "  - Mermaid (.mmd, .mermaid)"
    echo "  - PlantUML (.puml, .plantuml)"
    echo "  - Graphviz (.dot, .gv)"
    echo "  - ZenUML (.zenuml)"
    echo "  - DrawIO (.drawio, .xml)"
    echo ""
    echo "Examples:"
    echo "  $0 flowchart.mmd png ./images"
    echo "  $0 class.puml svg"
    echo "  $0 diagram.dot"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to get file extension
get_file_extension() {
    local filename=$(basename "$1")
    echo "${filename##*.}"
}

# Function to get filename without extension
get_filename_without_ext() {
    local filename=$(basename "$1")
    echo "${filename%.*}"
}

# Main conversion function
convert_dsl_to_image() {
    local input_file="$1"
    local output_format="$2"
    local output_dir="$3"
    local filename=$(get_filename_without_ext "$input_file")
    
    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"
    
    local output_path="${output_dir}/${filename}.${output_format}"
    
    print_info "Converting $input_file to $output_path"
    
    # Determine file type and use appropriate tool
    case "$(get_file_extension "$input_file")" in
        mmd|mermaid)
            if command_exists mmdc; then
                print_info "Using Mermaid CLI (mmdc) to convert $input_file"
                mmdc -i "$input_file" -o "$output_path" -w 1200
            else
                print_error "Mermaid CLI (mmdc) not found. Install with 'npm install -g @mermaid-js/mermaid-cli'"
                exit 1
            fi
            ;;
        puml|plantuml)
            if command_exists plantuml; then
                print_info "Using PlantUML to convert $input_file"
                plantuml -t${output_format} "$input_file" -o "$output_dir"
                # Move the generated file to the correct name
                local generated_file="${output_dir}/$(get_filename_without_ext "$input_file").${output_format}"
                mv "${output_dir}/$(get_filename_without_ext "$input_file").${output_format}" "$output_path" 2>/dev/null || true
            else
                print_error "PlantUML not found. Install with 'brew install plantuml' or download from http://plantuml.com/download"
                exit 1
            fi
            ;;
        dot|gv)
            if command_exists dot; then
                print_info "Using Graphviz (dot) to convert $input_file"
                dot -T${output_format} "$input_file" -o "$output_path"
            else
                print_error "Graphviz (dot) not found. Install with 'brew install graphviz'"
                exit 1
            fi
            ;;
        zenuml)
            print_warn "ZenUML conversion not directly supported. Please use the diagramly-kit library to convert."
            print_info "Looking for ZenUML in the project..."
            if [[ -f "./dist/index.js" ]]; then
                node ./dist/index.js convert-zenuml "$input_file" "$output_path"
            else
                print_error "diagramly-kit not found. Please install and build the project first."
                exit 1
            fi
            ;;
        drawio|xml)
            print_warn "DrawIO conversion not directly supported. Please use draw.io CLI or online service."
            print_error "DrawIO to image conversion requires additional setup. Manual conversion needed."
            exit 1
            ;;
        *)
            print_error "Unsupported file type: $(get_file_extension "$input_file")"
            print_info "Supported types: mmd, mermaid, puml, plantuml, dot, gv, zenuml, drawio, xml"
            exit 1
            ;;
    esac
    
    if [[ -f "$output_path" ]]; then
        print_info "Successfully converted $input_file to $output_path"
        print_info "File size: $(du -h "$output_path" | cut -f1)"
    else
        print_error "Conversion failed - output file was not created"
        exit 1
    fi
}

# Parse command line arguments
if [[ $# -eq 0 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

INPUT_FILE="$1"
OUTPUT_FORMAT="${2:-$DEFAULT_OUTPUT_FORMAT}"
OUTPUT_DIR="${3:-$DEFAULT_OUTPUT_DIR}"

# Validate input file
if [[ ! -f "$INPUT_FILE" ]]; then
    print_error "Input file does not exist: $INPUT_FILE"
    exit 1
fi

# Validate output format
if [[ "$OUTPUT_FORMAT" != "png" ]] && [[ "$OUTPUT_FORMAT" != "svg" ]] && [[ "$OUTPUT_FORMAT" != "pdf" ]]; then
    print_warn "Output format '$OUTPUT_FORMAT' not standard. Using default 'png'."
    OUTPUT_FORMAT="png"
fi

# Validate required tools based on file type
EXTENSION=$(get_file_extension "$INPUT_FILE")
case "$EXTENSION" in
    mmd|mermaid)
        if ! command_exists mmdc; then
            print_error "Mermaid CLI (mmdc) is required for .mmd/.mermaid files"
            print_info "Install with: npm install -g @mermaid-js/mermaid-cli"
            exit 1
        fi
        ;;
    puml|plantuml)
        if ! command_exists plantuml; then
            print_error "PlantUML is required for .puml/.plantuml files"
            print_info "Install with: brew install plantuml"
            exit 1
        fi
        ;;
    dot|gv)
        if ! command_exists dot; then
            print_error "Graphviz (dot) is required for .dot/.gv files"
            print_info "Install with: brew install graphviz"
            exit 1
        fi
        ;;
esac

# Perform the conversion
convert_dsl_to_image "$INPUT_FILE" "$OUTPUT_FORMAT" "$OUTPUT_DIR"

print_info "Conversion completed successfully!"