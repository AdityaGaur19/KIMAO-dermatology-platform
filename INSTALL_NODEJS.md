# Installing Node.js for React App

Node.js is required to run the React frontend application.

## Quick Installation

### Option 1: Download from Official Website (Recommended)

1. **Download Node.js:**
   - Go to: https://nodejs.org/
   - Download the **LTS (Long Term Support)** version
   - Choose the Windows Installer (.msi) for your system (64-bit recommended)

2. **Install Node.js:**
   - Run the downloaded installer
   - Follow the installation wizard
   - **Important:** Make sure to check "Add to PATH" during installation
   - Complete the installation

3. **Verify Installation:**
   ```powershell
   node --version
   npm --version
   ```
   You should see version numbers for both commands.

4. **Restart your terminal/PowerShell** after installation

### Option 2: Using Chocolatey (If you have it)

```powershell
choco install nodejs-lts
```

### Option 3: Using Winget (Windows Package Manager)

```powershell
winget install OpenJS.NodeJS.LTS
```

## After Installation

1. **Close and reopen your terminal/PowerShell** (required for PATH to update)

2. **Verify Node.js is installed:**
   ```powershell
   node --version
   npm --version
   ```

3. **Run the startup script:**
   ```powershell
   .\start_both_servers.ps1
   ```

## Troubleshooting

### If Node.js is installed but not found:

1. **Check if Node.js is installed:**
   - Look in: `C:\Program Files\nodejs\` or `C:\Program Files (x86)\nodejs\`
   - If it exists, add it to PATH manually

2. **Add to PATH manually:**
   - Open System Properties → Environment Variables
   - Edit "Path" in System variables
   - Add: `C:\Program Files\nodejs\`
   - Restart terminal

3. **Or reinstall Node.js** and make sure "Add to PATH" is checked

## What Node.js Does

Node.js is needed to:
- Run the React development server (Vite)
- Install npm packages (React, dependencies)
- Build and serve the frontend application

The backend (Python) doesn't need Node.js - only the React frontend does.

