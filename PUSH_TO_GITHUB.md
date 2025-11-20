# Push Code to GitHub Repository

## Step 1: Install Git (if not installed)

1. Download Git from: https://git-scm.com/download/win
2. Install it with default settings
3. Restart your terminal/PowerShell

## Step 2: Initialize Git Repository (if not already initialized)

Open PowerShell in the `DermaArcade_Chatbot_MVP` folder and run:

```powershell
cd C:\DermaArcade\DermaArcade_Chatbot_MVP
git init
```

## Step 3: Add Remote Repository

```powershell
git remote add origin https://github.com/AdityaGaur19/Kimao---AI-Skincare-Assistant.git
```

Or if remote already exists, update it:
```powershell
git remote set-url origin https://github.com/AdityaGaur19/Kimao---AI-Skincare-Assistant.git
```

## Step 4: Create .gitignore file (if not exists)

Create a `.gitignore` file with:
```
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.so
*.egg
*.egg-info/
dist/
build/
.venv/
venv/
env/
ENV/
*.db
*.sqlite
*.sqlite3
users.db
node_modules/
.DS_Store
*.log
.env
.env.local
*.key
API_KEY_SET.txt
GEMINI_SETUP.txt
models/
.vscode/
.idea/
```

## Step 5: Add, Commit and Push

```powershell
# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Kimao AI Skincare Assistant - Complete project with frontend, backend, and all features"

# Push to main branch
git branch -M main
git push -u origin main
```

## Alternative: If you need to force push (use with caution)

```powershell
git push -u origin main --force
```

## Troubleshooting

### If you get authentication error:
1. Use GitHub Personal Access Token instead of password
2. Generate token at: https://github.com/settings/tokens
3. Use token as password when prompted

### If repository already has content:
```powershell
git pull origin main --allow-unrelated-histories
# Resolve any conflicts, then:
git push -u origin main
```

