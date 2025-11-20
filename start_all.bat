@echo off
title DermaArcade - Starting All Services
color 0A

cd /d %~dp0

echo ========================================
echo   DermaArcade - Starting All Services
echo ========================================
echo.

REM Check Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found!
    pause
    exit /b 1
)

echo [OK] Python found
echo.

REM Install dependencies if needed
if exist ".venv\Scripts\python.exe" (
    echo [INFO] Using virtual environment...
    set PYTHON_CMD=.venv\Scripts\python.exe
    .venv\Scripts\python.exe -m pip install -q python-dotenv google-generativeai fastapi uvicorn 2>nul
) else (
    echo [INFO] Using system Python...
    set PYTHON_CMD=python
    python -m pip install -q python-dotenv google-generativeai fastapi uvicorn 2>nul
)

echo.
echo [INFO] Starting chatbot backend in new window...
start "DermaArcade Backend" cmd /k "%PYTHON_CMD% -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000"

echo [INFO] Waiting for backend to start...
timeout /t 3 /nobreak >nul

echo.
echo [INFO] Starting website...
echo Website will open at: http://localhost:8501
echo.
echo Press CTRL+C to stop the website
echo.

%PYTHON_CMD% start_website.py

pause
