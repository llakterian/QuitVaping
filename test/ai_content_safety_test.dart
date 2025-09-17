import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/services/mcp_manager_service.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';

@GenerateMocks([MCPManagerService])
import 'ai_content_safety_test.mocks.dart';

void main() {
  group('AI Content Safety Tests', () {
    late MockMCPManagerService mockMCPManager;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
    });

    group('Content Appropriateness Validation', () {
      test('should validate positive motivational content', () async {
        // Arrange
        final safeMotivationResponse = MCPResponse(
          id: 'safe-motivation-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': 'You\'re making excellent progress on your quit journey! Every day without vaping is a victory for your health.',
            'contentType': 'encouragement',
            'safetyScore': 0.98,
            'flaggedContent': false,
            'moderationTags': ['positive', 'supportive', 'health-focused', 'encouraging'],
            'toxicityScore': 0.02,
            'sentimentScore': 0.95,
          },
          confidence: 0.95,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => safeMotivationResponse);

        // Act
        final context = _createTestContext(MoodState.motivated);
        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert content safety
        expect(result.data['safetyScore'], greaterThan(0.95));
        expect(result.data['flaggedContent'], isFalse);
        expect(result.data['toxicityScore'], lessThan(0.1));
        expect(result.data['sentimentScore'], greaterThan(0.8));
        expect(result.data['moderationTags'], contains('positive'));
        expect(result.data['moderationTags'], contains('supportive'));
        
        // Verify content doesn't contain harmful language
        final content = result.data['content'] as String;
        expect(content, isNot(contains(RegExp(r'harm|danger|fail|impossible|hopeless', caseSensitive: false))));
        expect(content, contains(RegExp(r'progress|victory|health|excellent', caseSensitive: false)));
      });

      test('should detect and handle inappropriate content', () async {
        // Arrange
        final inappropriateResponse = MCPResponse(
          id: 'inappropriate-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.error,
          data: {
            'error': 'Content flagged by safety filter',
            'originalContent': 'You\'ll probably fail anyway, most people do',
            'safetyScore': 0.25,
            'flaggedContent': true,
            'moderationTags': ['negative', 'discouraging', 'harmful'],
            'toxicityScore': 0.85,
            'sentimentScore': -0.7,
            'flaggedReasons': ['discouraging_language', 'negative_prediction'],
            'fallbackContent': 'Quitting vaping is challenging, but you have the strength to succeed. Take it one day at a time.',
          },
          timestamp: DateTime.now(),
          error: 'Content safety violation',
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => inappropriateResponse);

        // Act
        final context = _createTestContext(MoodState.struggling);
        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert safety handling
        expect(result.responseType, equals(MCPResponseType.error));
        expect(result.data['flaggedContent'], isTrue);
        expect(result.data['safetyScore'], lessThan(0.5));
        expect(result.data['toxicityScore'], greaterThan(0.5));
        expect(result.data['sentimentScore'], lessThan(0));
        expect(result.data['flaggedReasons'], isNotEmpty);
        expect(result.data['fallbackContent'], isNotNull);
        expect(result.error, contains('safety'));
      });

      test('should validate intervention content safety', () async {
        // Arrange
        final safeInterventionResponse = MCPResponse(
          id: 'safe-intervention-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.intervention,
          data: {
            'plan': {
              'immediate': [
                {'type': 'breathing', 'instruction': 'Take slow, deep breaths for 2 minutes'},
                {'type': 'distraction', 'instruction': 'Drink a glass of cold water slowly'},
              ],
              'followup': [
                {'type': 'reflection', 'instruction': 'Journal about what triggered this craving'},
              ],
            },
            'safetyScore': 0.96,
            'flaggedContent': false,
            'moderationTags': ['safe', 'helpful', 'evidence-based'],
            'medicalSafety': true,
            'harmfulInstructions': false,
          },
          confidence: 0.92,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.createInterventionPlan(any))
            .thenAnswer((_) async => safeInterventionResponse);

        // Act
        final context = _createTestContext(MoodState.struggling);
        final result = await mockMCPManager.createInterventionPlan(context);

        // Assert intervention safety
        expect(result.data['safetyScore'], greaterThan(0.95));
        expect(result.data['flaggedContent'], isFalse);
        expect(result.data['medicalSafety'], isTrue);
        expect(result.data['harmfulInstructions'], isFalse);
        expect(result.data['moderationTags'], contains('safe'));
        expect(result.data['moderationTags'], contains('evidence-based'));

        // Verify intervention instructions are safe
        final plan = result.data['plan'] as Map<String, dynamic>;
        final immediateActions = plan['immediate'] as List;
        
        for (final action in immediateActions) {
          final instruction = action['instruction'] as String;
          expect(instruction, isNot(contains(RegExp(r'dangerous|harmful|risky|unsafe', caseSensitive: false))));
          expect(instruction, isNot(contains(RegExp(r'medication|drug|substance', caseSensitive: false))));
        }
      });

      test('should detect harmful intervention suggestions', () async {
        // Arrange
        final harmfulInterventionResponse = MCPResponse(
          id: 'harmful-intervention-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.error,
          data: {
            'error': 'Intervention flagged for safety concerns',
            'originalPlan': {
              'immediate': [
                {'type': 'medication', 'instruction': 'Take extra medication to cope'},
              ],
            },
            'safetyScore': 0.15,
            'flaggedContent': true,
            'moderationTags': ['unsafe', 'medical_advice', 'potentially_harmful'],
            'medicalSafety': false,
            'harmfulInstructions': true,
            'flaggedReasons': ['unauthorized_medical_advice', 'medication_suggestion'],
            'fallbackPlan': {
              'immediate': [
                {'type': 'breathing', 'instruction': 'Practice deep breathing exercises'},
                {'type': 'support', 'instruction': 'Contact your healthcare provider if needed'},
              ],
            },
          },
          timestamp: DateTime.now(),
          error: 'Unsafe intervention content',
        );

        when(mockMCPManager.createInterventionPlan(any))
            .thenAnswer((_) async => harmfulInterventionResponse);

        // Act
        final context = _createTestContext(MoodState.struggling);
        final result = await mockMCPManager.createInterventionPlan(context);

        // Assert safety handling
        expect(result.responseType, equals(MCPResponseType.error));
        expect(result.data['flaggedContent'], isTrue);
        expect(result.data['safetyScore'], lessThan(0.5));
        expect(result.data['medicalSafety'], isFalse);
        expect(result.data['harmfulInstructions'], isTrue);
        expect(result.data['flaggedReasons'], contains('unauthorized_medical_advice'));
        expect(result.data['fallbackPlan'], isNotNull);
      });
    });

    group('Content Quality Validation', () {
      test('should validate content relevance and helpfulness', () async {
        // Arrange
        final relevantResponse = MCPResponse(
          id: 'relevant-content-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': 'Since you mentioned feeling stressed at work, try the 4-7-8 breathing technique during your lunch break.',
            'relevanceScore': 0.94,
            'helpfulnessScore': 0.91,
            'personalizationScore': 0.88,
            'contextualAccuracy': 0.93,
            'actionableContent': true,
            'evidenceBased': true,
            'personalizationFactors': ['work_stress', 'lunch_break_timing', 'breathing_preference'],
          },
          confidence: 0.92,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => relevantResponse);

        // Act
        final context = _createTestContext(MoodState.struggling, triggers: ['work_stress']);
        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert content quality
        expect(result.data['relevanceScore'], greaterThan(0.9));
        expect(result.data['helpfulnessScore'], greaterThan(0.9));
        expect(result.data['personalizationScore'], greaterThan(0.8));
        expect(result.data['contextualAccuracy'], greaterThan(0.9));
        expect(result.data['actionableContent'], isTrue);
        expect(result.data['evidenceBased'], isTrue);
        expect(result.data['personalizationFactors'], contains('work_stress'));
      });

      test('should detect low-quality or generic content', () async {
        // Arrange
        final lowQualityResponse = MCPResponse(
          id: 'low-quality-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': 'Good luck with your thing.',
            'relevanceScore': 0.25,
            'helpfulnessScore': 0.15,
            'personalizationScore': 0.05,
            'contextualAccuracy': 0.20,
            'actionableContent': false,
            'evidenceBased': false,
            'qualityFlags': ['too_generic', 'not_actionable', 'low_relevance'],
            'improvementSuggestions': [
              'Add specific context about quitting vaping',
              'Include actionable steps',
              'Personalize based on user data',
            ],
          },
          confidence: 0.25,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => lowQualityResponse);

        // Act
        final context = _createTestContext(MoodState.motivated);
        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert quality detection
        expect(result.data['relevanceScore'], lessThan(0.5));
        expect(result.data['helpfulnessScore'], lessThan(0.5));
        expect(result.data['personalizationScore'], lessThan(0.5));
        expect(result.data['actionableContent'], isFalse);
        expect(result.data['evidenceBased'], isFalse);
        expect(result.data['qualityFlags'], contains('too_generic'));
        expect(result.data['improvementSuggestions'], isNotEmpty);
        expect(result.confidence, lessThan(0.5));
      });
    });

    group('Medical and Health Content Safety', () {
      test('should validate health information accuracy', () async {
        // Arrange
        final accurateHealthResponse = MCPResponse(
          id: 'accurate-health-1',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'timeline': [
              {'time': '20 minutes', 'benefit': 'Heart rate and blood pressure drop'},
              {'time': '12 hours', 'benefit': 'Carbon monoxide level normalizes'},
              {'time': '2-12 weeks', 'benefit': 'Circulation improves and lung function increases'},
            ],
            'medicalAccuracy': 0.98,
            'evidenceLevel': 'peer_reviewed',
            'sourcesVerified': true,
            'disclaimerIncluded': true,
            'medicalClaims': [
              'Heart rate normalization',
              'Blood pressure improvement',
              'Carbon monoxide reduction',
            ],
            'disclaimer': 'Individual results may vary. Consult healthcare provider for personalized advice.',
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getHealthRecoveryTimeline(any))
            .thenAnswer((_) async => accurateHealthResponse);

        // Act
        final result = await mockMCPManager.getHealthRecoveryTimeline('test-user');

        // Assert medical accuracy
        expect(result.data['medicalAccuracy'], greaterThan(0.95));
        expect(result.data['evidenceLevel'], equals('peer_reviewed'));
        expect(result.data['sourcesVerified'], isTrue);
        expect(result.data['disclaimerIncluded'], isTrue);
        expect(result.data['disclaimer'], contains('healthcare provider'));
        expect(result.data['medicalClaims'], isNotEmpty);
      });

      test('should flag unverified medical claims', () async {
        // Arrange
        final unverifiedHealthResponse = MCPResponse(
          id: 'unverified-health-1',
          serverId: 'health-data-server',
          responseType: MCPResponseType.error,
          data: {
            'error': 'Unverified medical claims detected',
            'originalContent': 'Quitting vaping will cure all your health problems instantly',
            'medicalAccuracy': 0.15,
            'evidenceLevel': 'unverified',
            'sourcesVerified': false,
            'flaggedClaims': [
              'cure_all_claim',
              'instant_results_claim',
              'absolute_health_guarantee',
            ],
            'correctedContent': 'Quitting vaping provides many health benefits over time. Individual results vary.',
            'disclaimer': 'This information is for educational purposes only. Consult your healthcare provider.',
          },
          timestamp: DateTime.now(),
          error: 'Medical content safety violation',
        );

        when(mockMCPManager.getHealthRecoveryTimeline(any))
            .thenAnswer((_) async => unverifiedHealthResponse);

        // Act
        final result = await mockMCPManager.getHealthRecoveryTimeline('test-user');

        // Assert medical safety
        expect(result.responseType, equals(MCPResponseType.error));
        expect(result.data['medicalAccuracy'], lessThan(0.5));
        expect(result.data['evidenceLevel'], equals('unverified'));
        expect(result.data['sourcesVerified'], isFalse);
        expect(result.data['flaggedClaims'], contains('cure_all_claim'));
        expect(result.data['correctedContent'], isNotNull);
        expect(result.error, contains('Medical content safety'));
      });
    });

    group('Bias and Fairness Testing', () {
      test('should provide inclusive and non-discriminatory content', () async {
        // Arrange
        final inclusiveResponse = MCPResponse(
          id: 'inclusive-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': 'Your quit journey is unique to you. Whether you\'re using NRT, going cold turkey, or trying other methods, what matters is finding what works for your situation.',
            'inclusivityScore': 0.95,
            'biasScore': 0.08,
            'discriminatoryContent': false,
            'inclusiveLanguage': true,
            'culturalSensitivity': 0.92,
            'accessibilityFriendly': true,
            'diversityFactors': ['method_neutral', 'situation_aware', 'non_judgmental'],
          },
          confidence: 0.93,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => inclusiveResponse);

        // Act
        final context = _createTestContext(MoodState.motivated);
        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert inclusivity
        expect(result.data['inclusivityScore'], greaterThan(0.9));
        expect(result.data['biasScore'], lessThan(0.2));
        expect(result.data['discriminatoryContent'], isFalse);
        expect(result.data['inclusiveLanguage'], isTrue);
        expect(result.data['culturalSensitivity'], greaterThan(0.9));
        expect(result.data['accessibilityFriendly'], isTrue);
        expect(result.data['diversityFactors'], contains('non_judgmental'));
      });

      test('should detect and flag biased content', () async {
        // Arrange
        final biasedResponse = MCPResponse(
          id: 'biased-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.error,
          data: {
            'error': 'Biased content detected',
            'originalContent': 'Only weak people need help quitting. Strong people just stop.',
            'inclusivityScore': 0.15,
            'biasScore': 0.88,
            'discriminatoryContent': true,
            'biasTypes': ['strength_bias', 'help_seeking_stigma', 'judgmental_language'],
            'correctedContent': 'Quitting vaping is challenging for everyone. Seeking support shows strength and wisdom.',
            'inclusiveAlternative': 'Everyone\'s quit journey is different. Support and resources are available to help you succeed.',
          },
          timestamp: DateTime.now(),
          error: 'Content bias violation',
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => biasedResponse);

        // Act
        final context = _createTestContext(MoodState.struggling);
        final result = await mockMCPManager.generateMotivationContent(context);

        // Assert bias detection
        expect(result.responseType, equals(MCPResponseType.error));
        expect(result.data['inclusivityScore'], lessThan(0.5));
        expect(result.data['biasScore'], greaterThan(0.5));
        expect(result.data['discriminatoryContent'], isTrue);
        expect(result.data['biasTypes'], contains('judgmental_language'));
        expect(result.data['correctedContent'], isNotNull);
        expect(result.data['inclusiveAlternative'], isNotNull);
      });
    });

    group('Crisis and Emergency Content Safety', () {
      test('should handle crisis situations appropriately', () async {
        // Arrange
        final crisisResponse = MCPResponse(
          id: 'crisis-1',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.intervention,
          data: {
            'plan': {
              'immediate': [
                {'type': 'crisis_support', 'instruction': 'If you\'re having thoughts of self-harm, please contact emergency services or a crisis hotline immediately'},
                {'type': 'professional_help', 'instruction': 'Reach out to a healthcare professional or counselor'},
              ],
              'resources': [
                {'type': 'crisis_hotline', 'number': '988', 'description': 'National Suicide Prevention Lifeline'},
                {'type': 'emergency', 'number': '911', 'description': 'Emergency services'},
              ],
            },
            'crisisDetected': true,
            'professionalHelpRecommended': true,
            'emergencyResourcesProvided': true,
            'safetyPriority': 'highest',
            'aiLimitations': 'AI cannot replace professional mental health support',
          },
          confidence: 0.98,
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.createInterventionPlan(any))
            .thenAnswer((_) async => crisisResponse);

        // Act
        final crisisContext = _createTestContext(MoodState.struggling, isCrisis: true);
        final result = await mockMCPManager.createInterventionPlan(crisisContext);

        // Assert crisis handling
        expect(result.data['crisisDetected'], isTrue);
        expect(result.data['professionalHelpRecommended'], isTrue);
        expect(result.data['emergencyResourcesProvided'], isTrue);
        expect(result.data['safetyPriority'], equals('highest'));
        expect(result.data['aiLimitations'], contains('cannot replace professional'));
        
        final resources = result.data['plan']['resources'] as List;
        expect(resources.any((r) => r['type'] == 'crisis_hotline'), isTrue);
        expect(resources.any((r) => r['type'] == 'emergency'), isTrue);
      });
    });
  });
}

// Helper function to create test context
AIWorkflowContext _createTestContext(MoodState mood, {List<String>? triggers, bool isCrisis = false}) {
  return AIWorkflowContext(
    userId: 'test-user',
    currentMood: mood,
    recentActivity: [
      UserActivity(
        type: isCrisis ? 'crisis_reported' : 'mood_update',
        timestamp: DateTime.now(),
        data: {'mood': mood.name, 'triggers': triggers ?? []},
      ),
    ],
    externalFactors: ExternalFactors(
      weather: 'sunny',
      timeOfDay: 'afternoon',
      location: 'home',
    ),
    availableInterventions: [
      InterventionType.breathing,
      InterventionType.distraction,
      InterventionType.motivation,
    ],
    learningData: UserLearningProfile(
      userId: 'test-user',
      preferredInterventions: ['breathing'],
      successfulStrategies: ['deep_breathing'],
      triggerPatterns: triggers ?? [],
      lastUpdated: DateTime.now(),
    ),
  );
}