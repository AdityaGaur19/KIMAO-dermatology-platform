# Simple script to run Streamlit frontend
cd $PSScriptRoot

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null

Write-Host "Starting Streamlit..." -ForegroundColor Cyan
Write-Host "Website will open at: http://localhost:8501" -ForegroundColor Green
Write-Host ""

.\.venv\Scripts\python.exe -m streamlit run app/app.py --server.port=8501 --server.address=0.0.0.0

