# Auto-start script - Runs everything needed for the website
cd $PSScriptRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DermaArcade - Auto Starting Everything" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

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

# Check if website files exist
if (-not (Test-Path "website\index.html")) {
    Write-Host "❌ Website files not found!" -ForegroundColor Red
    pause
    exit 1
}

# Check if video exists
if (-not (Test-Path "website\static\background_video.mp4")) {
    Write-Host "⚠️  Background video not found, copying..." -ForegroundColor Yellow
    if (Test-Path "static\background_video.mp4") {
        if (-not (Test-Path "website\static")) {
            New-Item -ItemType Directory -Path "website\static" | Out-Null
        }
        Copy-Item "static\background_video.mp4" -Destination "website\static\background_video.mp4" -Force
        Write-Host "✅ Video copied" -ForegroundColor Green
    } elseif (Test-Path "C:\Users\Aditya\Downloads\mylivewallpapers.com-Pixel-Pleiades-Overlord.mp4") {
        if (-not (Test-Path "website\static")) {
            New-Item -ItemType Directory -Path "website\static" | Out-Null
        }
        Copy-Item "C:\Users\Aditya\Downloads\mylivewallpapers.com-Pixel-Pleiades-Overlord.mp4" -Destination "website\static\background_video.mp4" -Force
        Write-Host "✅ Video copied from Downloads" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Starting website server..." -ForegroundColor Yellow
Write-Host "Website will open at: http://localhost:8501" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press CTRL+C to stop the server" -ForegroundColor Gray
Write-Host ""

# Start the website
& $pythonCmd start_website.py

