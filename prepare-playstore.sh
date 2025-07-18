#!/bin/bash

# Function to check if a file exists
check_file() {
  if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
  fi
}

# Function to check if a directory exists and create it if it doesn't
check_and_create_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}

# Navigate to the project directory
cd "$(dirname "$0")"

# Create deployment directory if it doesn't exist
mkdir -p deploy

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
  echo "Error: Flutter is not installed or not in your PATH"
  echo ""
  echo "Please install Flutter by following these steps:"
  echo "1. Visit https://flutter.dev/docs/get-started/install"
  echo "2. Download and extract Flutter SDK"
  echo "3. Add Flutter to your PATH:"
  echo "   export PATH=\"\$PATH:[PATH_TO_FLUTTER_SDK]/bin\""
  echo "4. Run 'flutter doctor' to verify installation"
  echo ""
  echo "After installing Flutter, run this script again."
  exit 1
fi

# Check if Android SDK is properly set up
if ! flutter doctor -v | grep -q "Android toolchain.*installed"; then
  echo "Warning: Android toolchain might not be properly set up."
  echo "Run 'flutter doctor' and resolve any issues with Android setup."
  echo "Continuing anyway..."
fi

# Check if keystore exists, if not create one
if [ ! -f "android/app/upload-keystore.jks" ]; then
  echo "Creating a new keystore for app signing..."
  
  # Create directory if it doesn't exist
  mkdir -p android/app
  
  # Check if keytool is available
  if ! command -v keytool &> /dev/null; then
    echo "Error: keytool not found. Please install Java JDK."
    exit 1
  fi
  
  # Generate a keystore
  keytool -genkey -v -keystore android/app/upload-keystore.jks \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -alias upload -storepass android -keypass android \
    -dname "CN=QuitVaping, OU=Development, O=YourOrganization, L=YourCity, S=YourState, C=US"
    
  echo "Keystore created. Please keep this file safe!"
  echo "For production, you should use a more secure password than the default."
fi

# Check if Flutter project is properly set up
if [ ! -f "pubspec.yaml" ]; then
  echo "Error: pubspec.yaml not found. Are you in a Flutter project directory?"
  exit 1
fi

# Build the app bundle for Play Store
echo "Building Android App Bundle (AAB) for Play Store..."
flutter build appbundle --release

# Check if build was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to build Android App Bundle."
  exit 1
fi

# Copy the AAB to the deploy directory
if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
  cp build/app/outputs/bundle/release/app-release.aab deploy/quitvaping-release.aab
  echo "✓ App Bundle (AAB) created successfully at deploy/quitvaping-release.aab"
else
  echo "Error: App Bundle (AAB) not found after build."
  echo "Check the build output for errors."
  exit 1
fi

# Also build an APK for testing
echo "Building APK for testing..."
flutter build apk --release

# Check if build was successful
if [ $? -ne 0 ]; then
  echo "Warning: Failed to build APK for testing, but AAB was created successfully."
else
  # Copy the APK to the deploy directory
  if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
    cp build/app/outputs/flutter-apk/app-release.apk deploy/quitvaping-release.apk
    echo "✓ Test APK created successfully at deploy/quitvaping-release.apk"
  else
    echo "Warning: Test APK not found after build."
  fi
fi

echo ""
echo "===== Play Store Submission Files Ready ====="
echo "App Bundle (AAB): deploy/quitvaping-release.aab"
echo "Test APK: deploy/quitvaping-release.apk"
echo ""
echo "Next steps:"
echo "1. Go to https://play.google.com/console/"
echo "2. Create a new app or select your existing app"
echo "3. Navigate to 'Production' > 'Create new release'"
echo "4. Upload the AAB file from deploy/quitvaping-release.aab"
echo "5. Complete the store listing, content rating, and pricing & distribution sections"
echo "6. Submit for review"
echo ""
echo "Note: Make sure you've updated your app's version in pubspec.yaml before building for a new release!"