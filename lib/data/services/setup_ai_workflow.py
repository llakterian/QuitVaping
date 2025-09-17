#!/usr/bin/env python3
"""
Setup script for AI Workflow MCP Server
Installs dependencies and configures the environment for the QuitVaping AI motivation system
"""

import os
import subprocess
import sys
from pathlib import Path

def run_command(command, description):
    """Run a command and handle errors"""
    print(f"🔄 {description}...")
    try:
        result = subprocess.run(command, shell=True, check=True, capture_output=True, text=True)
        print(f"✅ {description} completed successfully")
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"❌ {description} failed: {e}")
        print(f"Error output: {e.stderr}")
        return None

def check_python_version():
    """Check if Python version is compatible"""
    version = sys.version_info
    if version.major < 3 or (version.major == 3 and version.minor < 8):
        print("❌ Python 3.8 or higher is required")
        return False
    print(f"✅ Python {version.major}.{version.minor}.{version.micro} is compatible")
    return True

def install_dependencies():
    """Install required Python packages"""
    packages = [
        "httpx",
        "mcp",
        "asyncio",
        "python-dotenv"
    ]
    
    for package in packages:
        result = run_command(f"pip install {package}", f"Installing {package}")
        if result is None:
            return False
    
    return True

def create_env_file():
    """Create environment file template"""
    env_content = """# AI Workflow MCP Server Environment Variables
# Copy this file to .env and fill in your actual API keys

# Postman AI Agent Builder API Key
POSTMAN_AI_AGENT_API_KEY=your_postman_ai_agent_api_key_here

# OpenAI API Key (optional, for enhanced AI features)
OPENAI_API_KEY=your_openai_api_key_here

# MCP Server Configuration
FASTMCP_LOG_LEVEL=ERROR
MCP_SERVER_PORT=8000

# Health API Configuration (optional)
HEALTH_API_BASE_URL=https://api.health.gov
MEDICAL_DB_API_KEY=your_medical_db_api_key_here

# Weather API Configuration (optional)
WEATHER_API_KEY=your_weather_api_key_here

# Financial API Configuration (optional)
FINANCIAL_API_KEY=your_financial_api_key_here

# Community API Configuration (optional)
COMMUNITY_API_KEY=your_community_api_key_here

# Analytics Configuration (optional)
ANALYTICS_DB_URL=your_analytics_db_url_here
"""
    
    env_file = Path(".env.example")
    with open(env_file, "w") as f:
        f.write(env_content)
    
    print(f"✅ Created {env_file}")
    print("📝 Please copy .env.example to .env and fill in your API keys")

def create_startup_script():
    """Create startup script for the MCP server"""
    startup_content = """#!/bin/bash
# Startup script for AI Workflow MCP Server

echo "🚀 Starting AI Workflow MCP Server..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ .env file not found. Please copy .env.example to .env and configure your API keys."
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Start the MCP server
python ai_workflow_mcp_server.py
"""
    
    startup_file = Path("start_ai_workflow_server.sh")
    with open(startup_file, "w") as f:
        f.write(startup_content)
    
    # Make the script executable
    os.chmod(startup_file, 0o755)
    
    print(f"✅ Created {startup_file}")
    print("🔧 Use ./start_ai_workflow_server.sh to start the MCP server")

def create_test_script():
    """Create test script for the MCP server"""
    test_content = """#!/usr/bin/env python3
\"\"\"
Test script for AI Workflow MCP Server
Tests basic functionality of the motivation system
\"\"\"

import asyncio
import json
import httpx

async def test_motivation_content():
    \"\"\"Test motivation content generation\"\"\"
    url = "http://localhost:8000/tools/generate_motivation_content"
    
    test_data = {
        "method": "generate_motivation_content",
        "params": {
            "userId": "test_user",
            "mood": "positive",
            "recentActivity": [
                {
                    "activityType": "milestone_reached",
                    "timestamp": "2024-01-15T12:00:00Z",
                    "data": {"milestone": "1_week"}
                }
            ],
            "externalFactors": {
                "weather": "sunny",
                "timeOfDay": "afternoon"
            }
        }
    }
    
    try:
        async with httpx.AsyncClient() as client:
            response = await client.post(url, json=test_data, timeout=10.0)
            
            if response.status_code == 200:
                result = response.json()
                print("✅ Motivation content generation test passed")
                print(f"Generated content: {result.get('content', {}).get('content', 'N/A')}")
                return True
            else:
                print(f"❌ Test failed with status {response.status_code}")
                print(f"Response: {response.text}")
                return False
                
    except Exception as e:
        print(f"❌ Test failed with error: {e}")
        return False

async def test_mood_analysis():
    \"\"\"Test mood analysis\"\"\"
    url = "http://localhost:8000/tools/analyze_mood"
    
    test_data = {
        "method": "analyze_mood",
        "params": {
            "activityData": [
                {
                    "activityType": "craving_logged",
                    "timestamp": "2024-01-15T12:00:00Z",
                    "data": {"intensity": 8}
                },
                {
                    "activityType": "craving_logged",
                    "timestamp": "2024-01-15T11:30:00Z",
                    "data": {"intensity": 9}
                }
            ]
        }
    }
    
    try:
        async with httpx.AsyncClient() as client:
            response = await client.post(url, json=test_data, timeout=10.0)
            
            if response.status_code == 200:
                result = response.json()
                print("✅ Mood analysis test passed")
                print(f"Detected mood: {result.get('mood', 'N/A')}")
                return True
            else:
                print(f"❌ Test failed with status {response.status_code}")
                return False
                
    except Exception as e:
        print(f"❌ Test failed with error: {e}")
        return False

async def main():
    \"\"\"Run all tests\"\"\"
    print("🧪 Testing AI Workflow MCP Server...")
    print("Make sure the server is running on http://localhost:8000")
    print()
    
    tests = [
        test_motivation_content,
        test_mood_analysis,
    ]
    
    passed = 0
    total = len(tests)
    
    for test in tests:
        if await test():
            passed += 1
        print()
    
    print(f"📊 Test Results: {passed}/{total} tests passed")
    
    if passed == total:
        print("🎉 All tests passed! The AI Workflow MCP Server is working correctly.")
    else:
        print("⚠️  Some tests failed. Please check the server configuration and API keys.")

if __name__ == "__main__":
    asyncio.run(main())
"""
    
    test_file = Path("test_ai_workflow_server.py")
    with open(test_file, "w") as f:
        f.write(test_content)
    
    print(f"✅ Created {test_file}")
    print("🧪 Use python test_ai_workflow_server.py to test the MCP server")

def main():
    """Main setup function"""
    print("🚀 Setting up AI Workflow MCP Server for QuitVaping App")
    print("=" * 60)
    
    # Check Python version
    if not check_python_version():
        return False
    
    # Install dependencies
    print("\n📦 Installing Python dependencies...")
    if not install_dependencies():
        print("❌ Failed to install dependencies")
        return False
    
    # Create configuration files
    print("\n📝 Creating configuration files...")
    create_env_file()
    create_startup_script()
    create_test_script()
    
    print("\n🎉 Setup completed successfully!")
    print("\n📋 Next steps:")
    print("1. Copy .env.example to .env and configure your API keys")
    print("2. Run ./start_ai_workflow_server.sh to start the MCP server")
    print("3. Run python test_ai_workflow_server.py to test the server")
    print("4. Import the Postman collections for comprehensive testing")
    print("\n📚 Documentation:")
    print("- See AI_Workflow_Development.postman_notebook.json for detailed documentation")
    print("- Check the Postman collections for API testing examples")
    
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)