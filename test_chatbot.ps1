# PowerShell script to test if the chatbot is working
# This script handles Python path issues on Windows

$ErrorActionPreference = "Stop"

# Set execution policy for this session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DermaArcade Chatbot - Test Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to find Python executable
function Find-Python {
    $pythonCommands = @("python", "python3", "py")
    $venvPython = ".venv\Scripts\python.exe"
    
    # First, check if virtual environment exists and has Python
    if (Test-Path $venvPython) {
        Write-Host "✅ Found Python in virtual environment" -ForegroundColor Green
        return $venvPython
    }
    
    # Try different Python commands
    foreach ($cmd in $pythonCommands) {
        try {
            $output = & $cmd --version 2>&1
            # Check if it's the Windows Store redirect
            if ($output -match "Python was not found" -or $output -match "Microsoft Store") {
                continue
            }
            if ($LASTEXITCODE -eq 0 -or $?) {
                Write-Host "✅ Found Python: $cmd ($output)" -ForegroundColor Green
                return $cmd
            }
        } catch {
            continue
        }
    }
    
    return $null
}

# Find Python
$pythonCmd = Find-Python

if (-not $pythonCmd) {
    Write-Host "❌ Python not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please do one of the following:" -ForegroundColor Yellow
    Write-Host "1. Install Python from https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "2. Or run the setup script first: .\setup.ps1" -ForegroundColor White
    Write-Host "3. Or activate your virtual environment: .\.venv\Scripts\Activate.ps1" -ForegroundColor White
    Write-Host ""
    exit 1
}

# Check if virtual environment exists
$venvExists = Test-Path ".venv\Scripts\activate.ps1"
if (-not $venvExists) {
    Write-Host "⚠️  Virtual environment not found!" -ForegroundColor Yellow
    Write-Host "   Creating virtual environment..." -ForegroundColor Yellow
    & $pythonCmd -m venv .venv
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to create virtual environment" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Virtual environment created" -ForegroundColor Green
}

# Activate virtual environment if using system Python
if ($pythonCmd -ne ".venv\Scripts\python.exe") {
    Write-Host "Activating virtual environment..." -ForegroundColor Yellow
    & .\.venv\Scripts\Activate.ps1
    $pythonCmd = ".venv\Scripts\python.exe"
}

# Check if requirements are installed
Write-Host ""
Write-Host "Checking dependencies..." -ForegroundColor Yellow
$hasFastAPI = & $pythonCmd -c "import fastapi; print('ok')" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Dependencies not installed. Installing..." -ForegroundColor Yellow
    & $pythonCmd -m pip install --upgrade pip
    & $pythonCmd -m pip install -r requirements.txt
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Dependencies installed" -ForegroundColor Green
} else {
    Write-Host "✅ Dependencies are installed" -ForegroundColor Green
}

# Check knowledge base files
Write-Host ""
Write-Host "📚 Checking knowledge base files..." -ForegroundColor Yellow
$kbDir = "kb"
if (-not (Test-Path $kbDir)) {
    Write-Host "❌ kb/ directory not found!" -ForegroundColor Red
    exit 1
}

$mdFiles = Get-ChildItem -Path $kbDir -Filter "*.md"
if ($mdFiles.Count -eq 0) {
    Write-Host "❌ No .md files found in kb/ directory!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Found $($mdFiles.Count) knowledge base file(s):" -ForegroundColor Green
foreach ($f in $mdFiles) {
    Write-Host "   - $($f.Name)" -ForegroundColor White
}

# Check if backend is running
Write-Host ""
Write-Host "🔍 Checking if backend is running..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000/docs" -TimeoutSec 5 -UseBasicParsing -ErrorAction Stop
    Write-Host "✅ Backend server is running!" -ForegroundColor Green
    Write-Host "   API docs available at: http://localhost:8000/docs" -ForegroundColor Cyan
    
    # Run the Python test script
    Write-Host ""
    Write-Host "🧪 Running comprehensive tests..." -ForegroundColor Yellow
    Write-Host ""
    
    if (Test-Path "test_chatbot.py") {
        & $pythonCmd test_chatbot.py
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "========================================" -ForegroundColor Cyan
            Write-Host "✅ All tests passed! Chatbot is working correctly." -ForegroundColor Green
            Write-Host ""
            Write-Host "Next steps:" -ForegroundColor Yellow
            Write-Host "1. Keep the backend running" -ForegroundColor White
            Write-Host "2. Start the Streamlit frontend: cd app; streamlit run app.py" -ForegroundColor White
            Write-Host "3. Open http://localhost:8501 in your browser" -ForegroundColor White
            exit 0
        } else {
            Write-Host ""
            Write-Host "❌ Some tests failed. Check the output above." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "⚠️  test_chatbot.py not found. Backend is running, but cannot run full tests." -ForegroundColor Yellow
        Write-Host "   You can manually test at: http://localhost:8000/docs" -ForegroundColor Cyan
        exit 0
    }
    
} catch {
    Write-Host "❌ Backend server is NOT running!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please start the backend first:" -ForegroundColor Yellow
    Write-Host "1. Open a new PowerShell terminal" -ForegroundColor White
    Write-Host "2. cd DermaArcade_Chatbot_MVP" -ForegroundColor White
    Write-Host "3. .\.venv\Scripts\Activate.ps1" -ForegroundColor White
    Write-Host "4. cd backend" -ForegroundColor White
    Write-Host "5. $pythonCmd api.py" -ForegroundColor White
    Write-Host ""
    Write-Host "Then run this test script again." -ForegroundColor Yellow
    exit 1
}

