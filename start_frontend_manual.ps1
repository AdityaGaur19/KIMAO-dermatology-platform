# Manual frontend server startup script
# Use this if the main script fails to start the frontend

$ErrorActionPreference = "Continue"

# Get script directory
if ($PSScriptRoot) {
    Set-Location $PSScriptRoot
} else {
    $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
    if ($scriptPath) {
        Set-Location $scriptPath
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "REACT FRONTEND SERVER (Port 8501)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Check Node.js
$nodeCheck = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeCheck) {
    Write-Host "❌ Node.js not found!" -ForegroundColor Red
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit 1
}

Write-Host "Node.js version: $(node --version)" -ForegroundColor Green
Write-Host "npm version: $(npm --version)" -ForegroundColor Green
Write-Host ""

# Check package.json
if (-not (Test-Path "package.json")) {
    Write-Host "❌ package.json not found!" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Yellow
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit 1
}

# Check node_modules
if (-not (Test-Path "node_modules")) {
    Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install dependencies!" -ForegroundColor Red
        Write-Host "Press any key to exit..." -ForegroundColor Yellow
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        exit 1
    }
}

Write-Host "Starting React frontend server..." -ForegroundColor Yellow
Write-Host ""

# Start the server
npm run dev

Write-Host ""
Write-Host "Frontend server stopped." -ForegroundColor Yellow
Write-Host "Press any key to close..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

