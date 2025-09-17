#!/bin/bash

echo "🚀 QuitVaping Deployment Status Checker"
echo "========================================"
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: Not in Flutter project directory"
    exit 1
fi

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Check if we have uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Warning: You have uncommitted changes"
    git status --short
    echo ""
fi

# Check latest commit
echo "📝 Latest commit:"
git log --oneline -1
echo ""

# Check remote status
echo "🌐 Remote status:"
git remote -v
echo ""

# Check if GitHub Actions workflow exists
if [ -f ".github/workflows/deploy.yml" ]; then
    echo "✅ GitHub Actions workflow found"
    echo "📋 Workflow triggers on: $(grep -A 2 'branches:' .github/workflows/deploy.yml | grep -v 'branches:' | tr -d ' -[]')"
else
    echo "❌ No GitHub Actions workflow found"
fi

echo ""
echo "🔗 Check deployment status at:"
echo "   https://github.com/llakterian/QuitVaping/actions"
echo ""
echo "🌍 Your app will be live at:"
echo "   https://llakterian.github.io/QuitVaping/"
echo ""
echo "📋 To manually trigger deployment:"
echo "   1. Go to: https://github.com/llakterian/QuitVaping/actions"
echo "   2. Click on 'Deploy QuitVaping App to GitHub Pages'"
echo "   3. Click 'Run workflow' button"
echo ""

# Test if the site is already live
echo "🔍 Testing if site is live..."
if command -v curl &> /dev/null; then
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://llakterian.github.io/QuitVaping/")
    if [ "$HTTP_STATUS" = "200" ]; then
        echo "✅ Site is LIVE and responding!"
    elif [ "$HTTP_STATUS" = "404" ]; then
        echo "⏳ Site not yet deployed (404 - this is normal for first deployment)"
    else
        echo "⚠️  Site returned HTTP $HTTP_STATUS"
    fi
else
    echo "ℹ️  Install curl to test site status automatically"
fi

echo ""
echo "🎉 Next steps:"
echo "   1. Wait 2-3 minutes for GitHub Actions to complete"
echo "   2. Visit your live app at the URL above"
echo "   3. Share your app with friends and family!"