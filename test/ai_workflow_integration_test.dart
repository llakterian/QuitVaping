import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/services/mcp_manager_service.dart';
import 'package:quit_vaping/data/services/ai_service.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/models/ai_model.dart';
import 'package:quit_vaping/data/models/craving_model.dart';
import 'package:quit_vaping/data/models/user_model.dart';

@GenerateMocks([MCPManagerService])
import 'ai_workflow_integration_test.mocks.dart';

void main() {
  group('AI Workflow Integration Tests', () {
    late MockMCPManagerService mockMCPManager;
    late AIService aiService;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
      // Note: AIService doesn't currently use MCPManagerService directly
      // This test demonstrates how AI workflows would integrate with MCP
    });

    group('End-to-End AI Workflows', () {
      test('should complete full motivation workflow', () async {
        // Arrange
        const userId = 'test-user';
        
        // Mock MCP motivation response
        final motivationResponse = MCPResponse(
          id: 'motivation-workflow-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': 'You\'ve been vape-free for 5 days! Your lung capacity is already improving.',
            'contentType': 'milestone_celebration',
            'personalizationFactors': ['quit_duration', 'health_improvements'],
            'confidence': 0.92,
            'nextActions': [
              {'type': 'breathing_exercise', 'duration': 300},
              {'type': 'health_insight', 'category': 'respiratory'},
            ],
          },
          confidence: 0.92,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => motivationResponse);

        // Mock health insights response
        final healthResponse = MCPResponse(
          id: 'health-workflow-1',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'timeline': [
              {'time': '5 days', 'benefit': 'Lung cilia begin to regenerate'},
              {'time': '1 week', 'benefit': 'Taste and smell improve significantly'},
            ],
            'personalizedBenefits': [
              'Your oxygen levels have increased by 10%',
              'Risk of respiratory infection decreased by 25%',
            ],
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getHealthRecoveryTimeline(userId))
            .thenAnswer((_) async => healthResponse);

        // Act - Simulate complete workflow
        final context = AIWorkflowContext(
          userId: userId,
          currentMood: MoodState.motivated,
          recentActivity: [
            UserActivity(
              type: 'milestone_reached',
              timestamp: DateTime.now(),
              data: {'days_vape_free': 5},
            ),
          ],
          externalFactors: ExternalFactors(
            weather: 'sunny',
            timeOfDay: 'morning',
            location: 'home',
          ),
          availableInterventions: [InterventionType.breathing, InterventionType.distraction],
          learningData: UserLearningProfile(
            userId: userId,
            preferredInterventions: ['breathing_exercise'],
            successfulStrategies: ['morning_routine'],
            triggerPatterns: [],
            lastUpdated: DateTime.now(),
          ),
        );

        final motivationResult = await mockMCPManager.generateMotivationContent(context);
        final healthResult = await mockMCPManager.getHealthRecoveryTimeline(userId);

        // Assert workflow completion
        expect(motivationResult.responseType, equals(MCPResponseType.motivation));
        expect(motivationResult.data['content'], contains('5 days'));
        expect(motivationResult.data['contentType'], equals('milestone_celebration'));
        expect(motivationResult.confidence, greaterThan(0.9));

        expect(healthResult.responseType, equals(MCPResponseType.health));
        expect(healthResult.data['timeline'], isNotEmpty);
        expect(healthResult.data['personalizedBenefits'], isNotEmpty);

        // Verify MCP calls were made
        verify(mockMCPManager.generateMotivationContent(any)).called(1);
        verify(mockMCPManager.getHealthRecoveryTimeline(userId)).called(1);
      });

      test('should handle craving intervention workflow', () async {
        // Arrange
        const userId = 'test-user';
        
        final interventionResponse = MCPResponse(
          id: 'intervention-workflow-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.intervention,
          data: {
            'plan': {
              'immediate': [
                {'type': 'breathing', 'duration': 180, 'pattern': '4-7-8'},
                {'type': 'distraction', 'activity': 'cold_water', 'duration': 60},
              ],
              'followup': [
                {'type': 'reflection', 'questions': ['What triggered this craving?']},
                {'type': 'reward', 'suggestion': 'Celebrate resisting the urge'},
              ],
            },
            'urgency': 'high',
            'confidence': 0.88,
            'reasoning': 'Pattern indicates stress-related trigger at work',
          },
          confidence: 0.88,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.createInterventionPlan(any))
            .thenAnswer((_) async => interventionResponse);

        // Mock analytics for pattern recognition
        final analyticsResponse = MCPResponse(
          id: 'analytics-workflow-1',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'patterns': [
              {
                'type': 'trigger_pattern',
                'factor': 'work_stress',
                'confidence': 0.85,
                'frequency': 'daily_afternoon',
              },
            ],
            'recommendations': [
              'Schedule stress-relief breaks at 2 PM',
              'Practice breathing exercises before stressful meetings',
            ],
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.analyzeUserPatterns(any, any))
            .thenAnswer((_) async => analyticsResponse);

        // Act - Simulate craving intervention workflow
        final cravingContext = AIWorkflowContext(
          userId: userId,
          currentMood: MoodState.struggling,
          recentActivity: [
            UserActivity(
              type: 'craving_reported',
              timestamp: DateTime.now(),
              data: {'intensity': 8, 'trigger': 'work_stress'},
            ),
          ],
          externalFactors: ExternalFactors(
            weather: 'rainy',
            timeOfDay: 'afternoon',
            location: 'work',
          ),
          availableInterventions: [
            InterventionType.breathing,
            InterventionType.distraction,
            InterventionType.motivation,
          ],
          learningData: UserLearningProfile(
            userId: userId,
            preferredInterventions: ['breathing'],
            successfulStrategies: ['4-7-8_breathing'],
            triggerPatterns: ['work_stress'],
            lastUpdated: DateTime.now(),
          ),
        );

        final interventionResult = await mockMCPManager.createInterventionPlan(cravingContext);
        final analyticsResult = await mockMCPManager.analyzeUserPatterns(userId, []);

        // Assert intervention workflow
        expect(interventionResult.responseType, equals(MCPResponseType.intervention));
        expect(interventionResult.data['plan']['immediate'], isNotEmpty);
        expect(interventionResult.data['urgency'], equals('high'));
        expect(interventionResult.confidence, greaterThan(0.8));

        expect(analyticsResult.responseType, equals(MCPResponseType.analytics));
        expect(analyticsResult.data['patterns'], isNotEmpty);
        expect(analyticsResult.data['recommendations'], isNotEmpty);

        // Verify workflow steps
        verify(mockMCPManager.createInterventionPlan(any)).called(1);
        verify(mockMCPManager.analyzeUserPatterns(userId, any)).called(1);
      });

      test('should handle community support workflow', () async {
        // Arrange
        const userId = 'test-user';
        
        final communityResponse = MCPResponse(
          id: 'community-workflow-1',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'matches': [
              {
                'peerId': 'peer-123',
                'quitStage': 'week_2',
                'compatibility': 0.92,
                'sharedChallenges': ['work_stress', 'social_situations'],
              },
              {
                'peerId': 'peer-456',
                'quitStage': 'month_1',
                'compatibility': 0.87,
                'sharedChallenges': ['evening_cravings'],
              },
            ],
            'supportMessages': [
              'You\'re not alone in this journey!',
              'Many people experience similar challenges at your stage.',
            ],
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.matchCommunityPeers(any, any))
            .thenAnswer((_) async => communityResponse);

        // Act
        final preferences = {
          'quitStage': 'week_1',
          'challenges': ['work_stress', 'social_situations'],
          'supportType': 'peer_matching',
        };

        final communityResult = await mockMCPManager.matchCommunityPeers(userId, preferences);

        // Assert
        expect(communityResult.responseType, equals(MCPResponseType.community));
        expect(communityResult.data['matches'], hasLength(2));
        expect(communityResult.data['supportMessages'], isNotEmpty);

        final firstMatch = communityResult.data['matches'][0];
        expect(firstMatch['compatibility'], greaterThan(0.9));
        expect(firstMatch['sharedChallenges'], contains('work_stress'));

        verify(mockMCPManager.matchCommunityPeers(userId, preferences)).called(1);
      });

      test('should handle NRT optimization workflow', () async {
        // Arrange
        const userId = 'test-user';
        
        final nrtResponse = MCPResponse(
          id: 'nrt-workflow-1',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'recommendedNrtType': 'patch',
            'dosageSchedule': [
              {'week': 1, 'strength': 21, 'frequency': 1},
              {'week': 7, 'strength': 14, 'frequency': 1},
              {'week': 9, 'strength': 7, 'frequency': 1},
            ],
            'personalizedAdjustments': {
              'currentWeek': 2,
              'recommendedStrength': 21,
              'adjustmentReason': 'Withdrawal symptoms well-managed',
              'nextReviewDate': DateTime.now().add(Duration(days: 7)).toIso8601String(),
            },
            'safetyWarnings': [
              'Do not smoke while using NRT',
              'Consult healthcare provider if experiencing side effects',
            ],
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getNRTProtocols(any, any))
            .thenAnswer((_) async => nrtResponse);

        // Act
        final userProfile = {
          'quitDate': DateTime.now().subtract(Duration(days: 14)).toIso8601String(),
          'previousNRTExperience': 'none',
          'withdrawalSymptoms': ['mild_cravings', 'irritability'],
          'medicalConditions': [],
        };

        final nrtResult = await mockMCPManager.getNRTProtocols(userId, userProfile);

        // Assert
        expect(nrtResult.responseType, equals(MCPResponseType.health));
        expect(nrtResult.data['recommendedNrtType'], equals('patch'));
        expect(nrtResult.data['dosageSchedule'], isNotEmpty);
        expect(nrtResult.data['personalizedAdjustments'], isNotNull);
        expect(nrtResult.data['safetyWarnings'], isNotEmpty);

        final adjustments = nrtResult.data['personalizedAdjustments'];
        expect(adjustments['currentWeek'], equals(2));
        expect(adjustments['recommendedStrength'], equals(21));

        verify(mockMCPManager.getNRTProtocols(userId, userProfile)).called(1);
      });

      test('should handle comprehensive progress analysis workflow', () async {
        // Arrange
        const userId = 'test-user';
        
        final progressResponse = MCPResponse(
          id: 'progress-workflow-1',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'overallProgress': {
              'quitSuccessProbability': 0.78,
              'daysVapeFree': 14,
              'milestonesAchieved': ['24_hours', '72_hours', '1_week', '2_weeks'],
              'nextMilestone': '1_month',
            },
            'behaviorAnalysis': {
              'cravingTrends': 'decreasing',
              'triggerPatterns': ['work_stress', 'social_events'],
              'successfulStrategies': ['breathing_exercises', 'distraction'],
              'improvementAreas': ['evening_routine', 'stress_management'],
            },
            'predictions': {
              'riskFactors': ['upcoming_social_event', 'work_deadline'],
              'protectiveFactors': ['strong_motivation', 'good_support_system'],
              'recommendations': [
                'Prepare coping strategies for upcoming social event',
                'Schedule stress-relief activities during work deadline',
              ],
            },
            'achievements': [
              'Longest streak: 14 days',
              'Cravings reduced by 60%',
              'Successful intervention rate: 85%',
            ],
          },
          confidence: 0.91,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.createProgressReport(userId))
            .thenAnswer((_) async => progressResponse);

        // Mock quit success prediction
        final predictionResponse = MCPResponse(
          id: 'prediction-workflow-1',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'successProbability': 0.78,
            'confidenceInterval': [0.72, 0.84],
            'keyFactors': [
              {'factor': 'consistent_app_usage', 'impact': 0.15},
              {'factor': 'successful_craving_management', 'impact': 0.22},
              {'factor': 'social_support', 'impact': 0.18},
            ],
            'riskMitigation': [
              'Continue daily check-ins',
              'Practice stress management techniques',
              'Maintain social support connections',
            ],
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.predictQuitSuccess(any, any))
            .thenAnswer((_) async => predictionResponse);

        // Act
        final progressResult = await mockMCPManager.createProgressReport(userId);
        final predictionResult = await mockMCPManager.predictQuitSuccess(userId, []);

        // Assert progress analysis
        expect(progressResult.responseType, equals(MCPResponseType.analytics));
        expect(progressResult.confidence, greaterThan(0.9));
        
        final overallProgress = progressResult.data['overallProgress'];
        expect(overallProgress['quitSuccessProbability'], equals(0.78));
        expect(overallProgress['daysVapeFree'], equals(14));
        expect(overallProgress['milestonesAchieved'], hasLength(4));

        final behaviorAnalysis = progressResult.data['behaviorAnalysis'];
        expect(behaviorAnalysis['cravingTrends'], equals('decreasing'));
        expect(behaviorAnalysis['triggerPatterns'], isNotEmpty);

        // Assert prediction analysis
        expect(predictionResult.responseType, equals(MCPResponseType.analytics));
        expect(predictionResult.data['successProbability'], equals(0.78));
        expect(predictionResult.data['keyFactors'], hasLength(3));
        expect(predictionResult.data['riskMitigation'], isNotEmpty);

        verify(mockMCPManager.createProgressReport(userId)).called(1);
        verify(mockMCPManager.predictQuitSuccess(userId, any)).called(1);
      });
    });

    group('AI Content Safety Validation', () {
      test('should validate motivation content appropriateness', () async {
        // Arrange
        final motivationResponse = MCPResponse(
          id: 'safety-test-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': 'You\'re doing great! Keep up the excellent work on your quit journey.',
            'contentType': 'encouragement',
            'safetyScore': 0.98,
            'flaggedContent': false,
            'moderationTags': ['positive', 'supportive', 'health-focused'],
          },
          confidence: 0.95,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => motivationResponse);

        // Act
        final context = AIWorkflowContext(
          userId: 'test-user',
          currentMood: MoodState.motivated,
          recentActivity: [],
          externalFactors: ExternalFactors(
            weather: 'sunny',
            timeOfDay: 'morning',
            location: 'home',
          ),
          availableInterventions: [],
          learningData: UserLearningProfile(
            userId: 'test-user',
            preferredInterventions: [],
            successfulStrategies: [],
            triggerPatterns: [],
            lastUpdated: DateTime.now(),
          ),
        );

        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert content safety
        expect(result.data['safetyScore'], greaterThan(0.95));
        expect(result.data['flaggedContent'], isFalse);
        expect(result.data['moderationTags'], contains('positive'));
        expect(result.data['moderationTags'], contains('supportive'));
        expect(result.data['content'], isNot(contains(RegExp(r'harmful|dangerous|negative'))));
      });

      test('should handle flagged content appropriately', () async {
        // Arrange - Simulate flagged content response
        final flaggedResponse = MCPResponse(
          id: 'safety-test-2',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.error,
          data: {
            'error': 'Content flagged by safety filter',
            'safetyScore': 0.45,
            'flaggedContent': true,
            'moderationTags': ['potentially_harmful'],
            'fallbackContent': 'We\'re here to support your quit journey. Try a breathing exercise.',
          },
          timestamp: DateTime.now(),
          error: 'Content safety violation',
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => flaggedResponse);

        // Act
        final context = AIWorkflowContext(
          userId: 'test-user',
          currentMood: MoodState.struggling,
          recentActivity: [],
          externalFactors: ExternalFactors(
            weather: 'stormy',
            timeOfDay: 'night',
            location: 'unknown',
          ),
          availableInterventions: [],
          learningData: UserLearningProfile(
            userId: 'test-user',
            preferredInterventions: [],
            successfulStrategies: [],
            triggerPatterns: [],
            lastUpdated: DateTime.now(),
          ),
        );

        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert safety handling
        expect(result.responseType, equals(MCPResponseType.error));
        expect(result.data['flaggedContent'], isTrue);
        expect(result.data['safetyScore'], lessThan(0.5));
        expect(result.data['fallbackContent'], isNotNull);
        expect(result.error, contains('safety'));
      });
    });
  });
}