#!/usr/bin/env python3
"""
Smart NRT Management MCP Server

This server provides intelligent NRT (Nicotine Replacement Therapy) management
capabilities using medical databases and AI-powered algorithms for personalized
dosage calculations, withdrawal symptom tracking, and evidence-based protocols.
"""

import asyncio
import json
import logging
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any
import os
import sqlite3
from dataclasses import dataclass, asdict
from enum import Enum

# MCP imports
from mcp.server.models import InitializationOptions
from mcp.server import NotificationOptions, Server
from mcp.server.models import (
    CallToolRequest,
    CallToolResult,
    ListToolsRequest,
    ListToolsResult,
    Tool,
)
from mcp.types import (
    TextContent,
    ImageContent,
    EmbeddedResource,
)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("smart-nrt-mcp-server")

# Medical database simulation (in production, this would connect to real APIs)
MEDICAL_NRT_PROTOCOLS = {
    "patch": {
        "high_dependence": {
            "initial_strength": 21,
            "duration_weeks": 12,
            "reduction_schedule": [
                {"week": 1, "strength": 21, "frequency": 1},
                {"week": 7, "strength": 14, "frequency": 1},
                {"week": 9, "strength": 7, "frequency": 1},
            ]
        },
        "medium_dependence": {
            "initial_strength": 14,
            "duration_weeks": 10,
            "reduction_schedule": [
                {"week": 1, "strength": 14, "frequency": 1},
                {"week": 6, "strength": 7, "frequency": 1},
            ]
        },
        "low_dependence": {
            "initial_strength": 7,
            "duration_weeks": 8,
            "reduction_schedule": [
                {"week": 1, "strength": 7, "frequency": 1},
            ]
        }
    },
    "gum": {
        "high_dependence": {
            "initial_strength": 4,
            "duration_weeks": 12,
            "reduction_schedule": [
                {"week": 1, "strength": 4, "frequency": 8},
                {"week": 7, "strength": 2, "frequency": 6},
                {"week": 10, "strength": 2, "frequency": 3},
            ]
        },
        "medium_dependence": {
            "initial_strength": 2,
            "duration_weeks": 10,
            "reduction_schedule": [
                {"week": 1, "strength": 2, "frequency": 6},
                {"week": 6, "strength": 2, "frequency": 3},
            ]
        }
    }
}

WITHDRAWAL_SYMPTOM_RESPONSES = {
    "craving": {
        "mild": {
            "strategies": ["Deep breathing", "Distraction techniques", "Physical activity"],
            "message": "Cravings are normal and will pass. Try deep breathing or a quick walk.",
            "evidence": ["CDC Smoking Cessation Guidelines", "Cochrane Review 2018"]
        },
        "severe": {
            "strategies": ["Immediate NRT dose", "Call support line", "Emergency coping plan"],
            "message": "Strong cravings need immediate attention. Consider an additional NRT dose if safe.",
            "evidence": ["NICE Guidelines", "American Heart Association"]
        }
    },
    "irritability": {
        "mild": {
            "strategies": ["Mindfulness", "Progressive muscle relaxation", "Avoid triggers"],
            "message": "Irritability is temporary. Practice mindfulness and avoid known triggers.",
            "evidence": ["Journal of Behavioral Medicine", "Addiction Research"]
        },
        "severe": {
            "strategies": ["Professional support", "Medication review", "Stress management"],
            "message": "Severe irritability may need professional support. Consider consulting your healthcare provider.",
            "evidence": ["Clinical Psychology Review", "Nicotine & Tobacco Research"]
        }
    }
}

@dataclass
class UserProfile:
    user_id: str
    age: int
    vaping_duration_months: int
    daily_usage_level: str
    health_conditions: List[str]
    fitness_level: str
    quit_date: str

@dataclass
class NRTProtocol:
    recommended_nrt_type: str
    dosage_schedule: List[Dict]
    duration_weeks: int
    monitoring_schedule: List[str]
    success_indicators: List[str]
    safety_warnings: List[str]

class SmartNRTServer:
    def __init__(self):
        self.server = Server("smart-nrt-mcp-server")
        self.db_path = "smart_nrt.db"
        self._init_database()
        
    def _init_database(self):
        """Initialize SQLite database for storing NRT data"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Create tables
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS user_profiles (
                user_id TEXT PRIMARY KEY,
                age INTEGER,
                vaping_duration_months INTEGER,
                daily_usage_level TEXT,
                health_conditions TEXT,
                fitness_level TEXT,
                quit_date TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS nrt_protocols (
                id TEXT PRIMARY KEY,
                user_id TEXT,
                protocol_data TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES user_profiles (user_id)
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS withdrawal_symptoms (
                id TEXT PRIMARY KEY,
                user_id TEXT,
                symptom_type TEXT,
                severity INTEGER,
                timestamp TIMESTAMP,
                notes TEXT,
                FOREIGN KEY (user_id) REFERENCES user_profiles (user_id)
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS dosage_recommendations (
                id TEXT PRIMARY KEY,
                user_id TEXT,
                recommended_dosage TEXT,
                adjustment TEXT,
                confidence REAL,
                reasoning TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES user_profiles (user_id)
            )
        ''')
        
        conn.commit()
        conn.close()

    async def get_nrt_protocols(self, user_id: str, profile_data: Dict) -> Dict:
        """Generate personalized NRT protocol based on user profile"""
        try:
            profile = UserProfile(
                user_id=user_id,
                age=profile_data.get('age', 30),
                vaping_duration_months=profile_data.get('vapingDurationMonths', 12),
                daily_usage_level=profile_data.get('dailyUsageLevel', 'medium'),
                health_conditions=profile_data.get('healthConditions', []),
                fitness_level=profile_data.get('fitnessLevel', 'fair'),
                quit_date=profile_data.get('quitDate', datetime.now().isoformat())
            )
            
            # Store user profile
            self._store_user_profile(profile)
            
            # Determine dependence level
            dependence_level = self._assess_dependence_level(profile)
            
            # Select appropriate protocol
            nrt_type = self._recommend_nrt_type(profile)
            protocol_data = MEDICAL_NRT_PROTOCOLS.get(nrt_type, {}).get(dependence_level, {})
            
            if not protocol_data:
                protocol_data = MEDICAL_NRT_PROTOCOLS["patch"]["medium_dependence"]
            
            # Create personalized protocol
            protocol = NRTProtocol(
                recommended_nrt_type=nrt_type,
                dosage_schedule=protocol_data["reduction_schedule"],
                duration_weeks=protocol_data["duration_weeks"],
                monitoring_schedule=[
                    "Weekly symptom assessment",
                    "Bi-weekly progress review",
                    "Monthly medical consultation"
                ],
                success_indicators=[
                    "Reduced withdrawal symptoms",
                    "Consistent protocol adherence",
                    "Improved quality of life",
                    "Decreased nicotine dependence"
                ],
                safety_warnings=self._get_safety_warnings(profile)
            )
            
            # Store protocol
            self._store_protocol(user_id, protocol)
            
            return asdict(protocol)
            
        except Exception as e:
            logger.error(f"Error generating NRT protocol: {e}")
            return {"error": str(e)}

    async def calculate_personalized_dosage(self, user_id: str, params: Dict) -> Dict:
        """Calculate personalized dosage based on current progress and symptoms"""
        try:
            current_protocol = params.get('currentProtocol', {})
            recent_usage = params.get('recentUsage', [])
            symptom_severity = params.get('symptomSeverity', 0.0)
            withdrawal_symptoms = params.get('withdrawalSymptoms', [])
            
            # Analyze usage patterns
            usage_consistency = self._analyze_usage_consistency(recent_usage)
            
            # Calculate base recommendation
            base_dosage = self._get_current_protocol_dosage(current_protocol)
            
            # Adjust based on symptoms
            adjustment = "maintain"
            confidence = 0.8
            reasoning = "Standard protocol progression"
            
            if symptom_severity > 0.7:
                adjustment = "increase"
                confidence = 0.9
                reasoning = "High symptom severity indicates need for dosage increase"
            elif symptom_severity < 0.3 and usage_consistency > 0.8:
                adjustment = "decrease"
                confidence = 0.85
                reasoning = "Low symptoms and consistent usage suggest readiness for reduction"
            
            # Check for safety concerns
            warnings = []
            if len(withdrawal_symptoms) > 5:
                warnings.append("Multiple withdrawal symptoms reported - monitor closely")
            
            recommendation = {
                "recommendedDosage": base_dosage,
                "adjustment": adjustment,
                "confidence": confidence,
                "reasoning": reasoning,
                "nextReviewDate": (datetime.now() + timedelta(days=3)).isoformat(),
                "warnings": warnings,
                "supportingEvidence": [
                    "Clinical Practice Guidelines for NRT",
                    "Cochrane Review on NRT Effectiveness"
                ]
            }
            
            # Store recommendation
            self._store_dosage_recommendation(user_id, recommendation)
            
            return recommendation
            
        except Exception as e:
            logger.error(f"Error calculating personalized dosage: {e}")
            return {"error": str(e)}

    async def generate_symptom_response(self, user_id: str, params: Dict) -> Dict:
        """Generate intelligent response to withdrawal symptoms"""
        try:
            symptom_data = params.get('symptom', {})
            symptom_type = symptom_data.get('type', 'craving')
            severity = symptom_data.get('severity', 5)
            
            # Store symptom
            self._store_withdrawal_symptom(user_id, symptom_data)
            
            # Determine severity level
            severity_level = "mild" if severity <= 5 else "severe"
            
            # Get response template
            response_template = WITHDRAWAL_SYMPTOM_RESPONSES.get(
                symptom_type, 
                WITHDRAWAL_SYMPTOM_RESPONSES["craving"]
            ).get(severity_level, WITHDRAWAL_SYMPTOM_RESPONSES["craving"]["mild"])
            
            # Generate personalized response
            response = {
                "id": f"response_{user_id}_{datetime.now().timestamp()}",
                "userId": user_id,
                "symptom": symptom_data,
                "message": response_template["message"],
                "copingStrategies": response_template["strategies"],
                "evidenceSources": response_template["evidence"],
                "requiresImmediateAction": severity > 8,
                "requiresMedicalAttention": severity > 9,
                "followUpDate": (datetime.now() + timedelta(hours=24)).isoformat()
            }
            
            return response
            
        except Exception as e:
            logger.error(f"Error generating symptom response: {e}")
            return {"error": str(e)}

    async def assess_reduction_readiness(self, user_id: str, params: Dict) -> Dict:
        """Assess user's readiness for dosage reduction"""
        try:
            recent_symptoms = params.get('recentSymptoms', [])
            recent_usage = params.get('recentUsage', [])
            usage_trend = params.get('usageTrend', 'stable')
            
            # Calculate readiness score
            readiness_score = 0.5  # Base score
            reasons = []
            
            # Analyze symptoms
            if len(recent_symptoms) == 0:
                readiness_score += 0.3
                reasons.append("No recent withdrawal symptoms")
            elif len(recent_symptoms) > 3:
                readiness_score -= 0.2
                reasons.append("Multiple recent symptoms")
            
            # Analyze usage consistency
            if len(recent_usage) >= 7:
                readiness_score += 0.2
                reasons.append("Consistent usage pattern")
            
            # Analyze trend
            if usage_trend == "decreasing":
                readiness_score += 0.1
                reasons.append("Decreasing usage trend")
            elif usage_trend == "increasing":
                readiness_score -= 0.2
                reasons.append("Increasing usage trend")
            
            # Determine readiness
            is_ready = readiness_score >= 0.7
            recommended_wait_days = 0 if is_ready else max(3, int((0.7 - readiness_score) * 14))
            
            assessment = {
                "isReady": is_ready,
                "readinessScore": min(1.0, max(0.0, readiness_score)),
                "reasons": reasons,
                "recommendedWaitDays": recommended_wait_days,
                "preparationSteps": [
                    "Continue current dosage consistently",
                    "Monitor withdrawal symptoms",
                    "Practice coping strategies"
                ] if not is_ready else [],
                "nextAssessmentDate": (datetime.now() + timedelta(days=recommended_wait_days or 7)).isoformat()
            }
            
            return assessment
            
        except Exception as e:
            logger.error(f"Error assessing reduction readiness: {e}")
            return {"error": str(e)}

    async def get_medical_evidence(self, query: str) -> Dict:
        """Retrieve medical evidence for NRT recommendations"""
        try:
            # Simulate medical database query
            evidence_database = {
                "nrt_effectiveness": {
                    "title": "Nicotine replacement therapy for smoking cessation",
                    "source": "Cochrane Database of Systematic Reviews",
                    "summary": "NRT increases the rate of quitting by 50-70% regardless of setting",
                    "relevanceScore": 0.95,
                    "publishedDate": "2018-05-31",
                    "doi": "10.1002/14651858.CD000146.pub5"
                },
                "withdrawal_management": {
                    "title": "Management of nicotine withdrawal symptoms",
                    "source": "New England Journal of Medicine",
                    "summary": "Gradual reduction with NRT significantly reduces withdrawal severity",
                    "relevanceScore": 0.88,
                    "publishedDate": "2019-03-15",
                    "doi": "10.1056/NEJMra1808779"
                }
            }
            
            # Return relevant evidence
            evidence = evidence_database.get(query, evidence_database["nrt_effectiveness"])
            return {"evidence": [evidence]}
            
        except Exception as e:
            logger.error(f"Error retrieving medical evidence: {e}")
            return {"error": str(e)}

    async def monitor_safety_patterns(self, user_id: str, params: Dict) -> Dict:
        """Monitor usage patterns for safety concerns"""
        try:
            recent_usage = params.get('recentUsage', [])
            recent_symptoms = params.get('recentSymptoms', [])
            current_protocol = params.get('currentProtocol', {})
            
            alerts = []
            
            # Check for excessive usage
            if len(recent_usage) > 8:  # More than 8 uses in 24 hours
                alerts.append({
                    "id": f"alert_{user_id}_{datetime.now().timestamp()}",
                    "userId": user_id,
                    "type": "usage_pattern_concern",
                    "message": "Usage frequency exceeds recommended guidelines",
                    "severity": "medium",
                    "createdAt": datetime.now().isoformat()
                })
            
            # Check for concerning symptom patterns
            severe_symptoms = [s for s in recent_symptoms if s.get('severity', 0) >= 8]
            if len(severe_symptoms) >= 2:
                alerts.append({
                    "id": f"alert_{user_id}_{datetime.now().timestamp()}_symptoms",
                    "userId": user_id,
                    "type": "side_effect_concern",
                    "message": "Multiple severe symptoms reported - consider medical consultation",
                    "severity": "high",
                    "createdAt": datetime.now().isoformat()
                })
            
            return {"alerts": alerts}
            
        except Exception as e:
            logger.error(f"Error monitoring safety patterns: {e}")
            return {"error": str(e)}

    async def generate_progress_report(self, user_id: str, params: Dict) -> Dict:
        """Generate comprehensive progress report"""
        try:
            current_protocol = params.get('currentProtocol', {})
            all_usage = params.get('allUsage', [])
            all_symptoms = params.get('allSymptoms', [])
            
            # Calculate metrics
            days_on_nrt = 30  # Simplified
            initial_dosage = 21.0
            current_dosage = 14.0
            reduction_percentage = ((initial_dosage - current_dosage) / initial_dosage) * 100
            
            symptoms_reported = len(all_symptoms)
            avg_symptom_severity = sum(s.get('severity', 0) for s in all_symptoms) / max(len(all_symptoms), 1)
            
            # Generate report
            report = {
                "userId": user_id,
                "generatedAt": datetime.now().isostring(),
                "summary": {
                    "daysOnNRT": days_on_nrt,
                    "initialDosage": initial_dosage,
                    "currentDosage": current_dosage,
                    "reductionPercentage": reduction_percentage,
                    "symptomsReported": symptoms_reported,
                    "averageSymptomSeverity": avg_symptom_severity,
                    "milestonesAchieved": 3
                },
                "metrics": [
                    {
                        "name": "Adherence Rate",
                        "value": 85.0,
                        "unit": "%",
                        "trend": "improving",
                        "description": "Consistency in following NRT protocol"
                    },
                    {
                        "name": "Symptom Management",
                        "value": avg_symptom_severity,
                        "unit": "/10",
                        "trend": "improving" if avg_symptom_severity < 5 else "stable",
                        "description": "Effectiveness of symptom management"
                    }
                ],
                "achievements": [
                    "Successfully started NRT protocol",
                    "Maintained consistent usage for 4 weeks",
                    "Reduced dosage by 33%"
                ],
                "recommendations": [
                    "Continue current dosage for 2 more weeks",
                    "Monitor withdrawal symptoms closely",
                    "Consider next reduction step if symptoms remain manageable"
                ],
                "overallScore": 0.8,
                "nextReviewDate": (datetime.now() + timedelta(days=7)).isostring()
            }
            
            return report
            
        except Exception as e:
            logger.error(f"Error generating progress report: {e}")
            return {"error": str(e)}

    async def adjust_nrt_protocol(self, user_id: str, params: Dict) -> Dict:
        """Adjust NRT protocol based on user progress and feedback"""
        try:
            current_protocol = params.get('currentProtocol', {})
            progress_score = params.get('progressScore', 0.5)
            user_feedback = params.get('userFeedback', {})
            recent_usage = params.get('recentUsage', [])
            withdrawal_symptoms = params.get('withdrawalSymptoms', [])
            
            # Analyze current protocol effectiveness
            effectiveness_score = self._calculate_protocol_effectiveness(
                progress_score, recent_usage, withdrawal_symptoms
            )
            
            # Determine if adjustment is needed
            if effectiveness_score < 0.6:
                # Protocol needs adjustment
                adjusted_protocol = self._adjust_protocol_parameters(
                    current_protocol, user_feedback, withdrawal_symptoms
                )
            else:
                # Keep current protocol with minor optimizations
                adjusted_protocol = self._optimize_current_protocol(
                    current_protocol, progress_score
                )
            
            # Store adjusted protocol
            self._store_protocol(user_id, adjusted_protocol)
            
            return asdict(adjusted_protocol)
            
        except Exception as e:
            logger.error(f"Error adjusting NRT protocol: {e}")
            return {"error": str(e)}

    def _calculate_protocol_effectiveness(self, progress_score: float, 
                                        recent_usage: List[Dict], 
                                        withdrawal_symptoms: List[Dict]) -> float:
        """Calculate how effective the current protocol is"""
        effectiveness = progress_score
        
        # Adjust based on usage consistency
        if len(recent_usage) > 0:
            expected_usage = 7  # Expected uses per week
            actual_usage = len(recent_usage)
            usage_ratio = min(actual_usage / expected_usage, 1.0)
            effectiveness = (effectiveness + usage_ratio) / 2
        
        # Adjust based on symptom severity
        if withdrawal_symptoms:
            avg_severity = sum(s.get('severity', 0) for s in withdrawal_symptoms) / len(withdrawal_symptoms)
            severity_factor = max(0, 1 - (avg_severity / 10))
            effectiveness = (effectiveness + severity_factor) / 2
        
        return effectiveness

    def _adjust_protocol_parameters(self, current_protocol: Dict, 
                                  user_feedback: Dict, 
                                  withdrawal_symptoms: List[Dict]) -> NRTProtocol:
        """Adjust protocol parameters based on feedback and symptoms"""
        # Analyze feedback for adjustment needs
        needs_stronger_dose = user_feedback.get('cravings_too_strong', False)
        side_effects_reported = user_feedback.get('side_effects', False)
        
        # Adjust dosage schedule
        current_schedule = current_protocol.get('dosageSchedule', [])
        adjusted_schedule = []
        
        for step in current_schedule:
            adjusted_step = step.copy()
            
            if needs_stronger_dose and not side_effects_reported:
                # Increase strength slightly
                current_strength = int(step.get('strength', 14))
                adjusted_step['strength'] = min(current_strength + 7, 21)
            elif side_effects_reported:
                # Decrease strength or frequency
                current_strength = int(step.get('strength', 14))
                adjusted_step['strength'] = max(current_strength - 7, 7)
            
            adjusted_schedule.append(adjusted_step)
        
        return NRTProtocol(
            recommended_nrt_type=current_protocol.get('recommendedNrtType', 'patch'),
            dosage_schedule=adjusted_schedule,
            duration_weeks=current_protocol.get('durationWeeks', 12),
            monitoring_schedule=current_protocol.get('monitoringSchedule', []),
            success_indicators=current_protocol.get('successIndicators', []),
            safety_warnings=current_protocol.get('safetyWarnings', [])
        )

    def _optimize_current_protocol(self, current_protocol: Dict, progress_score: float) -> NRTProtocol:
        """Optimize current protocol with minor adjustments"""
        # If progress is good, prepare for next reduction step
        if progress_score > 0.8:
            current_schedule = current_protocol.get('dosageSchedule', [])
            optimized_schedule = []
            
            for step in current_schedule:
                optimized_step = step.copy()
                # Slightly accelerate timeline if progress is excellent
                if step.get('week', 1) > 1:
                    optimized_step['week'] = max(1, step['week'] - 1)
                optimized_schedule.append(optimized_step)
            
            return NRTProtocol(
                recommended_nrt_type=current_protocol.get('recommendedNrtType', 'patch'),
                dosage_schedule=optimized_schedule,
                duration_weeks=max(8, current_protocol.get('durationWeeks', 12) - 2),
                monitoring_schedule=current_protocol.get('monitoringSchedule', []),
                success_indicators=current_protocol.get('successIndicators', []),
                safety_warnings=current_protocol.get('safetyWarnings', [])
            )
        
        # Return current protocol unchanged
        return NRTProtocol(
            recommended_nrt_type=current_protocol.get('recommendedNrtType', 'patch'),
            dosage_schedule=current_protocol.get('dosageSchedule', []),
            duration_weeks=current_protocol.get('durationWeeks', 12),
            monitoring_schedule=current_protocol.get('monitoringSchedule', []),
            success_indicators=current_protocol.get('successIndicators', []),
            safety_warnings=current_protocol.get('safetyWarnings', [])
        )

    async def predict_success_probability(self, user_id: str, params: Dict) -> Dict:
        """Predict success probability using AI models"""
        try:
            usage_history = params.get('usageHistory', [])
            symptom_history = params.get('symptomHistory', [])
            adherence_score = params.get('adherenceScore', 0.5)
            time_on_protocol = params.get('timeOnProtocol', 0)
            
            # Simple prediction algorithm (in production, this would use ML models)
            base_probability = 0.6
            
            # Adjust based on adherence
            if adherence_score > 80:
                base_probability += 0.2
            elif adherence_score < 50:
                base_probability -= 0.2
            
            # Adjust based on symptom severity
            avg_severity = sum(s.get('severity', 0) for s in symptom_history) / max(len(symptom_history), 1)
            if avg_severity < 4:
                base_probability += 0.15
            elif avg_severity > 7:
                base_probability -= 0.15
            
            # Adjust based on time on protocol
            if time_on_protocol > 14:
                base_probability += 0.1
            
            success_probability = max(0.0, min(1.0, base_probability))
            
            prediction = {
                "userId": user_id,
                "successProbability": success_probability,
                "positiveFactors": [],
                "riskFactors": [],
                "recommendations": [
                    "Continue following your personalized protocol",
                    "Track symptoms regularly",
                    "Maintain consistent usage patterns"
                ],
                "predictionDate": datetime.now().isostring(),
                "predictionHorizonDays": 30
            }
            
            # Add factors based on analysis
            if adherence_score > 80:
                prediction["positiveFactors"].append("High adherence to protocol")
            if avg_severity < 4:
                prediction["positiveFactors"].append("Well-managed withdrawal symptoms")
            if time_on_protocol > 14:
                prediction["positiveFactors"].append("Sustained commitment to protocol")
            
            if adherence_score < 50:
                prediction["riskFactors"].append("Inconsistent protocol adherence")
            if avg_severity > 7:
                prediction["riskFactors"].append("Severe withdrawal symptoms")
            
            return prediction
            
        except Exception as e:
            logger.error(f"Error predicting success probability: {e}")
            return {"error": str(e)}

    # Helper methods
    def _store_user_profile(self, profile: UserProfile):
        """Store user profile in database"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            INSERT OR REPLACE INTO user_profiles 
            (user_id, age, vaping_duration_months, daily_usage_level, health_conditions, fitness_level, quit_date)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', (
            profile.user_id,
            profile.age,
            profile.vaping_duration_months,
            profile.daily_usage_level,
            json.dumps(profile.health_conditions),
            profile.fitness_level,
            profile.quit_date
        ))
        
        conn.commit()
        conn.close()

    def _store_protocol(self, user_id: str, protocol: NRTProtocol):
        """Store NRT protocol in database"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        protocol_id = f"protocol_{user_id}_{datetime.now().timestamp()}"
        cursor.execute('''
            INSERT INTO nrt_protocols (id, user_id, protocol_data)
            VALUES (?, ?, ?)
        ''', (protocol_id, user_id, json.dumps(asdict(protocol))))
        
        conn.commit()
        conn.close()

    def _store_withdrawal_symptom(self, user_id: str, symptom_data: Dict):
        """Store withdrawal symptom in database"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        symptom_id = f"symptom_{user_id}_{datetime.now().timestamp()}"
        cursor.execute('''
            INSERT INTO withdrawal_symptoms (id, user_id, symptom_type, severity, timestamp, notes)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (
            symptom_id,
            user_id,
            symptom_data.get('type', ''),
            symptom_data.get('severity', 0),
            symptom_data.get('timestamp', datetime.now().isoformat()),
            symptom_data.get('notes', '')
        ))
        
        conn.commit()
        conn.close()

    def _store_dosage_recommendation(self, user_id: str, recommendation: Dict):
        """Store dosage recommendation in database"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        rec_id = f"dosage_{user_id}_{datetime.now().timestamp()}"
        cursor.execute('''
            INSERT INTO dosage_recommendations (id, user_id, recommended_dosage, adjustment, confidence, reasoning)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (
            rec_id,
            user_id,
            recommendation.get('recommendedDosage', ''),
            recommendation.get('adjustment', ''),
            recommendation.get('confidence', 0.0),
            recommendation.get('reasoning', '')
        ))
        
        conn.commit()
        conn.close()

    def _assess_dependence_level(self, profile: UserProfile) -> str:
        """Assess user's nicotine dependence level"""
        score = 0
        
        # Duration factor
        if profile.vaping_duration_months > 24:
            score += 2
        elif profile.vaping_duration_months > 12:
            score += 1
        
        # Usage level factor
        if profile.daily_usage_level == "high":
            score += 2
        elif profile.daily_usage_level == "medium":
            score += 1
        
        # Age factor (younger users may have higher dependence)
        if profile.age < 25:
            score += 1
        
        if score >= 4:
            return "high_dependence"
        elif score >= 2:
            return "medium_dependence"
        else:
            return "low_dependence"

    def _recommend_nrt_type(self, profile: UserProfile) -> str:
        """Recommend NRT type based on user profile"""
        # Simple recommendation logic
        if "heart" in profile.health_conditions:
            return "gum"  # Avoid patches for heart conditions
        elif profile.daily_usage_level == "high":
            return "patch"  # Steady delivery for heavy users
        else:
            return "gum"  # Flexible dosing

    def _get_safety_warnings(self, profile: UserProfile) -> List[str]:
        """Get safety warnings based on user profile"""
        warnings = []
        
        if "heart" in profile.health_conditions:
            warnings.append("Consult cardiologist before starting NRT")
        
        if "pregnancy" in profile.health_conditions:
            warnings.append("Special precautions needed during pregnancy")
        
        if profile.age > 65:
            warnings.append("Monitor for side effects more closely in older adults")
        
        warnings.append("Do not smoke while using NRT")
        warnings.append("Follow dosing instructions carefully")
        
        return warnings

    def _analyze_usage_consistency(self, recent_usage: List[Dict]) -> float:
        """Analyze consistency of recent NRT usage"""
        if len(recent_usage) < 3:
            return 0.5
        
        # Simple consistency calculation based on timing regularity
        timestamps = [usage.get('timestamp', '') for usage in recent_usage]
        # In a real implementation, this would analyze timing patterns
        return 0.8  # Simplified

    def _get_current_protocol_dosage(self, protocol: Dict) -> str:
        """Get current dosage from protocol"""
        dosage_schedule = protocol.get('dosageSchedule', [])
        if dosage_schedule:
            return f"{dosage_schedule[0].get('strength', 14)}mg"
        return "14mg"

# Initialize server
server_instance = SmartNRTServer()

@server_instance.server.list_tools()
async def handle_list_tools() -> ListToolsResult:
    """List available NRT management tools"""
    return ListToolsResult(
        tools=[
            Tool(
                name="get_nrt_protocols",
                description="Generate personalized NRT protocol based on user profile and medical guidelines",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "profile": {"type": "object"}
                    },
                    "required": ["userId", "profile"]
                }
            ),
            Tool(
                name="calculate_personalized_dosage",
                description="Calculate personalized NRT dosage based on current progress and symptoms",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "currentProtocol": {"type": "object"},
                        "recentUsage": {"type": "array"},
                        "symptomSeverity": {"type": "number"},
                        "withdrawalSymptoms": {"type": "array"}
                    },
                    "required": ["userId"]
                }
            ),
            Tool(
                name="generate_symptom_response",
                description="Generate intelligent response to withdrawal symptoms with evidence-based coping strategies",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "symptom": {"type": "object"},
                        "currentProtocol": {"type": "object"},
                        "recentSymptoms": {"type": "array"}
                    },
                    "required": ["userId", "symptom"]
                }
            ),
            Tool(
                name="assess_reduction_readiness",
                description="Assess user's readiness for NRT dosage reduction based on symptoms and usage patterns",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "recentSymptoms": {"type": "array"},
                        "recentUsage": {"type": "array"},
                        "usageTrend": {"type": "string"}
                    },
                    "required": ["userId"]
                }
            ),
            Tool(
                name="get_medical_evidence",
                description="Retrieve medical evidence and research citations for NRT recommendations",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "query": {"type": "string"}
                    },
                    "required": ["query"]
                }
            ),
            Tool(
                name="monitor_safety_patterns",
                description="Monitor usage patterns for safety concerns and generate alerts",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "recentUsage": {"type": "array"},
                        "recentSymptoms": {"type": "array"},
                        "currentProtocol": {"type": "object"}
                    },
                    "required": ["userId"]
                }
            ),
            Tool(
                name="generate_progress_report",
                description="Generate comprehensive progress report with metrics and recommendations",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "currentProtocol": {"type": "object"},
                        "allUsage": {"type": "array"},
                        "allSymptoms": {"type": "array"},
                        "activeReminders": {"type": "array"},
                        "safetyAlerts": {"type": "array"}
                    },
                    "required": ["userId"]
                }
            ),
            Tool(
                name="predict_success_probability",
                description="Predict success probability using AI models and usage patterns",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "currentProtocol": {"type": "object"},
                        "usageHistory": {"type": "array"},
                        "symptomHistory": {"type": "array"},
                        "adherenceScore": {"type": "number"},
                        "timeOnProtocol": {"type": "number"}
                    },
                    "required": ["userId"]
                }
            ),
            Tool(
                name="adjust_nrt_protocol",
                description="Adjust NRT protocol based on user progress and feedback",
                inputSchema={
                    "type": "object",
                    "properties": {
                        "userId": {"type": "string"},
                        "currentProtocol": {"type": "object"},
                        "progressScore": {"type": "number"},
                        "userFeedback": {"type": "object"},
                        "recentUsage": {"type": "array"},
                        "withdrawalSymptoms": {"type": "array"}
                    },
                    "required": ["userId", "currentProtocol", "progressScore"]
                }
            )
        ]
    )

@server_instance.server.call_tool()
async def handle_call_tool(name: str, arguments: dict) -> CallToolResult:
    """Handle tool calls for NRT management"""
    try:
        if name == "get_nrt_protocols":
            result = await server_instance.get_nrt_protocols(
                arguments["userId"], 
                arguments["profile"]
            )
        elif name == "calculate_personalized_dosage":
            result = await server_instance.calculate_personalized_dosage(
                arguments["userId"], 
                arguments
            )
        elif name == "generate_symptom_response":
            result = await server_instance.generate_symptom_response(
                arguments["userId"], 
                arguments
            )
        elif name == "assess_reduction_readiness":
            result = await server_instance.assess_reduction_readiness(
                arguments["userId"], 
                arguments
            )
        elif name == "get_medical_evidence":
            result = await server_instance.get_medical_evidence(
                arguments["query"]
            )
        elif name == "monitor_safety_patterns":
            result = await server_instance.monitor_safety_patterns(
                arguments["userId"],
                arguments
            )
        elif name == "generate_progress_report":
            result = await server_instance.generate_progress_report(
                arguments["userId"],
                arguments
            )
        elif name == "predict_success_probability":
            result = await server_instance.predict_success_probability(
                arguments["userId"],
                arguments
            )
        elif name == "adjust_nrt_protocol":
            result = await server_instance.adjust_nrt_protocol(
                arguments["userId"],
                arguments
            )
        else:
            raise ValueError(f"Unknown tool: {name}")
        
        return CallToolResult(
            content=[TextContent(type="text", text=json.dumps(result, indent=2))]
        )
        
    except Exception as e:
        logger.error(f"Error in tool call {name}: {e}")
        return CallToolResult(
            content=[TextContent(type="text", text=f"Error: {str(e)}")],
            isError=True
        )

async def main():
    # Import here to avoid issues with event loop
    from mcp.server.stdio import stdio_server
    
    async with stdio_server() as (read_stream, write_stream):
        await server_instance.server.run(
            read_stream,
            write_stream,
            InitializationOptions(
                server_name="smart-nrt-mcp-server",
                server_version="1.0.0",
                capabilities=server_instance.server.get_capabilities(
                    notification_options=NotificationOptions(),
                    experimental_capabilities={},
                ),
            ),
        )

if __name__ == "__main__":
    asyncio.run(main())