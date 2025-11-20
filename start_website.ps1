# PowerShell script to start the DermaArcade website
# This script handles Python path issues and starts the Streamlit frontend

$ErrorActionPreference = "Stop"

# Set execution policy for this session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting DermaArcade Website" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to find Python
function Find-Python {
    $venvPython = ".venv\Scripts\python.exe"
    
    if (Test-Path $venvPython) {
        return $venvPython
    }
    
    $pythonCommands = @("python", "python3", "py")
    foreach ($cmd in $pythonCommands) {
        try {
            $output = & $cmd --version 2>&1
            if ($output -notmatch "Python was not found" -and $output -notmatch "Microsoft Store") {
                if ($LASTEXITCODE -eq 0 -or $?) {
                    return $cmd
                }
            }
        } catch {
            continue
        }
    }
    
    return $null
}

# Find Python
Write-Host "Looking for Python..." -ForegroundColor Yellow
$pythonCmd = Find-Python

if (-not $pythonCmd) {
    Write-Host "❌ Python not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Python or run setup first:" -ForegroundColor Yellow
    Write-Host "   .\setup.ps1" -ForegroundColor White
    exit 1
}

Write-Host "✅ Found Python: $pythonCmd" -ForegroundColor Green
Write-Host ""

# Check if virtual environment exists
if (-not (Test-Path ".venv\Scripts\activate.ps1")) {
    Write-Host "⚠️  Virtual environment not found!" -ForegroundColor Yellow
    Write-Host "   Creating virtual environment..." -ForegroundColor Yellow
    & $pythonCmd -m venv .venv
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to create virtual environment" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Virtual environment created" -ForegroundColor Green
    Write-Host "   Installing dependencies..." -ForegroundColor Yellow
    & .\.venv\Scripts\python.exe -m pip install --upgrade pip
    & .\.venv\Scripts\python.exe -m pip install -r requirements.txt
    $pythonCmd = ".venv\Scripts\python.exe"
} else {
    # Activate virtual environment
    Write-Host "Activating virtual environment..." -ForegroundColor Yellow
    & .\.venv\Scripts\Activate.ps1
    $pythonCmd = ".venv\Scripts\python.exe"
}

# Check if backend is running
Write-Host ""
Write-Host "Checking if backend is running..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000/health" -TimeoutSec 2 -UseBasicParsing -ErrorAction Stop
    Write-Host "✅ Backend is running!" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Backend is not running!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "The website will work, but image analysis requires the backend." -ForegroundColor Cyan
    Write-Host "To start the backend, run in another terminal:" -ForegroundColor Cyan
    Write-Host "   .\start_backend.ps1" -ForegroundColor White
    Write-Host ""
}

# Change to app directory
Set-Location app

Write-Host ""
Write-Host "Starting Streamlit website..." -ForegroundColor Green
Write-Host "Website will open at: http://localhost:8501" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press CTRL+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Start Streamlit
& $pythonCmd -m streamlit run app.py --server.port=8501 --server.address=0.0.0.0

