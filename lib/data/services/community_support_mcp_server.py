#!/usr/bin/env python3
"""
Community Support MCP Server for QuitVaping App

This MCP server provides community support features including:
- Anonymous peer matching using AI algorithms
- Secure messaging infrastructure
- AI-generated supportive responses
- Milestone sharing and celebration features

Requirements: 3.1, 3.2, 3.3, 3.4
"""

import asyncio
import json
import logging
import os
import uuid
from datetime import datetime, timedelta
from typing import Any, Dict, List, Optional, Tuple

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

# Environment variables
COMMUNITY_API_KEY = os.getenv("COMMUNITY_API_KEY", "")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY", "")
POSTMAN_AI_AGENT_API_KEY = os.getenv("POSTMAN_AI_AGENT_API_KEY", "")
COMMUNITY_DB_URL = os.getenv("COMMUNITY_DB_URL", "https://api.community.quitvaping.com")

# In-memory storage for demo purposes (replace with actual database)
community_members = {}
peer_matches = {}
support_messages = {}
milestone_celebrations = {}
anonymous_sessions = {}
class Comm
unityMember:
    """Represents an anonymous community member"""
    
    def __init__(self, user_id: str, profile: Dict[str, Any]):
        self.anonymous_id = str(uuid.uuid4())
        self.user_id = user_id  # Internal reference, never exposed
        self.quit_stage = profile.get("quit_stage", "beginning")
        self.quit_date = profile.get("quit_date")
        self.support_preferences = profile.get("support_preferences", {})
        self.interests = profile.get("interests", [])
        self.timezone = profile.get("timezone", "UTC")
        self.active_hours = profile.get("active_hours", [])
        self.created_at = datetime.now()
        self.last_active = datetime.now()
        
    def to_dict(self) -> Dict[str, Any]:
        return {
            "anonymous_id": self.anonymous_id,
            "quit_stage": self.quit_stage,
            "quit_date": self.quit_date,
            "support_preferences": self.support_preferences,
            "interests": self.interests,
            "timezone": self.timezone,
            "active_hours": self.active_hours,
            "created_at": self.created_at.isoformat(),
            "last_active": self.last_active.isoformat()
        }

class PeerMatch:
    """Represents a peer matching result"""
    
    def __init__(self, requester_id: str, matched_peers: List[str], match_score: float):
        self.match_id = str(uuid.uuid4())
        self.requester_id = requester_id
        self.matched_peers = matched_peers
        self.match_score = match_score
        self.created_at = datetime.now()
        self.status = "active"
        
    def to_dict(self) -> Dict[str, Any]:
        return {
            "match_id": self.match_id,
            "matched_peers": self.matched_peers,
            "match_score": self.match_score,
            "created_at": self.created_at.isoformat(),
            "status": self.status
        }

class SupportMessage:
    """Represents a supportive message or response"""
    
    def __init__(self, message_type: str, content: str, context: Dict[str, Any]):
        self.message_id = str(uuid.uuid4())
        self.message_type = message_type
        self.content = content
        self.context = context
        self.created_at = datetime.now()
        self.ai_generated = True
        
    def to_dict(self) -> Dict[str, Any]:
        return {
            "message_id": self.message_id,
            "message_type": self.message_type,
            "content": self.content,
            "context": self.context,
            "created_at": self.created_at.isoformat(),
            "ai_generated": self.ai_generated
        }asyn
c def calculate_peer_compatibility(member1: CommunityMember, member2: CommunityMember) -> float:
    """Calculate compatibility score between two community members using AI algorithms"""
    
    score = 0.0
    
    # Quit stage compatibility (40% weight)
    stage_compatibility = {
        ("beginning", "beginning"): 0.9,
        ("beginning", "early"): 0.7,
        ("early", "early"): 0.9,
        ("early", "middle"): 0.8,
        ("middle", "middle"): 0.9,
        ("middle", "advanced"): 0.7,
        ("advanced", "advanced"): 0.8,
        ("advanced", "maintenance"): 0.6,
        ("maintenance", "maintenance"): 0.7,
    }
    
    stage_key = (member1.quit_stage, member2.quit_stage)
    reverse_stage_key = (member2.quit_stage, member1.quit_stage)
    
    if stage_key in stage_compatibility:
        score += stage_compatibility[stage_key] * 0.4
    elif reverse_stage_key in stage_compatibility:
        score += stage_compatibility[reverse_stage_key] * 0.4
    else:
        score += 0.3 * 0.4  # Default compatibility
    
    # Quit date proximity (20% weight)
    if member1.quit_date and member2.quit_date:
        try:
            date1 = datetime.fromisoformat(member1.quit_date)
            date2 = datetime.fromisoformat(member2.quit_date)
            days_diff = abs((date1 - date2).days)
            
            if days_diff <= 7:
                score += 0.9 * 0.2
            elif days_diff <= 30:
                score += 0.7 * 0.2
            elif days_diff <= 90:
                score += 0.5 * 0.2
            else:
                score += 0.3 * 0.2
        except:
            score += 0.3 * 0.2
    else:
        score += 0.3 * 0.2
    
    # Support preferences alignment (20% weight)
    pref1 = set(member1.support_preferences.get("types", []))
    pref2 = set(member2.support_preferences.get("types", []))
    
    if pref1 and pref2:
        overlap = len(pref1.intersection(pref2))
        total = len(pref1.union(pref2))
        if total > 0:
            score += (overlap / total) * 0.2
        else:
            score += 0.5 * 0.2
    else:
        score += 0.5 * 0.2
    
    # Timezone and activity overlap (10% weight)
    if member1.timezone == member2.timezone:
        score += 0.8 * 0.1
    else:
        score += 0.4 * 0.1
    
    # Interest overlap (10% weight)
    interests1 = set(member1.interests)
    interests2 = set(member2.interests)
    
    if interests1 and interests2:
        overlap = len(interests1.intersection(interests2))
        total = len(interests1.union(interests2))
        if total > 0:
            score += (overlap / total) * 0.1
        else:
            score += 0.3 * 0.1
    else:
        score += 0.3 * 0.1
    
    return min(score, 1.0)a
sync def generate_ai_supportive_response(context: Dict[str, Any]) -> str:
    """Generate AI-powered supportive response using OpenAI API"""
    
    if not OPENAI_API_KEY:
        return generate_fallback_supportive_response(context)
    
    try:
        async with httpx.AsyncClient() as client:
            prompt = f"""
            You are a compassionate AI assistant helping people quit vaping. Generate a supportive, 
            encouraging response based on the following context:
            
            User situation: {context.get('situation', 'seeking support')}
            Mood: {context.get('mood', 'neutral')}
            Quit stage: {context.get('quit_stage', 'unknown')}
            Recent struggle: {context.get('struggle', 'general challenges')}
            
            Guidelines:
            - Be empathetic and understanding
            - Offer practical, actionable advice
            - Keep response under 200 words
            - Use encouraging but not overly cheerful tone
            - Include specific strategies when appropriate
            - Acknowledge their feelings and validate their experience
            """
            
            response = await client.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {OPENAI_API_KEY}",
                    "Content-Type": "application/json"
                },
                json={
                    "model": "gpt-3.5-turbo",
                    "messages": [{"role": "user", "content": prompt}],
                    "max_tokens": 200,
                    "temperature": 0.7
                },
                timeout=30.0
            )
            
            if response.status_code == 200:
                data = response.json()
                return data["choices"][0]["message"]["content"].strip()
            else:
                logger.warning(f"OpenAI API error: {response.status_code}")
                return generate_fallback_supportive_response(context)
                
    except Exception as e:
        logger.error(f"Error generating AI response: {e}")
        return generate_fallback_supportive_response(context)de
f generate_fallback_supportive_response(context: Dict[str, Any]) -> str:
    """Generate fallback supportive response when AI is unavailable"""
    
    mood = context.get('mood', 'neutral')
    quit_stage = context.get('quit_stage', 'unknown')
    
    responses = {
        'struggling': [
            "I understand you're going through a tough time right now. Remember that cravings are temporary, but your commitment to quitting is what will last. Take it one moment at a time.",
            "It's completely normal to feel this way during your quit journey. You've already shown incredible strength by starting this process. Consider trying some deep breathing exercises or reaching out to a friend.",
            "Struggling moments are part of the process, and they don't define your success. You're building resilience with each challenge you face. What's one small thing you can do right now to take care of yourself?"
        ],
        'anxious': [
            "Anxiety during quitting is very common and shows that your body is adjusting. Try the 4-7-8 breathing technique: breathe in for 4, hold for 7, exhale for 8. You're doing great.",
            "Those anxious feelings are temporary and will pass. Your body is healing and readjusting. Consider going for a short walk or doing some light stretching to help manage the anxiety.",
            "Anxiety can feel overwhelming, but remember it's a sign that you're making positive changes. Ground yourself by naming 5 things you can see, 4 you can touch, 3 you can hear."
        ],
        'motivated': [
            "I love seeing your motivation! This positive energy is going to carry you far in your quit journey. Keep channeling this feeling into healthy activities and celebrating your progress.",
            "Your motivation is inspiring! Use this momentum to plan ahead for challenging moments. What strategies work best for you when motivation dips?",
            "This motivation is powerful - hold onto this feeling and remember it during tougher moments. You're proving to yourself that you can do this!"
        ]
    }
    
    stage_responses = {
        'beginning': "You're at the start of an amazing journey. Every expert was once a beginner, and you're taking the most important step.",
        'early': "You're building momentum in your quit journey. The early days are challenging, but you're proving your commitment every day.",
        'middle': "You're in the heart of your transformation. This stage requires patience with yourself as your body and mind continue to heal.",
        'advanced': "Look how far you've come! You're developing real mastery over your habits and choices.",
        'maintenance': "You've built something incredible - a vape-free life. Your experience can inspire others who are just starting their journey."
    }
    
    mood_responses = responses.get(mood, responses['struggling'])
    selected_response = mood_responses[hash(context.get('user_id', '')) % len(mood_responses)]
    
    stage_addition = stage_responses.get(quit_stage, "")
    
    if stage_addition:
        return f"{selected_response} {stage_addition}"
    else:
        return selected_responseasync 
def generate_milestone_celebration(milestone: str, context: Dict[str, Any]) -> str:
    """Generate personalized milestone celebration message"""
    
    celebrations = {
        '1_day': [
            "🎉 One full day vape-free! You've already started the healing process. Your body is beginning to clear out toxins and your sense of taste and smell are starting to improve.",
            "Amazing! 24 hours without vaping is a huge accomplishment. You've proven you can break the cycle. Keep building on this momentum!",
            "Congratulations on your first day! This is the foundation of your new vape-free life. You should feel proud of taking control."
        ],
        '1_week': [
            "🌟 One week vape-free! Your lung function is already improving, and you've saved money that would have gone to vaping. You're building real momentum!",
            "A full week - that's incredible! You've broken through the initial withdrawal phase and proven your commitment. Your body is thanking you.",
            "Seven days of freedom! You've established new routines and shown yourself that you can handle cravings. This is just the beginning of amazing changes."
        ],
        '1_month': [
            "🏆 One month vape-free! Your circulation has improved significantly, and your risk of infection is decreasing. You've built lasting habits!",
            "30 days of success! Your lung cilia are regenerating, helping clear your airways. You've proven this isn't just a temporary change - it's your new lifestyle.",
            "A full month! You've navigated through different situations and emotions without vaping. Your confidence and health are both growing stronger."
        ],
        '3_months': [
            "🎊 Three months vape-free! Your lung function has improved by up to 30%, and your energy levels are likely much higher. You're truly transformed!",
            "90 days of freedom! You've rewired your brain's reward pathways and built a completely new relationship with stress and emotions. Incredible work!",
            "Three months strong! Your body has healed significantly, and you've proven that you can maintain this healthy lifestyle long-term."
        ],
        '6_months': [
            "🌈 Six months vape-free! Your risk of heart disease has dropped significantly, and you've likely saved hundreds of dollars. You're an inspiration!",
            "Half a year of success! Your respiratory system has made remarkable improvements, and you've developed incredible mental resilience. Amazing achievement!",
            "Six months of freedom! You've navigated through seasons, stress, celebrations, and challenges - all while staying true to your commitment."
        ],
        '1_year': [
            "🎆 ONE FULL YEAR VAPE-FREE! Your risk of heart disease is now half that of someone who still vapes. You've completely transformed your life!",
            "365 days of freedom! You've proven that you can maintain this healthy lifestyle through every season and situation. You're a true success story!",
            "A full year! You've saved significant money, dramatically improved your health, and shown incredible dedication. You should be incredibly proud!"
        ]
    }
    
    milestone_messages = celebrations.get(milestone, [
        f"Congratulations on reaching {milestone}! Every milestone in your quit journey represents growth, healing, and commitment. Keep celebrating these victories!"
    ])
    
    user_id = context.get('user_id', '')
    selected_message = milestone_messages[hash(user_id) % len(milestone_messages)]
    
    # Add personalized elements if available
    if context.get('money_saved'):
        selected_message += f" You've saved ${context['money_saved']:.2f} so far!"
    
    if context.get('health_improvements'):
        improvements = context['health_improvements']
        if improvements:
            selected_message += f" Your health improvements include: {', '.join(improvements)}."
    
    return selected_message

# Initialize the MCP server
server = Server("community-support-mcp-server")@serv
er.list_tools()
async def handle_list_tools() -> ListToolsResult:
    """List available community support tools"""
    
    return ListToolsResult(
        tools=[
            Tool(
                name="register_community_member",
                description="Register a new anonymous community member for peer support",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "user_id": {"type": "string", "description": "Internal user ID (kept private)"},
                        "profile": {
                            "type": "object",
                            "properties": {
                                "quit_stage": {"type": "string", "enum": ["beginning", "early", "middle", "advanced", "maintenance"]},
                                "quit_date": {"type": "string", "description": "ISO date string"},
                                "support_preferences": {"type": "object"},
                                "interests": {"type": "array", "items": {"type": "string"}},
                                "timezone": {"type": "string"},
                                "active_hours": {"type": "array", "items": {"type": "string"}}
                            },
                            "required": ["quit_stage"]
                        }
                    },
                    "required": ["user_id", "profile"]
                }
            ),
            Tool(
                name="find_peer_matches",
                description="Find compatible peer matches using AI algorithms",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "user_id": {"type": "string", "description": "User ID requesting matches"},
                        "max_matches": {"type": "integer", "default": 5, "description": "Maximum number of matches to return"},
                        "min_compatibility": {"type": "number", "default": 0.6, "description": "Minimum compatibility score"}
                    },
                    "required": ["user_id"]
                }
            ),
            Tool(
                name="generate_supportive_response",
                description="Generate AI-powered supportive response to user posts or struggles",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "context": {
                            "type": "object",
                            "properties": {
                                "user_id": {"type": "string"},
                                "situation": {"type": "string", "description": "Current situation or struggle"},
                                "mood": {"type": "string", "enum": ["positive", "neutral", "negative", "anxious", "motivated", "struggling"]},
                                "quit_stage": {"type": "string"},
                                "struggle": {"type": "string", "description": "Specific struggle or challenge"}
                            },
                            "required": ["situation", "mood"]
                        }
                    },
                    "required": ["context"]
                }
            ),
            Tool(
                name="create_milestone_celebration",
                description="Create personalized milestone celebration message",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "user_id": {"type": "string"},
                        "milestone": {"type": "string", "description": "Milestone achieved (e.g., '1_day', '1_week', '1_month')"},
                        "context": {
                            "type": "object",
                            "properties": {
                                "money_saved": {"type": "number"},
                                "health_improvements": {"type": "array", "items": {"type": "string"}},
                                "personal_notes": {"type": "string"}
                            }
                        }
                    },
                    "required": ["user_id", "milestone"]
                }
            ),
            Tool(
                name="create_anonymous_session",
                description="Create secure anonymous messaging session between matched peers",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "requester_id": {"type": "string"},
                        "peer_ids": {"type": "array", "items": {"type": "string"}},
                        "session_type": {"type": "string", "enum": ["one_on_one", "group", "support_circle"], "default": "one_on_one"}
                    },
                    "required": ["requester_id", "peer_ids"]
                }
            ),
            Tool(
                name="get_community_insights",
                description="Get insights about community engagement and support patterns",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "user_id": {"type": "string"},
                        "insight_type": {"type": "string", "enum": ["personal", "community", "trends"], "default": "personal"}
                    },
                    "required": ["user_id"]
                }
            )
        ]
    )@server.
call_tool()
async def handle_call_tool(name: str, arguments: Dict[str, Any]) -> CallToolResult:
    """Handle community support tool calls"""
    
    try:
        if name == "register_community_member":
            user_id = arguments["user_id"]
            profile = arguments["profile"]
            
            # Create anonymous community member
            member = CommunityMember(user_id, profile)
            community_members[user_id] = member
            
            logger.info(f"Registered community member: {member.anonymous_id}")
            
            return CallToolResult(
                content=[
                    TextContent(
                        type="text",
                        text=json.dumps({
                            "success": True,
                            "anonymous_id": member.anonymous_id,
                            "member_profile": member.to_dict(),
                            "message": "Successfully registered for community support"
                        }, indent=2)
                    )
                ]
            )
        
        elif name == "find_peer_matches":
            user_id = arguments["user_id"]
            max_matches = arguments.get("max_matches", 5)
            min_compatibility = arguments.get("min_compatibility", 0.6)
            
            if user_id not in community_members:
                return CallToolResult(
                    content=[
                        TextContent(
                            type="text",
                            text=json.dumps({
                                "success": False,
                                "error": "User not registered in community"
                            }, indent=2)
                        )
                    ]
                )
            
            requester = community_members[user_id]
            matches = []
            
            # Calculate compatibility with all other members
            for other_user_id, other_member in community_members.items():
                if other_user_id != user_id:
                    compatibility = await calculate_peer_compatibility(requester, other_member)
                    
                    if compatibility >= min_compatibility:
                        matches.append({
                            "anonymous_id": other_member.anonymous_id,
                            "compatibility_score": compatibility,
                            "quit_stage": other_member.quit_stage,
                            "common_interests": list(set(requester.interests).intersection(set(other_member.interests))),
                            "timezone": other_member.timezone
                        })
            
            # Sort by compatibility and limit results
            matches.sort(key=lambda x: x["compatibility_score"], reverse=True)
            matches = matches[:max_matches]
            
            # Store the match result
            match = PeerMatch(user_id, [m["anonymous_id"] for m in matches], 
                            sum(m["compatibility_score"] for m in matches) / len(matches) if matches else 0)
            peer_matches[match.match_id] = match
            
            logger.info(f"Found {len(matches)} peer matches for user {user_id}")
            
            return CallToolResult(
                content=[
                    TextContent(
                        type="text",
                        text=json.dumps({
                            "success": True,
                            "match_id": match.match_id,
                            "matches": matches,
                            "total_matches": len(matches),
                            "average_compatibility": match.match_score
                        }, indent=2)
                    )
                ]
            ) 
       elif name == "generate_supportive_response":
            context = arguments["context"]
            
            # Generate AI-powered supportive response
            response_text = await generate_ai_supportive_response(context)
            
            # Create support message record
            message = SupportMessage("supportive_response", response_text, context)
            support_messages[message.message_id] = message
            
            logger.info(f"Generated supportive response: {message.message_id}")
            
            return CallToolResult(
                content=[
                    TextContent(
                        type="text",
                        text=json.dumps({
                            "success": True,
                            "message_id": message.message_id,
                            "response": response_text,
                            "context": context,
                            "ai_generated": True,
                            "created_at": message.created_at.isoformat()
                        }, indent=2)
                    )
                ]
            )
        
        elif name == "create_milestone_celebration":
            user_id = arguments["user_id"]
            milestone = arguments["milestone"]
            context = arguments.get("context", {})
            context["user_id"] = user_id
            
            # Generate personalized celebration message
            celebration_text = await generate_milestone_celebration(milestone, context)
            
            # Create celebration record
            celebration = SupportMessage("milestone_celebration", celebration_text, {
                "milestone": milestone,
                "user_id": user_id,
                **context
            })
            milestone_celebrations[celebration.message_id] = celebration
            
            logger.info(f"Created milestone celebration for {milestone}: {celebration.message_id}")
            
            return CallToolResult(
                content=[
                    TextContent(
                        type="text",
                        text=json.dumps({
                            "success": True,
                            "celebration_id": celebration.message_id,
                            "milestone": milestone,
                            "celebration_message": celebration_text,
                            "created_at": celebration.created_at.isoformat()
                        }, indent=2)
                    )
                ]
            )
        
        elif name == "create_anonymous_session":
            requester_id = arguments["requester_id"]
            peer_ids = arguments["peer_ids"]
            session_type = arguments.get("session_type", "one_on_one")
            
            # Create anonymous session
            session_id = str(uuid.uuid4())
            session = {
                "session_id": session_id,
                "requester_id": requester_id,
                "peer_ids": peer_ids,
                "session_type": session_type,
                "created_at": datetime.now().isoformat(),
                "status": "active",
                "messages": []
            }
            
            anonymous_sessions[session_id] = session
            
            logger.info(f"Created anonymous session: {session_id}")
            
            return CallToolResult(
                content=[
                    TextContent(
                        type="text",
                        text=json.dumps({
                            "success": True,
                            "session_id": session_id,
                            "session_type": session_type,
                            "participants": len(peer_ids) + 1,
                            "created_at": session["created_at"],
                            "message": "Anonymous messaging session created successfully"
                        }, indent=2)
                    )
                ]
            )  
      elif name == "get_community_insights":
            user_id = arguments["user_id"]
            insight_type = arguments.get("insight_type", "personal")
            
            insights = {}
            
            if insight_type == "personal":
                # Personal community engagement insights
                user_matches = [m for m in peer_matches.values() if m.requester_id == user_id]
                user_messages = [m for m in support_messages.values() if m.context.get("user_id") == user_id]
                user_celebrations = [c for c in milestone_celebrations.values() if c.context.get("user_id") == user_id]
                
                insights = {
                    "total_peer_matches": len(user_matches),
                    "average_match_score": sum(m.match_score for m in user_matches) / len(user_matches) if user_matches else 0,
                    "support_messages_received": len(user_messages),
                    "milestones_celebrated": len(user_celebrations),
                    "community_engagement_level": "high" if len(user_matches) > 3 else "moderate" if len(user_matches) > 0 else "low"
                }
            
            elif insight_type == "community":
                # Overall community insights
                insights = {
                    "total_members": len(community_members),
                    "active_sessions": len([s for s in anonymous_sessions.values() if s["status"] == "active"]),
                    "total_matches_made": len(peer_matches),
                    "support_messages_generated": len(support_messages),
                    "milestones_celebrated": len(milestone_celebrations)
                }
            
            elif insight_type == "trends":
                # Community trends and patterns
                quit_stages = [m.quit_stage for m in community_members.values()]
                stage_distribution = {stage: quit_stages.count(stage) for stage in set(quit_stages)}
                
                insights = {
                    "quit_stage_distribution": stage_distribution,
                    "most_common_stage": max(stage_distribution, key=stage_distribution.get) if stage_distribution else None,
                    "average_compatibility_score": sum(m.match_score for m in peer_matches.values()) / len(peer_matches) if peer_matches else 0,
                    "peak_activity_hours": ["18:00-20:00", "20:00-22:00"]  # Mock data
                }
            
            return CallToolResult(
                content=[
                    TextContent(
                        type="text",
                        text=json.dumps({
                            "success": True,
                            "insight_type": insight_type,
                            "insights": insights,
                            "generated_at": datetime.now().isoformat()
                        }, indent=2)
                    )
                ]
            )
        
        else:
            return CallToolResult(
                content=[
                    TextContent(
                        type="text",
                        text=json.dumps({
                            "success": False,
                            "error": f"Unknown tool: {name}"
                        }, indent=2)
                    )
                ]
            )
    
    except Exception as e:
        logger.error(f"Error handling tool call {name}: {e}")
        return CallToolResult(
            content=[
                TextContent(
                    type="text",
                    text=json.dumps({
                        "success": False,
                        "error": str(e)
                    }, indent=2)
                )
            ]
        )async de
f main():
    """Run the Community Support MCP server"""
    
    logger.info("Starting Community Support MCP Server...")
    
    # Initialize server options
    options = InitializationOptions(
        server_name="community-support-mcp-server",
        server_version="1.0.0",
        capabilities={
            "tools": {}
        }
    )
    
    async with stdio_server() as (read_stream, write_stream):
        await server.run(
            read_stream,
            write_stream,
            options
        )

if __name__ == "__main__":
    asyncio.run(main())