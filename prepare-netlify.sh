#!/bin/bash

# Navigate to the project directory
cd "$(dirname "$0")"

# Create deployment directory
mkdir -p deploy

# Build the web app (this would normally be done with Flutter, but we'll simulate it)
echo "Simulating Flutter web build..."
mkdir -p build/web
cp -r web/* build/web/ 2>/dev/null || echo "No web files to copy"
cp .env.example build/web/.env

# Create a zip file for Netlify manual deployment
cd build/web
zip -r ../../deploy/quitvaping-netlify.zip .
cd ../..

echo "Deployment package created at deploy/quitvaping-netlify.zip"
echo "You can upload this file to Netlify for manual deployment."
echo "For a real deployment, you would run 'flutter build web --release' first."