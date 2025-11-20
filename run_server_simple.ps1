# Simple script to run the chatbot backend server
$ErrorActionPreference = "Continue"

# Change to script directory
Set-Location $PSScriptRoot

Write-Host "Starting DermaArcade Chatbot Backend..." -ForegroundColor Cyan
Write-Host ""

# Clean up corrupted packages if they exist
if (Test-Path ".venv\Scripts\python.exe") {
    $sitePackages = Join-Path $PSScriptRoot ".venv\Lib\site-packages"
    if (Test-Path $sitePackages) {
        Get-ChildItem -Path $sitePackages -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "^~" } | ForEach-Object {
            Write-Host "Cleaning up corrupted package: $($_.Name)" -ForegroundColor Yellow
            Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

# Find Python
$python = $null
if (Test-Path ".venv\Scripts\python.exe") {
    $python = ".venv\Scripts\python.exe"
    Write-Host "Using virtual environment Python" -ForegroundColor Green
} else {
    # Try to find Python
    $python = Get-Command python -ErrorAction SilentlyContinue
    if (-not $python) {
        $python = Get-Command py -ErrorAction SilentlyContinue
    }
    if ($python) {
        $python = $python.Source
        Write-Host "Using system Python: $python" -ForegroundColor Green
    } else {
        Write-Host "ERROR: Python not found!" -ForegroundColor Red
        Write-Host "Please install Python or create a virtual environment" -ForegroundColor Yellow
        pause
        exit 1
    }
}

Write-Host ""
Write-Host "Installing dependencies..." -ForegroundColor Yellow
# Suppress warnings and errors from pip
$env:PYTHONWARNINGS = "ignore"
& $python -m pip install -q --disable-pip-version-check google-generativeai fastapi uvicorn python-dotenv 2>&1 | Where-Object { $_ -notmatch "WARNING.*invalid distribution" } | Out-Null

Write-Host ""
Write-Host "Starting server at http://localhost:8000" -ForegroundColor Cyan
Write-Host "Press CTRL+C to stop" -ForegroundColor Gray
Write-Host ""

# Start the server
& $python -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload

