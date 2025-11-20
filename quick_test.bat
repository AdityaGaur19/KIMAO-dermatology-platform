@echo off
echo ========================================
echo DermaArcade Chatbot - Quick Test
echo ========================================
echo.

REM Check if virtual environment exists
if not exist ".venv\Scripts\activate.bat" (
    echo ERROR: Virtual environment not found!
    echo Please run setup.ps1 first or create venv manually.
    pause
    exit /b 1
)

REM Activate virtual environment
call .venv\Scripts\activate.bat

REM Check if backend is running
echo Checking if backend is running...
curl -s http://localhost:8000/docs >nul 2>&1
if %errorlevel% equ 0 (
    echo Backend is running! Testing endpoint...
    python test_chatbot.py
) else (
    echo.
    echo Backend is NOT running!
    echo.
    echo Please start the backend first:
    echo   1. Open a new terminal
    echo   2. cd backend
    echo   3. python api.py
    echo.
    echo Then run this test again.
)

pause













