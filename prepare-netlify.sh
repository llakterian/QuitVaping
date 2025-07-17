#!/bin/bash

# Navigate to the project directory
cd "$(dirname "$0")"

# Create deployment directory
mkdir -p deploy

# Check if we should do a real build or simulate
if [ "$1" == "--real-build" ]; then
  echo "Building Flutter web app for production..."
  flutter build web --release
else
  # Simulate the build for testing
  echo "Simulating Flutter web build..."
  mkdir -p build/web
  cp -r web/* build/web/ 2>/dev/null || echo "No web files to copy"
  cp .env.example build/web/.env
fi

# Ensure netlify.toml is in the build directory
cp netlify.toml build/web/

# Create a zip file for Netlify manual deployment
cd build/web
zip -r ../../deploy/quitvaping-netlify.zip .
cd ../..

echo "Deployment package created at deploy/quitvaping-netlify.zip"
echo "You can upload this file to Netlify for manual deployment."
echo "For a real deployment, run: ./prepare-netlify.sh --real-build"