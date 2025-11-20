# Simple script to start website with minimal dependencies
cd $PSScriptRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting DermaArcade (Simple Mode)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

# Install minimal dependencies
Write-Host "Installing minimal dependencies..." -ForegroundColor Yellow
.\.venv\Scripts\python.exe -m pip install --quiet --upgrade pip
.\.venv\Scripts\python.exe -m pip install --quiet Pillow fastapi uvicorn python-multipart requests streamlit altair blinker cachetools click numpy packaging pandas protobuf requests rich toml tornado tzlocal watchdog gitpython typing-extensions tenacity 2>&1 | Out-Null

Write-Host "✅ Dependencies installed" -ForegroundColor Green
Write-Host ""

# Start backend in new window
Write-Host "Starting backend..." -ForegroundColor Yellow
$backendCmd = "cd '$PSScriptRoot'; Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; .\.venv\Scripts\python.exe backend/api_simple.py"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $backendCmd

# Wait for backend
Start-Sleep -Seconds 3

# Start frontend in new window
Write-Host "Starting frontend..." -ForegroundColor Yellow
$frontendCmd = "cd '$PSScriptRoot'; Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; .\.venv\Scripts\python.exe -m streamlit run app/app.py --server.port=8501 --server.address=0.0.0.0"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $frontendCmd

Write-Host ""
Write-Host "✅ Both services started!" -ForegroundColor Green
Write-Host ""
Write-Host "Backend: http://localhost:8000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:8501" -ForegroundColor Cyan
Write-Host ""
Write-Host "The website should open automatically in your browser." -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

