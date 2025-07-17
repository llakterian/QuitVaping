#!/bin/bash

# Script to push changes to GitHub
echo "Pushing changes to GitHub..."

# Add all changes
git add .

# Commit changes
git commit -m "Fix Flutter analyze errors and warnings"

# Push to GitHub
git push origin main

echo "Changes pushed to GitHub successfully!"