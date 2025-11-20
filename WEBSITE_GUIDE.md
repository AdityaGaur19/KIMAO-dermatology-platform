# 🌐 DermaArcade Website Guide

## Quick Start - Visit the Website

### Option 1: Start Everything (Backend + Frontend) - **RECOMMENDED**

**PowerShell:**
```powershell
.\start_all.ps1
```

**Command Prompt:**
```cmd
start_all.bat
```

This will:
- ✅ Start the backend server (http://localhost:8000)
- ✅ Start the frontend website (http://localhost:8501)
- ✅ Open both in separate windows
- ✅ Automatically open your browser to the website

### Option 2: Start Website Only

**PowerShell:**
```powershell
.\start_website.ps1
```

**Command Prompt:**
```cmd
start_website.bat
```

**Note**: Image analysis features require the backend to be running. Start it separately with `start_backend.ps1` or `start_backend.bat`.

### Option 3: Manual Start

**Terminal 1 - Backend:**
```powershell
cd backend
python api.py
```

**Terminal 2 - Frontend:**
```powershell
cd app
streamlit run app.py
```

## 🌍 Accessing the Website

Once started, the website will be available at:

**Frontend (Main Website):**
```
http://localhost:8501
```

**Backend API:**
```
http://localhost:8000
```

**API Documentation:**
```
http://localhost:8501/docs
```

## 🎬 Background Video

The website includes a looping background video:
- **Location**: `static/background_video.mp4`
- **Features**: 
  - Loops continuously
  - Muted and autoplays
  - Semi-transparent overlay for readability
  - Doesn't interfere with UI

## 🎨 Website Features

### Image Analysis Tab
- Upload skin images or use webcam
- Ask questions about your skin
- Get AI-powered analysis and recommendations
- View personalized AM/PM skincare routines

### Chat Assistant Tab
- Ask general skincare questions
- Get advice from the knowledge base

### Sidebar
- View analysis history
- Clear history
- Quick access to previous analyses

## 🛠️ Troubleshooting

### Website won't start
1. Make sure Python is installed
2. Run `.\setup.ps1` to set up the environment
3. Check if port 8501 is already in use

### Background video not showing
1. Check if `static/background_video.mp4` exists
2. The video should be in the project's `static/` folder
3. Refresh the browser page

### Image analysis not working
1. Make sure the backend is running (http://localhost:8000)
2. Check backend terminal for errors
3. Try restarting both backend and frontend

### Port already in use
If port 8501 is busy:
```powershell
# Find what's using the port
netstat -ano | findstr :8501

# Or use a different port
streamlit run app.py --server.port=8502
```

## 📝 Notes

- The website uses Streamlit, which automatically opens in your default browser
- The background video loops continuously and doesn't require any interaction
- All content is readable with a semi-transparent overlay
- The website works offline once loaded (except for API calls)

## 🚀 Next Steps

1. **Start the website**: `.\start_all.ps1`
2. **Upload a skin image** in the Image Analysis tab
3. **Ask questions** about your skin concern
4. **View recommendations** and skincare routines
5. **Check history** in the sidebar

Enjoy using DermaArcade! ✨

