# 🚀 Install and Run Website - Step by Step

## The Problem
`pyarrow` is failing to build because Python 3.14 is very new and pyarrow needs build tools.

## Solution: Install Pre-built Packages

### Step 1: Install Build Tools (if needed)
```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
.\.venv\Scripts\python.exe -m pip install setuptools wheel build
```

### Step 2: Try Installing Streamlit with Pre-built Wheels
```powershell
.\.venv\Scripts\python.exe -m pip install streamlit --prefer-binary
```

### Step 3: If That Fails, Install Without pyarrow (Limited Functionality)
```powershell
.\.venv\Scripts\python.exe -m pip install streamlit --no-deps
.\.venv\Scripts\python.exe -m pip install altair blinker cachetools click numpy packaging pandas pillow protobuf pydeck pympler requests rich toml tornado tzlocal watchdog
```

### Step 4: Start the Website

**Terminal 1 - Backend:**
```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
.\.venv\Scripts\python.exe backend/api.py
```

**Terminal 2 - Frontend:**
```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
.\.venv\Scripts\python.exe -m streamlit run app/app.py
```

## Alternative: Use Python 3.11 or 3.12

If Python 3.14 continues to cause issues, consider using Python 3.11 or 3.12 which have better package support:

1. Install Python 3.11 or 3.12 from python.org
2. Create new venv: `python3.11 -m venv .venv`
3. Install packages normally

## Quick Test

After installation, test if streamlit works:
```powershell
.\.venv\Scripts\python.exe -m streamlit --version
```

If it shows a version number, you're good to go!

