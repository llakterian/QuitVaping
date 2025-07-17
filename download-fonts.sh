#!/bin/bash

# Create fonts directory if it doesn't exist
mkdir -p assets/fonts

# Download Poppins fonts
echo "Downloading Poppins fonts..."
curl -L "https://fonts.google.com/download?family=Poppins" -o poppins.zip
unzip -j poppins.zip "static/Poppins-Regular.ttf" "static/Poppins-Medium.ttf" "static/Poppins-SemiBold.ttf" "static/Poppins-Bold.ttf" -d assets/fonts/
rm poppins.zip

echo "Fonts downloaded successfully!"