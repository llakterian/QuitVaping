# 🌐 **MCP Server Setup Guide**

## **Option 1: Use Existing MCP Servers (Easiest)**

### **A. Official MCP Servers from Anthropic**
```bash
# Install the MCP CLI
npm install -g @modelcontextprotocol/cli

# Available official servers:
mcp install filesystem    # File system operations
mcp install sqlite       # Database operations
mcp install web-search   # Web search capabilities
mcp install github       # GitHub integration
mcp install slack        # Slack integration
```

### **B. Community MCP Servers**
```bash
# Health & Wellness MCP Servers
npm install -g @health-mcp/nutrition-server
npm install -g @health-mcp/fitness-tracker
npm install -g @wellness-mcp/meditation-server

# AI & Analytics MCP Servers  
npm install -g @ai-mcp/openai-server
npm install -g @analytics-mcp/data-processor
npm install -g @ml-mcp/prediction-server
```

## **Option 2: Create Custom MCP Servers**

### **A. Python MCP Server (Recommended)**
```python
# requirements.txt
mcp>=0.1.0
fastapi>=0.68.0
uvicorn>=0.15.0
pydantic>=1.8.0

# health_server.py
from mcp import Server, Tool
from typing import Dict, Any
import json

class HealthDataServer(Server):
    def __init__(self):
        super().__init__("health-data-server")
        
    @Tool("get_health_recovery_timeline")
    async def get_health_recovery_timeline(self, user_id: str) -> Dict[str, Any]:
        """Get personalized health recovery timeline"""
        # Simulate health data calculation
        days_quit = 30  # This would come from user data
        
        timeline = {
            "user_id": user_id,
            "days_quit": days_quit,
            "health_improvements": [
                {
                    "milestone": "20 minutes",
                    "improvement": "Heart rate and blood pressure drop",
                    "achieved": days_quit >= 0
                },
                {
                    "milestone": "12 hours", 
                    "improvement": "Carbon monoxide levels normalize",
                    "achieved": days_quit >= 1
                },
                {
                    "milestone": "2 weeks",
                    "improvement": "Circulation improves, lung function increases",
                    "achieved": days_quit >= 14
                },
                {
                    "milestone": "1 month",
                    "improvement": "Coughing and shortness of breath decrease",
                    "achieved": days_quit >= 30
                }
            ],
            "next_milestone": "3 months - Significant lung function improvement",
            "personalized_message": f"Great progress! You've been vape-free for {days_quit} days."
        }
        
        return {
            "success": True,
            "data": timeline,
            "timestamp": "2024-01-01T00:00:00Z"
        }

# Run server
if __name__ == "__main__":
    server = HealthDataServer()
    server.run(host="0.0.0.0", port=8001)
```

### **B. Node.js MCP Server**
```javascript
// package.json
{
  "name": "ai-workflow-server",
  "version": "1.0.0",
  "dependencies": {
    "@modelcontextprotocol/sdk": "^0.1.0",
    "express": "^4.18.0",
    "openai": "^4.0.0"
  }
}

// ai_server.js
const { Server, Tool } = require('@modelcontextprotocol/sdk');
const OpenAI = require('openai');

class AIWorkflowServer extends Server {
  constructor() {
    super('ai-workflow-server');
    this.openai = new OpenAI({
      apiKey: process.env.OPENAI_API_KEY
    });
  }

  @Tool('generate_motivation_content')
  async generateMotivationContent(context) {
    const { userId, currentMood, recentActivity } = context;
    
    const prompt = `Generate personalized motivation for someone quitting vaping:
    - User mood: ${currentMood}
    - Recent activity: ${JSON.stringify(recentActivity)}
    - Keep it encouraging and specific to their situation`;

    try {
      const response = await this.openai.chat.completions.create({
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 150
      });

      return {
        success: true,
        data: {
          content: response.choices[0].message.content,
          personalized: true,
          mood_responsive: true
        }
      };
    } catch (error) {
      return {
        success: false,
        error: error.message,
        fallback_content: "You're doing great! Every day without vaping is a victory."
      };
    }
  }
}

const server = new AIWorkflowServer();
server.listen(8002);
```

## **Option 3: Docker-Based MCP Servers**

### **A. Docker Compose Setup**
```yaml
# docker-compose.yml
version: '3.8'
services:
  health-server:
    build: ./servers/health
    ports:
      - "8001:8001"
    environment:
      - SERVER_NAME=health-data-server
      
  ai-server:
    build: ./servers/ai
    ports:
      - "8002:8002"
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - SERVER_NAME=ai-workflow-server
      
  analytics-server:
    build: ./servers/analytics
    ports:
      - "8003:8003"
    environment:
      - SERVER_NAME=analytics-server
      
  external-services:
    build: ./servers/external
    ports:
      - "8004:8004"
    environment:
      - WEATHER_API_KEY=${WEATHER_API_KEY}
      - SERVER_NAME=external-services-server
```

### **B. Dockerfile Template**
```dockerfile
# Dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
EXPOSE 8001

CMD ["python", "server.py"]
```

## **Option 4: Cloud-Hosted MCP Servers**

### **A. Deploy to Railway**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Deploy health server
railway login
railway new health-mcp-server
railway add
railway deploy

# Your server will be available at: https://your-app.railway.app
```

### **B. Deploy to Vercel (Serverless)**
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy AI server
vercel --prod

# Configure environment variables
vercel env add OPENAI_API_KEY
```

### **C. Deploy to Heroku**
```bash
# Install Heroku CLI
# Create Procfile
echo "web: python server.py" > Procfile

# Deploy
heroku create your-mcp-server
git push heroku main
heroku config:set OPENAI_API_KEY=your_key
```

## **Option 5: Local Development Servers**

### **A. Quick Python Server**
```python
# quick_mcp_server.py
from flask import Flask, jsonify, request
from flask_cors import CORS
import json
import random

app = Flask(__name__)
CORS(app)

@app.route('/health/recovery-timeline', methods=['POST'])
def health_timeline():
    data = request.json
    user_id = data.get('userId', 'unknown')
    
    return jsonify({
        "id": f"health-{random.randint(1000, 9999)}",
        "serverId": "health-data-server",
        "responseType": "health",
        "data": {
            "timeline": [
                {"time": "20 minutes", "benefit": "Heart rate normalizes"},
                {"time": "12 hours", "benefit": "Carbon monoxide clears"},
                {"time": "2 weeks", "benefit": "Circulation improves"}
            ],
            "personalized_message": f"Great progress, {user_id}!"
        }
    })

@app.route('/ai/motivation', methods=['POST'])
def generate_motivation():
    data = request.json
    mood = data.get('currentMood', 'neutral')
    
    motivations = {
        'struggling': "Remember why you started. Every craving you resist makes you stronger!",
        'motivated': "You're crushing it! Keep up the amazing momentum!",
        'neutral': "One day at a time. You've got this!"
    }
    
    return jsonify({
        "id": f"ai-{random.randint(1000, 9999)}",
        "serverId": "ai-workflow-server", 
        "responseType": "motivation",
        "data": {
            "content": motivations.get(mood, motivations['neutral']),
            "personalized": True
        }
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
```

### **B. Run Local Server**
```bash
# Install dependencies
pip install flask flask-cors

# Run server
python quick_mcp_server.py

# Server available at: http://localhost:8000
```

## **Option 6: Update Flutter App Configuration**

### **A. Update MCP Client URLs**
```dart
// lib/data/services/mcp_client_service.dart
class MCPClientService {
  static const Map<String, String> _serverUrls = {
    'health-data-server': 'http://localhost:8001',      // or your deployed URL
    'ai-workflow-server': 'http://localhost:8002',      // or your deployed URL  
    'external-services-server': 'http://localhost:8003', // or your deployed URL
    'analytics-server': 'http://localhost:8004',        // or your deployed URL
  };
  
  // Update connection logic to use real URLs instead of simulation
}
```

### **B. Environment Configuration**
```dart
// lib/config/mcp_config.dart
class MCPConfig {
  static const bool useSimulation = false; // Set to false for real servers
  
  static const Map<String, String> serverUrls = {
    'health-data-server': String.fromEnvironment('HEALTH_SERVER_URL', 
        defaultValue: 'http://localhost:8001'),
    'ai-workflow-server': String.fromEnvironment('AI_SERVER_URL',
        defaultValue: 'http://localhost:8002'),
  };
}
```

## **🚀 Quick Start Recommendation**

**For immediate testing:**
1. Use **Option 5A** (Quick Python Server) - Takes 5 minutes to set up
2. Run the server: `python quick_mcp_server.py`
3. Update your Flutter app to use `http://localhost:8000`
4. Test the performance optimizations with real server responses

**For production:**
1. Use **Option 3** (Docker) for scalability
2. Deploy to **Option 4A** (Railway) for easy cloud hosting
3. Integrate with real APIs (OpenAI, health databases, weather services)

## **📊 Testing Your Setup**

```bash
# Test health endpoint
curl -X POST http://localhost:8000/health/recovery-timeline \
  -H "Content-Type: application/json" \
  -d '{"userId": "test-user"}'

# Test AI endpoint  
curl -X POST http://localhost:8000/ai/motivation \
  -H "Content-Type: application/json" \
  -d '{"currentMood": "motivated", "userId": "test-user"}'
```

Choose the option that best fits your needs and technical setup!