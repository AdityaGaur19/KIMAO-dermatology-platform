# Direct server start script with error handling
$ErrorActionPreference = "Continue"

Set-Location $PSScriptRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting DermaArcade Chatbot Backend" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Use virtual environment Python
$python = ".\.venv\Scripts\python.exe"

if (-not (Test-Path $python)) {
    Write-Host "❌ Virtual environment not found!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Using Python: $python" -ForegroundColor Green
Write-Host ""

# Install dependencies
Write-Host "Installing/updating dependencies..." -ForegroundColor Yellow
$env:PYTHONWARNINGS = "ignore"
& $python -m pip install -q --disable-pip-version-check google-generativeai fastapi uvicorn python-dotenv 2>&1 | Out-Null

Write-Host ""
Write-Host "Starting server at http://localhost:8000" -ForegroundColor Cyan
Write-Host "Press CTRL+C to stop" -ForegroundColor Gray
Write-Host ""

# Start the server - run in foreground so we can see errors
& $python -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload

