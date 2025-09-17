#!/bin/bash

echo "🚀 DEPLOYING QUITVAPING APP NOW!"
echo "================================="
echo ""

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Please install Flutter first."
    exit 1
fi

# Clean and prepare
echo "🧹 Cleaning previous builds..."
flutter clean
flutter pub get

echo ""
echo "🔄 Switching to web-compatible dependencies..."
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
    echo "❌ Build failed! Restoring original pubspec..."
    cp pubspec_backup.yaml pubspec.yaml
    exit 1
fi

echo ""
echo "✅ Build successful! Files created in build/web/"
ls -la build/web/

echo ""
echo "🔄 Restoring original dependencies..."
cp pubspec_backup.yaml pubspec.yaml
flutter pub get

echo ""
echo "📦 Committing build artifacts..."
git add .
git commit -m "🚀 Deploy QuitVaping app - $(date '+%Y-%m-%d %H:%M:%S')"

echo ""
echo "⬆️  Pushing to GitHub..."
git push origin master

echo ""
echo "🎯 MANUAL STEPS REQUIRED:"
echo "========================"
echo ""
echo "1. 🌐 Configure GitHub Pages:"
echo "   → Go to: https://github.com/llakterian/QuitVaping/settings/pages"
echo "   → Under 'Source', select 'GitHub Actions'"
echo "   → Click 'Save'"
echo ""
echo "2. 🔄 Trigger Deployment:"
echo "   → Go to: https://github.com/llakterian/QuitVaping/actions"
echo "   → Click 'Deploy QuitVaping App to GitHub Pages'"
echo "   → Click 'Run workflow' → Select 'master' → Click 'Run workflow'"
echo ""
echo "3. ⏱️  Wait 2-3 minutes for deployment"
echo ""
echo "4. 🎉 Visit your live app:"
echo "   → https://llakterian.github.io/QuitVaping/"
echo ""
echo "🔍 Check deployment status:"
echo "   → https://github.com/llakterian/QuitVaping/actions"
echo ""

# Test if we can reach GitHub
echo "🌐 Testing GitHub connectivity..."
if curl -s --head https://github.com | head -n 1 | grep -q "200 OK"; then
    echo "✅ GitHub is reachable"
else
    echo "⚠️  GitHub connectivity issue - check your internet connection"
fi

echo ""
echo "🎯 YOUR APP WILL BE LIVE AT:"
echo "https://llakterian.github.io/QuitVaping/"
echo ""
echo "If it's still not working after following the manual steps above,"
echo "the issue is likely in GitHub Pages configuration, not your code!"