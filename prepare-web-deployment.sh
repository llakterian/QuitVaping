#!/bin/bash

# 🚭 QuitVaping App - Web Deployment Preparation Script
# This script prepares your QuitVaping app for web deployment

echo "🚭 Preparing QuitVaping App for Web Deployment..."
echo "=================================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"

# Enable web support
echo "🌐 Enabling web support..."
flutter config --enable-web

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Check for any issues
echo "🔍 Running flutter doctor..."
flutter doctor

# Build for web with optimizations
echo "🏗️  Building optimized web version..."
flutter build web --release \
  --dart-define=FLUTTER_WEB_USE_SKIA=false \
  --source-maps

# Check if build was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 SUCCESS! Your QuitVaping app is ready for deployment!"
    echo ""
    echo "📁 Web files are in: ./build/web/"
    echo ""
    echo "🚀 Next steps:"
    echo "1. Push your code to GitHub"
    echo "2. Set up GitHub Pages (see HOSTING_GUIDE.md)"
    echo "3. Your app will be live at: https://llakterian.github.io/QuitVaping/"
    echo ""
    echo "💡 Pro tip: Test locally first with:"
    echo "   flutter run -d chrome"
    echo ""
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi