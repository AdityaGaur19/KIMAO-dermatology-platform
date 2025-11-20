#!/usr/bin/env python
"""
Simple script to run the chatbot backend server.
"""
import subprocess
import sys
import os
from pathlib import Path

def main():
    # Change to script directory
    script_dir = Path(__file__).parent
    os.chdir(script_dir)
    
    print("Starting DermaArcade Chatbot Backend...")
    print()
    
    # Install dependencies
    print("Installing dependencies...")
    try:
        subprocess.check_call([
            sys.executable, "-m", "pip", "install", "-q",
            "google-generativeai", "fastapi", "uvicorn", "python-dotenv"
        ])
    except subprocess.CalledProcessError:
        print("Warning: Could not install some dependencies")
    
    print()
    print("Starting server at http://localhost:8000")
    print("Press CTRL+C to stop")
    print()
    
    # Start the server
    try:
        subprocess.run([
            sys.executable, "-m", "uvicorn",
            "backend.api_chat:app",
            "--host", "0.0.0.0",
            "--port", "8000",
            "--reload"
        ])
    except KeyboardInterrupt:
        print("\nServer stopped.")

if __name__ == "__main__":
    main()

