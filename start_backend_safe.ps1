# Safe backend startup script with error handling
$ErrorActionPreference = "Continue"

Set-Location $PSScriptRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Backend Server (Safe Mode)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check virtual environment
$python = ".\.venv\Scripts\python.exe"
if (-not (Test-Path $python)) {
    Write-Host "❌ Virtual environment not found at: $python" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Yellow
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "✅ Virtual environment found" -ForegroundColor Green
Write-Host ""

# Test imports first
Write-Host "Testing imports..." -ForegroundColor Yellow
try {
    & $python -c "from backend.api_chat import app; print('✅ Imports OK')" 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) {
        throw "Import test failed"
    }
    Write-Host "✅ All imports successful" -ForegroundColor Green
} catch {
    Write-Host "❌ Import error: $_" -ForegroundColor Red
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host ""
Write-Host "Starting backend server..." -ForegroundColor Yellow
Write-Host "Server will be available at: http://localhost:8000" -ForegroundColor Cyan
Write-Host "Health check: http://localhost:8000/health" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Start backend with error handling
try {
    & $python -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload
} catch {
    Write-Host ""
    Write-Host "❌ Error starting server: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

