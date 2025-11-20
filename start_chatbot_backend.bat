@echo off
title DermaArcade Chatbot Backend
color 0A

cd /d %~dp0

echo ========================================
echo Starting Chatbot Backend (Gemini API)
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
    echo [INFO] Installing dependencies...
    .venv\Scripts\python.exe -m pip install -q google-generativeai fastapi uvicorn 2>nul
    set PYTHON_CMD=.venv\Scripts\python.exe
) else (
    python -m pip install -q google-generativeai fastapi uvicorn 2>nul
    set PYTHON_CMD=python
)

echo.
echo [INFO] Starting backend server...
echo Backend will run at: http://localhost:8000
echo.
echo Press CTRL+C to stop
echo.

%PYTHON_CMD% -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload

pause

