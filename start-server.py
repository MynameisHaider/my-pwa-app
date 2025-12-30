#!/usr/bin/env python3
"""
Simple HTTP Server for Multiplication Board PWA
Run this to serve files so mobile can install as app
"""

import http.server
import socketserver
import os
import webbrowser

# Configuration
PORT = 8000
DIRECTORY = os.path.dirname(os.path.abspath(__file__))

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        # Add headers to allow PWA installation
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        super().end_headers()

def start_server():
    # Change to the directory containing this script
    os.chdir(DIRECTORY)

    # Create server
    handler = MyHTTPRequestHandler
    with socketserver.TCPServer(("", PORT), handler) as httpd:
        print("=" * 60)
        print("🚀 MULTIPLICATION BOARD SERVER STARTED")
        print("=" * 60)
        print(f"📁 Serving files from: {DIRECTORY}")
        print(f"🌐 Server running at: http://localhost:{PORT}")
        print("=" * 60)
        print("\n📱 TO INSTALL ON MOBILE:")
        print("=" * 60)
        print("1️⃣ Make sure your mobile and computer are on SAME Wi-Fi")
        print("2️⃣ Find your computer's IP address below:")
        print("")

        # Try to get local IP
        try:
            import socket
            hostname = socket.gethostname()
            local_ip = socket.gethostbyname(hostname)
            print(f"   📡 Your IP: http://{local_ip}:{PORT}")
            print("")
        except:
            print("   ⚠️  Could not detect IP automatically")
            print("   💡 Find your IP by running 'ipconfig' (Windows)")
            print("      or 'ifconfig' (Mac/Linux)")

        print("3️⃣ On mobile Chrome, type: http://YOUR_IP:8000/multiplication-board.html")
        print("4️⃣ Open the page in Chrome")
        print("5️⃣ Tap ⋮ menu (top right)")
        print("6️⃣ Select 'Add to Home Screen' or 'Install App'")
        print("=" * 60)
        print("\n💡 Keep this window open while using the app")
        print("🛑 Press Ctrl+C to stop the server\n")

        # Open in default browser
        print("🌐 Opening browser...")
        webbrowser.open(f'http://localhost:{PORT}/multiplication-board.html')

        # Keep server running
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n\n🛑 Server stopped. Goodbye! 👋")

if __name__ == "__main__":
    start_server()
