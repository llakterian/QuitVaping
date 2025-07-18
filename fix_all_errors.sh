#!/bin/bash

# Function to check if a file exists
check_file() {
  if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
  fi
}

# Function to check if a directory exists and create it if it doesn't
check_and_create_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}

# Fix critical errors
./fix-critical-errors.sh

# Fix prepare-playstore.sh issues
./fix-prepare-playstore.sh
