import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/mcp_model.dart';
import 'mcp_client_service.dart';

/// Community Support Service for peer matching and messaging
class CommunitySupportService {
  static const String _serverName = 'external-services-server';
  
  final MCPClientService _mcpClient;
  final StreamController<CommunityUpdate> _updateController = 
      StreamController<CommunityUpdate>.broadcast();

  CommunitySupportService(this._mcpClient);

  /// Stream of community updates
  Stream<CommunityUpdate> get updateStream => _updateController.stream;

  /// Create user profile for community matching
  Future<CommunityProfile> createUserProfile({
    required String userId,
    required int daysQuit,
    required List<SupportType> supportPreferences,
    required List<int> availabilityHours,
    String timezone = 'UTC',
    String language = 'en',
    List<String> interests = const [],
    List<String> personalityTraits = const [],
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'create_user_profile',
        serverId: _serverName,
        params: {
          'user_id': userId,
          'days_quit': daysQuit,
          'support_preferences': supportPreferences.map((e) => e.name).toList(),
          'availability_hours': availabilityHours,
          'timezone': timezone,
          'language': language,
          'interests': interests,
          'personality_traits': personalityTraits,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to create user profile: ${response.error}');
      }

      final data = response.data;
      return CommunityProfile(
        anonymousId: data['anonymous_id'] as String,
        quitStage: QuitStage.values.firstWhere(
          (stage) => stage.name == data['quit_stage'],
          orElse: () => QuitStage.preparing,
        ),
        profileCreated: data['profile_created'] as bool,
        matchingEnabled: data['matching_enabled'] as bool,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Error creating user profile: $e');
      rethrow;
    }
  }

  /// Find compatible peer matches
  Future<List<PeerMatch>> findPeerMatches({
    required String userId,
    int maxMatches = 5,
    double minCompatibilityScore = 0.3,
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'find_peer_matches',
        serverId: _serverName,
        params: {
          'user_id': userId,
          'max_matches': maxMatches,
          'min_compatibility_score': minCompatibilityScore,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to find peer matches: ${response.error}');
      }

      final data = response.data;
      final matches = (data['matches'] as List).map((match) {
        return PeerMatch(
          anonymousId: match['anonymous_id'] as String,
          compatibilityScore: (match['compatibility_score'] as num).toDouble(),
          quitStage: QuitStage.values.firstWhere(
            (stage) => stage.name == match['quit_stage'],
            orElse: () => QuitStage.preparing,
          ),
          daysQuit: match['days_quit'] as int,
          supportTypes: (match['support_types'] as List)
              .map((type) => SupportType.values.firstWhere(
                    (st) => st.name == type,
                    orElse: () => SupportType.emotional,
                  ))
              .toList(),
          commonInterests: List<String>.from(match['common_interests'] as List),
          timezone: match['timezone'] as String,
          lastActive: DateTime.parse(match['last_active'] as String),
        );
      }).toList();

      _updateController.add(CommunityUpdate(
        type: CommunityUpdateType.peerMatchesFound,
        data: {'matches': matches, 'total_found': data['total_found']},
        timestamp: DateTime.now(),
      ));

      return matches;
    } catch (e) {
      debugPrint('Error finding peer matches: $e');
      rethrow;
    }
  }

  /// Send secure message to peer
  Future<MessageResult> sendSecureMessage({
    required String senderUserId,
    required String recipientAnonymousId,
    required String content,
    String messageType = 'support',
    int expiresHours = 24,
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'send_secure_message',
        serverId: _serverName,
        params: {
          'sender_user_id': senderUserId,
          'recipient_anonymous_id': recipientAnonymousId,
          'content': content,
          'message_type': messageType,
          'expires_hours': expiresHours,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to send message: ${response.error}');
      }

      final data = response.data;
      final result = MessageResult(
        messageId: data['message_id'] as String,
        sent: data['sent'] as bool,
        encrypted: data['encrypted'] as bool,
        expiresAt: DateTime.parse(data['expires_at'] as String),
        deliveryStatus: data['delivery_status'] as String,
      );

      _updateController.add(CommunityUpdate(
        type: CommunityUpdateType.messageSent,
        data: {'message_result': result},
        timestamp: DateTime.now(),
      ));

      return result;
    } catch (e) {
      debugPrint('Error sending secure message: $e');
      rethrow;
    }
  }

  /// Get messages for user
  Future<List<CommunityMessage>> getMessages({
    required String userId,
    int limit = 20,
    String? messageType,
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'get_messages',
        serverId: _serverName,
        params: {
          'user_id': userId,
          'limit': limit,
          if (messageType != null) 'message_type': messageType,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to get messages: ${response.error}');
      }

      final data = response.data;
      final messages = (data['messages'] as List).map((msg) {
        return CommunityMessage(
          messageId: msg['message_id'] as String,
          senderAnonymousId: msg['sender_anonymous_id'] as String,
          content: msg['content'] as String,
          messageType: msg['message_type'] as String,
          timestamp: DateTime.parse(msg['timestamp'] as String),
          expiresAt: msg['expires_at'] != null 
              ? DateTime.parse(msg['expires_at'] as String)
              : null,
        );
      }).toList();

      return messages;
    } catch (e) {
      debugPrint('Error getting messages: $e');
      rethrow;
    }
  }

  /// Generate AI-powered supportive response
  Future<SupportiveResponse> generateSupportiveResponse({
    required String context,
    required String userMood,
    required SupportType supportType,
    Map<String, dynamic>? personalizationData,
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'generate_supportive_response',
        serverId: _serverName,
        params: {
          'context': context,
          'user_mood': userMood,
          'support_type': supportType.name,
          if (personalizationData != null) 'personalization_data': personalizationData,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to generate supportive response: ${response.error}');
      }

      final data = response.data;
      return SupportiveResponse(
        response: data['response'] as String,
        supportType: supportType,
        moodAddressed: data['mood_addressed'] as String,
        confidence: (data['confidence'] as num).toDouble(),
        followUpSuggestions: List<String>.from(data['follow_up_suggestions'] as List),
        generatedAt: DateTime.parse(data['generated_at'] as String),
      );
    } catch (e) {
      debugPrint('Error generating supportive response: $e');
      rethrow;
    }
  }

  /// Share milestone with community
  Future<MilestoneShareResult> shareMilestone({
    required String userId,
    required String milestoneType,
    required int daysAchieved,
    String personalMessage = '',
    String celebrationLevel = 'standard',
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'share_milestone',
        serverId: _serverName,
        params: {
          'user_id': userId,
          'milestone_type': milestoneType,
          'days_achieved': daysAchieved,
          'personal_message': personalMessage,
          'celebration_level': celebrationLevel,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to share milestone: ${response.error}');
      }

      final data = response.data;
      final result = MilestoneShareResult(
        shareId: data['share_id'] as String,
        celebrationMessage: data['celebration_message'] as String,
        milestoneType: data['milestone_type'] as String,
        daysAchieved: data['days_achieved'] as int,
        communityVisibility: data['community_visibility'] as bool,
        encouragementEnabled: data['encouragement_enabled'] as bool,
        sharedAt: DateTime.parse(data['shared_at'] as String),
      );

      _updateController.add(CommunityUpdate(
        type: CommunityUpdateType.milestoneShared,
        data: {'milestone_result': result},
        timestamp: DateTime.now(),
      ));

      return result;
    } catch (e) {
      debugPrint('Error sharing milestone: $e');
      rethrow;
    }
  }

  /// Get community milestones
  Future<List<CommunityMilestone>> getCommunityMilestones({
    int limit = 10,
    String? milestoneType,
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'get_community_milestones',
        serverId: _serverName,
        params: {
          'limit': limit,
          if (milestoneType != null) 'milestone_type': milestoneType,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to get community milestones: ${response.error}');
      }

      final data = response.data;
      final milestones = (data['milestones'] as List).map((milestone) {
        return CommunityMilestone(
          shareId: milestone['share_id'] as String,
          anonymousId: milestone['anonymous_id'] as String,
          milestoneType: milestone['milestone_type'] as String,
          daysAchieved: milestone['days_achieved'] as int,
          message: milestone['message'] as String,
          celebrationLevel: milestone['celebration_level'] as String,
          reactions: Map<String, int>.from(milestone['reactions'] as Map),
          timestamp: DateTime.parse(milestone['timestamp'] as String),
        );
      }).toList();

      return milestones;
    } catch (e) {
      debugPrint('Error getting community milestones: $e');
      rethrow;
    }
  }

  /// React to a milestone
  Future<ReactionResult> reactToMilestone({
    required String userId,
    required String shareId,
    required String reactionType,
  }) async {
    try {
      final request = MCPRequest(
        id: _generateRequestId(),
        method: 'react_to_milestone',
        serverId: _serverName,
        params: {
          'user_id': userId,
          'share_id': shareId,
          'reaction_type': reactionType,
        },
      );

      final response = await _mcpClient.sendRequest(request);
      
      if (response.error != null) {
        throw CommunityException('Failed to react to milestone: ${response.error}');
      }

      final data = response.data;
      final result = ReactionResult(
        reactionAdded: data['reaction_added'] as bool,
        reactionType: data['reaction_type'] as String,
        totalReactions: data['total_reactions'] as int,
        milestoneId: data['milestone_id'] as String,
      );

      _updateController.add(CommunityUpdate(
        type: CommunityUpdateType.reactionAdded,
        data: {'reaction_result': result},
        timestamp: DateTime.now(),
      ));

      return result;
    } catch (e) {
      debugPrint('Error reacting to milestone: $e');
      rethrow;
    }
  }

  String _generateRequestId() {
    return 'community_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
  }

  void dispose() {
    _updateController.close();
  }
}

/// Community-related data models

enum QuitStage {
  preparing,
  firstWeek,
  firstMonth,
  threeMonths,
  sixMonths,
  oneYear,
  longTerm,
}

enum SupportType {
  emotional,
  practical,
  motivational,
  crisis,
  celebration,
}

enum CommunityUpdateType {
  peerMatchesFound,
  messageSent,
  messageReceived,
  milestoneShared,
  reactionAdded,
}

class CommunityProfile {
  final String anonymousId;
  final QuitStage quitStage;
  final bool profileCreated;
  final bool matchingEnabled;
  final DateTime createdAt;

  CommunityProfile({
    required this.anonymousId,
    required this.quitStage,
    required this.profileCreated,
    required this.matchingEnabled,
    required this.createdAt,
  });
}

class PeerMatch {
  final String anonymousId;
  final double compatibilityScore;
  final QuitStage quitStage;
  final int daysQuit;
  final List<SupportType> supportTypes;
  final List<String> commonInterests;
  final String timezone;
  final DateTime lastActive;

  PeerMatch({
    required this.anonymousId,
    required this.compatibilityScore,
    required this.quitStage,
    required this.daysQuit,
    required this.supportTypes,
    required this.commonInterests,
    required this.timezone,
    required this.lastActive,
  });
}

class MessageResult {
  final String messageId;
  final bool sent;
  final bool encrypted;
  final DateTime expiresAt;
  final String deliveryStatus;

  MessageResult({
    required this.messageId,
    required this.sent,
    required this.encrypted,
    required this.expiresAt,
    required this.deliveryStatus,
  });
}

class CommunityMessage {
  final String messageId;
  final String senderAnonymousId;
  final String content;
  final String messageType;
  final DateTime timestamp;
  final DateTime? expiresAt;

  CommunityMessage({
    required this.messageId,
    required this.senderAnonymousId,
    required this.content,
    required this.messageType,
    required this.timestamp,
    this.expiresAt,
  });
}

class SupportiveResponse {
  final String response;
  final SupportType supportType;
  final String moodAddressed;
  final double confidence;
  final List<String> followUpSuggestions;
  final DateTime generatedAt;

  SupportiveResponse({
    required this.response,
    required this.supportType,
    required this.moodAddressed,
    required this.confidence,
    required this.followUpSuggestions,
    required this.generatedAt,
  });
}

class MilestoneShareResult {
  final String shareId;
  final String celebrationMessage;
  final String milestoneType;
  final int daysAchieved;
  final bool communityVisibility;
  final bool encouragementEnabled;
  final DateTime sharedAt;

  MilestoneShareResult({
    required this.shareId,
    required this.celebrationMessage,
    required this.milestoneType,
    required this.daysAchieved,
    required this.communityVisibility,
    required this.encouragementEnabled,
    required this.sharedAt,
  });
}

class CommunityMilestone {
  final String shareId;
  final String anonymousId;
  final String milestoneType;
  final int daysAchieved;
  final String message;
  final String celebrationLevel;
  final Map<String, int> reactions;
  final DateTime timestamp;

  CommunityMilestone({
    required this.shareId,
    required this.anonymousId,
    required this.milestoneType,
    required this.daysAchieved,
    required this.message,
    required this.celebrationLevel,
    required this.reactions,
    required this.timestamp,
  });
}

class ReactionResult {
  final bool reactionAdded;
  final String reactionType;
  final int totalReactions;
  final String milestoneId;

  ReactionResult({
    required this.reactionAdded,
    required this.reactionType,
    required this.totalReactions,
    required this.milestoneId,
  });
}

class CommunityUpdate {
  final CommunityUpdateType type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  CommunityUpdate({
    required this.type,
    required this.data,
    required this.timestamp,
  });
}

class CommunityException implements Exception {
  final String message;
  final dynamic originalError;

  CommunityException(this.message, {this.originalError});

  @override
  String toString() => 'CommunityException: $message';
}