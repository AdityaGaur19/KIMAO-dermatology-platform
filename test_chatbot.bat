@echo off
REM Batch file to test if the chatbot is working
REM This avoids PowerShell execution policy issues

echo ========================================
echo DermaArcade Chatbot - Test Script
echo ========================================
echo.

REM Check if virtual environment exists
if not exist ".venv\Scripts\python.exe" (
    echo Virtual environment not found!
    echo.
    echo Please run setup first:
    echo   .\setup.ps1
    echo.
    echo OR manually create venv:
    echo   python -m venv .venv
    echo   .venv\Scripts\activate
    echo   pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

REM Activate virtual environment
call .venv\Scripts\activate.bat

REM Check knowledge base files
echo Checking knowledge base files...
if not exist "kb" (
    echo ERROR: kb/ directory not found!
    pause
    exit /b 1
)

dir /b kb\*.md >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: No .md files found in kb/ directory!
    pause
    exit /b 1
)

echo Knowledge base files found.
echo.

REM Check if backend is running
echo Checking if backend is running...
curl -s http://localhost:8000/docs >nul 2>&1
if %errorlevel% equ 0 (
    echo Backend is running! Running tests...
    echo.
    python test_chatbot.py
    if %errorlevel% equ 0 (
        echo.
        echo ========================================
        echo All tests passed! Chatbot is working.
        echo ========================================
    ) else (
        echo.
        echo ========================================
        echo Some tests failed. Check output above.
        echo ========================================
    )
) else (
    echo.
    echo Backend is NOT running!
    echo.
    echo Please start the backend first:
    echo   1. Open a new terminal
    echo   2. cd DermaArcade_Chatbot_MVP
    echo   3. .venv\Scripts\activate
    echo   4. cd backend
    echo   5. python api.py
    echo.
    echo Then run this test again.
)

echo.
pause

