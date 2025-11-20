# Simple PowerShell script to run the website
cd $PSScriptRoot

Write-Host "Starting DermaArcade Website..." -ForegroundColor Cyan
Write-Host "Website will open at: http://localhost:8501" -ForegroundColor Green
Write-Host ""

python start_website.py

