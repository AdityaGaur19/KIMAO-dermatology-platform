# Quick Start Backend Server

## The backend server is not running. Follow these steps:

### Option 1: Use the startup script (Recommended)
1. Open PowerShell in the project directory: `C:\DermaArcade\DermaArcade_Chatbot_MVP`
2. Run: `.\start_backend.ps1`

### Option 2: Manual start
1. Open a new PowerShell window
2. Navigate to the project:
   ```powershell
   cd C:\DermaArcade\DermaArcade_Chatbot_MVP
   ```
3. Activate virtual environment and start server:
   ```powershell
   .\.venv\Scripts\python.exe -m uvicorn backend.api_chat:app --host 0.0.0.0 --port 8000 --reload
   ```

### Option 3: Use the combined startup script
Run: `.\start_both_servers.ps1` (starts both backend and frontend)

## Verify Backend is Running
Open your browser and go to: `http://localhost:8000/health`

You should see: `{"status":"healthy","gemini_available":true}`

## Troubleshooting
- If you see import errors, make sure the virtual environment is activated
- If port 8000 is already in use, stop the process using that port first
- Check the PowerShell window for error messages

