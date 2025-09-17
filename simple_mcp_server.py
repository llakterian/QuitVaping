#!/usr/bin/env python3
"""
Simple MCP Server for QuitVaping App - No External Dependencies
Uses only Python standard library (http.server, json, urllib)
"""

import json
import random
import time
from datetime import datetime, timedelta
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import threading

class MCPHandler(BaseHTTPRequestHandler):
    def do_OPTIONS(self):
        """Handle CORS preflight requests"""
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()

    def do_GET(self):
        """Handle GET requests"""
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        
        response = {
            "status": "healthy",
            "server": "QuitVaping MCP Test Server",
            "version": "1.0.0",
            "message": "MCP Server is running! Use POST requests to test endpoints.",
            "endpoints": [
                "POST /health/recovery-timeline",
                "POST /ai/motivation",
                "POST /analytics/patterns",
                "POST /external/weather"
            ]
        }
        
        self.wfile.write(json.dumps(response, indent=2).encode())

    def do_POST(self):
        """Handle POST requests"""
        # Add simulated latency
        time.sleep(0.1 + random.uniform(0.05, 0.1))
        
        # Parse the request
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length)
        
        try:
            request_data = json.loads(post_data.decode()) if post_data else {}
        except:
            request_data = {}
        
        # Route the request
        path = self.path
        response_data = None
        
        if path == '/health/recovery-timeline':
            response_data = self.handle_health_timeline(request_data)
        elif path == '/ai/motivation':
            response_data = self.handle_ai_motivation(request_data)
        elif path == '/analytics/patterns':
            response_data = self.handle_analytics(request_data)
        elif path == '/external/weather':
            response_data = self.handle_weather(request_data)
        else:
            response_data = {"error": f"Unknown endpoint: {path}"}
        
        # Send response
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        self.wfile.write(json.dumps(response_data).encode())

    def handle_health_timeline(self, data):
        """Handle health recovery timeline requests"""
        user_id = data.get('userId', f'user-{random.randint(1000, 9999)}')
        days_quit = random.randint(1, 100)
        
        return {
            "id": f"health-{random.randint(1000, 9999)}",
            "serverId": "health-data-server",
            "responseType": "health",
            "data": {
                "user_id": user_id,
                "days_quit": days_quit,
                "health_improvements": [
                    {
                        "milestone": "20 minutes",
                        "improvement": "Heart rate and blood pressure drop",
                        "achieved": True
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
                    }
                ],
                "personalized_message": f"Amazing progress! You've been vape-free for {days_quit} days.",
                "health_score": min(100, days_quit * 2),
                "money_saved": days_quit * 8.50
            },
            "timestamp": datetime.now().isoformat(),
            "confidence": 0.95
        }

    def handle_ai_motivation(self, data):
        """Handle AI motivation requests"""
        mood = data.get('currentMood', 'neutral')
        
        motivations = {
            'struggling': [
                "Every craving you resist is a victory. You're stronger than you think! 💪",
                "Remember: this feeling is temporary, but your health improvements are permanent.",
                "You've overcome cravings before - you can do it again. One breath at a time."
            ],
            'motivated': [
                "You're absolutely crushing it! This momentum is incredible! 🚀",
                "Look at you go! Your determination is inspiring and your progress is real.",
                "You're not just quitting vaping - you're choosing a healthier, happier life!"
            ],
            'neutral': [
                "Steady progress is still progress. You're doing great! 🌟",
                "One day at a time, one choice at a time. You've got this.",
                "Your commitment to your health is admirable. Keep up the good work!"
            ]
        }
        
        selected_motivation = random.choice(motivations.get(mood, motivations['neutral']))
        
        return {
            "id": f"ai-{random.randint(1000, 9999)}",
            "serverId": "ai-workflow-server",
            "responseType": "motivation",
            "data": {
                "content": selected_motivation,
                "personalized": True,
                "mood_responsive": True,
                "confidence_score": random.uniform(0.85, 0.98)
            },
            "timestamp": datetime.now().isoformat()
        }

    def handle_analytics(self, data):
        """Handle analytics requests"""
        patterns = [
            {
                "pattern_type": "craving_trigger",
                "description": "Cravings tend to be stronger in the evening",
                "confidence": 0.87,
                "recommendation": "Plan evening activities to stay distracted"
            },
            {
                "pattern_type": "success_factor",
                "description": "Morning workouts correlate with better craving control",
                "confidence": 0.92,
                "recommendation": "Continue your morning exercise routine"
            }
        ]
        
        return {
            "id": f"analytics-{random.randint(1000, 9999)}",
            "serverId": "analytics-server",
            "responseType": "analytics",
            "data": {
                "patterns_identified": len(patterns),
                "patterns": patterns,
                "analysis_date": datetime.now().isoformat()
            },
            "timestamp": datetime.now().isoformat()
        }

    def handle_weather(self, data):
        """Handle weather requests"""
        weather_conditions = ['sunny', 'cloudy', 'rainy', 'partly_cloudy']
        current_weather = random.choice(weather_conditions)
        
        return {
            "id": f"weather-{random.randint(1000, 9999)}",
            "serverId": "external-services-server",
            "responseType": "external_data",
            "data": {
                "weather": current_weather,
                "temperature": random.randint(15, 30),
                "recommendation": "Great weather for a walk instead of vaping!" if current_weather == 'sunny' else "Stay cozy and vape-free indoors!"
            },
            "timestamp": datetime.now().isoformat()
        }

    def log_message(self, format, *args):
        """Override to reduce log noise"""
        pass

def run_server():
    """Run the MCP server"""
    server_address = ('', 8000)
    httpd = HTTPServer(server_address, MCPHandler)
    
    print("🚀 QuitVaping MCP Test Server Starting")
    print("=" * 50)
    print(f"Server running at: http://localhost:8000")
    print("Health check: http://localhost:8000/")
    print("")
    print("Available endpoints:")
    print("  POST http://localhost:8000/health/recovery-timeline")
    print("  POST http://localhost:8000/ai/motivation")
    print("  POST http://localhost:8000/analytics/patterns")
    print("  POST http://localhost:8000/external/weather")
    print("")
    print("💡 No external dependencies required!")
    print("   Uses only Python standard library")
    print("=" * 50)
    print("")
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n🛑 Server stopped by user")
        httpd.shutdown()

if __name__ == '__main__':
    run_server()