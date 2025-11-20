# Quick Start Guide

## 🚀 Easiest Way (All-in-One Script)

Just run this one command:

```powershell
.\run_all.ps1
```

This script will:
- ✅ Find Python automatically
- ✅ Create virtual environment if needed
- ✅ Install all dependencies
- ✅ Give you options to start backend or test

## 📋 Step-by-Step Guide

### 1. First Time Setup

Run the setup script:
```powershell
.\setup.ps1
```

This will:
- Create a Python virtual environment
- Install all required packages
- Set everything up automatically

### 2. Start the Backend

**Option A: PowerShell Script**
```powershell
.\start_backend.ps1
```

**Option B: Batch File (works from CMD or PowerShell)**
```cmd
start_backend.bat
```

**Option C: Manual**
```powershell
.\.venv\Scripts\Activate.ps1
cd backend
python api.py
```

The backend will run at: http://localhost:8000
API docs at: http://localhost:8000/docs

### 3. Test the Chatbot

**Option A: PowerShell Script**
```powershell
.\test_chatbot.ps1
```

**Option B: Batch File**
```cmd
test_chatbot.bat
```

**Option C: Manual**
```powershell
.\.venv\Scripts\Activate.ps1
python test_chatbot.py
```

### 4. Start the Frontend (Optional)

In a new terminal:
```powershell
.\.venv\Scripts\Activate.ps1
cd app
streamlit run app.py
```

Then open: http://localhost:8501

## 🔧 Troubleshooting

### "Python not found"
- Install Python from https://www.python.org/downloads/
- Make sure to check "Add Python to PATH" during installation

### "Execution policy" error
- All scripts now automatically fix this
- Or run: `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`

### "Module not found" errors
- Run: `.\setup.ps1` to install dependencies
- Or manually: `.\.venv\Scripts\Activate.ps1` then `pip install -r requirements.txt`

### Backend won't start
- Check if port 8000 is in use: `netstat -ano | findstr :8000`
- Make sure virtual environment is activated
- Check that all dependencies are installed

## 📝 Available Scripts

| Script | Purpose |
|--------|---------|
| `run_all.ps1` | Complete setup and run (recommended) |
| `setup.ps1` | Initial setup (creates venv, installs deps) |
| `start_backend.ps1` | Start the backend server |
| `test_chatbot.ps1` | Test if chatbot is working |
| `start_backend.bat` | Start backend (batch file) |
| `test_chatbot.bat` | Test chatbot (batch file) |

## ✅ Success Indicators

**Backend is working if:**
- You see "Uvicorn running on http://0.0.0.0:8000"
- You can access http://localhost:8000/docs in browser
- Test script shows "✅ All tests passed"

**Frontend is working if:**
- Browser opens to http://localhost:8501
- You see "DermaArcade — Skincare Assistant (MVP)"
- You can upload images and get responses

## 🎯 Quick Test

The fastest way to verify everything works:

```powershell
.\run_all.ps1
```

Choose option 3 (Start backend and test) - it does everything automatically!

