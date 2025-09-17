#!/bin/bash

# 🌐 Install Chrome on Kali Linux for Flutter Web Development

echo "🌐 Installing Google Chrome on Kali Linux..."
echo "============================================="

# Update package list
echo "📦 Updating package list..."
sudo apt update

# Download Chrome
echo "⬇️  Downloading Google Chrome..."
cd /tmp
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Update and install Chrome
echo "📦 Installing Google Chrome..."
sudo apt update
sudo apt install -y google-chrome-stable

# Verify installation
if command -v google-chrome &> /dev/null; then
    echo "✅ Google Chrome installed successfully!"
    echo "🔍 Chrome version: $(google-chrome --version)"
    
    # Set Chrome executable for Flutter
    echo "🔧 Setting up Chrome for Flutter..."
    export CHROME_EXECUTABLE=$(which google-chrome)
    echo "export CHROME_EXECUTABLE=$(which google-chrome)" >> ~/.bashrc
    
    echo ""
    echo "🎉 SUCCESS! Chrome is ready for Flutter web development!"
    echo ""
    echo "💡 To use Chrome with Flutter:"
    echo "   flutter run -d chrome"
    echo ""
    echo "🔄 Restart your terminal or run:"
    echo "   source ~/.bashrc"
    echo ""
else
    echo "❌ Chrome installation failed. Please try manual installation."
    echo ""
    echo "Manual installation steps:"
    echo "1. Download Chrome .deb from https://www.google.com/chrome/"
    echo "2. sudo dpkg -i google-chrome-stable_current_amd64.deb"
    echo "3. sudo apt-get install -f"
fi