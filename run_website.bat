@echo off
REM Simple batch file to run the website

cd /d %~dp0

echo Starting DermaArcade Website...
echo.

python start_website.py

pause

