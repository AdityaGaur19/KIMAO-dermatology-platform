# Scripts Overview

All scripts have been fixed to handle common Windows issues automatically.

## 🎯 Main Scripts

### `run_all.ps1` - **START HERE!**
The master script that does everything:
- Finds Python automatically
- Creates virtual environment
- Installs dependencies
- Gives you options to start backend or test

**Usage:**
```powershell
.\run_all.ps1
```

### `setup.ps1`
Initial setup script:
- Creates Python virtual environment
- Installs all dependencies

**Usage:**
```powershell
.\setup.ps1
```

### `test_chatbot.ps1`
Test if the chatbot is working:
- Checks knowledge base files
- Tests if backend is running
- Tests the API endpoint

**Usage:**
```powershell
.\test_chatbot.ps1
```

### `start_backend.ps1`
Start the backend server:
- Finds Python automatically
- Activates virtual environment
- Starts FastAPI server

**Usage:**
```powershell
.\start_backend.ps1
```

## 📦 Batch Files (Alternative)

If PowerShell scripts don't work, use these `.bat` files:

- `test_chatbot.bat` - Test the chatbot
- `start_backend.bat` - Start the backend

**Usage:**
```cmd
test_chatbot.bat
start_backend.bat
```

## ✅ What's Fixed

All scripts now:
- ✅ **Auto-fix execution policy** - No more "running scripts is disabled" errors
- ✅ **Find Python automatically** - Checks multiple locations
- ✅ **Detect Windows Store redirect** - Won't mistake redirect for real Python
- ✅ **Handle missing Python** - Clear instructions if Python isn't installed
- ✅ **Work from any directory** - Uses proper path resolution
- ✅ **Better error messages** - Tells you exactly what to do

## 🚨 Common Issues & Solutions

### Issue: "Python was not found"
**Solution:** Python isn't installed. See `INSTALL_PYTHON.md` for instructions.

### Issue: "Execution policy" error
**Solution:** All scripts now fix this automatically. No action needed.

### Issue: "Module not found"
**Solution:** Run `.\setup.ps1` to install dependencies.

### Issue: Script won't run from PowerShell
**Solution:** Use the `.bat` files instead, or run:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

## 📚 Documentation Files

- `QUICK_START.md` - Quick start guide
- `INSTALL_PYTHON.md` - How to install Python
- `FIX_EXECUTION_POLICY.md` - Execution policy details
- `HOW_TO_TEST.md` - Detailed testing guide

## 🎬 Quick Start

1. **Install Python** (if not installed):
   - See `INSTALL_PYTHON.md`

2. **Run setup:**
   ```powershell
   .\run_all.ps1
   ```

3. **That's it!** The script will guide you through everything.

