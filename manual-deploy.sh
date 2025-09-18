#!/bin/bash

echo "🚀 MANUAL DEPLOYMENT - QuitVaping App"
echo "===================================="
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: Not in Flutter project directory"
    exit 1
fi

echo "📍 Current directory: $(pwd)"
echo "📍 Current branch: $(git branch --show-current)"
echo ""

# Clean and prepare
echo "🧹 Cleaning previous builds..."
flutter clean
rm -rf build/

echo ""
echo "🔄 Setting up web dependencies..."
cp pubspec.yaml pubspec_backup.yaml
cp pubspec_web.yaml pubspec.yaml
flutter pub get

echo ""
echo "🏗️  Building web app..."
flutter build web --release \
  --target=lib/main_final_web.dart \
  --base-href "/QuitVaping/" \
  --dart-define=FLUTTER_WEB_USE_SKIA=false

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Build failed!"
    cp pubspec_backup.yaml pubspec.yaml
    exit 1
fi

echo ""
echo "✅ Build successful! Files created:"
ls -la build/web/

echo ""
echo "🔄 Restoring original dependencies..."
cp pubspec_backup.yaml pubspec.yaml
flutter pub get

echo ""
echo "📦 Deploying to gh-pages branch..."

# Create or switch to gh-pages branch
git checkout gh-pages 2>/dev/null || git checkout -b gh-pages

# Clear the branch and copy build files
git rm -rf . 2>/dev/null || true
cp -r build/web/* .
cp build/web/.* . 2>/dev/null || true

# Add and commit
git add .
git commit -m "🚀 Manual deployment - $(date '+%Y-%m-%d %H:%M:%S')"

# Push to gh-pages
git push origin gh-pages --force

# Switch back to main
git checkout main

echo ""
echo "🎉 DEPLOYMENT COMPLETE!"
echo ""
echo "🌍 Your app should be live at:"
echo "   https://llakterian.github.io/QuitVaping/"
echo ""
echo "📋 Next steps:"
echo "   1. Wait 2-3 minutes for GitHub Pages to update"
echo "   2. Check: https://github.com/llakterian/QuitVaping/settings/pages"
echo "   3. Ensure 'Source' is set to 'Deploy from a branch: gh-pages'"
echo ""
echo "🔍 If still not working:"
echo "   - Check GitHub repository settings"
echo "   - Verify Pages source is set to gh-pages branch"
echo "   - Clear browser cache and try again"