# How to Install Python

## ❌ Current Issue

You're seeing this error because Python is not actually installed on your system. Windows is showing a redirect to the Microsoft Store, but Python itself isn't installed.

## ✅ Solution: Install Python

You have **two options**:

### Option 1: Install from Python.org (Recommended)

1. **Download Python:**
   - Go to: https://www.python.org/downloads/
   - Click the big yellow "Download Python" button
   - This will download the latest Python version

2. **Run the installer:**
   - Double-click the downloaded file
   - **IMPORTANT:** Check the box that says **"Add Python to PATH"** at the bottom
   - Click "Install Now"
   - Wait for installation to complete

3. **Verify installation:**
   - Close and reopen PowerShell
   - Run: `python --version`
   - You should see something like: `Python 3.11.x`

4. **Run the setup:**
   ```powershell
   cd DermaArcade_Chatbot_MVP
   .\setup.ps1
   ```

### Option 2: Install from Microsoft Store

1. **Open Microsoft Store:**
   - Press `Windows Key` and type "Microsoft Store"
   - Open the Microsoft Store app

2. **Search for Python:**
   - Search for "Python 3.11" or "Python 3.12"
   - Click on the official Python app (by Python Software Foundation)

3. **Install:**
   - Click "Install" or "Get"
   - Wait for installation to complete

4. **Verify installation:**
   - Close and reopen PowerShell
   - Run: `python --version`

5. **Run the setup:**
   ```powershell
   cd DermaArcade_Chatbot_MVP
   .\setup.ps1
   ```

## 🔍 Verify Python is Installed

After installation, verify it works:

```powershell
python --version
```

You should see a version number like `Python 3.11.5` or similar.

If you still see "Python was not found", try:
- Restart PowerShell completely
- Restart your computer
- Make sure you checked "Add Python to PATH" during installation

## 📝 After Python is Installed

Once Python is installed, you can run:

```powershell
cd DermaArcade_Chatbot_MVP
.\run_all.ps1
```

This will set up everything automatically!

## 🆘 Still Having Issues?

If Python is installed but still not found:

1. **Check PATH:**
   ```powershell
   $env:Path -split ';' | Select-String python
   ```

2. **Find Python manually:**
   ```powershell
   Get-ChildItem -Path "C:\Users\$env:USERNAME\AppData\Local\Programs\Python" -Recurse -Filter "python.exe" -ErrorAction SilentlyContinue
   ```

3. **Add to PATH manually** (if needed):
   - Search for "Environment Variables" in Windows
   - Edit "Path" variable
   - Add Python installation directory (usually `C:\Users\YourName\AppData\Local\Programs\Python\Python3XX`)

