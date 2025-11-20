# Start chatbot backend with Gemini API
cd $PSScriptRoot

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting DermaArcade Chatbot Backend" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Python is available
$pythonCmd = $null
$pythonCommands = @("python", "python3", "py")

foreach ($cmd in $pythonCommands) {
    try {
        $output = & $cmd --version 2>&1
        if ($output -notmatch "Python was not found" -and $output -notmatch "Microsoft Store") {
            $pythonCmd = $cmd
            break
        }
    } catch {
        continue
    }
}

if (-not $pythonCmd) {
    Write-Host "❌ Python not found!" -ForegroundColor Red
    Write-Host "Please install Python first." -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "✅ Found Python: $pythonCmd" -ForegroundColor Green
Write-Host ""

# Check for virtual environment
if (Test-Path ".venv\Scripts\python.exe") {
    Write-Host "✅ Activating virtual environment..." -ForegroundColor Green
    & ".venv\Scripts\python.exe" -m pip install -q google-generativeai fastapi uvicorn 2>$null
    $pythonCmd = ".venv\Scripts\python.exe"
} else {
    Write-Host "⚠️  Virtual environment not found. Installing packages globally..." -ForegroundColor Yellow
    & $pythonCmd -m pip install -q google-generativeai fastapi uvicorn 2>$null
}

Write-Host ""
Write-Host "Checking for GEMINI_API_KEY..." -ForegroundColor Yellow

# Check for API key in .env file first
$envFile = Join-Path $PSScriptRoot ".env"
if (Test-Path $envFile) {
    $envContent = Get-Content $envFile | Where-Object { $_ -match "GEMINI_API_KEY" }
    if ($envContent) {
        $apiKey = ($envContent -split "=")[1].Trim()
        $env:GEMINI_API_KEY = $apiKey
        Write-Host "✅ GEMINI_API_KEY loaded from .env file" -ForegroundColor Green
    }
}

# Check for API key in environment
if (-not $env:GEMINI_API_KEY) {
    Write-Host ""
    Write-Host "⚠️  GEMINI_API_KEY not found!" -ForegroundColor Yellow
    Write-Host "Please check your .env file or set it as environment variable" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "✅ GEMINI_API_KEY found" -ForegroundColor Green
}

Write-Host ""
Write-Host "Starting chatbot backend server..." -ForegroundColor Yellow
Write-Host "Backend will run at: http://localhost:8000" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press CTRL+C to stop the server" -ForegroundColor Gray
Write-Host ""

# Start the backend
& $pythonCmd -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload

