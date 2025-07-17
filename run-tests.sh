#!/bin/bash

# Navigate to the project directory
cd "$(dirname "$0")"

# Run Flutter tests
flutter test

# Check the exit code
if [ $? -eq 0 ]; then
  echo "✅ All tests passed!"
else
  echo "❌ Tests failed!"
  exit 1
fi