#!/bin/bash
# Multiplication Board PWA Server Launcher for Mac/Linux
# This starts a local web server so you can install the app on mobile

echo "============================================================"
echo "🚀 MULTIPLICATION BOARD SERVER STARTED"
echo "============================================================"
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    if ! command -v python &> /dev/null; then
        echo "❌ Python not found!"
        echo ""
        echo "Please install Python from: https://www.python.org/downloads/"
        echo ""
        exit 1
    else
        PYTHON_CMD="python"
    fi
else
    PYTHON_CMD="python3"
fi

echo "✅ Python found"
echo ""
echo "📁 Starting server in current directory..."
echo ""

# Get the directory containing this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change to that directory
cd "$DIR"

# Try to get local IP
echo "============================================================"
echo "🌐 Server running at: http://localhost:8000"
echo "============================================================"
echo ""
echo "📱 TO INSTALL ON MOBILE:"
echo "============================================================"
echo "1️⃣  Make sure your mobile and computer are on SAME Wi-Fi"
echo "2️⃣  Find your computer's IP address below:"
echo ""

# Get IP address
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    IP=$(ipconfig getifaddr en0 | grep -E "inet.[0-9]" | cut -d " " -f 2)
else
    # Linux
    IP=$(hostname -I | cut -d ' ' -f 1)
fi

if [ ! -z "$IP" ]; then
    echo "   📡 Your IP: http://$IP:8000"
    echo ""
else
    echo "   ⚠️  Could not detect IP automatically"
    echo "   💡 Find your IP by running 'ifconfig' (Mac)"
    echo "      or 'ip addr show' (Linux)"
    echo ""
fi

echo "3️⃣  On mobile Chrome, type: http://YOUR_IP:8000/multiplication-board.html"
echo "4️⃣  Open the page in Chrome"
echo "5️⃣  Tap ⋮ menu (top right)"
echo "6️⃣  Select 'Add to Home Screen' or 'Install App'"
echo "============================================================"
echo ""
echo "💡 Keep this terminal open while using the app"
echo "🛑 Press Ctrl+C to stop the server"
echo ""
echo "🌐 Opening browser..."
echo ""

# Open in default browser on Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    open http://localhost:8000/multiplication-board.html
elif command -v xdg-open &> /dev/null; then
    # Linux with xdg-open
    xdg-open http://localhost:8000/multiplication-board.html
fi

# Start server
$PYTHON_CMD -m http.server 8000
