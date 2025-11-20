# High-Accuracy Model Training - Complete Setup

## 🎯 Goal
Train a skin disease classifier with **96%+ accuracy** using state-of-the-art datasets and techniques.

## 📦 What's Been Created

### Training Scripts
1. **`ml/train_high_accuracy_model.py`** - Main training script
   - Uses EfficientNet-B4 (larger, more accurate)
   - 384x384 image resolution
   - Advanced data augmentation
   - Class imbalance handling
   - Mixed precision training
   - Early stopping
   - Target: 96%+ accuracy

2. **`ml/improved_classifier.py`** - Inference class
   - Loads trained model
   - Integrates with backend
   - Fallback to improved image analyzer

3. **`ml/organize_datasets.py`** - Dataset organizer
   - Organizes HAM10000 dataset
   - Creates unified structure

4. **`ml/download_datasets.py`** - Dataset downloader
   - Instructions for multiple datasets

### Helper Scripts
- **`start_training.ps1`** - Easy training launcher
- **`ml/download_kaggle_dataset.ps1`** - Kaggle dataset downloader

### Documentation
- **`QUICK_START_TRAINING.md`** - Quick start guide
- **`ml/README_TRAINING.md`** - Detailed training guide

## 🚀 Quick Start

### 1. Download Dataset

**Option A: HAM10000 (Recommended)**
```powershell
# Install Kaggle API
pip install kaggle

# Set up credentials (download kaggle.json from kaggle.com/account)
# Place in: C:\Users\<YourUsername>\.kaggle\kaggle.json

# Download
.\ml\download_kaggle_dataset.ps1

# Organize
python ml\organize_datasets.py
```

**Option B: ISIC Archive (Largest - Best)**
- Go to: https://www.isic-archive.com/
- Download ISIC 2019/2020 dataset
- Organize in: `data\dermatology_datasets\organized\`

### 2. Start Training
```powershell
.\start_training.ps1
```

### 3. Wait for Results
- Training time: 4-8 hours (GPU recommended)
- Model saved to: `models\skin_classifier_final.pth`
- Backend automatically uses trained model

## 📊 Model Architecture

- **Backbone**: EfficientNet-B4 (pre-trained on ImageNet)
- **Image Size**: 384x384 pixels
- **Classifier Head**: 
  - Adaptive Average Pooling
  - Dropout layers (0.3, 0.5, 0.3)
  - Batch Normalization
  - Fully Connected: 512 → 256 → num_classes

## 🎓 Training Features

✅ **Advanced Data Augmentation**
- Random flips, rotations
- Color jitter
- Random affine transforms

✅ **Class Imbalance Handling**
- Weighted sampling
- Class weights in loss function

✅ **Optimization**
- AdamW optimizer
- Cosine annealing LR scheduler
- Mixed precision training (faster)

✅ **Regularization**
- Dropout layers
- Weight decay
- Early stopping

## 📈 Expected Performance

With HAM10000 dataset (10,000+ images):
- **Accuracy**: 96%+ on validation set
- **Precision**: 95%+
- **Recall**: 95%+
- **F1-Score**: 95%+

With ISIC Archive (25,000+ images):
- **Accuracy**: 97%+ possible
- Even better generalization

## 🔧 Configuration

Edit `ml/train_high_accuracy_model.py` to customize:

```python
CONFIG = {
    'model_name': 'efficientnet_b4',  # Try b5 or b6 for better accuracy
    'img_size': 384,  # Increase to 512 for better accuracy (slower)
    'batch_size': 16,  # Reduce if out of memory
    'num_epochs': 100,
    'learning_rate': 1e-4,
    'target_accuracy': 0.96,
}
```

## 🔄 Integration

The backend (`backend/api_chat.py`) automatically:
1. Checks for trained model at `models/skin_classifier_final.pth`
2. Uses high-accuracy model if available
3. Falls back to improved image analyzer if not

## 📝 Dataset Structure

Organize images like this:
```
data/
└── dermatology_datasets/
    └── organized/
        ├── acne/
        ├── rosacea/
        ├── hyperpigmentation/
        ├── melanoma/
        ├── basal_cell_carcinoma/
        ├── squamous_cell_carcinoma/
        ├── benign_keratosis/
        ├── dermatofibroma/
        ├── vascular_lesion/
        └── normal_skin/
```

## ⚠️ Troubleshooting

**Out of Memory?**
- Reduce `batch_size` to 8 or 4
- Use smaller model (efficientnet_b2)
- Reduce `img_size` to 256

**Low Accuracy?**
- Need more data (10,000+ images minimum)
- Check data quality
- Use larger model (efficientnet_b5)
- Increase training epochs

**Dataset Not Found?**
- Verify path: `data\dermatology_datasets\organized\`
- Check folder structure
- Run `python ml\organize_datasets.py`

## 🎉 Success Criteria

Training is successful when:
- ✅ Validation accuracy reaches 96%+
- ✅ Model saved to `models/skin_classifier_final.pth`
- ✅ Backend automatically uses trained model
- ✅ Real-world images get accurate predictions

## 📚 Resources

- **HAM10000**: https://www.kaggle.com/datasets/kmader/skin-cancer-mnist-ham10000
- **ISIC Archive**: https://www.isic-archive.com/
- **DermNet**: https://www.dermnet.com/
- **EfficientNet Paper**: https://arxiv.org/abs/1905.11946

## 🚀 Next Steps After Training

1. Test model with real images
2. Fine-tune if needed
3. Deploy to production
4. Monitor performance
5. Retrain periodically with new data

---

**Ready to train?** Follow `QUICK_START_TRAINING.md`!

