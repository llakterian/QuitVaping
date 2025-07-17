#!/bin/bash

echo "Preparing QuitVaping app for Play Store submission..."

# Step 1: Fix all remaining errors
echo "Step 1: Fixing all remaining errors..."
./fix-final-errors.sh

# Step 2: Update app version
echo "Step 2: Updating app version..."
# Increment version code (build number)
VERSION_NAME=$(grep -oP 'version: \K[0-9]+\.[0-9]+\.[0-9]+' pubspec.yaml)
VERSION_CODE=$(grep -oP 'version: [0-9]+\.[0-9]+\.[0-9]+\+\K[0-9]+' pubspec.yaml)
NEW_VERSION_CODE=$((VERSION_CODE + 1))
sed -i "s/version: $VERSION_NAME+$VERSION_CODE/version: $VERSION_NAME+$NEW_VERSION_CODE/" pubspec.yaml
echo "Updated version from $VERSION_NAME+$VERSION_CODE to $VERSION_NAME+$NEW_VERSION_CODE"

# Step 3: Run flutter clean
echo "Step 3: Running flutter clean..."
flutter clean

# Step 4: Get dependencies
echo "Step 4: Getting dependencies..."
flutter pub get

# Step 5: Run tests
echo "Step 5: Running tests..."
flutter test

# Step 6: Build release APK and App Bundle
echo "Step 6: Building release APK and App Bundle..."
flutter build apk --release
flutter build appbundle

# Step 7: Generate Play Store assets
echo "Step 7: Creating Play Store assets directory..."
mkdir -p play_store_assets
mkdir -p play_store_assets/screenshots
mkdir -p play_store_assets/graphics

echo "Creating Play Store listing template files..."
cat > play_store_assets/short_description.txt << EOL
AI-powered app to help users quit vaping through personalized tracking and support.
EOL

cat > play_store_assets/full_description.txt << EOL
QuitVaping is an AI-powered app designed to help you quit vaping for good. With personalized tracking, support, and tools, we make your quit journey easier and more successful.

Features:
• Track your progress with real-time stats on time since quitting, money saved, and health improvements
• Get personalized insights based on your usage patterns and quit journey
• Use the AI Coach for 24/7 support and guidance
• Practice breathing exercises to manage cravings
• Access Panic Mode for immediate help during strong cravings
• Track Nicotine Replacement Therapy (NRT) usage
• Log and analyze your cravings to identify patterns
• Set goals and celebrate achievements

Premium features:
• Advanced analytics and personalized insights
• Unlimited AI Coach conversations
• Premium breathing exercises
• Advanced NRT analytics
• Additional panic mode techniques
• Detailed craving analytics

Start your journey to a vape-free life today!
EOL

cat > play_store_assets/privacy_policy_url.txt << EOL
https://quitvaping.app/privacy
EOL

cat > play_store_assets/website.txt << EOL
https://quitvaping.app
EOL

cat > play_store_assets/email.txt << EOL
support@quitvaping.app
EOL

cat > play_store_assets/phone.txt << EOL
+1-555-123-4567
EOL

echo "Play Store preparation complete!"
echo ""
echo "Next steps:"
echo "1. Create a Google Play Developer account if you don't have one"
echo "2. Create a new app in the Play Console"
echo "3. Upload your app bundle from build/app/outputs/bundle/release/app-release.aab"
echo "4. Complete the store listing using the templates in play_store_assets/"
echo "5. Add screenshots to play_store_assets/screenshots/"
echo "6. Add feature graphic and other graphics to play_store_assets/graphics/"
echo "7. Set up in-app purchases for your subscription products"
echo "8. Complete content rating questionnaire"
echo "9. Submit for review"