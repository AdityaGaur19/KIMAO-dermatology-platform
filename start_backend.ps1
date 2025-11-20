# Simple backend startup script
$ErrorActionPreference = "Continue"

Set-Location $PSScriptRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Backend Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$python = ".\.venv\Scripts\python.exe"

if (-not (Test-Path $python)) {
    Write-Host "❌ Virtual environment not found at: $python" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Virtual environment found" -ForegroundColor Green
Write-Host "Starting backend on http://localhost:8000" -ForegroundColor Yellow
Write-Host ""

# Start backend
& $python -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload
