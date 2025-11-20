# 🚀 How to Start the DermaArcade Website

## Quick Commands (Copy & Paste)

### Option 1: Start Everything (Backend + Frontend)

**Open TWO PowerShell terminals:**

**Terminal 1 - Backend:**
```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
.\.venv\Scripts\Activate.ps1
cd backend
python api.py
```

**Terminal 2 - Frontend (after backend starts):**
```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
.\.venv\Scripts\Activate.ps1
cd app
streamlit run app.py
```

### Option 2: Using Batch Files

**Terminal 1 - Backend:**
```cmd
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
start_backend.bat
```

**Terminal 2 - Frontend:**
```cmd
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
start_website.bat
```

## Step-by-Step Instructions

### Step 1: Open PowerShell

Press `Windows Key + X` and select "Windows PowerShell" or "Terminal"

### Step 2: Navigate to Project

```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
```

### Step 3: Activate Virtual Environment

```powershell
.\.venv\Scripts\Activate.ps1
```

You should see `(.venv)` in your prompt.

### Step 4: Start Backend (Terminal 1)

```powershell
cd backend
python api.py
```

Wait until you see:
```
INFO:     Uvicorn running on http://0.0.0.0:8000
```

### Step 5: Start Frontend (New Terminal 2)

Open a **NEW** PowerShell window:

```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
.\.venv\Scripts\Activate.ps1
cd app
streamlit run app.py
```

### Step 6: Open Website

The website will automatically open at:
```
http://localhost:8501
```

Or manually open: http://localhost:8501

## Troubleshooting

### "Python not found"
```powershell
# Check if venv exists
Test-Path .venv\Scripts\python.exe

# If not, run setup
.\setup.ps1
```

### "Port already in use"
```powershell
# Kill process on port 8000
netstat -ano | findstr :8000
# Note the PID, then:
taskkill /PID <PID> /F

# Or use different port
streamlit run app.py --server.port=8502
```

### "Module not found"
```powershell
# Reinstall dependencies
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

## All-in-One Command (Single Line)

**Backend:**
```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP; .\.venv\Scripts\Activate.ps1; cd backend; python api.py
```

**Frontend:**
```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP; .\.venv\Scripts\Activate.ps1; cd app; streamlit run app.py
```

