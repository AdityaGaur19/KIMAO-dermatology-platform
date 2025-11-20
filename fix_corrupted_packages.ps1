# Fix corrupted packages in virtual environment
$ErrorActionPreference = "Continue"

Set-Location $PSScriptRoot

Write-Host "Checking for corrupted packages..." -ForegroundColor Yellow

if (Test-Path ".venv\Scripts\python.exe") {
    $python = ".venv\Scripts\python.exe"
    Write-Host "Using virtual environment Python" -ForegroundColor Green
} else {
    Write-Host "Virtual environment not found. Skipping cleanup." -ForegroundColor Yellow
    exit 0
}

# Find and remove corrupted package directories
$sitePackages = Join-Path $PSScriptRoot ".venv\Lib\site-packages"
if (Test-Path $sitePackages) {
    Write-Host "Scanning for corrupted packages..." -ForegroundColor Yellow
    
    # Look for directories starting with ~ (corrupted packages)
    Get-ChildItem -Path $sitePackages -Directory | Where-Object { $_.Name -match "^~" } | ForEach-Object {
        Write-Host "Removing corrupted package: $($_.Name)" -ForegroundColor Red
        Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    # Also check for corrupted .dist-info directories
    Get-ChildItem -Path $sitePackages -Directory | Where-Object { $_.Name -match "^~.*\.dist-info$" } | ForEach-Object {
        Write-Host "Removing corrupted dist-info: $($_.Name)" -ForegroundColor Red
        Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    Write-Host "Cleanup complete!" -ForegroundColor Green
} else {
    Write-Host "Site-packages directory not found." -ForegroundColor Yellow
}

