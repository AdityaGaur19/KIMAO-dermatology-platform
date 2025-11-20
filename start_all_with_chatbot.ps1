# Start both website and chatbot backend
cd $PSScriptRoot

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting DermaArcade (Full Stack)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Start chatbot backend in new window
Write-Host "Starting chatbot backend..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot'; .\start_chatbot_backend.ps1"

# Wait a bit for backend to start
Start-Sleep -Seconds 3

# Start website
Write-Host "Starting website..." -ForegroundColor Yellow
Write-Host ""
python start_website.py

