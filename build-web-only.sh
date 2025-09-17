#!/bin/bash

# 🌐 QuitVaping Web-Only Build Script
# This script builds the app for web without Firebase dependencies

echo "🌐 Building QuitVaping for Web (Firebase-free version)..."
echo "========================================================"

# Backup original pubspec.yaml
echo "📦 Backing up original pubspec.yaml..."
cp pubspec.yaml pubspec_original.yaml

# Use web-specific pubspec.yaml
echo "🔄 Switching to web-compatible dependencies..."
cp pubspec_web.yaml pubspec.yaml

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get web-compatible dependencies
echo "📦 Getting web-compatible dependencies..."
flutter pub get

# Build for web with final web main file
echo "🏗️  Building optimized web version..."
flutter build web --release \
  --target=lib/main_final_web.dart \
  --dart-define=FLUTTER_WEB_USE_SKIA=false \
  --source-maps

# Check if build was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 SUCCESS! QuitVaping web app is ready!"
    echo ""
    echo "📁 Web files are in: ./build/web/"
    echo ""
    echo "🚀 Next steps:"
    echo "1. Test locally: python3 -m http.server 8000 -d build/web"
    echo "2. Push to GitHub for automatic deployment"
    echo "3. Your app will be live at: https://llakterian.github.io/QuitVaping/"
    echo ""
    echo "🔄 Restoring original pubspec.yaml..."
    cp pubspec_original.yaml pubspec.yaml
    rm pubspec_original.yaml
    echo ""
    echo "✅ Build complete and dependencies restored!"
else
    echo "❌ Build failed. Restoring original pubspec.yaml..."
    cp pubspec_original.yaml pubspec.yaml
    rm pubspec_original.yaml
    echo "Please check the errors above."
    exit 1
fi