# Troubleshooting Blank Page on localhost:8501

If you see a blank white page, follow these steps:

## Step 1: Check Browser Console

1. **Open Developer Tools:**
   - Press `F12` or `Ctrl+Shift+I`
   - Click on the "Console" tab

2. **Look for errors:**
   - Red error messages will tell you what's wrong
   - Common errors:
     - "Failed to load module"
     - "Cannot find module"
     - "Unexpected token"
     - Network errors

## Step 2: Check Frontend Server Window

Look at the PowerShell window where you ran `npm run dev`:
- Are there any error messages?
- Does it show "VITE ready" or compilation errors?

## Step 3: Common Fixes

### Fix 1: Clear Browser Cache
- Press `Ctrl+Shift+Delete`
- Clear cached images and files
- Refresh the page (`Ctrl+F5`)

### Fix 2: Check if Dependencies are Installed
```powershell
cd DermaArcade\DermaArcade_Chatbot_MVP
npm install
```

### Fix 3: Restart Frontend Server
1. Stop the frontend server (Ctrl+C in the npm window)
2. Delete `node_modules` and reinstall:
   ```powershell
   Remove-Item -Recurse -Force node_modules
   npm install
   npm run dev
   ```

### Fix 4: Check for Missing Files
Make sure these files exist:
- `index.html` (in root)
- `src/main.tsx`
- `src/App.tsx`
- `src/index.css`

## Step 4: Check Network Tab

1. Open Developer Tools (F12)
2. Go to "Network" tab
3. Refresh the page
4. Look for failed requests (red)
5. Check if `/src/main.tsx` is loading

## Step 5: Verify Vite is Running

The frontend window should show:
```
VITE v6.x.x  ready in xxx ms

➜  Local:   http://localhost:8501/
➜  Network: use --host to expose
```

If you don't see this, the server isn't running properly.

## Quick Test

Open browser console (F12) and check:
- Are there any red errors?
- What does the error message say?

Share the error message and I can help fix it!

