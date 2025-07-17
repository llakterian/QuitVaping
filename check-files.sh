#!/bin/bash

# Define required files and directories
required_files=(
  "lib/main.dart"
  "lib/app.dart"
  "lib/config/env_config.dart"
  "pubspec.yaml"
  ".env.example"
  ".gitignore"
  "README.md"
  "LICENSE"
  "web/index.html"
  "web/manifest.json"
  "netlify.toml"
)

required_dirs=(
  "lib/data/models"
  "lib/data/services"
  "lib/features"
  "lib/shared"
  "assets"
  "test"
  ".github/workflows"
)

# Check required files
echo "Checking required files..."
missing_files=0
for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ Missing file: $file"
    missing_files=$((missing_files + 1))
  else
    echo "✅ Found file: $file"
  fi
done

# Check required directories
echo -e "\nChecking required directories..."
missing_dirs=0
for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "❌ Missing directory: $dir"
    missing_dirs=$((missing_dirs + 1))
  else
    echo "✅ Found directory: $dir"
  fi
done

# Summary
echo -e "\nSummary:"
if [ $missing_files -eq 0 ] && [ $missing_dirs -eq 0 ]; then
  echo "✅ All required files and directories are present!"
  echo "The project is ready to be pushed to GitHub."
else
  echo "❌ Missing $missing_files files and $missing_dirs directories."
  echo "Please create the missing files and directories before pushing to GitHub."
fi