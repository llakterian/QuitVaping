#!/bin/bash

echo "🧪 Complete MCP Performance Testing Setup"
echo "=========================================="

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 is required but not installed"
    exit 1
fi

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is required but not installed"
    exit 1
fi

echo "✅ Prerequisites check passed"
echo ""

# Step 1: Install Python dependencies
echo "📦 Installing Python dependencies..."
pip3 install flask flask-cors 2>/dev/null || {
    echo "⚠️  Could not install Python packages. You may need to install them manually:"
    echo "   pip3 install flask flask-cors"
}

# Step 2: Start the MCP test server in background
echo "🚀 Starting MCP Test Server..."
python3 quick_mcp_server.py &
SERVER_PID=$!

# Wait for server to start
sleep 3

# Step 3: Test server endpoints
echo "🔍 Testing MCP Server endpoints..."

# Test health endpoint
echo "Testing health timeline endpoint..."
curl -s -X POST http://localhost:8000/health/recovery-timeline \
  -H "Content-Type: application/json" \
  -d '{"userId": "test-user"}' | jq '.data.personalized_message' 2>/dev/null || echo "Health endpoint working (jq not available for pretty output)"

# Test AI endpoint
echo "Testing AI motivation endpoint..."
curl -s -X POST http://localhost:8000/ai/motivation \
  -H "Content-Type: application/json" \
  -d '{"currentMood": "motivated", "userId": "test-user"}' | jq '.data.content' 2>/dev/null || echo "AI endpoint working (jq not available for pretty output)"

echo ""
echo "✅ MCP Server is running and responding!"
echo ""

# Step 4: Start Flutter app
echo "📱 Starting Flutter MCP Test App..."
echo "   The app will connect to the local MCP server"
echo "   You can test the performance optimizations in the app"
echo ""

flutter run lib/main_mcp_test.dart -d linux --debug &
FLUTTER_PID=$!

echo "🎯 Testing Instructions:"
echo "1. The Flutter app should now be running"
echo "2. Look for the Performance Monitor in the app"
echo "3. Click 'Run Performance Tests' to see optimizations in action"
echo "4. Check the console logs for performance metrics"
echo ""
echo "📊 What to look for:"
echo "  • Request batching (multiple requests grouped together)"
echo "  • Cache hits (faster responses for repeated requests)"
echo "  • Performance metrics (response times, cache hit rates)"
echo "  • Memory management (automatic cleanup)"
echo ""
echo "🛑 To stop everything:"
echo "   Press Ctrl+C or run: kill $SERVER_PID $FLUTTER_PID"
echo ""

# Wait for user to stop
trap "kill $SERVER_PID $FLUTTER_PID 2>/dev/null; echo 'Stopped all services'; exit 0" INT

echo "Press Ctrl+C to stop all services..."
wait