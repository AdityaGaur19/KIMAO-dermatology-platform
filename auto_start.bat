@echo off
REM Auto-start script - Runs everything needed

cd /d %~dp0

echo ========================================
echo DermaArcade - Auto Starting
echo ========================================
echo.

REM Check if Python exists
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python not found!
    echo Please install Python first.
    pause
    exit /b 1
)

echo Python found!
echo.

REM Copy video if needed
if not exist "website\static\background_video.mp4" (
    if exist "static\background_video.mp4" (
        if not exist "website\static" mkdir website\static
        copy "static\background_video.mp4" "website\static\background_video.mp4" >nul
        echo Video copied
    )
)

echo.
echo Starting website...
echo Website will open at: http://localhost:8501
echo.
echo Press CTRL+C to stop
echo.

python start_website.py

pause

