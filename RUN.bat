@echo off
title DermaArcade
color 0A
cd /d %~dp0

echo.
echo ========================================
echo   STARTING DERMAARCADE
echo ========================================
echo.

REM Start backend in new window
echo [1/2] Starting backend...
start "Backend" cmd /k "python -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000"

REM Wait
timeout /t 4 /nobreak >nul

REM Start website
echo [2/2] Starting website...
echo.
echo Website: http://localhost:8501
echo Backend:  http://localhost:8000
echo.
echo Press CTRL+C to stop
echo.

python start_website.py

