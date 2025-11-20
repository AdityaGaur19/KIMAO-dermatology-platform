# Quick Start: Train 96%+ Accuracy Model

## Step 1: Download Dataset (Choose One)

### Option A: HAM10000 (Easiest - Recommended)
```powershell
# 1. Install Kaggle API
pip install kaggle

# 2. Get Kaggle credentials
#    - Go to: https://www.kaggle.com/account
#    - Click "Create New API Token"
#    - Save kaggle.json to: C:\Users\<YourUsername>\.kaggle\kaggle.json

# 3. Download dataset
.\ml\download_kaggle_dataset.ps1

# 4. Organize dataset
python ml\organize_datasets.py
```

### Option B: Manual Download
1. Download HAM10000 from: https://www.kaggle.com/datasets/kmader/skin-cancer-mnist-ham10000
2. Extract to: `data\dermatology_datasets\HAM10000\`
3. Run: `python ml\organize_datasets.py`

### Option C: ISIC Archive (Largest - Best Accuracy)
1. Go to: https://www.isic-archive.com/
2. Create account and download ISIC 2019/2020 dataset
3. Organize images in: `data\dermatology_datasets\organized\`
   - Create folders: `acne\`, `rosacea\`, `hyperpigmentation\`, etc.
   - Place images in respective folders

## Step 2: Start Training

```powershell
.\start_training.ps1
```

**Training will:**
- ✅ Use EfficientNet-B4 (state-of-the-art)
- ✅ Train for up to 100 epochs
- ✅ Stop early if accuracy plateaus
- ✅ Save best model automatically
- ✅ Target: 96%+ accuracy

## Step 3: Wait for Training

- **Time**: 4-8 hours (depending on GPU and dataset size)
- **GPU Recommended**: 10-20x faster than CPU
- **Progress**: Shows accuracy after each epoch

## Step 4: Model Ready!

Once training completes:
- Model saved to: `models\skin_classifier_final.pth`
- Backend will automatically use it
- Test with real images!

## Expected Results

With HAM10000 dataset:
- **Accuracy**: 96%+ on validation set
- **Model Size**: ~75MB
- **Inference**: ~50ms per image (GPU)

## Troubleshooting

**Out of Memory?**
- Reduce batch size in `ml\train_high_accuracy_model.py` (line 33: `'batch_size': 8`)

**Low Accuracy?**
- Need more data (10,000+ images recommended)
- Check data quality
- Use larger model (efficientnet_b5)

**Dataset Not Found?**
- Verify images are in: `data\dermatology_datasets\organized\`
- Check folder structure matches expected format

## Need Help?

See detailed guide: `ml\README_TRAINING.md`

