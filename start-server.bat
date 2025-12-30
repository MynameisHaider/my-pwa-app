@echo off
REM Multiplication Board PWA Server Launcher for Windows
REM This starts a local web server so you can install the app on mobile

echo ============================================================
echo 🚀 MULTIPLICATION BOARD SERVER STARTED
echo ============================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python not found!
    echo.
    echo Please install Python from: https://www.python.org/downloads/
    echo.
    pause
    exit /b
)

echo ✅ Python found
echo.
echo 📁 Starting server in current directory...
echo.

REM Start Python HTTP server on port 8000
echo ============================================================
echo 🌐 Server running at: http://localhost:8000
echo ============================================================
echo.
echo 📱 TO INSTALL ON MOBILE:
echo ============================================================
echo 1. Make sure your mobile and computer are on SAME Wi-Fi
echo 2. Find your computer's IP address:
echo.

REM Try to get IP address
ipconfig | findstr /i "IPv4" > nul
if %errorlevel% equ 0 (
    ipconfig | findstr /i "IPv4"
) else (
    echo    ⚠️  Run 'ipconfig' to find your IP address
)

echo.
echo 3. On mobile Chrome, type: http://YOUR_IP:8000/multiplication-board.html
echo 4. Open the page in Chrome
echo 5. Tap ⋮ menu (top right)
echo 6. Select 'Add to Home Screen' or 'Install App'
echo ============================================================
echo.
echo 💡 Keep this window open while using the app
echo 🛑 Close this window to stop the server
echo.
echo 🌐 Opening browser...
echo.

REM Open browser
start http://localhost:8000/multiplication-board.html

REM Start server
python -m http.server 8000

pause
