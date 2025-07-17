#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install git first."
    exit 1
fi

# Navigate to the project directory
cd "$(dirname "$0")"

# Initialize git repository if it doesn't exist
if [ ! -d ".git" ]; then
  git init
  echo "Git repository initialized."
fi

# Add remote repository if it doesn't exist
if ! git remote | grep -q "origin"; then
  git remote add origin https://github.com/llakterian/QuitVaping.git
  echo "Remote repository added."
fi

# Add all files
git add .

# Commit changes
git commit -m "Initial commit of QuitVaping app"

# Push to GitHub
git push -u origin main

echo "Code pushed to GitHub repository: https://github.com/llakterian/QuitVaping.git"