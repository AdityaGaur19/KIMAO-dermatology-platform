# Master script to set up and test the chatbot
# This script handles everything automatically

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DermaArcade Chatbot - Complete Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set execution policy for this session
Write-Host "Setting execution policy..." -ForegroundColor Yellow
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

# Function to find Python
function Find-Python {
    $pythonCommands = @("python", "python3", "py")
    $venvPython = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"
    
    # Check virtual environment first
    if (Test-Path $venvPython) {
        return $venvPython
    }
    
    # Try system Python
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
    Write-Host "❌ Python not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Python is not installed on your system." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please install Python:" -ForegroundColor Cyan
    Write-Host "1. Download from: https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "2. During installation, check 'Add Python to PATH'" -ForegroundColor White
    Write-Host "3. After installation, restart PowerShell and run this script again" -ForegroundColor White
    Write-Host ""
    Write-Host "OR install via Microsoft Store:" -ForegroundColor Cyan
    Write-Host "   Search for 'Python' in Microsoft Store and install it" -ForegroundColor White
    exit 1
}

Write-Host "✅ Found Python: $pythonCmd" -ForegroundColor Green
$pythonVersion = & $pythonCmd --version 2>&1
Write-Host "   Version: $pythonVersion" -ForegroundColor Cyan
Write-Host ""

# Check/create virtual environment
$venvPath = Join-Path $PSScriptRoot ".venv"
$venvActivate = Join-Path $venvPath "Scripts\Activate.ps1"

if (-not (Test-Path $venvActivate)) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    & $pythonCmd -m venv $venvPath
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to create virtual environment" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Virtual environment created" -ForegroundColor Green
} else {
    Write-Host "✅ Virtual environment exists" -ForegroundColor Green
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& $venvActivate
$venvPython = Join-Path $venvPath "Scripts\python.exe"

# Upgrade pip
Write-Host "Upgrading pip..." -ForegroundColor Yellow
& $venvPython -m pip install --upgrade pip --quiet

# Check if requirements are installed
Write-Host "Checking dependencies..." -ForegroundColor Yellow
$requirementsFile = Join-Path $PSScriptRoot "requirements.txt"
$hasFastAPI = & $venvPython -c "import fastapi" 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "Installing dependencies (this may take a few minutes)..." -ForegroundColor Yellow
    & $venvPython -m pip install -r $requirementsFile
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Dependencies installed" -ForegroundColor Green
} else {
    Write-Host "✅ Dependencies are installed" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check knowledge base
Write-Host "Checking knowledge base files..." -ForegroundColor Yellow
$kbDir = Join-Path $PSScriptRoot "kb"
if (-not (Test-Path $kbDir)) {
    Write-Host "❌ kb/ directory not found!" -ForegroundColor Red
    exit 1
}

$mdFiles = Get-ChildItem -Path $kbDir -Filter "*.md" -ErrorAction SilentlyContinue
if ($mdFiles.Count -eq 0) {
    Write-Host "❌ No .md files found in kb/ directory!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Found $($mdFiles.Count) knowledge base file(s)" -ForegroundColor Green
Write-Host ""

# Ask user what to do next
Write-Host "What would you like to do?" -ForegroundColor Cyan
Write-Host "1. Start the backend server" -ForegroundColor White
Write-Host "2. Test the chatbot (requires backend running)" -ForegroundColor White
Write-Host "3. Start backend and test" -ForegroundColor White
Write-Host "4. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter choice (1-4)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "Starting backend server..." -ForegroundColor Green
        Write-Host "Server will be at: http://localhost:8000" -ForegroundColor Cyan
        Write-Host "API docs at: http://localhost:8000/docs" -ForegroundColor Cyan
        Write-Host "Press CTRL+C to stop" -ForegroundColor Yellow
        Write-Host ""
        $backendDir = Join-Path $PSScriptRoot "backend"
        Set-Location $backendDir
        & $venvPython api.py
    }
    "2" {
        Write-Host ""
        Write-Host "Testing chatbot..." -ForegroundColor Green
        $testScript = Join-Path $PSScriptRoot "test_chatbot.py"
        & $venvPython $testScript
    }
    "3" {
        Write-Host ""
        Write-Host "Starting backend in background..." -ForegroundColor Green
        $backendDir = Join-Path $PSScriptRoot "backend"
        $backendScript = Join-Path $backendDir "api.py"
        
        # Start backend in background job
        $job = Start-Job -ScriptBlock {
            param($python, $script)
            Set-Location (Split-Path $script)
            & $python $script
        } -ArgumentList $venvPython, $backendScript
        
        Write-Host "Waiting for backend to start..." -ForegroundColor Yellow
        Start-Sleep -Seconds 5
        
        # Test if backend is up
        $maxRetries = 10
        $retry = 0
        $backendUp = $false
        
        while ($retry -lt $maxRetries) {
            try {
                $response = Invoke-WebRequest -Uri "http://localhost:8000/docs" -TimeoutSec 2 -UseBasicParsing -ErrorAction Stop
                $backendUp = $true
                break
            } catch {
                $retry++
                Start-Sleep -Seconds 2
            }
        }
        
        if ($backendUp) {
            Write-Host "✅ Backend is running!" -ForegroundColor Green
            Write-Host ""
            Write-Host "Running tests..." -ForegroundColor Yellow
            $testScript = Join-Path $PSScriptRoot "test_chatbot.py"
            & $venvPython $testScript
            
            Write-Host ""
            Write-Host "Backend is still running in the background." -ForegroundColor Cyan
            Write-Host "To stop it, run: Stop-Job -Id $($job.Id); Remove-Job -Id $($job.Id)" -ForegroundColor Yellow
        } else {
            Write-Host "❌ Backend failed to start" -ForegroundColor Red
            Stop-Job -Id $job.Id -ErrorAction SilentlyContinue
            Remove-Job -Id $job.Id -ErrorAction SilentlyContinue
        }
    }
    "4" {
        Write-Host "Exiting..." -ForegroundColor Yellow
        exit 0
    }
    default {
        Write-Host "Invalid choice. Exiting..." -ForegroundColor Red
        exit 1
    }
}

