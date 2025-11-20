@echo off
cd /d %~dp0

echo Starting DermaArcade Chatbot Backend...
echo.

REM Check for virtual environment
if exist ".venv\Scripts\python.exe" (
    set PYTHON_CMD=.venv\Scripts\python.exe
    echo Using virtual environment
) else (
    set PYTHON_CMD=python
    echo Using system Python
)

echo.
echo Installing dependencies...
%PYTHON_CMD% -m pip install -q google-generativeai fastapi uvicorn python-dotenv 2>nul

echo.
echo Starting server at http://localhost:8000
echo Press CTRL+C to stop
echo.

%PYTHON_CMD% -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload

pause

