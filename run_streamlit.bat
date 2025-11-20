@echo off
REM Simple batch file to run Streamlit

cd /d %~dp0

echo Starting Streamlit...
echo Website will open at: http://localhost:8501
echo.

call .venv\Scripts\activate.bat
python -m streamlit run app/app.py --server.port=8501 --server.address=0.0.0.0

pause

