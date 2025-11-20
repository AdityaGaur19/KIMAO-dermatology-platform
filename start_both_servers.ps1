# Start both backend and frontend servers
$ErrorActionPreference = "Continue"

# Get script directory - handle both when run as file and when run directly
if ($PSScriptRoot) {
    Set-Location $PSScriptRoot
} else {
    # If run directly, try to find the script location or use current directory
    $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
    if ($scriptPath) {
        Set-Location $scriptPath
    } else {
        # Fallback: try to find DermaArcade_Chatbot_MVP directory
        $currentDir = Get-Location
        if ($currentDir.Path -notlike "*DermaArcade_Chatbot_MVP*") {
            $targetDir = Join-Path $currentDir "DermaArcade_Chatbot_MVP"
            if (Test-Path $targetDir) {
                Set-Location $targetDir
            } else {
                Write-Host "❌ Cannot find project directory!" -ForegroundColor Red
                Write-Host "Please navigate to DermaArcade_Chatbot_MVP directory first:" -ForegroundColor Yellow
                Write-Host "  cd DermaArcade\DermaArcade_Chatbot_MVP" -ForegroundColor Yellow
                Write-Host "Then run: .\start_both_servers.ps1" -ForegroundColor Yellow
                Write-Host "Press any key to exit..." -ForegroundColor Yellow
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                exit 1
            }
        }
    }
}

# Store the working directory
$PSScriptRoot = Get-Location

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Kimao Servers" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check for Python virtual environment
$python = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"
if (-not (Test-Path $python)) {
    Write-Host "❌ Virtual environment not found!" -ForegroundColor Red
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    try {
        python -m venv (Join-Path $PSScriptRoot ".venv")
        if (-not (Test-Path $python)) {
            Write-Host "❌ Failed to create virtual environment!" -ForegroundColor Red
            Write-Host "Please create it manually:" -ForegroundColor Yellow
            Write-Host "  python -m venv .venv" -ForegroundColor Yellow
            Write-Host "Press any key to exit..." -ForegroundColor Yellow
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            exit 1
        }
        Write-Host "✅ Virtual environment created!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Error creating virtual environment: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please create it manually:" -ForegroundColor Yellow
        Write-Host "  python -m venv .venv" -ForegroundColor Yellow
        Write-Host "Press any key to exit..." -ForegroundColor Yellow
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        exit 1
    }
}

# Verify we're in the right directory (check for website folder)
if (-not (Test-Path "website\index.html")) {
    Write-Host "❌ website\index.html not found!" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Yellow
    Write-Host "Please make sure you're in the DermaArcade_Chatbot_MVP directory" -ForegroundColor Yellow
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit 1
}

# Start backend in new window
Write-Host "Starting backend server (port 8000)..." -ForegroundColor Yellow
$backendWindow = Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot'; `$ErrorActionPreference = 'Continue'; Write-Host '========================================' -ForegroundColor Cyan; Write-Host 'BACKEND SERVER (Port 8000)' -ForegroundColor Cyan; Write-Host '========================================' -ForegroundColor Cyan; Write-Host ''; try { .\.venv\Scripts\python.exe -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload } catch { Write-Host 'ERROR: Backend server failed to start!' -ForegroundColor Red; Write-Host `$_.Exception.Message -ForegroundColor Red; Write-Host ''; Write-Host 'Press any key to close this window...' -ForegroundColor Yellow; `$null = `$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') }" -PassThru

Start-Sleep -Seconds 3

# Start frontend HTML website in new window
Write-Host "Starting HTML frontend server (port 8501)..." -ForegroundColor Yellow
$frontendWindow = Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot'; `$ErrorActionPreference = 'Continue'; Write-Host '========================================' -ForegroundColor Cyan; Write-Host 'HTML FRONTEND SERVER (Port 8501)' -ForegroundColor Cyan; Write-Host '========================================' -ForegroundColor Cyan; Write-Host ''; try { .\.venv\Scripts\python.exe start_website.py } catch { Write-Host 'ERROR: Frontend server failed to start!' -ForegroundColor Red; Write-Host `$_.Exception.Message -ForegroundColor Red; Write-Host ''; Write-Host 'Press any key to close this window...' -ForegroundColor Yellow; `$null = `$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') }" -PassThru

Write-Host ""
Write-Host "✅ Servers starting in separate windows!" -ForegroundColor Green
Write-Host ""
Write-Host "Backend:  http://localhost:8000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:8501" -ForegroundColor Cyan
Write-Host ""
Write-Host "Waiting for servers to start..." -ForegroundColor Yellow

Start-Sleep -Seconds 5

# Check status
Write-Host ""
Write-Host "Checking server status..." -ForegroundColor Yellow
$backendOk = $false
$frontendOk = $false

try {
    $r = Invoke-RestMethod -Uri "http://localhost:8000/health" -TimeoutSec 3
    Write-Host "✅ Backend is running!" -ForegroundColor Green
    $backendOk = $true
} catch {
    Write-Host "⚠️  Backend not ready yet (may still be starting)" -ForegroundColor Yellow
}

# Wait a bit for HTML server to start
Start-Sleep -Seconds 3
try {
    $r = Invoke-WebRequest -Uri "http://localhost:8501" -UseBasicParsing -TimeoutSec 5
    Write-Host "✅ HTML frontend is running!" -ForegroundColor Green
    $frontendOk = $true
} catch {
    Write-Host "⚠️  Frontend not ready yet (may still be starting)" -ForegroundColor Yellow
    Write-Host "   Check the frontend server window for any errors" -ForegroundColor Yellow
}

if ($backendOk -and $frontendOk) {
    Write-Host ""
    Write-Host "✅✅✅ BOTH SERVERS ARE RUNNING! ✅✅✅" -ForegroundColor Green
    Write-Host ""
    Write-Host "Backend:  http://localhost:8000" -ForegroundColor Cyan
    Write-Host "Frontend: http://localhost:8501" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Server windows are open. Check them for logs." -ForegroundColor Yellow
    Write-Host "Press Ctrl+C in this window to stop monitoring (servers will keep running)." -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "Servers are starting. Please check the separate windows for logs." -ForegroundColor Cyan
    Write-Host "Backend window should show FastAPI/uvicorn logs" -ForegroundColor Gray
    Write-Host "Frontend window should show Python HTTP server logs" -ForegroundColor Gray
    Write-Host ""
}

# Keep script running so user can see status
Write-Host "Monitoring servers... (Press Ctrl+C to exit this window)" -ForegroundColor Gray
Write-Host "Note: Closing this window will NOT stop the servers." -ForegroundColor Gray
Write-Host "To stop servers, close the individual server windows." -ForegroundColor Gray
Write-Host ""

try {
    # Keep script alive and check server status periodically
    while ($true) {
        Start-Sleep -Seconds 30
        try {
            $backendCheck = Invoke-RestMethod -Uri "http://localhost:8000/health" -TimeoutSec 2 -ErrorAction SilentlyContinue
            $frontendCheck = Invoke-WebRequest -Uri "http://localhost:8501" -UseBasicParsing -TimeoutSec 2 -ErrorAction SilentlyContinue
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ✅ Both servers are running" -ForegroundColor Green
        } catch {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ⚠️  One or both servers may have stopped. Check the server windows." -ForegroundColor Yellow
        }
    }
} catch {
    # User pressed Ctrl+C or window closed
    Write-Host ""
    Write-Host "Monitoring stopped. Servers are still running in separate windows." -ForegroundColor Yellow
    Write-Host "Press any key to exit..." -ForegroundColor Gray
    try {
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    } catch {
        # If ReadKey fails, just exit
    }
}