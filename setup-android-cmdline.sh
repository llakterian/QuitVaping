#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}===== Setting up Android SDK Command-line Tools =====${NC}"
echo ""

# Create Android SDK directory if it doesn't exist
mkdir -p ~/Android/Sdk/cmdline-tools
cd ~/Android/Sdk/cmdline-tools

echo -e "${YELLOW}Downloading Android SDK Command-line Tools...${NC}"
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip

echo -e "${YELLOW}Extracting Command-line Tools...${NC}"
unzip -q commandlinetools-linux-9477386_latest.zip

# Create the proper directory structure expected by the SDK manager
mkdir -p ~/Android/Sdk/cmdline-tools/latest
mv cmdline-tools/* ~/Android/Sdk/cmdline-tools/latest/
rmdir cmdline-tools

# Set up environment variables
echo -e "${YELLOW}Setting up environment variables...${NC}"
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools' >> ~/.bashrc

# Apply the environment variables to the current session
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

echo -e "${GREEN}Installing Android SDK components...${NC}"
# Install platform tools and build tools
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --sdk_root=$ANDROID_HOME "platform-tools" "build-tools;33.0.2" "platforms;android-33"

echo -e "${GREEN}Configuring Flutter to use the Android SDK...${NC}"
flutter config --android-sdk ~/Android/Sdk

echo -e "${YELLOW}Now accepting Android licenses...${NC}"
flutter doctor --android-licenses

echo -e "${GREEN}===== Setup Complete =====${NC}"
echo ""
echo "Please run the following command to update your current terminal session:"
echo -e "${YELLOW}source ~/.bashrc${NC}"
echo ""
echo "Then verify your setup with:"
echo -e "${YELLOW}flutter doctor -v${NC}"
echo ""
echo "Once everything is set up, you can build your app with:"
echo -e "${YELLOW}./prepare-playstore.sh${NC}"