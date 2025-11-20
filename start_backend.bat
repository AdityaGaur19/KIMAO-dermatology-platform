@echo off
REM Batch file to start the backend server
REM This avoids PowerShell execution policy issues

echo Starting DermaArcade Backend...
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

REM Change to backend directory
cd backend

echo Starting FastAPI backend server...
echo Server will be available at: http://localhost:8000
echo API docs will be available at: http://localhost:8000/docs
echo.
echo Press CTRL+C to stop the server
echo.

REM Start the backend
python api.py

