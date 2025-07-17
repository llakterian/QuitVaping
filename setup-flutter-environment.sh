#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}===== Flutter & Android Development Environment Setup =====${NC}"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${YELLOW}Flutter not found. Let's install it.${NC}"
    
    # Create a directory for Flutter
    mkdir -p ~/development
    cd ~/development
    
    # Download Flutter
    echo "Downloading Flutter SDK..."
    wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.10.6-stable.tar.xz
    
    # Extract Flutter
    echo "Extracting Flutter SDK..."
    tar xf flutter_linux_3.10.6-stable.tar.xz
    
    # Add Flutter to PATH
    echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc
    export PATH="$PATH:$HOME/development/flutter/bin"
    
    echo -e "${GREEN}Flutter SDK installed!${NC}"
    echo "Please run 'source ~/.bashrc' or restart your terminal to update PATH."
    echo ""
else
    echo -e "${GREEN}Flutter is already installed.${NC}"
    flutter --version
    echo ""
fi

# Check for Android SDK
echo -e "${YELLOW}Setting up Android SDK...${NC}"
echo "Android SDK can be installed via Android Studio or command line."
echo ""
echo "Option 1: Install Android Studio (Recommended for beginners)"
echo "  1. Download from: https://developer.android.com/studio"
echo "  2. Install and run Android Studio"
echo "  3. Go through the setup wizard which will install Android SDK"
echo ""
echo "Option 2: Command line installation (For advanced users)"
echo "  Run the following commands:"
echo ""
echo "  # Install required packages"
echo "  sudo apt update"
echo "  sudo apt install -y openjdk-11-jdk-headless unzip"
echo ""
echo "  # Create Android SDK directory"
echo "  mkdir -p ~/Android/Sdk/cmdline-tools"
echo "  cd ~/Android/Sdk/cmdline-tools"
echo ""
echo "  # Download command line tools"
echo "  wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip"
echo ""
echo "  # Extract tools"
echo "  unzip commandlinetools-linux-9477386_latest.zip"
echo "  mv cmdline-tools latest"
echo "  mkdir -p ~/Android/Sdk/cmdline-tools/latest"
echo "  mv latest ~/Android/Sdk/cmdline-tools/"
echo ""
echo "  # Set up environment variables"
echo "  echo 'export ANDROID_HOME=\$HOME/Android/Sdk' >> ~/.bashrc"
echo "  echo 'export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools' >> ~/.bashrc"
echo "  source ~/.bashrc"
echo ""
echo "  # Install platform tools and build tools"
echo "  sdkmanager \"platform-tools\" \"build-tools;33.0.2\" \"platforms;android-33\""
echo ""

echo -e "${YELLOW}After installing Android SDK, run:${NC}"
echo "flutter config --android-sdk ~/Android/Sdk"
echo "flutter doctor --android-licenses"
echo ""

echo -e "${GREEN}===== Next Steps =====${NC}"
echo "1. Complete the installation steps above"
echo "2. Run 'flutter doctor' and fix any remaining issues"
echo "3. Once everything is set up, run './prepare-playstore.sh'"
echo ""
echo -e "${YELLOW}Note: You may need to restart your terminal or run 'source ~/.bashrc' after installation.${NC}"