@echo off
title DermaArcade Website
color 0A

echo.
echo ========================================
echo   DermaArcade - Starting Website
echo ========================================
echo.

cd /d %~dp0

REM Check Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found!
    echo Please install Python first.
    pause
    exit /b 1
)

echo [OK] Python found
echo.

REM Copy video if needed
if not exist "website\static\background_video.mp4" (
    echo [INFO] Copying background video...
    if exist "static\background_video.mp4" (
        if not exist "website\static" mkdir website\static
        copy "static\background_video.mp4" "website\static\background_video.mp4" >nul
        echo [OK] Video copied
    ) else if exist "C:\Users\Aditya\Downloads\mylivewallpapers.com-Pixel-Pleiades-Overlord.mp4" (
        if not exist "website\static" mkdir website\static
        copy "C:\Users\Aditya\Downloads\mylivewallpapers.com-Pixel-Pleiades-Overlord.mp4" "website\static\background_video.mp4" >nul
        echo [OK] Video copied from Downloads
    )
)

echo.
echo ========================================
echo   Starting Server...
echo ========================================
echo.
echo Website will open at: http://localhost:8501
echo.
echo Press CTRL+C to stop the server
echo.

python start_website.py

pause
