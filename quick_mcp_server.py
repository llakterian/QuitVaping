#!/usr/bin/env python3
"""
Quick MCP Server for Testing QuitVaping App Performance Optimizations
Run with: python quick_mcp_server.py
"""

from flask import Flask, jsonify, request
from flask_cors import CORS
import json
import random
import time
from datetime import datetime, timedelta

app = Flask(__name__)
CORS(app)

# Simulate some latency for testing performance optimizations
SIMULATE_LATENCY = True
BASE_LATENCY = 0.1  # 100ms base latency

def add_latency():
    if SIMULATE_LATENCY:
        # Add random latency between 50-200ms to simulate real server
        latency = BASE_LATENCY + random.uniform(0.05, 0.1)
        time.sleep(latency)

@app.route('/', methods=['GET'])
def health_check():
    return jsonify({
        "status": "healthy",
        "server": "QuitVaping MCP Test Server",
        "version": "1.0.0",
        "endpoints": [
            "/health/recovery-timeline",
            "/ai/motivation", 
            "/analytics/patterns",
            "/external/weather"
        ]
    })

@app.route('/health/recovery-timeline', methods=['POST'])
def health_timeline():
    add_latency()
    
    data = request.json or {}
    user_id = data.get('userId', f'user-{random.randint(1000, 9999)}')
    
    # Simulate personalized health timeline
    days_quit = random.randint(1, 100)
    
    timeline_data = {
        "user_id": user_id,
        "days_quit": days_quit,
        "health_improvements": [
            {
                "milestone": "20 minutes",
                "improvement": "Heart rate and blood pressure drop",
                "achieved": True,
                "achievement_date": (datetime.now() - timedelta(days=days_quit)).isoformat()
            },
            {
                "milestone": "12 hours",
                "improvement": "Carbon monoxide levels normalize", 
                "achieved": days_quit >= 1,
                "achievement_date": (datetime.now() - timedelta(days=max(0, days_quit-1))).isoformat() if days_quit >= 1 else None
            },
            {
                "milestone": "2 weeks",
                "improvement": "Circulation improves, lung function increases",
                "achieved": days_quit >= 14,
                "achievement_date": (datetime.now() - timedelta(days=max(0, days_quit-14))).isoformat() if days_quit >= 14 else None
            },
            {
                "milestone": "1 month",
                "improvement": "Coughing and shortness of breath decrease",
                "achieved": days_quit >= 30,
                "achievement_date": (datetime.now() - timedelta(days=max(0, days_quit-30))).isoformat() if days_quit >= 30 else None
            }
        ],
        "next_milestone": "3 months - Significant lung function improvement",
        "personalized_message": f"Amazing progress! You've been vape-free for {days_quit} days. Your body is healing!",
        "health_score": min(100, days_quit * 2),
        "money_saved": days_quit * 8.50  # Assuming $8.50 per day saved
    }
    
    return jsonify({
        "id": f"health-{random.randint(1000, 9999)}",
        "serverId": "health-data-server",
        "responseType": "health",
        "data": timeline_data,
        "timestamp": datetime.now().isoformat(),
        "confidence": 0.95
    })

@app.route('/ai/motivation', methods=['POST'])
def generate_motivation():
    add_latency()
    
    data = request.json or {}
    user_id = data.get('userId', 'anonymous')
    mood = data.get('currentMood', 'neutral')
    recent_activity = data.get('recentActivity', [])
    external_factors = data.get('externalFactors', {})
    
    # Mood-based motivational content
    motivations = {
        'struggling': [
            "Every craving you resist is a victory. You're stronger than you think! 💪",
            "Remember: this feeling is temporary, but your health improvements are permanent.",
            "You've overcome cravings before - you can do it again. One breath at a time.",
            "Your future self will thank you for not giving up today. Keep going!"
        ],
        'motivated': [
            "You're absolutely crushing it! This momentum is incredible! 🚀",
            "Look at you go! Your determination is inspiring and your progress is real.",
            "You're not just quitting vaping - you're choosing a healthier, happier life!",
            "This energy you have right now? Bottle it up for the tough days ahead!"
        ],
        'neutral': [
            "Steady progress is still progress. You're doing great! 🌟",
            "One day at a time, one choice at a time. You've got this.",
            "Your commitment to your health is admirable. Keep up the good work!",
            "Every day without vaping is an investment in your future self."
        ],
        'anxious': [
            "Breathe deeply. This anxiety will pass, but your progress is permanent.",
            "It's okay to feel anxious - it means you're breaking free from addiction.",
            "Try some deep breathing or a quick walk. You're stronger than this feeling.",
            "Anxiety is temporary, but the pride you'll feel for staying strong lasts forever."
        ]
    }
    
    # Select appropriate motivation
    mood_motivations = motivations.get(mood, motivations['neutral'])
    selected_motivation = random.choice(mood_motivations)
    
    # Add contextual elements based on external factors
    time_of_day = external_factors.get('timeOfDay', 'unknown')
    weather = external_factors.get('weather', 'unknown')
    
    contextual_additions = []
    if time_of_day == 'morning':
        contextual_additions.append("Start your day strong!")
    elif time_of_day == 'evening':
        contextual_additions.append("End your day with pride!")
    
    if weather == 'sunny':
        contextual_additions.append("Beautiful day to celebrate your progress!")
    elif weather == 'rainy':
        contextual_additions.append("Even on cloudy days, your determination shines!")
    
    # Combine motivation with context
    full_content = selected_motivation
    if contextual_additions:
        full_content += " " + " ".join(contextual_additions)
    
    return jsonify({
        "id": f"ai-{random.randint(1000, 9999)}",
        "serverId": "ai-workflow-server",
        "responseType": "motivation", 
        "data": {
            "content": full_content,
            "personalized": True,
            "mood_responsive": True,
            "context_aware": len(contextual_additions) > 0,
            "confidence_score": random.uniform(0.85, 0.98)
        },
        "timestamp": datetime.now().isoformat()
    })

@app.route('/analytics/patterns', methods=['POST'])
def analyze_patterns():
    add_latency()
    
    data = request.json or {}
    user_id = data.get('userId', 'anonymous')
    
    # Simulate pattern analysis
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
        },
        {
            "pattern_type": "risk_period",
            "description": "Weekends show higher relapse risk",
            "confidence": 0.78,
            "recommendation": "Schedule engaging weekend activities"
        }
    ]
    
    return jsonify({
        "id": f"analytics-{random.randint(1000, 9999)}",
        "serverId": "analytics-server",
        "responseType": "analytics",
        "data": {
            "user_id": user_id,
            "patterns_identified": len(patterns),
            "patterns": patterns,
            "analysis_date": datetime.now().isoformat(),
            "next_analysis": (datetime.now() + timedelta(days=7)).isoformat()
        },
        "timestamp": datetime.now().isoformat()
    })

@app.route('/external/weather', methods=['POST'])
def get_weather_context():
    add_latency()
    
    data = request.json or {}
    location = data.get('location', 'Unknown')
    
    # Simulate weather data
    weather_conditions = ['sunny', 'cloudy', 'rainy', 'partly_cloudy', 'clear']
    current_weather = random.choice(weather_conditions)
    
    return jsonify({
        "id": f"weather-{random.randint(1000, 9999)}",
        "serverId": "external-services-server",
        "responseType": "external_data",
        "data": {
            "location": location,
            "weather": current_weather,
            "temperature": random.randint(15, 30),
            "humidity": random.randint(30, 80),
            "recommendation": "Great weather for a walk instead of vaping!" if current_weather == 'sunny' else "Stay cozy and vape-free indoors!"
        },
        "timestamp": datetime.now().isoformat()
    })

@app.route('/test/batch', methods=['POST'])
def test_batch_requests():
    """Endpoint for testing batch request performance"""
    add_latency()
    
    data = request.json or {}
    batch_size = data.get('batch_size', 1)
    request_type = data.get('request_type', 'test')
    
    # Simulate processing multiple requests
    results = []
    for i in range(batch_size):
        results.append({
            "request_id": f"{request_type}-{i}",
            "processed_at": datetime.now().isoformat(),
            "result": f"Batch request {i+1} of {batch_size} completed"
        })
    
    return jsonify({
        "id": f"batch-{random.randint(1000, 9999)}",
        "serverId": "test-server",
        "responseType": "batch_test",
        "data": {
            "batch_size": batch_size,
            "results": results,
            "processing_time_ms": int((BASE_LATENCY + random.uniform(0.05, 0.1)) * 1000)
        },
        "timestamp": datetime.now().isoformat()
    })

if __name__ == '__main__':
    print("🚀 Starting QuitVaping MCP Test Server")
    print("=" * 50)
    print("Server will be available at: http://localhost:8000")
    print("Health check: http://localhost:8000/")
    print("")
    print("Available endpoints:")
    print("  POST /health/recovery-timeline")
    print("  POST /ai/motivation")
    print("  POST /analytics/patterns") 
    print("  POST /external/weather")
    print("  POST /test/batch")
    print("")
    print("💡 This server simulates real MCP responses with latency")
    print("   Perfect for testing your performance optimizations!")
    print("=" * 50)
    
    app.run(host='0.0.0.0', port=8000, debug=True)