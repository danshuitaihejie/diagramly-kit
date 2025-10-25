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
    echo "  - Markmap (.mm, .markmap)"
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

# Function to encode diagram source using deflate compression (similar to JavaScript version)
encode_diagram_source() {
    local source="$1"
    
    # Create temporary file with the source content
    local temp_input=$(mktemp)
    echo -n "$source" > "$temp_input"
    
    # Compress using gzip, then base64 encode and make URL-safe
    local compressed=$(gzip -c "$temp_input" | base64 -w 0 | tr '+/' '-_' | tr -d '=')
    
    # Clean up
    rm "$temp_input"
    
    echo "$compressed"
}

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
            print_error "Unsupported file extension: $extension"
            return 1
            ;;
    esac
}

# Function to convert DSL to image using Kroki.io service
convert_dsl_to_image_kroki() {
    local input_file="$1"
    local output_format="$2"
    local output_dir="$3"
    local filename=$(get_filename_without_ext "$input_file")
    
    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"
    
    local output_path="${output_dir}/${filename}.${output_format}"
    
    print_info "Converting $input_file to $output_path using Kroki.io service"
    
    # Get diagram type from extension
    local diagram_type
    diagram_type=$(get_diagram_type_from_extension "$input_file")
    if [ $? -ne 0 ]; then
        exit 1
    fi
    
    # Read DSL content from file
    local diagram_dsl
    diagram_dsl=$(cat "$input_file")
    
    # Encode the diagram source
    local encoded_value
    encoded_value=$(encode_diagram_source "$diagram_dsl")
    print_info "Encoded diagram source length: ${#encoded_value}"
    
    # Create the Kroki URL
    #local base_url="https://kroki.io"
    local base_url="http://localhost:8000"
    local kroki_url="${base_url}/${diagram_type}/${output_format}/${encoded_value}"
    
    print_info "Generated Kroki URL: ${kroki_url:0:80}..."
    
    # Download the image from Kroki with retry
    local retry_count=3
    local success=false
    
    for i in $(seq 1 $retry_count); do
        print_info "Making request to Kroki service (attempt $i)..."
        if curl -s -f -L -o "$output_path" "$kroki_url"; then
            success=true
            break
        else
            print_warn "Kroki request failed (attempt $i)"
            if [ $i -lt $retry_count ]; then
                print_info "Retrying in 1 second..."
                sleep 1
            fi
        fi
    done
    
    if [ "$success" = true ]; then
        if [[ -f "$output_path" && -s "$output_path" ]]; then
            print_info "Successfully downloaded image to $output_path"
            print_info "File size: $(du -h "$output_path" | cut -f1)"
            return 0
        else
            print_error "Conversion failed - output file was not created or is empty"
            return 1
        fi
    else
        print_error "Failed to convert diagram after $retry_count attempts"
        return 1
    fi
}

# Main conversion function - first tries local tools, falls back to Kroki.io
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
                print_warn "Mermaid CLI (mmdc) not found, falling back to Kroki.io service"
                convert_dsl_to_image_kroki "$input_file" "$output_format" "$output_dir"
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
                print_warn "PlantUML not found, falling back to Kroki.io service"
                convert_dsl_to_image_kroki "$input_file" "$output_format" "$output_dir"
            fi
            ;;
        dot|gv)
            if command_exists dot; then
                print_info "Using Graphviz (dot) to convert $input_file"
                dot -T${output_format} "$input_file" -o "$output_path"
            else
                print_warn "Graphviz (dot) not found, falling back to Kroki.io service"
                convert_dsl_to_image_kroki "$input_file" "$output_format" "$output_dir"
            fi
            ;;
        zenuml)
            print_warn "ZenUML conversion not directly supported by local tools, using Kroki.io service"
            convert_dsl_to_image_kroki "$input_file" "$output_format" "$output_dir"
            ;;
        drawio|xml)
            print_warn "DrawIO conversion not directly supported by local tools, using Kroki.io service"
            convert_dsl_to_image_kroki "$input_file" "$output_format" "$output_dir"
            ;;
        mm|markmap)
            print_warn "Markmap conversion not directly supported by local tools, using Kroki.io service"
            convert_dsl_to_image_kroki "$input_file" "$output_format" "$output_dir"
            ;;
        *)
            print_error "Unsupported file type: $(get_file_extension "$input_file")"
            print_info "Supported types: mmd, mermaid, puml, plantuml, dot, gv, zenuml, drawio, xml, mm, markmap"
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

# Perform the conversion (validates internally)
convert_dsl_to_image "$INPUT_FILE" "$OUTPUT_FORMAT" "$OUTPUT_DIR"

print_info "Conversion completed successfully!"