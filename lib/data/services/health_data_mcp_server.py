#!/usr/bin/env python3
"""
Health Data MCP Server for QuitVaping App
Provides health recovery timeline calculations and personalized health insights
using Postman's MCP server generation tools and health APIs.
"""

import asyncio
import json
import logging
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional
import httpx
import os
from dataclasses import dataclass, asdict
from enum import Enum

# MCP Server imports (would be from actual MCP SDK)
from mcp import MCPServer, MCPRequest, MCPResponse, MCPError
from mcp.types import Tool, Resource

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class HealthBenefitStage(Enum):
    """Health benefit stages after quitting vaping"""
    IMMEDIATE = "immediate"  # 0-24 hours
    SHORT_TERM = "short_term"  # 1-30 days
    MEDIUM_TERM = "medium_term"  # 1-12 months
    LONG_TERM = "long_term"  # 1+ years

@dataclass
class HealthBenefit:
    """Represents a health benefit at a specific time"""
    time_description: str
    benefit_description: str
    stage: HealthBenefitStage
    confidence_level: float
    personalization_factors: List[str]

@dataclass
class UserHealthProfile:
    """User's health profile for personalized insights"""
    user_id: str
    quit_date: datetime
    age: int
    vaping_duration_months: int
    daily_usage_level: str  # low, medium, high
    health_conditions: List[str]
    fitness_level: str  # poor, fair, good, excellent

class HealthDataMCPServer:
    """MCP Server for health data and recovery timeline calculations"""
    
    def __init__(self):
        self.server = MCPServer("health-data-server")
        self.health_api_base_url = os.getenv("HEALTH_API_BASE_URL", "https://api.health.gov")
        self.medical_db_api_key = os.getenv("MEDICAL_DB_API_KEY", "")
        self.client = httpx.AsyncClient(timeout=30.0)
        
        # Health benefits timeline data
        self.health_benefits_timeline = self._initialize_health_benefits()
        
        # Register MCP tools
        self._register_tools()
        
    def _initialize_health_benefits(self) -> List[HealthBenefit]:
        """Initialize the health benefits timeline based on medical research"""
        return [
            # Immediate benefits (0-24 hours)
            HealthBenefit(
                time_description="20 minutes",
                benefit_description="Heart rate and blood pressure begin to normalize",
                stage=HealthBenefitStage.IMMEDIATE,
                confidence_level=0.95,
                personalization_factors=["age", "fitness_level"]
            ),
            HealthBenefit(
                time_description="2 hours",
                benefit_description="Nicotine levels in blood drop significantly",
                stage=HealthBenefitStage.IMMEDIATE,
                confidence_level=0.98,
                personalization_factors=["daily_usage_level", "vaping_duration_months"]
            ),
            HealthBenefit(
                time_description="12 hours",
                benefit_description="Carbon monoxide levels normalize, oxygen levels increase",
                stage=HealthBenefitStage.IMMEDIATE,
                confidence_level=0.92,
                personalization_factors=["daily_usage_level"]
            ),
            
            # Short-term benefits (1-30 days)
            HealthBenefit(
                time_description="24 hours",
                benefit_description="Risk of heart attack begins to decrease",
                stage=HealthBenefitStage.SHORT_TERM,
                confidence_level=0.88,
                personalization_factors=["age", "health_conditions"]
            ),
            HealthBenefit(
                time_description="48 hours",
                benefit_description="Nerve endings begin to regrow, taste and smell improve",
                stage=HealthBenefitStage.SHORT_TERM,
                confidence_level=0.85,
                personalization_factors=["vaping_duration_months"]
            ),
            HealthBenefit(
                time_description="72 hours",
                benefit_description="Breathing becomes easier, lung capacity increases",
                stage=HealthBenefitStage.SHORT_TERM,
                confidence_level=0.90,
                personalization_factors=["fitness_level", "daily_usage_level"]
            ),
            HealthBenefit(
                time_description="2 weeks",
                benefit_description="Circulation improves significantly",
                stage=HealthBenefitStage.SHORT_TERM,
                confidence_level=0.87,
                personalization_factors=["age", "fitness_level"]
            ),
            
            # Medium-term benefits (1-12 months)
            HealthBenefit(
                time_description="1 month",
                benefit_description="Coughing and shortness of breath decrease noticeably",
                stage=HealthBenefitStage.MEDIUM_TERM,
                confidence_level=0.83,
                personalization_factors=["vaping_duration_months", "daily_usage_level"]
            ),
            HealthBenefit(
                time_description="3 months",
                benefit_description="Lung function improves by up to 30%",
                stage=HealthBenefitStage.MEDIUM_TERM,
                confidence_level=0.80,
                personalization_factors=["age", "fitness_level", "vaping_duration_months"]
            ),
            HealthBenefit(
                time_description="6 months",
                benefit_description="Risk of respiratory infections decreases significantly",
                stage=HealthBenefitStage.MEDIUM_TERM,
                confidence_level=0.85,
                personalization_factors=["health_conditions", "age"]
            ),
            HealthBenefit(
                time_description="9 months",
                benefit_description="Cilia in lungs regrow, improving lung cleaning ability",
                stage=HealthBenefitStage.MEDIUM_TERM,
                confidence_level=0.78,
                personalization_factors=["vaping_duration_months", "daily_usage_level"]
            ),
            
            # Long-term benefits (1+ years)
            HealthBenefit(
                time_description="1 year",
                benefit_description="Risk of heart disease reduced by 50%",
                stage=HealthBenefitStage.LONG_TERM,
                confidence_level=0.82,
                personalization_factors=["age", "health_conditions", "vaping_duration_months"]
            ),
            HealthBenefit(
                time_description="2 years",
                benefit_description="Risk of stroke approaches that of non-vapers",
                stage=HealthBenefitStage.LONG_TERM,
                confidence_level=0.75,
                personalization_factors=["age", "health_conditions"]
            ),
            HealthBenefit(
                time_description="5 years",
                benefit_description="Risk of lung cancer reduced by 50%",
                stage=HealthBenefitStage.LONG_TERM,
                confidence_level=0.70,
                personalization_factors=["vaping_duration_months", "daily_usage_level", "age"]
            ),
        ]
    
    def _register_tools(self):
        """Register MCP tools for health data operations"""
        
        @self.server.tool("get_health_recovery_timeline")
        async def get_health_recovery_timeline(user_id: str, personalize: bool = True) -> Dict[str, Any]:
            """Get personalized health recovery timeline for a user"""
            try:
                user_profile = await self._get_user_health_profile(user_id)
                timeline = await self._calculate_personalized_timeline(user_profile, personalize)
                
                return {
                    "timeline": timeline,
                    "user_id": user_id,
                    "generated_at": datetime.now().isoformat(),
                    "personalized": personalize
                }
            except Exception as e:
                logger.error(f"Error getting health recovery timeline: {e}")
                raise MCPError(f"Failed to get health recovery timeline: {str(e)}")
        
        @self.server.tool("get_cessation_benefits")
        async def get_cessation_benefits(user_id: str, time_period: str = "current") -> Dict[str, Any]:
            """Get current cessation benefits based on quit duration"""
            try:
                user_profile = await self._get_user_health_profile(user_id)
                benefits = await self._get_current_benefits(user_profile, time_period)
                
                return {
                    "benefits": benefits,
                    "quit_duration": self._calculate_quit_duration(user_profile.quit_date),
                    "user_id": user_id,
                    "time_period": time_period
                }
            except Exception as e:
                logger.error(f"Error getting cessation benefits: {e}")
                raise MCPError(f"Failed to get cessation benefits: {str(e)}")
        
        @self.server.tool("get_nrt_protocols")
        async def get_nrt_protocols(user_id: str, current_stage: str = "initial") -> Dict[str, Any]:
            """Get evidence-based NRT protocols and recommendations"""
            try:
                user_profile = await self._get_user_health_profile(user_id)
                protocols = await self._get_nrt_recommendations(user_profile, current_stage)
                
                return {
                    "protocols": protocols,
                    "user_id": user_id,
                    "current_stage": current_stage,
                    "safety_warnings": await self._get_nrt_safety_warnings(user_profile)
                }
            except Exception as e:
                logger.error(f"Error getting NRT protocols: {e}")
                raise MCPError(f"Failed to get NRT protocols: {str(e)}")
        
        @self.server.tool("get_personalized_insights")
        async def get_personalized_insights(user_id: str, insight_type: str = "comprehensive") -> Dict[str, Any]:
            """Get personalized health insights based on user profile and progress"""
            try:
                user_profile = await self._get_user_health_profile(user_id)
                insights = await self._generate_personalized_insights(user_profile, insight_type)
                
                return {
                    "insights": insights,
                    "user_id": user_id,
                    "insight_type": insight_type,
                    "confidence_score": insights.get("confidence_score", 0.8)
                }
            except Exception as e:
                logger.error(f"Error getting personalized insights: {e}")
                raise MCPError(f"Failed to get personalized insights: {str(e)}")
    
    async def _get_user_health_profile(self, user_id: str) -> UserHealthProfile:
        """Retrieve user health profile (mock implementation)"""
        # In a real implementation, this would fetch from a database
        # For now, return a mock profile
        return UserHealthProfile(
            user_id=user_id,
            quit_date=datetime.now() - timedelta(days=30),  # 30 days ago
            age=28,
            vaping_duration_months=24,
            daily_usage_level="medium",
            health_conditions=[],
            fitness_level="good"
        )
    
    async def _calculate_personalized_timeline(self, user_profile: UserHealthProfile, personalize: bool) -> List[Dict[str, Any]]:
        """Calculate personalized health recovery timeline"""
        timeline = []
        quit_duration = self._calculate_quit_duration(user_profile.quit_date)
        
        for benefit in self.health_benefits_timeline:
            timeline_item = {
                "time_description": benefit.time_description,
                "benefit_description": benefit.benefit_description,
                "stage": benefit.stage.value,
                "confidence_level": benefit.confidence_level,
                "achieved": self._is_benefit_achieved(benefit, quit_duration),
                "personalization_factors": benefit.personalization_factors if personalize else []
            }
            
            if personalize:
                timeline_item["personalized_message"] = self._personalize_benefit_message(
                    benefit, user_profile, quit_duration
                )
            
            timeline.append(timeline_item)
        
        return timeline
    
    async def _get_current_benefits(self, user_profile: UserHealthProfile, time_period: str) -> List[Dict[str, Any]]:
        """Get current health benefits based on quit duration"""
        quit_duration = self._calculate_quit_duration(user_profile.quit_date)
        current_benefits = []
        
        for benefit in self.health_benefits_timeline:
            if self._is_benefit_achieved(benefit, quit_duration):
                current_benefits.append({
                    "benefit": benefit.benefit_description,
                    "achieved_at": benefit.time_description,
                    "confidence": benefit.confidence_level,
                    "personalized_impact": self._calculate_personal_impact(benefit, user_profile)
                })
        
        return current_benefits
    
    async def _get_nrt_recommendations(self, user_profile: UserHealthProfile, current_stage: str) -> Dict[str, Any]:
        """Get NRT protocol recommendations based on user profile"""
        # Mock NRT recommendations based on usage level and duration
        recommendations = {
            "recommended_nrt_type": self._recommend_nrt_type(user_profile),
            "dosage_schedule": self._create_dosage_schedule(user_profile, current_stage),
            "duration_weeks": self._calculate_nrt_duration(user_profile),
            "monitoring_schedule": self._create_monitoring_schedule(current_stage),
            "success_indicators": [
                "Reduced cravings within 3-7 days",
                "Improved sleep quality within 1-2 weeks",
                "Decreased withdrawal symptoms within 2-4 weeks"
            ]
        }
        
        return recommendations
    
    async def _get_nrt_safety_warnings(self, user_profile: UserHealthProfile) -> List[str]:
        """Get safety warnings for NRT based on user profile"""
        warnings = []
        
        if "heart_disease" in user_profile.health_conditions:
            warnings.append("Consult healthcare provider before using nicotine patches due to heart condition")
        
        if user_profile.age < 18:
            warnings.append("NRT use in minors requires medical supervision")
        
        if user_profile.daily_usage_level == "high":
            warnings.append("High usage history may require extended NRT duration")
        
        return warnings
    
    async def _generate_personalized_insights(self, user_profile: UserHealthProfile, insight_type: str) -> Dict[str, Any]:
        """Generate personalized health insights"""
        quit_duration = self._calculate_quit_duration(user_profile.quit_date)
        
        insights = {
            "quit_progress": {
                "days_quit": quit_duration["days"],
                "percentage_complete": min(100, (quit_duration["days"] / 365) * 100),
                "next_milestone": self._get_next_milestone(quit_duration)
            },
            "health_improvements": self._calculate_health_improvements(user_profile, quit_duration),
            "financial_savings": self._calculate_financial_savings(user_profile, quit_duration),
            "risk_reductions": self._calculate_risk_reductions(user_profile, quit_duration),
            "confidence_score": self._calculate_confidence_score(user_profile, quit_duration)
        }
        
        return insights
    
    def _calculate_quit_duration(self, quit_date: datetime) -> Dict[str, int]:
        """Calculate duration since quit date"""
        duration = datetime.now() - quit_date
        return {
            "days": duration.days,
            "weeks": duration.days // 7,
            "months": duration.days // 30,
            "years": duration.days // 365
        }
    
    def _is_benefit_achieved(self, benefit: HealthBenefit, quit_duration: Dict[str, int]) -> bool:
        """Check if a health benefit has been achieved based on quit duration"""
        time_desc = benefit.time_description.lower()
        
        if "minute" in time_desc:
            minutes = int(time_desc.split()[0])
            return quit_duration["days"] * 24 * 60 >= minutes
        elif "hour" in time_desc:
            hours = int(time_desc.split()[0])
            return quit_duration["days"] * 24 >= hours
        elif "day" in time_desc:
            days = int(time_desc.split()[0])
            return quit_duration["days"] >= days
        elif "week" in time_desc:
            weeks = int(time_desc.split()[0])
            return quit_duration["weeks"] >= weeks
        elif "month" in time_desc:
            months = int(time_desc.split()[0])
            return quit_duration["months"] >= months
        elif "year" in time_desc:
            years = int(time_desc.split()[0])
            return quit_duration["years"] >= years
        
        return False
    
    def _personalize_benefit_message(self, benefit: HealthBenefit, user_profile: UserHealthProfile, quit_duration: Dict[str, int]) -> str:
        """Create personalized message for health benefit"""
        base_message = benefit.benefit_description
        
        if "age" in benefit.personalization_factors:
            if user_profile.age < 25:
                base_message += " (Your young age gives you excellent recovery potential)"
            elif user_profile.age > 50:
                base_message += " (Recovery may take slightly longer but is still very beneficial)"
        
        if "fitness_level" in benefit.personalization_factors:
            if user_profile.fitness_level == "excellent":
                base_message += " (Your fitness level will accelerate this improvement)"
            elif user_profile.fitness_level == "poor":
                base_message += " (Consider light exercise to enhance this benefit)"
        
        return base_message
    
    def _calculate_personal_impact(self, benefit: HealthBenefit, user_profile: UserHealthProfile) -> str:
        """Calculate personal impact of health benefit"""
        impact_factors = []
        
        if user_profile.daily_usage_level == "high":
            impact_factors.append("significant improvement expected")
        elif user_profile.daily_usage_level == "low":
            impact_factors.append("moderate improvement expected")
        
        if user_profile.vaping_duration_months > 24:
            impact_factors.append("long-term benefits will be substantial")
        
        return ", ".join(impact_factors) if impact_factors else "positive impact expected"
    
    def _recommend_nrt_type(self, user_profile: UserHealthProfile) -> str:
        """Recommend NRT type based on user profile"""
        if user_profile.daily_usage_level == "high":
            return "combination_therapy"  # Patch + gum/lozenge
        elif user_profile.daily_usage_level == "medium":
            return "nicotine_patch"
        else:
            return "nicotine_gum"
    
    def _create_dosage_schedule(self, user_profile: UserHealthProfile, current_stage: str) -> List[Dict[str, Any]]:
        """Create NRT dosage schedule"""
        if user_profile.daily_usage_level == "high":
            return [
                {"week": "1-6", "dosage": "21mg patch daily", "additional": "2mg gum as needed"},
                {"week": "7-8", "dosage": "14mg patch daily", "additional": "2mg gum as needed"},
                {"week": "9-10", "dosage": "7mg patch daily", "additional": "1mg gum as needed"},
                {"week": "11-12", "dosage": "discontinue", "additional": "1mg gum as needed"}
            ]
        else:
            return [
                {"week": "1-4", "dosage": "14mg patch daily", "additional": None},
                {"week": "5-6", "dosage": "7mg patch daily", "additional": None},
                {"week": "7-8", "dosage": "discontinue", "additional": None}
            ]
    
    def _calculate_nrt_duration(self, user_profile: UserHealthProfile) -> int:
        """Calculate recommended NRT duration in weeks"""
        base_duration = 8
        
        if user_profile.daily_usage_level == "high":
            base_duration += 4
        if user_profile.vaping_duration_months > 24:
            base_duration += 2
        
        return min(base_duration, 12)  # Max 12 weeks
    
    def _create_monitoring_schedule(self, current_stage: str) -> List[str]:
        """Create monitoring schedule for NRT"""
        return [
            "Daily craving intensity (1-10 scale)",
            "Weekly weight monitoring",
            "Bi-weekly sleep quality assessment",
            "Monthly healthcare provider check-in"
        ]
    
    def _get_next_milestone(self, quit_duration: Dict[str, int]) -> Dict[str, Any]:
        """Get next milestone to achieve"""
        days = quit_duration["days"]
        
        milestones = [
            (1, "24 hours smoke-free"),
            (3, "72 hours - breathing improves"),
            (7, "1 week milestone"),
            (14, "2 weeks - circulation improves"),
            (30, "1 month milestone"),
            (90, "3 months - major lung improvement"),
            (180, "6 months milestone"),
            (365, "1 year - major health milestone")
        ]
        
        for milestone_days, description in milestones:
            if days < milestone_days:
                return {
                    "days_remaining": milestone_days - days,
                    "description": description,
                    "milestone_day": milestone_days
                }
        
        return {
            "days_remaining": 0,
            "description": "All major milestones achieved!",
            "milestone_day": days
        }
    
    def _calculate_health_improvements(self, user_profile: UserHealthProfile, quit_duration: Dict[str, int]) -> Dict[str, Any]:
        """Calculate quantified health improvements"""
        days = quit_duration["days"]
        
        improvements = {
            "lung_capacity_improvement": min(30, days * 0.5),  # Up to 30% improvement
            "circulation_improvement": min(100, days * 2),     # Up to 100% improvement
            "taste_smell_recovery": min(100, days * 3),        # Up to 100% recovery
            "energy_level_increase": min(50, days * 1.5)       # Up to 50% increase
        }
        
        return improvements
    
    def _calculate_financial_savings(self, user_profile: UserHealthProfile, quit_duration: Dict[str, int]) -> Dict[str, Any]:
        """Calculate financial savings from quitting"""
        # Estimate based on usage level
        daily_cost = {
            "low": 5.0,
            "medium": 10.0,
            "high": 15.0
        }.get(user_profile.daily_usage_level, 10.0)
        
        total_saved = quit_duration["days"] * daily_cost
        
        return {
            "total_saved": round(total_saved, 2),
            "daily_savings": daily_cost,
            "monthly_savings": round(daily_cost * 30, 2),
            "yearly_projection": round(daily_cost * 365, 2)
        }
    
    def _calculate_risk_reductions(self, user_profile: UserHealthProfile, quit_duration: Dict[str, int]) -> Dict[str, Any]:
        """Calculate health risk reductions"""
        days = quit_duration["days"]
        
        # Risk reduction percentages based on medical research
        risk_reductions = {
            "heart_attack_risk": min(50, days * 0.1),
            "stroke_risk": min(40, days * 0.08),
            "lung_cancer_risk": min(30, days * 0.05),
            "respiratory_infection_risk": min(60, days * 0.2)
        }
        
        return risk_reductions
    
    def _calculate_confidence_score(self, user_profile: UserHealthProfile, quit_duration: Dict[str, int]) -> float:
        """Calculate confidence score for insights"""
        base_confidence = 0.7
        
        # Increase confidence with longer quit duration
        duration_bonus = min(0.2, quit_duration["days"] * 0.001)
        
        # Adjust based on user profile completeness
        profile_bonus = 0.1 if len(user_profile.health_conditions) > 0 else 0.05
        
        return min(1.0, base_confidence + duration_bonus + profile_bonus)
    
    async def start_server(self):
        """Start the MCP server"""
        logger.info("Starting Health Data MCP Server...")
        await self.server.start()
    
    async def stop_server(self):
        """Stop the MCP server"""
        logger.info("Stopping Health Data MCP Server...")
        await self.client.aclose()
        await self.server.stop()

async def main():
    """Main entry point for the Health Data MCP Server"""
    server = HealthDataMCPServer()
    
    try:
        await server.start_server()
    except KeyboardInterrupt:
        logger.info("Received shutdown signal")
    finally:
        await server.stop_server()

if __name__ == "__main__":
    asyncio.run(main())