# PowerShell setup script for DermaArcade Chatbot MVP
# Run this script to set up the Python virtual environment and install dependencies

$ErrorActionPreference = "Stop"

Write-Host "Setting up DermaArcade Chatbot MVP..." -ForegroundColor Green

# Set execution policy for this session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

# Function to find Python
function Find-Python {
    $pythonCommands = @("python", "python3", "py")
    $venvPython = ".venv\Scripts\python.exe"
    
    if (Test-Path $venvPython) {
        return $venvPython
    }
    
    foreach ($cmd in $pythonCommands) {
        try {
            $output = & $cmd --version 2>&1
            # Check if it's the Windows Store redirect
            if ($output -match "Python was not found" -or $output -match "Microsoft Store") {
                continue
            }
            if ($LASTEXITCODE -eq 0 -or $?) {
                return $cmd
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
    Write-Host "Error: Python not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Python:" -ForegroundColor Yellow
    Write-Host "1. Download from: https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "2. During installation, check 'Add Python to PATH'" -ForegroundColor White
    Write-Host "3. After installation, restart PowerShell and run this script again" -ForegroundColor White
    Write-Host ""
    Write-Host "OR install via Microsoft Store:" -ForegroundColor Yellow
    Write-Host "   Search for 'Python' in Microsoft Store and install it" -ForegroundColor White
    exit 1
}

Write-Host "Found Python: $pythonCmd" -ForegroundColor Green

# Create virtual environment
Write-Host "Creating Python virtual environment..." -ForegroundColor Yellow
& $pythonCmd -m venv .venv
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to create virtual environment. Make sure Python is installed." -ForegroundColor Red
    exit 1
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& .\.venv\Scripts\Activate.ps1

# Use venv Python
$venvPython = ".venv\Scripts\python.exe"

# Upgrade pip
Write-Host "Upgrading pip..." -ForegroundColor Yellow
& $venvPython -m pip install --upgrade pip

# Install requirements
Write-Host "Installing dependencies (this may take a while)..." -ForegroundColor Yellow
& $venvPython -m pip install -r requirements.txt

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nSetup complete! To get started:" -ForegroundColor Green
    Write-Host "1. Activate the virtual environment: .\.venv\Scripts\Activate.ps1" -ForegroundColor Cyan
    Write-Host "2. Start the backend: cd backend; python api.py" -ForegroundColor Cyan
    Write-Host "3. In another terminal, start the frontend: cd app; streamlit run app.py" -ForegroundColor Cyan
} else {
    Write-Host "Error: Failed to install dependencies." -ForegroundColor Red
    exit 1
}

