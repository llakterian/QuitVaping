#!/bin/bash

echo "🚀 MCP Performance Testing Script"
echo "=================================="

# Test 1: Run the MCP test app
echo "📱 Starting MCP Test App..."
flutter run lib/main_mcp_test.dart -d linux --debug &
APP_PID=$!

# Wait for app to start
sleep 10

# Test 2: Check if performance monitoring is working
echo "📊 Testing Performance Monitoring..."
echo "✅ App should now be running with performance monitor"
echo "✅ Check the Performance Monitor widget in the app"
echo "✅ Click 'Run Performance Tests' to see optimization in action"

# Test 3: Monitor logs for performance metrics
echo "📈 Monitoring Performance Logs..."
echo "Look for these indicators in the Flutter logs:"
echo "  • 'MCP Performance Optimizer initialized'"
echo "  • '📦 Executing batch of X requests'"
echo "  • '🧹 Cleaned up X expired cache entries'"
echo "  • '📊 MCP Performance Metrics'"

echo ""
echo "🎯 To test performance optimizations:"
echo "1. Open the app and navigate to the Performance Monitor"
echo "2. Click 'Run Performance Tests'"
echo "3. Observe the batching and caching in action"
echo "4. Check the performance statistics"

echo ""
echo "Press Ctrl+C to stop the app"
wait $APP_PID