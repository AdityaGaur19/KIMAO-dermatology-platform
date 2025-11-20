"""
Simple test script to verify the chatbot backend is working.
Run this after starting the FastAPI backend server.

Usage:
    python test_chatbot.py
"""
import requests
import json
import sys
from pathlib import Path

# Get the script's directory to handle relative paths correctly
SCRIPT_DIR = Path(__file__).resolve().parent
API_URL = "http://localhost:8000/analyze"
BACKEND_URL = "http://localhost:8000"

def test_backend_health():
    """Test if the backend is running"""
    try:
        # Try to access the root endpoint (FastAPI provides docs at /docs)
        resp = requests.get(f"{BACKEND_URL}/docs", timeout=5)
        if resp.status_code == 200:
            print("✅ Backend server is running!")
            print(f"   API docs available at: {BACKEND_URL}/docs")
            return True
    except requests.exceptions.ConnectionError:
        print("❌ Backend server is NOT running!")
        print("   Please start it with: cd backend && python api.py")
        return False
    except Exception as e:
        print(f"❌ Error checking backend: {e}")
        return False

def test_analyze_endpoint():
    """Test the /analyze endpoint with a dummy image"""
    print("\n🧪 Testing /analyze endpoint...")
    
    # Create a simple test image (1x1 pixel PNG)
    from PIL import Image
    import io
    
    # Create a minimal test image
    img = Image.new('RGB', (100, 100), color='red')
    img_bytes = io.BytesIO()
    img.save(img_bytes, format='PNG')
    img_bytes.seek(0)
    
    try:
        files = {"file": ("test.png", img_bytes, "image/png")}
        data = {"question": "Is this acne?"}
        
        print("   Sending test request...")
        resp = requests.post(API_URL, files=files, data=data, timeout=10)
        
        if resp.status_code == 200:
            result = resp.json()
            print("✅ /analyze endpoint is working!")
            print(f"   Response: {json.dumps(result, indent=2)}")
            return True
        else:
            print(f"❌ /analyze endpoint returned error: {resp.status_code}")
            print(f"   Response: {resp.text}")
            return False
    except requests.exceptions.ConnectionError:
        print("❌ Cannot connect to backend!")
        print("   Make sure the backend is running on http://localhost:8000")
        return False
    except Exception as e:
        print(f"❌ Error testing endpoint: {e}")
        return False

def test_kb_files():
    """Check if knowledge base files exist"""
    print("\n📚 Checking knowledge base files...")
    kb_dir = SCRIPT_DIR / "kb"
    if not kb_dir.exists():
        print(f"❌ kb/ directory not found at {kb_dir}!")
        return False
    
    md_files = list(kb_dir.glob("*.md"))
    if len(md_files) == 0:
        print(f"❌ No .md files found in kb/ directory!")
        return False
    
    print(f"✅ Found {len(md_files)} knowledge base file(s):")
    for f in md_files:
        print(f"   - {f.name}")
    return True

def test_root_endpoint():
    """Test the root endpoint"""
    try:
        resp = requests.get(BACKEND_URL, timeout=5)
        print(f"✅ Root endpoint accessible (status: {resp.status_code})")
        return True
    except Exception as e:
        print(f"⚠️  Root endpoint test failed: {e}")
        return False

if __name__ == "__main__":
    print("=" * 60)
    print("DermaArcade Chatbot - Testing Script")
    print("=" * 60)
    
    # Test KB files first (doesn't require server)
    kb_ok = test_kb_files()
    
    # Test backend
    backend_ok = test_backend_health()
    
    if backend_ok:
        # Test root endpoint
        root_ok = test_root_endpoint()
        
        # Test analyze endpoint
        analyze_ok = test_analyze_endpoint()
        
        print("\n" + "=" * 60)
        if kb_ok and backend_ok and analyze_ok:
            print("✅ All tests passed! Chatbot is working correctly.")
            print("\nNext steps:")
            print("1. Start the Streamlit frontend: cd app && streamlit run app.py")
            print("2. Open http://localhost:8501 in your browser")
            print("3. Upload a skin photo to test the full interface")
            sys.exit(0)
        else:
            print("❌ Some tests failed. Please check the errors above.")
            sys.exit(1)
    else:
        print("\n" + "=" * 60)
        print("⚠️  Backend is not running. Please start it first:")
        print("   cd backend")
        print("   python api.py")
        sys.exit(1)

