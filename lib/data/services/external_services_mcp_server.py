#!/usr/bin/env python3
"""
External Services MCP Server for QuitVaping App
Handles weather, location, and other external API integrations for craving intervention
"""

import asyncio
import json
import logging
import os
from datetime import datetime
from typing import Any, Dict, List, Optional

import httpx
from mcp.server import Server
from mcp.server.models import InitializationOptions
from mcp.server.stdio import stdio_server
from mcp.types import (
    CallToolRequest,
    CallToolResult,
    ListToolsRequest,
    ListToolsResult,
    Tool,
    TextContent,
)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class ExternalServicesServer:
    def __init__(self):
        self.server = Server("external-services")
        self.http_client = httpx.AsyncClient(timeout=30.0)
        
        # API keys (should be set via environment variables)
        self.weather_api_key = os.getenv("OPENWEATHER_API_KEY")
        self.location_api_key = os.getenv("LOCATION_API_KEY")
        
        self._setup_handlers()
    
    def _setup_handlers(self):
        @self.server.list_tools()
        async def list_tools(request: ListToolsRequest) -> ListToolsResult:
            return ListToolsResult(
                tools=[
                    Tool(
                        name="get_weather",
                        description="Get current weather data for location-based craving triggers",
                        inputSchema={
                            "type": "object",
                            "properties": {
                                "location": {
                                    "type": "string",
                                    "description": "Location (city name, coordinates, or 'current' for user location)"
                                },
                                "include_forecast": {
                                    "type": "boolean",
                                    "description": "Whether to include weather forecast",
                                    "default": False
                                }
                            },
                            "required": ["location"]
                        }
                    ),
                    Tool(
                        name="get_location_context",
                        description="Get location-based context for craving triggers",
                        inputSchema={
                            "type": "object",
                            "properties": {
                                "latitude": {"type": "number"},
                                "longitude": {"type": "number"},
                                "include_nearby_places": {
                                    "type": "boolean",
                                    "description": "Include nearby places that might be triggers",
                                    "default": True
                                }
                            },
                            "required": ["latitude", "longitude"]
                        }
                    ),
                    Tool(
                        name="analyze_external_triggers",
                        description="Analyze external factors that might trigger cravings",
                        inputSchema={
                            "type": "object",
                            "properties": {
                                "user_location": {
                                    "type": "object",
                                    "properties": {
                                        "latitude": {"type": "number"},
                                        "longitude": {"type": "number"}
                                    }
                                },
                                "time_of_day": {"type": "integer"},
                                "day_of_week": {"type": "integer"},
                                "user_triggers": {
                                    "type": "array",
                                    "items": {"type": "string"}
                                }
                            },
                            "required": ["time_of_day", "day_of_week"]
                        }
                    ),
                    Tool(
                        name="get_air_quality",
                        description="Get air quality data to show health benefits of quitting",
                        inputSchema={
                            "type": "object",
                            "properties": {
                                "location": {
                                    "type": "string",
                                    "description": "Location for air quality data"
                                }
                            },
                            "required": ["location"]
                        }
                    )
                ]
            )
        
        @self.server.call_tool()
        async def call_tool(request: CallToolRequest) -> CallToolResult:
            try:
                if request.name == "get_weather":
                    result = await self._get_weather(request.arguments)
                elif request.name == "get_location_context":
                    result = await self._get_location_context(request.arguments)
                elif request.name == "analyze_external_triggers":
                    result = await self._analyze_external_triggers(request.arguments)
                elif request.name == "get_air_quality":
                    result = await self._get_air_quality(request.arguments)
                else:
                    raise ValueError(f"Unknown tool: {request.name}")
                
                return CallToolResult(
                    content=[TextContent(type="text", text=json.dumps(result, indent=2))]
                )
            
            except Exception as e:
                logger.error(f"Error in {request.name}: {str(e)}")
                return CallToolResult(
                    content=[TextContent(type="text", text=json.dumps({
                        "error": str(e),
                        "tool": request.name
                    }))]
                )
    
    async def _get_weather(self, args: Dict[str, Any]) -> Dict[str, Any]:
        """Get current weather data"""
        location = args.get("location", "current")
        include_forecast = args.get("include_forecast", False)
        
        if not self.weather_api_key:
            return self._get_mock_weather_data(location, include_forecast)
        
        try:
            # Use OpenWeatherMap API
            if location == "current":
                # For demo purposes, use a default location
                location = "London,UK"
            
            url = f"http://api.openweathermap.org/data/2.5/weather"
            params = {
                "q": location,
                "appid": self.weather_api_key,
                "units": "metric"
            }
            
            response = await self.http_client.get(url, params=params)
            response.raise_for_status()
            weather_data = response.json()
            
            result = {
                "current": {
                    "location": weather_data["name"],
                    "temperature": weather_data["main"]["temp"],
                    "condition": weather_data["weather"][0]["description"],
                    "humidity": weather_data["main"]["humidity"],
                    "pressure": weather_data["main"]["pressure"],
                    "wind_speed": weather_data.get("wind", {}).get("speed", 0),
                    "timestamp": datetime.now().isoformat()
                }
            }
            
            if include_forecast:
                # Get forecast data
                forecast_url = f"http://api.openweathermap.org/data/2.5/forecast"
                forecast_response = await self.http_client.get(forecast_url, params=params)
                if forecast_response.status_code == 200:
                    forecast_data = forecast_response.json()
                    result["forecast"] = forecast_data["list"][:8]  # Next 24 hours
            
            return result
            
        except Exception as e:
            logger.error(f"Error fetching weather data: {e}")
            return self._get_mock_weather_data(location, include_forecast)
    
    def _get_mock_weather_data(self, location: str, include_forecast: bool) -> Dict[str, Any]:
        """Return mock weather data for testing"""
        result = {
            "current": {
                "location": location if location != "current" else "Demo Location",
                "temperature": 18.5,
                "condition": "partly cloudy",
                "humidity": 65,
                "pressure": 1013,
                "wind_speed": 3.2,
                "timestamp": datetime.now().isoformat()
            }
        }
        
        if include_forecast:
            result["forecast"] = [
                {
                    "dt_txt": (datetime.now()).isoformat(),
                    "main": {"temp": 19.0},
                    "weather": [{"description": "clear sky"}]
                }
            ] * 8
        
        return result
    
    async def _get_location_context(self, args: Dict[str, Any]) -> Dict[str, Any]:
        """Get location-based context"""
        latitude = args.get("latitude")
        longitude = args.get("longitude")
        include_nearby_places = args.get("include_nearby_places", True)
        
        # For demo purposes, return mock data
        # In production, this would use Google Places API or similar
        result = {
            "coordinates": {
                "latitude": latitude,
                "longitude": longitude
            },
            "area_type": "urban",  # urban, suburban, rural
            "population_density": "medium",
            "timestamp": datetime.now().isoformat()
        }
        
        if include_nearby_places:
            result["nearby_places"] = [
                {
                    "name": "Coffee Shop",
                    "type": "cafe",
                    "distance": 0.2,
                    "potential_trigger": True,
                    "reason": "Social smoking area"
                },
                {
                    "name": "Park",
                    "type": "recreation",
                    "distance": 0.5,
                    "potential_trigger": False,
                    "reason": "Good for breathing exercises"
                }
            ]
        
        return result
    
    async def _analyze_external_triggers(self, args: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze external factors for craving triggers"""
        time_of_day = args.get("time_of_day")
        day_of_week = args.get("day_of_week")
        user_location = args.get("user_location")
        user_triggers = args.get("user_triggers", [])
        
        # Get weather data if location is provided
        weather_risk = 0.0
        if user_location:
            weather_data = await self._get_weather({
                "location": f"{user_location['latitude']},{user_location['longitude']}"
            })
            
            # Analyze weather-based triggers
            current_weather = weather_data.get("current", {})
            condition = current_weather.get("condition", "").lower()
            temperature = current_weather.get("temperature", 20)
            
            if "rain" in condition or "cloud" in condition:
                weather_risk += 0.2
            if temperature < 5 or temperature > 30:
                weather_risk += 0.1
        
        # Time-based risk analysis
        time_risk = 0.0
        high_risk_hours = [9, 12, 15, 18, 21]  # Common break times
        if time_of_day in high_risk_hours:
            time_risk += 0.3
        
        # Weekend vs weekday
        day_risk = 0.0
        if day_of_week in [6, 7]:  # Weekend
            day_risk += 0.1
        
        # User-specific trigger analysis
        trigger_risk = 0.0
        high_risk_triggers = ["stress", "alcohol", "social", "boredom"]
        for trigger in user_triggers:
            if trigger.lower() in high_risk_triggers:
                trigger_risk += 0.2
        
        total_risk = min(weather_risk + time_risk + day_risk + trigger_risk, 1.0)
        
        return {
            "overall_risk_score": total_risk,
            "risk_factors": {
                "weather": weather_risk,
                "time_of_day": time_risk,
                "day_of_week": day_risk,
                "personal_triggers": trigger_risk
            },
            "recommendations": self._get_risk_recommendations(total_risk),
            "timestamp": datetime.now().isoformat()
        }
    
    def _get_risk_recommendations(self, risk_score: float) -> List[str]:
        """Get recommendations based on risk score"""
        if risk_score < 0.3:
            return [
                "Risk level is low. Continue with your regular routine.",
                "Consider doing a quick check-in with yourself."
            ]
        elif risk_score < 0.6:
            return [
                "Moderate risk detected. Be mindful of your triggers.",
                "Consider doing a breathing exercise.",
                "Have a healthy distraction ready."
            ]
        else:
            return [
                "High risk situation detected. Take proactive steps.",
                "Use breathing exercises or call a support person.",
                "Avoid known trigger locations if possible.",
                "Remember your reasons for quitting."
            ]
    
    async def _get_air_quality(self, args: Dict[str, Any]) -> Dict[str, Any]:
        """Get air quality data"""
        location = args.get("location")
        
        # Mock air quality data for demo
        # In production, would use EPA API or similar
        return {
            "location": location,
            "aqi": 45,  # Air Quality Index
            "quality": "Good",
            "pm25": 12.5,
            "pm10": 18.2,
            "health_message": "Air quality is good. Your lungs are benefiting from not vaping!",
            "comparison": {
                "vaping_equivalent": "Not vaping is like breathing clean air vs. 50+ AQI",
                "improvement_message": "Every day without vaping improves your lung health"
            },
            "timestamp": datetime.now().isoformat()
        }
    
    async def run(self):
        """Run the MCP server"""
        async with stdio_server() as (read_stream, write_stream):
            await self.server.run(
                read_stream,
                write_stream,
                InitializationOptions(
                    server_name="external-services",
                    server_version="1.0.0",
                    capabilities=self.server.get_capabilities(
                        notification_options=None,
                        experimental_capabilities=None,
                    ),
                ),
            )

async def main():
    """Main entry point"""
    server = ExternalServicesServer()
    await server.run()

if __name__ == "__main__":
    asyncio.run(main())