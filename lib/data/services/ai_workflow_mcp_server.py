#!/usr/bin/env python3
"""
AI Workflow MCP Server for QuitVaping App
Provides AI-powered motivation, mood analysis, and intervention planning using Postman AI Agent Builder
"""

import asyncio
import json
import logging
import os
import random
from datetime import datetime, timedelta
from typing import Any, Dict, List, Optional

import httpx
from mcp.server import Server
from mcp.server.models import InitializationOptions
from mcp.server.stdio import stdio_server
from mcp.types import (
    Resource,
    Tool,
    TextContent,
    ImageContent,
    EmbeddedResource,
)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Server configuration
server = Server("ai-workflow-server")

# API Configuration
POSTMAN_AI_AGENT_API_KEY = os.getenv("POSTMAN_AI_AGENT_API_KEY")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# AI Agent endpoints (simulated - replace with actual Postman AI Agent Builder endpoints)
AI_AGENT_BASE_URL = "https://api.postman.com/ai-agents/v1"

class AIWorkflowManager:
    """Manages AI workflows for motivation and intervention"""
    
    def __init__(self):
        self.client = httpx.AsyncClient(timeout=30.0)
        self.motivation_templates = self._load_motivation_templates()
        self.intervention_strategies = self._load_intervention_strategies()
    
    def _load_motivation_templates(self) -> Dict[str, List[str]]:
        """Load motivation templates based on mood and context"""
        return {
            "positive": [
                "You're doing amazing! {days_quit} days smoke-free is a huge accomplishment.",
                "Your body is healing every day. Keep up the fantastic work!",
                "You've saved ${money_saved} by not vaping. That's incredible progress!",
                "Every craving you resist makes you stronger. You've got this!",
            ],
            "neutral": [
                "Take it one day at a time. You're making steady progress.",
                "Remember why you started this journey. Your health is worth it.",
                "Each day without vaping is a victory. Celebrate the small wins.",
                "You're building new, healthier habits. Stay consistent.",
            ],
            "negative": [
                "It's okay to have tough days. This feeling will pass.",
                "You've overcome cravings before, and you can do it again.",
                "Reach out for support when you need it. You're not alone.",
                "Focus on your breathing. Take deep, calming breaths.",
            ],
            "anxious": [
                "Anxiety is temporary, but your health improvements are permanent.",
                "Try the 4-7-8 breathing technique: inhale for 4, hold for 7, exhale for 8.",
                "Ground yourself: name 5 things you can see, 4 you can touch, 3 you can hear.",
                "This anxious feeling will pass. You're stronger than your cravings.",
            ],
            "motivated": [
                "Channel this motivation into healthy activities!",
                "You're in a great headspace. Use this energy to plan your success.",
                "Your determination is inspiring. Keep pushing forward!",
                "This is the perfect time to set new health goals.",
            ],
            "struggling": [
                "You're not alone in this struggle. Reach out for support.",
                "Every moment you don't vape is a victory, no matter how small.",
                "Call a friend, go for a walk, or try a breathing exercise.",
                "This is temporary. You have the strength to get through this.",
            ],
        }
    
    def _load_intervention_strategies(self) -> Dict[str, Dict[str, Any]]:
        """Load intervention strategies for different situations"""
        return {
            "breathing": {
                "name": "Deep Breathing Exercise",
                "description": "Calm your mind and reduce cravings with focused breathing",
                "steps": [
                    "Find a comfortable position",
                    "Inhale slowly through your nose for 4 counts",
                    "Hold your breath for 7 counts",
                    "Exhale through your mouth for 8 counts",
                    "Repeat 4-6 times"
                ],
                "duration": 5,
                "effectiveness": 0.8
            },
            "distraction": {
                "name": "5-Minute Distraction",
                "description": "Redirect your attention away from cravings",
                "activities": [
                    "Call a friend or family member",
                    "Do 20 jumping jacks or push-ups",
                    "Listen to your favorite song",
                    "Play a quick mobile game",
                    "Write in your journal",
                    "Take a short walk outside"
                ],
                "duration": 5,
                "effectiveness": 0.7
            },
            "motivation": {
                "name": "Motivation Boost",
                "description": "Remember your reasons for quitting",
                "prompts": [
                    "Why did you decide to quit vaping?",
                    "How do you want to feel in 6 months?",
                    "What will you do with the money you save?",
                    "Who are you doing this for?"
                ],
                "duration": 3,
                "effectiveness": 0.75
            }
        }
    
    async def generate_motivation_content(self, context: Dict[str, Any]) -> Dict[str, Any]:
        """Generate personalized motivational content using AI"""
        try:
            mood = context.get("mood", "neutral")
            user_id = context.get("userId")
            recent_activity = context.get("recentActivity", [])
            external_factors = context.get("externalFactors", {})
            
            # Analyze context for personalization
            personalization_data = await self._analyze_context(context)
            
            # Select appropriate template based on mood
            templates = self.motivation_templates.get(mood, self.motivation_templates["neutral"])
            base_message = random.choice(templates)
            
            # Personalize the message
            personalized_content = await self._personalize_content(
                base_message, 
                personalization_data,
                external_factors
            )
            
            # Generate additional insights
            insights = await self._generate_insights(context)
            
            return {
                "content": {
                    "id": f"motivation_{datetime.now().isoformat()}",
                    "timestamp": datetime.now().isoformat(),
                    "type": "mood_based",
                    "title": f"Motivation for {mood.title()} Mood",
                    "content": personalized_content,
                    "tags": [mood, "ai_generated", "personalized"],
                    "relevanceScore": personalization_data.get("relevance_score", 0.8),
                    "metadata": {
                        "mood": mood,
                        "insights": insights,
                        "generated_by": "ai_workflow_server"
                    }
                },
                "learning_update": {
                    "personalized_data": {
                        "last_mood": mood,
                        "content_preferences": personalization_data.get("preferences", {}),
                        "engagement_score": personalization_data.get("engagement_score", 0.5)
                    }
                }
            }
            
        except Exception as e:
            logger.error(f"Error generating motivation content: {e}")
            return {
                "error": f"Failed to generate motivation content: {str(e)}"
            }
    
    async def analyze_mood(self, activity_data: List[Dict[str, Any]]) -> str:
        """Analyze mood from user activity data"""
        try:
            if not activity_data:
                return "neutral"
            
            # Simple mood analysis based on activity patterns
            recent_activities = [a for a in activity_data if self._is_recent(a.get("timestamp"))]
            
            if not recent_activities:
                return "neutral"
            
            # Count different types of activities
            craving_count = len([a for a in recent_activities if a.get("activityType") == "craving_logged"])
            positive_count = len([a for a in recent_activities if a.get("activityType") in ["milestone_reached", "exercise", "meditation"]])
            
            if craving_count > 3:
                return "struggling"
            elif craving_count > 1:
                return "anxious"
            elif positive_count > 2:
                return "motivated"
            elif positive_count > 0:
                return "positive"
            else:
                return "neutral"
                
        except Exception as e:
            logger.error(f"Error analyzing mood: {e}")
            return "neutral"
    
    async def create_intervention_plan(self, context: Dict[str, Any]) -> Dict[str, Any]:
        """Create personalized intervention plan"""
        try:
            mood = context.get("mood", "neutral")
            available_interventions = context.get("availableInterventions", [])
            learning_data = context.get("learningData", {})
            urgency = context.get("urgency", "normal")
            
            # Select interventions based on effectiveness and availability
            selected_interventions = self._select_interventions(
                available_interventions, 
                learning_data, 
                mood, 
                urgency
            )
            
            # Create intervention plan
            plan = {
                "id": f"intervention_{datetime.now().isoformat()}",
                "timestamp": datetime.now().isoformat(),
                "urgency": urgency,
                "mood": mood,
                "interventions": selected_interventions,
                "estimated_duration": sum(i.get("duration", 5) for i in selected_interventions),
                "success_probability": self._calculate_success_probability(selected_interventions, learning_data)
            }
            
            return {
                "intervention_plan": plan,
                "immediate_action": selected_interventions[0] if selected_interventions else None
            }
            
        except Exception as e:
            logger.error(f"Error creating intervention plan: {e}")
            return {
                "error": f"Failed to create intervention plan: {str(e)}"
            }
    
    async def generate_celebration_message(self, user_id: str, milestone: str) -> Dict[str, Any]:
        """Generate personalized celebration message for milestones"""
        try:
            celebration_templates = {
                "20 minutes": "🎉 Amazing! You've been vape-free for 20 minutes! Your body is already starting to recover.",
                "8 hours": "🌟 Incredible! 8 hours without vaping! Your oxygen levels are returning to normal.",
                "24 hours": "🏆 Outstanding! A full day vape-free! Your risk of heart attack is already decreasing.",
                "1 week": "🎊 Phenomenal! One week smoke-free! Your sense of taste and smell are improving.",
                "1 month": "🥇 Extraordinary! One month of freedom! Your circulation is improving significantly.",
                "3 months": "💎 Remarkable! Three months strong! Your lung function is increasing by up to 30%.",
                "1 year": "👑 LEGENDARY! One full year! You've reduced your risk of heart disease by half!"
            }
            
            base_message = celebration_templates.get(milestone, f"🎉 Congratulations on reaching {milestone}!")
            
            # Add personalized elements
            tips = [
                "Keep up the amazing work!",
                "You're an inspiration to others on this journey.",
                "Your body thanks you for this healthy choice.",
                "Every day gets easier from here.",
                "You've proven you have incredible willpower!"
            ]
            
            celebration = {
                "id": f"celebration_{datetime.now().isoformat()}",
                "timestamp": datetime.now().isoformat(),
                "milestone": milestone,
                "title": f"🎉 {milestone} Milestone Reached!",
                "message": f"{base_message}\n\n{random.choice(tips)}",
                "celebrationImageUrl": f"https://api.quitvaping.app/celebrations/{milestone.replace(' ', '_')}.png",
                "shareText": f"I've been vape-free for {milestone}! 💪 #QuitVaping #HealthyChoices"
            }
            
            return {
                "celebration": celebration
            }
            
        except Exception as e:
            logger.error(f"Error generating celebration message: {e}")
            return {
                "error": f"Failed to generate celebration message: {str(e)}"
            }
    
    def _is_recent(self, timestamp_str: str, hours: int = 24) -> bool:
        """Check if timestamp is within recent hours"""
        try:
            timestamp = datetime.fromisoformat(timestamp_str.replace('Z', '+00:00'))
            return datetime.now() - timestamp < timedelta(hours=hours)
        except:
            return False
    
    async def _analyze_context(self, context: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze context for personalization"""
        mood = context.get("mood", "neutral")
        recent_activity = context.get("recentActivity", [])
        external_factors = context.get("externalFactors", {})
        
        # Calculate relevance score based on context
        relevance_score = 0.5
        
        # Adjust based on mood urgency
        if mood in ["struggling", "anxious"]:
            relevance_score += 0.3
        elif mood in ["motivated", "positive"]:
            relevance_score += 0.2
        
        # Adjust based on recent activity
        if len(recent_activity) > 5:
            relevance_score += 0.1
        
        # Adjust based on external factors
        weather = external_factors.get("weather", "").lower()
        if "rain" in weather or "storm" in weather:
            relevance_score += 0.1  # Weather might affect mood
        
        return {
            "relevance_score": min(relevance_score, 1.0),
            "engagement_score": random.uniform(0.6, 0.9),
            "preferences": {
                "tone": "encouraging" if mood in ["struggling", "anxious"] else "celebratory",
                "focus": "health" if mood == "motivated" else "support"
            }
        }
    
    async def _personalize_content(self, base_message: str, personalization_data: Dict[str, Any], external_factors: Dict[str, Any]) -> str:
        """Personalize content based on user data"""
        # Simple personalization - in production, this would use more sophisticated AI
        personalized = base_message
        
        # Add weather-based personalization
        weather = external_factors.get("weather", "").lower()
        time_of_day = external_factors.get("timeOfDay", "")
        
        if "rain" in weather and time_of_day == "evening":
            personalized += "\n\nRainy evenings can be challenging, but you're stronger than any craving."
        elif time_of_day == "morning":
            personalized += "\n\nStart your day with this positive energy!"
        
        return personalized
    
    async def _generate_insights(self, context: Dict[str, Any]) -> List[str]:
        """Generate insights based on context"""
        insights = []
        mood = context.get("mood", "neutral")
        
        if mood == "struggling":
            insights.append("Consider reaching out to your support network")
            insights.append("Try a 5-minute breathing exercise")
        elif mood == "motivated":
            insights.append("Great time to plan your next health goal")
            insights.append("Consider sharing your progress with others")
        
        return insights
    
    def _select_interventions(self, available: List[str], learning_data: Dict[str, Any], mood: str, urgency: str) -> List[Dict[str, Any]]:
        """Select best interventions based on availability and effectiveness"""
        selected = []
        effectiveness_data = learning_data.get("interventionEffectiveness", {})
        
        # Priority order based on mood and urgency
        if urgency == "high" or mood == "struggling":
            priority_order = ["breathing", "distraction", "motivation"]
        else:
            priority_order = ["motivation", "breathing", "distraction"]
        
        for intervention_type in priority_order:
            if intervention_type in available and intervention_type in self.intervention_strategies:
                strategy = self.intervention_strategies[intervention_type].copy()
                
                # Adjust effectiveness based on learning data
                learned_effectiveness = effectiveness_data.get(intervention_type, strategy.get("effectiveness", 0.5))
                strategy["effectiveness"] = learned_effectiveness
                strategy["type"] = intervention_type
                
                selected.append(strategy)
                
                if len(selected) >= 3:  # Limit to 3 interventions
                    break
        
        return selected
    
    def _calculate_success_probability(self, interventions: List[Dict[str, Any]], learning_data: Dict[str, Any]) -> float:
        """Calculate probability of intervention success"""
        if not interventions:
            return 0.0
        
        # Simple calculation based on intervention effectiveness
        total_effectiveness = sum(i.get("effectiveness", 0.5) for i in interventions)
        avg_effectiveness = total_effectiveness / len(interventions)
        
        # Adjust based on user's historical success
        user_success_rate = learning_data.get("personalizedData", {}).get("success_rate", 0.7)
        
        return min((avg_effectiveness + user_success_rate) / 2, 1.0)

# Initialize AI workflow manager
ai_workflow_manager = AIWorkflowManager()

@server.list_tools()
async def handle_list_tools() -> List[Tool]:
    """List available AI workflow tools"""
    return [
        Tool(
            name="generate_motivation_content",
            description="Generate personalized motivational content based on user context",
            inputSchema={
                "type": "object",
                "properties": {
                    "userId": {"type": "string"},
                    "mood": {"type": "string", "enum": ["positive", "neutral", "negative", "anxious", "motivated", "struggling"]},
                    "recentActivity": {"type": "array"},
                    "externalFactors": {"type": "object"},
                },
                "required": ["userId", "mood"]
            }
        ),
        Tool(
            name="analyze_mood",
            description="Analyze user mood from activity data",
            inputSchema={
                "type": "object",
                "properties": {
                    "activityData": {"type": "array"},
                },
                "required": ["activityData"]
            }
        ),
        Tool(
            name="create_intervention_plan",
            description="Create personalized intervention plan for cravings",
            inputSchema={
                "type": "object",
                "properties": {
                    "userId": {"type": "string"},
                    "mood": {"type": "string"},
                    "availableInterventions": {"type": "array"},
                    "learningData": {"type": "object"},
                    "urgency": {"type": "string", "enum": ["normal", "high"]},
                },
                "required": ["userId", "mood"]
            }
        ),
        Tool(
            name="generate_celebration_message",
            description="Generate celebration message for milestones",
            inputSchema={
                "type": "object",
                "properties": {
                    "userId": {"type": "string"},
                    "milestone": {"type": "string"},
                    "personalized": {"type": "boolean"},
                },
                "required": ["userId", "milestone"]
            }
        ),
    ]

@server.call_tool()
async def handle_call_tool(name: str, arguments: Dict[str, Any]) -> List[TextContent]:
    """Handle tool calls"""
    try:
        if name == "generate_motivation_content":
            result = await ai_workflow_manager.generate_motivation_content(arguments)
            return [TextContent(type="text", text=json.dumps(result, indent=2))]
        
        elif name == "analyze_mood":
            mood = await ai_workflow_manager.analyze_mood(arguments.get("activityData", []))
            return [TextContent(type="text", text=json.dumps({"mood": mood}, indent=2))]
        
        elif name == "create_intervention_plan":
            result = await ai_workflow_manager.create_intervention_plan(arguments)
            return [TextContent(type="text", text=json.dumps(result, indent=2))]
        
        elif name == "generate_celebration_message":
            result = await ai_workflow_manager.generate_celebration_message(
                arguments.get("userId", ""),
                arguments.get("milestone", "")
            )
            return [TextContent(type="text", text=json.dumps(result, indent=2))]
        
        else:
            return [TextContent(type="text", text=json.dumps({"error": f"Unknown tool: {name}"}))]
    
    except Exception as e:
        logger.error(f"Error handling tool call {name}: {e}")
        return [TextContent(type="text", text=json.dumps({"error": str(e)}))]

async def main():
    """Run the AI workflow MCP server"""
    async with stdio_server() as (read_stream, write_stream):
        await server.run(
            read_stream,
            write_stream,
            InitializationOptions(
                server_name="ai-workflow-server",
                server_version="1.0.0",
                capabilities=server.get_capabilities(
                    notification_options=None,
                    experimental_capabilities=None,
                ),
            ),
        )

if __name__ == "__main__":
    asyncio.run(main())