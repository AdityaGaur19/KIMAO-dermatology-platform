# PowerShell script to push code to GitHub
# Make sure Git is installed first!

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Pushing Kimao Project to GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "✅ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git is not installed!" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "Then run this script again." -ForegroundColor Yellow
    exit 1
}

# Navigate to project directory
$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectDir

Write-Host "Current directory: $projectDir" -ForegroundColor Gray
Write-Host ""

# Check if .git exists
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "✅ Git repository already initialized" -ForegroundColor Green
}

# Check/create .gitignore
if (-not (Test-Path ".gitignore")) {
    Write-Host "Creating .gitignore file..." -ForegroundColor Yellow
    @"
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
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
    Write-Host "✅ .gitignore created" -ForegroundColor Green
} else {
    Write-Host "✅ .gitignore already exists" -ForegroundColor Green
}

# Set remote
$remoteUrl = "https://github.com/AdityaGaur19/Kimao---AI-Skincare-Assistant.git"
Write-Host ""
Write-Host "Setting remote repository..." -ForegroundColor Yellow

$existingRemote = git remote get-url origin 2>$null
if ($existingRemote) {
    if ($existingRemote -ne $remoteUrl) {
        Write-Host "Updating remote URL..." -ForegroundColor Yellow
        git remote set-url origin $remoteUrl
    } else {
        Write-Host "✅ Remote already set correctly" -ForegroundColor Green
    }
} else {
    git remote add origin $remoteUrl
    Write-Host "✅ Remote added" -ForegroundColor Green
}

# Add all files
Write-Host ""
Write-Host "Adding all files..." -ForegroundColor Yellow
git add .
Write-Host "✅ Files added" -ForegroundColor Green

# Check if there are changes to commit
$status = git status --porcelain
if ($status) {
    Write-Host ""
    Write-Host "Committing changes..." -ForegroundColor Yellow
    git commit -m "Initial commit: Kimao AI Skincare Assistant - Complete project with frontend, backend, and all features"
    Write-Host "✅ Changes committed" -ForegroundColor Green
} else {
    Write-Host "⚠️  No changes to commit" -ForegroundColor Yellow
}

# Set branch to main
Write-Host ""
Write-Host "Setting branch to main..." -ForegroundColor Yellow
git branch -M main 2>$null
Write-Host "✅ Branch set to main" -ForegroundColor Green

# Push to GitHub
Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "You may be prompted for GitHub credentials." -ForegroundColor Cyan
Write-Host ""

try {
    git push -u origin main
    Write-Host ""
    Write-Host "✅✅✅ SUCCESS! Code pushed to GitHub! ✅✅✅" -ForegroundColor Green
    Write-Host ""
    Write-Host "Repository URL: $remoteUrl" -ForegroundColor Cyan
} catch {
    Write-Host ""
    Write-Host "❌ Push failed. Common issues:" -ForegroundColor Red
    Write-Host "1. Authentication required - use GitHub Personal Access Token" -ForegroundColor Yellow
    Write-Host "2. Repository might have existing content - try: git pull origin main --allow-unrelated-histories" -ForegroundColor Yellow
    Write-Host "3. Check your internet connection" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

