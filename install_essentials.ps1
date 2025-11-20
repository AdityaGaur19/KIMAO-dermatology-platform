# Install essential packages for website to run
cd $PSScriptRoot

Write-Host "Installing essential packages..." -ForegroundColor Yellow
Write-Host "This will install: streamlit, fastapi, uvicorn, requests, Pillow" -ForegroundColor Cyan
Write-Host ""

.\.venv\Scripts\python.exe -m pip install --upgrade pip
.\.venv\Scripts\python.exe -m pip install streamlit fastapi uvicorn[standard] requests Pillow python-multipart

Write-Host ""
Write-Host "✅ Essential packages installed!" -ForegroundColor Green
Write-Host ""
Write-Host "You can now start the website with:" -ForegroundColor Cyan
Write-Host "  .\start_website.ps1" -ForegroundColor White

