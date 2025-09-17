import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/services/mcp_client_service.dart';
import 'package:quit_vaping/data/services/community_support_service.dart';

import 'community_support_service_test.mocks.dart';

@GenerateMocks([MCPClientService])
void main() {
  group('CommunitySupport Service Tests', () {
    late CommunitySupportService communityService;
    late MockMCPClientService mockMcpClient;

    setUp(() {
      mockMcpClient = MockMCPClientService();
      communityService = CommunitySupportService(mockMcpClient);
    });

    tearDown(() {
      communityService.dispose();
    });

    group('User Profile Creation', () {
      test('should create user profile successfully', () async {
        // Arrange
        const userId = 'test_user_123';
        const daysQuit = 15;
        final supportPreferences = [SupportType.emotional, SupportType.motivational];
        final availabilityHours = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'anonymous_id': 'anon_123456',
            'quit_stage': 'first_month',
            'profile_created': true,
            'matching_enabled': true,
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await communityService.createUserProfile(
          userId: userId,
          daysQuit: daysQuit,
          supportPreferences: supportPreferences,
          availabilityHours: availabilityHours,
        );

        // Assert
        expect(result.anonymousId, equals('anon_123456'));
        expect(result.quitStage, equals(QuitStage.firstMonth));
        expect(result.profileCreated, isTrue);
        expect(result.matchingEnabled, isTrue);

        verify(mockMcpClient.sendRequest(argThat(predicate<MCPRequest>((request) =>
            request.method == 'create_user_profile' &&
            request.params['user_id'] == userId &&
            request.params['days_quit'] == daysQuit &&
            request.params['support_preferences'].contains('emotional') &&
            request.params['support_preferences'].contains('motivational')
        )))).called(1);
      });

      test('should handle profile creation error', () async {
        // Arrange
        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.error,
          data: {},
          timestamp: DateTime.now(),
          error: 'Profile creation failed',
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => communityService.createUserProfile(
            userId: 'test_user',
            daysQuit: 10,
            supportPreferences: [SupportType.emotional],
            availabilityHours: [9, 10, 11],
          ),
          throwsA(isA<CommunityException>()),
        );
      });
    });

    group('Peer Matching', () {
      test('should find peer matches successfully', () async {
        // Arrange
        const userId = 'test_user_123';
        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'matches': [
              {
                'anonymous_id': 'peer_456',
                'compatibility_score': 0.85,
                'quit_stage': 'first_month',
                'days_quit': 18,
                'support_types': ['emotional', 'practical'],
                'common_interests': ['fitness', 'meditation'],
                'timezone': 'UTC',
                'last_active': DateTime.now().toIso8601String(),
              },
              {
                'anonymous_id': 'peer_789',
                'compatibility_score': 0.72,
                'quit_stage': 'first_month',
                'days_quit': 12,
                'support_types': ['motivational'],
                'common_interests': ['reading'],
                'timezone': 'UTC',
                'last_active': DateTime.now().toIso8601String(),
              }
            ],
            'total_found': 2,
            'matching_algorithm': 'ai_compatibility_scoring',
            'timestamp': DateTime.now().toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final matches = await communityService.findPeerMatches(
          userId: userId,
          maxMatches: 5,
          minCompatibilityScore: 0.3,
        );

        // Assert
        expect(matches, hasLength(2));
        
        final firstMatch = matches[0];
        expect(firstMatch.anonymousId, equals('peer_456'));
        expect(firstMatch.compatibilityScore, equals(0.85));
        expect(firstMatch.quitStage, equals(QuitStage.firstMonth));
        expect(firstMatch.daysQuit, equals(18));
        expect(firstMatch.supportTypes, contains(SupportType.emotional));
        expect(firstMatch.supportTypes, contains(SupportType.practical));
        expect(firstMatch.commonInterests, contains('fitness'));
        expect(firstMatch.commonInterests, contains('meditation'));

        verify(mockMcpClient.sendRequest(argThat(predicate<MCPRequest>((request) =>
            request.method == 'find_peer_matches' &&
            request.params['user_id'] == userId &&
            request.params['max_matches'] == 5 &&
            request.params['min_compatibility_score'] == 0.3
        )))).called(1);
      });

      test('should handle empty peer matches', () async {
        // Arrange
        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'matches': [],
            'total_found': 0,
            'matching_algorithm': 'ai_compatibility_scoring',
            'timestamp': DateTime.now().toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final matches = await communityService.findPeerMatches(userId: 'test_user');

        // Assert
        expect(matches, isEmpty);
      });
    });

    group('Secure Messaging', () {
      test('should send secure message successfully', () async {
        // Arrange
        const senderUserId = 'sender_123';
        const recipientAnonymousId = 'recipient_456';
        const content = 'Hi! How are you doing on your quit journey?';

        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'message_id': 'msg_123456',
            'sent': true,
            'encrypted': true,
            'expires_at': DateTime.now().add(Duration(hours: 24)).toIso8601String(),
            'delivery_status': 'pending',
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await communityService.sendSecureMessage(
          senderUserId: senderUserId,
          recipientAnonymousId: recipientAnonymousId,
          content: content,
        );

        // Assert
        expect(result.messageId, equals('msg_123456'));
        expect(result.sent, isTrue);
        expect(result.encrypted, isTrue);
        expect(result.deliveryStatus, equals('pending'));

        verify(mockMcpClient.sendRequest(argThat(predicate<MCPRequest>((request) =>
            request.method == 'send_secure_message' &&
            request.params['sender_user_id'] == senderUserId &&
            request.params['recipient_anonymous_id'] == recipientAnonymousId &&
            request.params['content'] == content
        )))).called(1);
      });

      test('should get messages successfully', () async {
        // Arrange
        const userId = 'test_user_123';
        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'messages': [
              {
                'message_id': 'msg_001',
                'sender_anonymous_id': 'sender_anon_123',
                'content': 'Great job on your progress!',
                'message_type': 'support',
                'timestamp': DateTime.now().toIso8601String(),
                'expires_at': DateTime.now().add(Duration(hours: 24)).toIso8601String(),
              }
            ],
            'total_count': 1,
            'user_anonymous_id': 'user_anon_456',
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final messages = await communityService.getMessages(userId: userId);

        // Assert
        expect(messages, hasLength(1));
        expect(messages[0].messageId, equals('msg_001'));
        expect(messages[0].senderAnonymousId, equals('sender_anon_123'));
        expect(messages[0].content, equals('Great job on your progress!'));
        expect(messages[0].messageType, equals('support'));
      });
    });

    group('AI-Generated Support', () {
      test('should generate supportive response for struggling user', () async {
        // Arrange
        const context = 'User is experiencing a strong craving';
        const userMood = 'struggling';
        const supportType = SupportType.emotional;

        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'response': 'I understand how difficult this moment feels. Every craving you resist makes you stronger.',
            'support_type': 'emotional',
            'mood_addressed': 'struggling',
            'confidence': 0.85,
            'follow_up_suggestions': [
              'Would you like to connect with someone who has been through this?',
              'Can I help you create a personalized coping strategy?',
            ],
            'generated_at': DateTime.now().toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final response = await communityService.generateSupportiveResponse(
          context: context,
          userMood: userMood,
          supportType: supportType,
        );

        // Assert
        expect(response.response, contains('understand'));
        expect(response.supportType, equals(supportType));
        expect(response.moodAddressed, equals('struggling'));
        expect(response.confidence, equals(0.85));
        expect(response.followUpSuggestions, hasLength(2));
      });

      test('should generate practical response for anxious user', () async {
        // Arrange
        const context = 'User is feeling anxious about social situations';
        const userMood = 'anxious';
        const supportType = SupportType.practical;

        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'response': 'Ground yourself with the 5-4-3-2-1 technique: Name 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, 1 you can taste.',
            'support_type': 'practical',
            'mood_addressed': 'anxious',
            'confidence': 0.90,
            'follow_up_suggestions': [
              'Would breathing exercises be helpful right now?',
              'Can I suggest other grounding techniques?',
            ],
            'generated_at': DateTime.now().toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final response = await communityService.generateSupportiveResponse(
          context: context,
          userMood: userMood,
          supportType: supportType,
        );

        // Assert
        expect(response.response, contains('5-4-3-2-1'));
        expect(response.supportType, equals(supportType));
        expect(response.moodAddressed, equals('anxious'));
        expect(response.confidence, equals(0.90));
      });
    });

    group('Milestone Sharing', () {
      test('should share milestone successfully', () async {
        // Arrange
        const userId = 'test_user_123';
        const milestoneType = 'first_week';
        const daysAchieved = 7;
        const personalMessage = 'Feeling great after my first week!';

        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'share_id': 'share_123456',
            'celebration_message': '🌟 One week smoke-free! Your body is already starting to heal and recover.',
            'milestone_type': 'first_week',
            'days_achieved': 7,
            'community_visibility': true,
            'encouragement_enabled': true,
            'shared_at': DateTime.now().toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await communityService.shareMilestone(
          userId: userId,
          milestoneType: milestoneType,
          daysAchieved: daysAchieved,
          personalMessage: personalMessage,
        );

        // Assert
        expect(result.shareId, equals('share_123456'));
        expect(result.celebrationMessage, contains('week'));
        expect(result.milestoneType, equals('first_week'));
        expect(result.daysAchieved, equals(7));
        expect(result.communityVisibility, isTrue);
        expect(result.encouragementEnabled, isTrue);
      });

      test('should get community milestones successfully', () async {
        // Arrange
        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'milestones': [
              {
                'share_id': 'share_001',
                'anonymous_id': 'anon_123',
                'milestone_type': 'first_week',
                'days_achieved': 7,
                'message': 'First week completed!',
                'celebration_level': 'standard',
                'reactions': {'celebrate': 5, 'support': 3},
                'timestamp': DateTime.now().toIso8601String(),
              }
            ],
            'total_count': 1,
            'community_active': true,
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final milestones = await communityService.getCommunityMilestones();

        // Assert
        expect(milestones, hasLength(1));
        expect(milestones[0].shareId, equals('share_001'));
        expect(milestones[0].milestoneType, equals('first_week'));
        expect(milestones[0].daysAchieved, equals(7));
        expect(milestones[0].reactions['celebrate'], equals(5));
      });

      test('should react to milestone successfully', () async {
        // Arrange
        const userId = 'test_user_123';
        const shareId = 'share_456';
        const reactionType = 'celebrate';

        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'reaction_added': true,
            'reaction_type': 'celebrate',
            'total_reactions': 6,
            'milestone_id': 'share_456',
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await communityService.reactToMilestone(
          userId: userId,
          shareId: shareId,
          reactionType: reactionType,
        );

        // Assert
        expect(result.reactionAdded, isTrue);
        expect(result.reactionType, equals('celebrate'));
        expect(result.totalReactions, equals(6));
        expect(result.milestoneId, equals('share_456'));
      });
    });

    group('Error Handling', () {
      test('should handle MCP server errors gracefully', () async {
        // Arrange
        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.error,
          data: {},
          timestamp: DateTime.now(),
          error: 'Server temporarily unavailable',
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => communityService.createUserProfile(
            userId: 'test_user',
            daysQuit: 10,
            supportPreferences: [SupportType.emotional],
            availabilityHours: [9, 10, 11],
          ),
          throwsA(isA<CommunityException>()),
        );
      });
    });

    group('Stream Updates', () {
      test('should emit updates when peer matches are found', () async {
        // Arrange
        const userId = 'test_user_123';
        final mockResponse = MCPResponse(
          id: 'test_request_id',
          serverId: 'external-services-server',
          responseType: MCPResponseType.community,
          data: {
            'matches': [],
            'total_found': 0,
          },
          timestamp: DateTime.now(),
        );

        when(mockMcpClient.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final updatesFuture = communityService.updateStream.first;
        await communityService.findPeerMatches(userId: userId);
        final update = await updatesFuture;

        // Assert
        expect(update.type, equals(CommunityUpdateType.peerMatchesFound));
        expect(update.data, containsPair('total_found', 0));
      });
    });
  });
}