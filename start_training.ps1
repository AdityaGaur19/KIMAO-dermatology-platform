# Start training script for high-accuracy model
$ErrorActionPreference = "Continue"

Set-Location $PSScriptRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "High-Accuracy Model Training" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if datasets exist
$dataDir = "data\dermatology_datasets\organized"
if (-not (Test-Path $dataDir)) {
    Write-Host "⚠️  Dataset not found!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please download and organize datasets first:" -ForegroundColor Cyan
    Write-Host "  1. Download HAM10000 from Kaggle" -ForegroundColor White
    Write-Host "  2. Run: python ml\organize_datasets.py" -ForegroundColor White
    Write-Host "  3. Or organize images in: $dataDir" -ForegroundColor White
    Write-Host ""
    Write-Host "See ml\README_TRAINING.md for detailed instructions" -ForegroundColor Cyan
    Write-Host ""
    pause
    exit 1
}

Write-Host "✅ Dataset found!" -ForegroundColor Green
Write-Host ""

# Check Python
$python = ".\.venv\Scripts\python.exe"
if (-not (Test-Path $python)) {
    Write-Host "❌ Virtual environment not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Installing training dependencies..." -ForegroundColor Yellow
& $python -m pip install -q torch torchvision timm pandas scikit-learn tqdm matplotlib seaborn 2>&1 | Out-Null

Write-Host ""
Write-Host "Starting training..." -ForegroundColor Green
Write-Host "This may take several hours depending on dataset size and GPU." -ForegroundColor Yellow
Write-Host "Target accuracy: 96%+" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press CTRL+C to stop training" -ForegroundColor Gray
Write-Host ""

# Start training
& $python ml\train_high_accuracy_model.py

pause

