#!/usr/bin/env python3
"""
Simple Python HTTP server to run the website
Just run: python start_website.py
"""

import http.server
import socketserver
import webbrowser
import os
from pathlib import Path

PORT = 8501
DIRECTORY = Path(__file__).parent / "website"

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(DIRECTORY), **kwargs)

def main():
    os.chdir(DIRECTORY)
    
    with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
        print(f"🚀 Server starting at http://localhost:{PORT}")
        print(f"📁 Serving from: {DIRECTORY}")
        print("🌐 Opening browser...")
        print("Press CTRL+C to stop the server")
        print()
        
        # Open browser
        webbrowser.open(f'http://localhost:{PORT}')
        
        # Start server
        httpd.serve_forever()

if __name__ == "__main__":
    main()

