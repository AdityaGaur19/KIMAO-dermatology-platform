# PowerShell script to start both backend and frontend
# Opens two separate windows

$ErrorActionPreference = "Continue"

# Set execution policy
try {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null
} catch {
    # Ignore if already set
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting DermaArcade (Backend + Frontend)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get current directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

# Check if virtual environment exists
if (-not (Test-Path ".venv\Scripts\python.exe")) {
    Write-Host "❌ Virtual environment not found!" -ForegroundColor Red
    Write-Host "   Please run: .\setup.ps1" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Or manually:" -ForegroundColor Yellow
    Write-Host "   python -m venv .venv" -ForegroundColor White
    Write-Host "   .\.venv\Scripts\Activate.ps1" -ForegroundColor White
    Write-Host "   pip install -r requirements.txt" -ForegroundColor White
    pause
    exit 1
}

# Start backend in new window
Write-Host "Starting backend in new window..." -ForegroundColor Yellow
$backendCmd = "cd '$scriptDir'; Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; .\.venv\Scripts\Activate.ps1; cd backend; python api.py"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $backendCmd

# Wait a bit for backend to start
Write-Host "Waiting for backend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Start frontend in new window
Write-Host "Starting frontend in new window..." -ForegroundColor Yellow
$frontendCmd = "cd '$scriptDir'; Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; .\.venv\Scripts\Activate.ps1; cd app; python -m streamlit run app.py --server.port=8501 --server.address=0.0.0.0"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $frontendCmd

Write-Host ""
Write-Host "✅ Both services started!" -ForegroundColor Green
Write-Host ""
Write-Host "Backend: http://localhost:8000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:8501" -ForegroundColor Cyan
Write-Host ""
Write-Host "The website should open automatically in your browser." -ForegroundColor Yellow
Write-Host "Close the PowerShell windows to stop the services." -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to exit this window (services will keep running)..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

