# Starting the React App

The login feature has been implemented in the **React app** (in the `src/` folder), not the old HTML website.

## To run the React app:

1. **Make sure Node.js is installed:**
   - Download from: https://nodejs.org/
   - Or check if it's installed: `node --version`

2. **Install dependencies (first time only):**
   ```powershell
   npm install
   ```

3. **Start the React app:**
   ```powershell
   npm run dev
   ```

4. **The React app will run on:** http://localhost:8501

## What's different:

- **Old website** (`website/` folder): Has the old login modal with Google/Email/Phone buttons
- **New React app** (`src/` folder): Has the new login feature with:
  - Email/password login and registration
  - Persistent sessions (stays logged in)
  - Chat history
  - Analysis history
  - User profile menu

The `start_both_servers.ps1` script has been updated to run the React app, but you need Node.js installed first.

