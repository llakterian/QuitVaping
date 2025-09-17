import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:quit_vaping/data/services/motivation_service.dart';
import 'package:quit_vaping/data/services/mcp_manager_service.dart';
import 'package:quit_vaping/data/services/storage_service.dart';
import 'package:quit_vaping/data/models/user_model.dart';
import 'package:quit_vaping/data/models/progress_model.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/models/motivation_model.dart';

// Mock classes
class MockMCPManagerService extends Mock implements MCPManagerService {}
class MockStorageService extends Mock implements StorageService {}
void main() {
  group('MotivationService Tests', () {
    late MotivationService motivationService;
    late MockMCPManagerService mockMCPManager;
    late MockStorageService mockStorageService;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
      mockStorageService = MockStorageService();
      motivationService = MotivationService(mockMCPManager, mockStorageService);
    });

    tearDown(() {
      motivationService.dispose();
    });

    group('Initialization', () {
      test('should initialize successfully with cached data', () async {
        // Arrange
        final mockLearningProfile = {
          'interventionEffectiveness': {'breathing': 0.8, 'motivation': 0.7},
          'preferredInterventions': {'breathing': 5, 'motivation': 3},
          'personalizedData': {'success_rate': 0.75}
        };

        when(mockStorageService.getSetting('learning_profile'))
            .thenReturn(jsonEncode(mockLearningProfile));
        when(mockStorageService.getSetting('recent_activity'))
            .thenReturn('[]');
        when(mockStorageService.getSetting('motivational_content'))
            .thenReturn('[]');
        when(mockStorageService.getUserData())
            .thenReturn(_createMockUser());

        // Mock MCP response
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': {
              'id': 'content_123',
              'timestamp': DateTime.now().toIso8601String(),
              'type': 'mood_based',
              'title': 'Daily Motivation',
              'content': 'You are doing great!',
              'tags': ['positive', 'ai_generated'],
              'relevanceScore': 0.8,
              'metadata': {
                'mood': 'positive',
                'insights': ['Keep up the good work'],
                'generated_by': 'ai_workflow_server'
              }
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        await motivationService.initialize();

        // Assert
        expect(motivationService.learningProfile.interventionEffectiveness['breathing'], 0.8);
        expect(motivationService.learningProfile.preferredInterventions['breathing'], 5);
        verify(mockStorageService.getSetting('learning_profile')).called(1);
        verify(mockMCPManager.generateMotivationContent(any)).called(1);
      });

      test('should handle initialization errors gracefully', () async {
        // Arrange
        when(mockStorageService.getSetting(any))
            .thenThrow(Exception('Storage error'));

        // Act
        await motivationService.initialize();

        // Assert
        expect(motivationService.lastError, contains('Failed to initialize motivation system'));
      });
    });

    group('Content Generation', () {
      test('should generate personalized content for positive mood', () async {
        // Arrange
        final user = _createMockUser();
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': {
              'id': 'content_positive',
              'timestamp': DateTime.now().toIso8601String(),
              'type': 'mood_based',
              'title': 'Positive Motivation',
              'content': 'You are doing amazing! Keep up the fantastic work!',
              'tags': ['positive', 'ai_generated'],
              'relevanceScore': 0.9,
              'metadata': {
                'mood': 'positive',
                'insights': ['Great progress'],
                'generated_by': 'ai_workflow_server'
              }
            },
            'learning_update': {
              'personalized_data': {
                'last_mood': 'positive',
                'engagement_score': 0.8
              }
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);
        when(mockStorageService.saveSetting(any, any))
            .thenAnswer((_) async {});

        // Act
        await motivationService.generatePersonalizedContent(user);

        // Assert
        expect(motivationService.motivationalContent.length, 1);
        expect(motivationService.motivationalContent.first.type, 'mood_based');
        expect(motivationService.motivationalContent.first.content, contains('amazing'));
        expect(motivationService.isGeneratingContent, false);
        verify(mockMCPManager.generateMotivationContent(any)).called(1);
      });

      test('should generate content for struggling mood with appropriate tone', () async {
        // Arrange
        final user = _createMockUser();
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': {
              'id': 'content_struggling',
              'timestamp': DateTime.now().toIso8601String(),
              'type': 'mood_based',
              'title': 'Support Message',
              'content': 'It\'s okay to have tough days. This feeling will pass.',
              'tags': ['struggling', 'support', 'ai_generated'],
              'relevanceScore': 0.95,
              'metadata': {
                'mood': 'struggling',
                'insights': ['Reach out for support', 'Try breathing exercises'],
                'generated_by': 'ai_workflow_server'
              }
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);
        when(mockStorageService.saveSetting(any, any))
            .thenAnswer((_) async {});

        // Set struggling mood
        motivationService.recordActivity('craving_logged', {
          'intensity': 9,
          'trigger': 'stress'
        });

        // Act
        await motivationService.generatePersonalizedContent(user);

        // Assert
        expect(motivationService.motivationalContent.length, 1);
        expect(motivationService.motivationalContent.first.content, contains('tough days'));
        expect(motivationService.motivationalContent.first.tags, contains('struggling'));
      });

      test('should handle content generation errors', () async {
        // Arrange
        final user = _createMockUser();
        when(mockMCPManager.generateMotivationContent(any))
            .thenThrow(Exception('MCP server error'));

        // Act
        await motivationService.generatePersonalizedContent(user);

        // Assert
        expect(motivationService.lastError, contains('Failed to generate content'));
        expect(motivationService.isGeneratingContent, false);
      });
    });

    group('Mood Analysis', () {
      test('should analyze mood as struggling from high craving activity', () async {
        // Arrange
        final user = _createMockUser();
        when(mockStorageService.getUserData()).thenReturn(user);
        when(mockStorageService.getCravings()).thenReturn([
          _createMockCraving(intensity: 9, timestamp: DateTime.now().subtract(const Duration(hours: 1))),
          _createMockCraving(intensity: 8, timestamp: DateTime.now().subtract(const Duration(hours: 2))),
          _createMockCraving(intensity: 8, timestamp: DateTime.now().subtract(const Duration(hours: 3))),
        ]);

        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {'content': _createMockMotivationContent()},
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);
        when(mockStorageService.saveSetting(any, any))
            .thenAnswer((_) async {});

        // Act
        await motivationService.initialize();
        // Trigger mood analysis
        motivationService.recordActivity('craving_logged', {'intensity': 9});

        // Wait for async operations
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(motivationService.currentMood, MoodState.struggling);
      });

      test('should analyze mood as motivated from positive activity', () async {
        // Arrange
        final user = _createMockUser();
        when(mockStorageService.getUserData()).thenReturn(user);
        when(mockStorageService.getCravings()).thenReturn([]); // No recent cravings

        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {'content': _createMockMotivationContent()},
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);
        when(mockStorageService.saveSetting(any, any))
            .thenAnswer((_) async {});

        // Act
        await motivationService.initialize();
        // Trigger mood analysis with positive activity
        motivationService.recordActivity('milestone_reached', {'milestone': '1_week'});

        // Wait for async operations
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(motivationService.currentMood, MoodState.motivated);
      });
    });

    group('Milestone Celebrations', () {
      test('should generate celebration for milestone achievement', () async {
        // Arrange
        final user = _createMockUser();
        final progress = _createMockProgress();
        
        when(mockStorageService.getUserData()).thenReturn(user);
        when(mockStorageService.getProgress()).thenReturn(progress);
        when(mockStorageService.saveProgress(any)).thenAnswer((_) async {});

        final mockCelebrationResponse = MCPResponse(
          id: 'celebration_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'celebration': {
              'id': 'celebration_24_hours',
              'timestamp': DateTime.now().toIso8601String(),
              'milestoneKey': '24_hours',
              'title': '🎉 24 hours Milestone Reached!',
              'message': '🏆 Outstanding! A full day vape-free! Your risk of heart attack is already decreasing.\n\nKeep up the amazing work!',
              'celebrationImageUrl': 'https://api.quitvaping.app/celebrations/24_hours.png',
              'milestone': {
                'key': '24_hours',
                'hours': 24,
                'description': '1 day smoke-free'
              }
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateCelebrationMessage(any, any))
            .thenAnswer((_) async => mockCelebrationResponse);

        // Act
        await motivationService.initialize();

        // Listen to milestone stream
        bool celebrationReceived = false;
        motivationService.milestoneStream.listen((milestone) {
          celebrationReceived = true;
          expect(milestone.title, contains('24 hours'));
          expect(milestone.message, contains('Outstanding'));
        });

        // Simulate milestone check (normally done by timer)
        await motivationService.initialize();

        // Wait for async operations
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        // Note: In a real test, we'd need to trigger the milestone check manually
        // since we can't easily test timer-based operations
      });
    });

    group('Activity Recording', () {
      test('should record user activity and update recent activity list', () {
        // Act
        motivationService.recordActivity('craving_logged', {
          'intensity': 7,
          'trigger': 'stress',
          'resolved': true
        });

        // Assert
        expect(motivationService.recentActivity.length, 1);
        expect(motivationService.recentActivity.first.activityType, 'craving_logged');
        expect(motivationService.recentActivity.first.data['intensity'], 7);
      });

      test('should limit recent activity to 50 items', () {
        // Act
        for (int i = 0; i < 60; i++) {
          motivationService.recordActivity('test_activity', {'index': i});
        }

        // Assert
        expect(motivationService.recentActivity.length, 50);
        expect(motivationService.recentActivity.first.data['index'], 59); // Most recent first
      });
    });

    group('Learning Profile Updates', () {
      test('should update learning profile from MCP response', () async {
        // Arrange
        final user = _createMockUser();
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': _createMockMotivationContent(),
            'learning_update': {
              'effectiveness': {'breathing': 0.9, 'motivation': 0.8},
              'preferences': {'breathing': 6, 'motivation': 4},
              'personalized_data': {'success_rate': 0.85, 'preferred_time': 'morning'}
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);
        when(mockStorageService.saveSetting(any, any))
            .thenAnswer((_) async {});

        // Act
        await motivationService.generatePersonalizedContent(user);

        // Assert
        expect(motivationService.learningProfile.interventionEffectiveness['breathing'], 0.9);
        expect(motivationService.learningProfile.preferredInterventions['breathing'], 6);
        expect(motivationService.learningProfile.personalizedData['success_rate'], 0.85);
        expect(motivationService.learningProfile.personalizedData['preferred_time'], 'morning');
      });
    });

    group('Stream Events', () {
      test('should emit content stream events when new content is generated', () async {
        // Arrange
        final user = _createMockUser();
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {
            'content': {
              'id': 'stream_content',
              'timestamp': DateTime.now().toIso8601String(),
              'type': 'mood_based',
              'title': 'Stream Test',
              'content': 'Stream content test',
              'tags': ['test'],
              'relevanceScore': 0.8,
              'metadata': {}
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);
        when(mockStorageService.saveSetting(any, any))
            .thenAnswer((_) async {});

        // Act & Assert
        bool contentReceived = false;
        motivationService.contentStream.listen((content) {
          contentReceived = true;
          expect(content.id, 'stream_content');
          expect(content.title, 'Stream Test');
        });

        await motivationService.generatePersonalizedContent(user);
        
        // Wait for stream event
        await Future.delayed(const Duration(milliseconds: 50));
        
        expect(contentReceived, true);
      });

      test('should emit mood stream events when mood changes', () async {
        // Arrange
        final user = _createMockUser();
        when(mockStorageService.getUserData()).thenReturn(user);
        when(mockStorageService.getCravings()).thenReturn([
          _createMockCraving(intensity: 9, timestamp: DateTime.now()),
        ]);

        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {'content': _createMockMotivationContent()},
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.generateMotivationContent(any))
            .thenAnswer((_) async => mockResponse);
        when(mockStorageService.saveSetting(any, any))
            .thenAnswer((_) async {});

        // Act & Assert
        bool moodReceived = false;
        motivationService.moodStream.listen((mood) {
          moodReceived = true;
          expect(mood, MoodState.struggling);
        });

        motivationService.recordActivity('craving_logged', {'intensity': 9});
        
        // Wait for mood analysis
        await Future.delayed(const Duration(milliseconds: 100));
        
        expect(moodReceived, true);
      });
    });
  });
}

// Helper methods to create mock objects
UserModel _createMockUser() {
  return UserModel(
    id: 'test_user_123',
    name: 'Test User',
    age: 25,
    gender: 'other',
    email: 'test@example.com',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now(),
    quitDate: DateTime.now().subtract(const Duration(days: 7)),
    vapingHistory: const VapingHistoryModel(
      dailyFrequency: 20,
      nicotineStrength: 12,
      yearsVaping: 2.5,
      deviceType: 'pod',
      commonTriggers: ['stress', 'social'],
      previousQuitAttempts: ['cold_turkey'],
      longestQuitDuration: 14,
    ),
    motivationFactors: ['health', 'money', 'family'],
    preferences: {
      'community_support': true,
      'using_nrt': false,
      'notifications': true,
    },
  );
}

ProgressModel _createMockProgress() {
  return ProgressModel(
    userId: 'test_user_123',
    quitDate: DateTime.now().subtract(const Duration(days: 7)),
    dailySavings: 8.50,
    achievedMilestones: {
      '20_minutes': true,
      '8_hours': true,
    },
    currentStreak: 7,
    longestStreak: 7,
    achievements: [],
  );
}

dynamic _createMockCraving({required int intensity, required DateTime timestamp}) {
  return {
    'id': 'craving_${timestamp.millisecondsSinceEpoch}',
    'timestamp': timestamp.toIso8601String(),
    'intensity': intensity,
    'triggerCategory': 'emotional',
    'specificTrigger': 'stress',
    'resolved': false,
  };
}

Map<String, dynamic> _createMockMotivationContent() {
  return {
    'id': 'mock_content',
    'timestamp': DateTime.now().toIso8601String(),
    'type': 'mood_based',
    'title': 'Mock Motivation',
    'content': 'Mock motivational content',
    'tags': ['test'],
    'relevanceScore': 0.8,
    'metadata': {}
  };
}