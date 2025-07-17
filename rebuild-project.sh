#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}===== Rebuilding Flutter Project =====${NC}"
echo ""

# Navigate to the project directory
cd "$(dirname "$0")"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Error: Flutter is not installed or not in your PATH${NC}"
    exit 1
fi

# Create a temporary directory
echo -e "${YELLOW}Creating temporary directory...${NC}"
TEMP_DIR=$(mktemp -d)
echo "Temporary directory: $TEMP_DIR"

# Create a new Flutter project in the temporary directory
echo -e "${YELLOW}Creating new Flutter project...${NC}"
cd $TEMP_DIR
flutter create --org com.quitvaping --project-name quit_vaping .

# Copy over the lib directory, assets, and pubspec.yaml from the original project
echo -e "${YELLOW}Copying project files...${NC}"
ORIGINAL_DIR=$(dirname "$0")
cp -r $ORIGINAL_DIR/lib $TEMP_DIR/
cp -r $ORIGINAL_DIR/assets $TEMP_DIR/ 2>/dev/null || mkdir -p $TEMP_DIR/assets
cp $ORIGINAL_DIR/pubspec.yaml $TEMP_DIR/

# Copy environment files
cp $ORIGINAL_DIR/.env* $TEMP_DIR/ 2>/dev/null || echo "No .env files found"

# Get dependencies
echo -e "${YELLOW}Getting dependencies...${NC}"
flutter pub get

# Build the app bundle
echo -e "${YELLOW}Building Android App Bundle...${NC}"
flutter build appbundle --release

# Create deploy directory in the original project
mkdir -p $ORIGINAL_DIR/deploy

# Copy the built AAB to the original project's deploy directory
echo -e "${YELLOW}Copying built AAB to deploy directory...${NC}"
cp build/app/outputs/bundle/release/app-release.aab $ORIGINAL_DIR/deploy/quitvaping-release.aab

# Also build an APK for testing
echo -e "${YELLOW}Building APK for testing...${NC}"
flutter build apk --release

# Copy the APK to the original project's deploy directory
cp build/app/outputs/flutter-apk/app-release.apk $ORIGINAL_DIR/deploy/quitvaping-release.apk

echo -e "${GREEN}===== Build Complete =====${NC}"
echo ""
echo "App Bundle (AAB): $ORIGINAL_DIR/deploy/quitvaping-release.aab"
echo "Test APK: $ORIGINAL_DIR/deploy/quitvaping-release.apk"
echo ""
echo "Next steps:"
echo "1. Go to https://play.google.com/console/"
echo "2. Create a new app or select your existing app"
echo "3. Navigate to 'Production' > 'Create new release'"
echo "4. Upload the AAB file from deploy/quitvaping-release.aab"
echo "5. Complete the store listing, content rating, and pricing & distribution sections"
echo "6. Submit for review"