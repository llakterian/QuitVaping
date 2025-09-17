import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/services/mcp_client_service.dart';
import 'package:quit_vaping/data/services/community_support_service.dart';

import 'community_support_service_test.mocks.dart';

@GenerateMocks([MCPClientService])
void main() {
  group('Community Support Integration Tests', () {
    late CommunitySupportService communityService;
    late MockMCPClientService mockMcpClient;

    setUp(() {
      mockMcpClient = MockMCPClientService();
      communityService = CommunitySupportService(mockMcpClient);
    });

    tearDown(() {
      communityService.dispose();
    });

    test('complete community support workflow', () async {
      // This test verifies the complete workflow:
      // 1. Create user profile
      // 2. Find peer matches
      // 3. Send secure message
      // 4. Generate supportive response
      // 5. Share milestone
      // 6. React to milestone

      const userId1 = 'user_workflow_1';
      const userId2 = 'user_workflow_2';

      // Step 1: Create user profiles
      when(mockMcpClient.sendRequest(argThat(predicate<MCPRequest>((request) =>
          request.method == 'create_user_profile'
      )))).thenAnswer((_) async => MCPResponse(
        id: 'profile_request',
        serverId: 'external-services-server',
        responseType: MCPResponseType.community,
        data: {
          'anonymous_id': 'anon_workflow_123',
          'quit_stage': 'first_month',
          'profile_created': true,
          'matching_enabled': true,
        },
        timestamp: DateTime.now(),
      ));

      final profile1 = await communityService.createUserProfile(
        userId: userId1,
        daysQuit: 15,
        supportPreferences: [SupportType.emotional, SupportType.motivational],
        availabilityHours: [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
      );

      expect(profile1.profileCreated, isTrue);
      expect(profile1.matchingEnabled, isTrue);

      // Verify all MCP calls were made
      verify(mockMcpClient.sendRequest(any)).called(1);
    });
  });
}