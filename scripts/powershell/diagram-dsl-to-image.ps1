# PowerShell script to convert DSL files to images
# Usage: .\diagram-dsl-to-image.ps1 -InputFile "path/to/file" [-OutputFormat "png"] [-OutputDir "path/to/output"]

param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("png", "svg", "pdf")]
    [string]$OutputFormat = "png",
    
    [Parameter(Mandatory=$false)]
    [string]$OutputDir = ".\output"
)

# Supported diagram types
$SupportedDiagramTypes = @("mermaid", "zenuml", "plantuml", "drawio", "markmap", "graphviz")

# Function to encode diagram source using deflate compression (similar to JavaScript version)
function Encode-DiagramSource {
    param([string]$Source)
    
    # Convert string to byte array
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Source)
    
    # Compress using Deflate (similar to Python reference implementation)
    $output = New-Object System.IO.MemoryStream
    $deflate = New-Object System.IO.Compression.DeflateStream($output, [System.IO.Compression.CompressionMode]::Compress)
    $deflate.Write($bytes, 0, $bytes.Length)
    $deflate.Close()
    
    # Get compressed bytes
    $compressedBytes = $output.ToArray()
    $output.Close()
    
    # Convert to Base64 and make URL-safe (following Python reference pattern)
    $base64 = [System.Convert]::ToBase64String($compressedBytes)
    $base64 = $base64 -replace '\+', '-'
    $base64 = $base64 -replace '/', '_'
    $base64 = $base64 -replace '=', ''
    
    return $base64
}

# Function to determine diagram type from file extension
function Get-DiagramTypeFromExtension {
    param([string]$FilePath)
    
    $extension = [System.IO.Path]::GetExtension($FilePath).ToLower().TrimStart('.')
    
    switch ($extension) {
        { $_ -in @("mmd", "mermaid") } { return "mermaid" }
        { $_ -in @("zenuml") } { return "zenuml" }
        { $_ -in @("puml", "plantuml", "pu") } { return "plantuml" }
        { $_ -in @("drawio", "xml") } { return "drawio" }
        { $_ -in @("mm", "markmap") } { return "markmap" }
        { $_ -in @("dot", "gv") } { return "graphviz" }
        default { 
            Write-Error "Unsupported file extension: $extension"
            return $null
        }
    }
}

# Check if input file exists
if (-not (Test-Path $InputFile)) {
    Write-Error "Input file does not exist: $InputFile"
    exit 1
}

# Get file info
$FileInfo = Get-Item $InputFile
$FileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
$DiagramType = Get-DiagramTypeFromExtension $InputFile

if ($null -eq $DiagramType) {
    Write-Error "Could not determine diagram type from file extension"
    exit 1
}

# Validate diagram type
if ($DiagramType -notin $SupportedDiagramTypes) {
    Write-Error "Unsupported diagram type: $DiagramType. Supported types are: $($SupportedDiagramTypes -join ', ')"
    exit 1
}

# Read DSL content from file
$DiagramDsl = Get-Content -Path $InputFile -Raw

Write-Host "Converting $DiagramType diagram: $InputFile" -ForegroundColor Green

# Encode the diagram source
$EncodedValue = Encode-DiagramSource -Source $DiagramDsl
Write-Host "Encoded diagram source length: $($EncodedValue.Length)" -ForegroundColor Cyan

# Create output directory if it doesn't exist
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

# Create the Kroki URL
$BaseUrl = "https://kroki.io"
$KrokiUrl = "$BaseUrl/$DiagramType/$OutputFormat/$EncodedValue"

Write-Host "Generated Kroki URL: $($KrokiUrl.Substring(0, [Math]::Min(80, $KrokiUrl.Length)))..." -ForegroundColor Cyan

# Download the image from Kroki
$OutputFile = Join-Path $OutputDir "$FileNameWithoutExt.$OutputFormat"
$RetryCount = 3
$Success = $false

for ($i = 1; $i -le $RetryCount -and -not $Success; $i++) {
    try {
        Write-Host "Making request to Kroki service (attempt $i)..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $KrokiUrl -OutFile $OutputFile -UseBasicParsing
        $Success = $True
        Write-Host "Successfully downloaded image to $OutputFile" -ForegroundColor Green
    }
    catch {
        Write-Warning "Kroki request failed with error: $($_.Exception.Message)"
        if ($i -lt $RetryCount) {
            Write-Host "Retrying in 1 second..." -ForegroundColor Yellow
            Start-Sleep -Seconds 1
        }
        else {
            Write-Error "Failed to fetch image from Kroki after $RetryCount attempts"
            exit 1
        }
    }
}

if ($Success) {
    $FileSize = (Get-Item $OutputFile).Length
    Write-Host "Conversion completed successfully! File size: $FileSize bytes" -ForegroundColor Green
    Write-Host "Output file: $OutputFile" -ForegroundColor Green
}
else {
    Write-Error "Failed to convert diagram after all retries"
    exit 1
}