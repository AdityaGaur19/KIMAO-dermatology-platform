# How to Test the DermaArcade Chatbot

This guide will help you verify that the chatbot is working correctly.

## Quick Test Steps

### 1. Check Prerequisites

First, make sure you have:
- Python 3.8+ installed
- Virtual environment set up and activated
- All dependencies installed

```powershell
# Navigate to project directory
cd DermaArcade_Chatbot_MVP

# Activate virtual environment (if not already active)
.\.venv\Scripts\Activate.ps1

# Verify dependencies are installed
pip list | Select-String "streamlit|fastapi|uvicorn"
```

### 2. Start the Backend Server

**Open Terminal/PowerShell Window 1:**

```powershell
cd DermaArcade_Chatbot_MVP
.\.venv\Scripts\Activate.ps1
cd backend
python api.py
```

**Expected output:**
```
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
INFO:     Started server process
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

**✅ Success indicators:**
- Server starts without errors
- You see "Uvicorn running on http://0.0.0.0:8000"
- No import errors or missing module errors

**❌ Common issues:**
- `ModuleNotFoundError`: Run `pip install -r requirements.txt`
- Port 8000 already in use: Change port in `api.py` or close the other application

### 3. Test the Backend API

**Option A: Use the test script (Recommended)**

**Open Terminal/PowerShell Window 2 (keep backend running):**

```powershell
cd DermaArcade_Chatbot_MVP
.\.venv\Scripts\Activate.ps1
python test_chatbot.py
```

**Expected output:**
```
✅ Backend server is running!
✅ /analyze endpoint is working!
✅ All tests passed!
```

**Option B: Test manually with browser**

1. Open browser and go to: `http://localhost:8000/docs`
2. You should see the FastAPI interactive API documentation
3. Click on `POST /analyze` endpoint
4. Click "Try it out"
5. Upload a test image file
6. Click "Execute"
7. You should see a response with `label`, `confidence`, `recommendations`, etc.

**Option C: Test with curl (PowerShell)**

```powershell
# Create a test image first, or use an existing image
$imagePath = "path\to\your\test\image.jpg"

curl -X POST "http://localhost:8000/analyze" `
  -F "file=@$imagePath" `
  -F "question=Is this acne?"
```

### 4. Start the Frontend (Streamlit)

**Open Terminal/PowerShell Window 3 (keep backend running):**

```powershell
cd DermaArcade_Chatbot_MVP
.\.venv\Scripts\Activate.ps1
cd app
streamlit run app.py
```

**Expected output:**
```
You can now view your Streamlit app in your browser.

Local URL: http://localhost:8501
Network URL: http://192.168.x.x:8501
```

**✅ Success indicators:**
- Streamlit starts without errors
- Browser automatically opens to `http://localhost:8501`
- You see the "DermaArcade — Skincare Assistant (MVP)" interface

### 5. Test the Full Interface

1. **Upload an image:**
   - Click "Browse files" or drag and drop a skin photo
   - Accepts: JPG, JPEG, PNG

2. **Enter a question (optional):**
   - Example: "Is this acne? What should I use?"

3. **Click "Analyze" button**

4. **Expected results:**
   - Image displays
   - You see a label (e.g., "Mild inflammatory acne")
   - Confidence percentage
   - Explanation text
   - Recommendations list
   - Citations from knowledge base
   - Result appears in sidebar "Recent results"

**✅ Working correctly if:**
- Image uploads successfully
- Analysis completes (spinner disappears)
- Results display with all sections populated
- No error messages appear

**❌ Not working if:**
- Error: "Analysis failed: 500" or connection errors
- Spinner never stops
- Empty results or "Unknown" label
- Backend connection refused errors

## Troubleshooting

### Backend won't start
- Check if port 8000 is available: `netstat -ano | findstr :8000`
- Verify all dependencies: `pip install -r requirements.txt`
- Check for Python errors in the terminal

### Frontend can't connect to backend
- Verify backend is running on port 8000
- Check `app/app.py` has correct API_URL: `http://localhost:8000/analyze`
- Try accessing `http://localhost:8000/docs` in browser

### No results or errors
- Check backend terminal for error messages
- Verify `kb/` directory has `.md` files
- Check that `tmp_uploads/` directory can be created

### Import errors
- Make sure virtual environment is activated
- Reinstall dependencies: `pip install -r requirements.txt --force-reinstall`

## Quick Health Check

Run this command to check everything at once:

```powershell
python test_chatbot.py
```

This will verify:
- ✅ Knowledge base files exist
- ✅ Backend server is running
- ✅ API endpoint responds correctly

## Expected Behavior (MVP)

Since this is an MVP with simulated logic:
- **Labels are randomly selected** from a predefined list
- **Confidence scores are random** (55-92%)
- **Recommendations are rule-based** based on the label
- **This is expected** - real ML models will replace this later

The important thing is that:
- ✅ The pipeline works end-to-end
- ✅ Images upload successfully
- ✅ API returns structured responses
- ✅ Frontend displays results correctly













