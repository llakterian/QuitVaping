#!/bin/bash

# Navigate to the project directory
cd "$(dirname "$0")"

# Create a directory for the test zip
mkdir -p test_build

# Copy all necessary files
cp -r lib/ test_build/
cp -r assets/ test_build/ 2>/dev/null || mkdir -p test_build/assets
cp -r web/ test_build/ 2>/dev/null || mkdir -p test_build/web
cp pubspec.yaml test_build/
cp .env.example test_build/.env
cp README.md test_build/
cp netlify.toml test_build/

# Create a zip file
cd test_build
zip -r ../quitvaping-test.zip .
cd ..

# Clean up
rm -rf test_build

echo "Test zip file created: quitvaping-test.zip"
echo "You can upload this file to Netlify for testing."