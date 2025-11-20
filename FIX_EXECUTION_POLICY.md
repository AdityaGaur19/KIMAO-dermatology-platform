# Fix PowerShell Execution Policy Error

If you see this error:
```
running scripts is disabled on this system
```

Here are **3 ways to fix it**:

## Option 1: Bypass for Current Session (Easiest)

Run this command in PowerShell:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

Then run your script:
```powershell
.\setup.ps1
```

**Note:** This only works for the current PowerShell window. You'll need to run it again if you open a new terminal.

## Option 2: Allow Scripts for Current User (Recommended)

Run PowerShell **as Administrator**, then:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

This allows you to run local scripts (like `.ps1` files in this project) but still requires remote scripts to be signed. This is safe and recommended.

## Option 3: Use Batch Files Instead (No Policy Needed)

I've created `.bat` files that don't require changing execution policy:

- **`test_chatbot.bat`** - Test the chatbot
- **`start_backend.bat`** - Start the backend server

Just double-click them or run:
```cmd
test_chatbot.bat
start_backend.bat
```

## Quick Start (Using Batch Files)

1. **First time setup** (if virtual environment doesn't exist):
   - Option A: Fix execution policy (Option 2 above) then run `.\setup.ps1`
   - Option B: Manually create venv:
     ```cmd
     python -m venv .venv
     .venv\Scripts\activate
     pip install -r requirements.txt
     ```

2. **Start backend**:
   ```cmd
   start_backend.bat
   ```

3. **Test chatbot** (in another terminal):
   ```cmd
   test_chatbot.bat
   ```

## Why This Happens

Windows PowerShell has a security feature that prevents scripts from running by default. This protects your system from malicious scripts, but it also blocks legitimate scripts like the ones in this project.

The batch files (`.bat`) don't have this restriction, so they're a good alternative if you don't want to change PowerShell settings.

