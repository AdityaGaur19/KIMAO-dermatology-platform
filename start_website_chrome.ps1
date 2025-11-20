# Start website and open in Chrome
cd $PSScriptRoot

Write-Host "Starting DermaArcade Website..." -ForegroundColor Cyan
Write-Host ""

# Activate venv and start streamlit
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

.\.venv\Scripts\python.exe -m streamlit run app/app.py --server.port=8501 --server.address=0.0.0.0 --browser.gatherUsageStats=false

# Open Chrome after a delay (this runs in background)
Start-Sleep -Seconds 3
Start-Process "chrome.exe" "http://localhost:8501"

