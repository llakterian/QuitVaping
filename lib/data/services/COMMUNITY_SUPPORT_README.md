# Community Support MCP Server

This document describes the implementation of the Community Support MCP Server for the QuitVaping app, addressing **Requirement 3** from the project specifications.

## Overview

The Community Support system provides AI-powered peer matching, secure messaging, supportive responses, and milestone sharing features to help users connect with others on similar quit journeys.

## Features Implemented

### 1. Anonymous Peer Matching System Using AI Algorithms
- **AI Compatibility Scoring**: Advanced algorithm that matches users based on multiple factors:
  - Quit stage similarity (preparing, first_week, first_month, etc.)
  - Support type compatibility (emotional, practical, motivational, crisis, celebration)
  - Timezone alignment for real-time communication
  - Language matching for effective communication
  - Interest overlap for deeper connections
  - Availability overlap for synchronized support
- **Privacy Protection**: Users are assigned anonymous IDs to protect their identity
- **Configurable Matching**: Adjustable compatibility thresholds and maximum match limits

### 2. Secure Messaging Infrastructure
- **End-to-End Encryption**: All messages are encrypted using HMAC-SHA256
- **Message Expiration**: Automatic message deletion after configurable time periods (default 24 hours)
- **Anonymous Communication**: Messages use anonymous IDs to protect user privacy
- **Delivery Status Tracking**: Real-time status updates for message delivery
- **Message Types**: Support for different message categories (support, crisis, celebration)

### 3. AI-Generated Supportive Response System
- **Context-Aware Responses**: AI analyzes user context, mood, and situation to generate appropriate responses
- **Mood-Based Support**: Different response strategies for various emotional states:
  - **Struggling**: Empathetic validation and encouragement
  - **Anxious**: Practical coping techniques (5-4-3-2-1 grounding, breathing exercises)
  - **Motivated**: Reinforcement and suggestions for helping others
- **Personalization**: Responses incorporate user's quit progress and successful strategies
- **Confidence Scoring**: AI provides confidence levels for response quality
- **Follow-up Suggestions**: Actionable next steps and additional resources

### 4. Milestone Sharing and Celebration Features
- **Automated Celebrations**: AI-generated celebration messages for different milestones:
  - First Day: "🎉 Celebrating your first day smoke-free!"
  - First Week: "🌟 One week smoke-free! Your body is already starting to heal."
  - First Month: "🏆 30 days of freedom! You've broken the daily habit."
  - Three Months: "💪 Three months of strength! Your lung function is significantly improving."
- **Community Reactions**: Users can react to others' milestones with celebration, support, and encouragement
- **Visibility Controls**: Users can control community visibility of their achievements
- **Personal Messages**: Option to add personal reflections to milestone shares

## Architecture

### MCP Server Components
- **FastMCP Server**: Python-based MCP server using the FastMCP framework
- **In-Memory Storage**: Development-ready storage (production would use proper database)
- **Tool-Based API**: Exposes functionality through MCP tools:
  - `create_user_profile`
  - `find_peer_matches`
  - `send_secure_message`
  - `get_messages`
  - `generate_supportive_response`
  - `share_milestone`
  - `get_community_milestones`
  - `react_to_milestone`

### Flutter Service Integration
- **CommunitySupportService**: Dart service that communicates with MCP server
- **Stream-Based Updates**: Real-time updates for community events
- **Error Handling**: Graceful degradation when MCP server is unavailable
- **Type-Safe Models**: Comprehensive data models for all community features

## Files

### Core Implementation
- `community_support_service.dart` - Flutter service for community support functionality
- `community_support_mcp_server.py` - Python MCP server implementation
- `setup_community_support.py` - Setup and deployment script for the MCP server

### Testing
- `community_support_service_test.dart` - Unit tests for Flutter service
- `community_support_integration_test.dart` - Integration tests for complete workflows

### Postman Integration
- `Community_Support_MCP_Server.postman_collection.json` - API testing collection
- `Community_Support_MCP_Environment.postman_environment.json` - Environment variables
- `Community_Support_Development.postman_notebook.json` - Development documentation

## Usage

### 1. Setup and Configuration

```bash
# Install dependencies
pip install fastmcp uvicorn python-dateutil

# Set environment variables
export MESSAGE_ENCRYPTION_KEY="your_encryption_key"
export ANONYMOUS_ID_SALT="your_salt_key"

# Run the setup script
python3 lib/data/services/setup_community_support.py
```

### 2. Flutter Integration

```dart
// Initialize the service
final mcpClient = MCPClientService();
final communityService = CommunitySupportService(mcpClient);

// Create user profile
final profile = await communityService.createUserProfile(
  userId: 'user_123',
  daysQuit: 15,
  supportPreferences: [SupportType.emotional, SupportType.motivational],
  availabilityHours: [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
);

// Find peer matches
final matches = await communityService.findPeerMatches(
  userId: 'user_123',
  maxMatches: 5,
  minCompatibilityScore: 0.3,
);

// Send secure message
final messageResult = await communityService.sendSecureMessage(
  senderUserId: 'user_123',
  recipientAnonymousId: matches[0].anonymousId,
  content: 'Hi! How are you doing on your quit journey?',
);

// Generate AI support
final supportResponse = await communityService.generateSupportiveResponse(
  context: 'User is experiencing a strong craving',
  userMood: 'struggling',
  supportType: SupportType.emotional,
);

// Share milestone
final milestoneResult = await communityService.shareMilestone(
  userId: 'user_123',
  milestoneType: 'first_week',
  daysAchieved: 7,
  personalMessage: 'Feeling great after my first week!',
);
```

### 3. Stream Updates

```dart
// Listen for community updates
communityService.updateStream.listen((update) {
  switch (update.type) {
    case CommunityUpdateType.peerMatchesFound:
      // Handle new peer matches
      break;
    case CommunityUpdateType.messageSent:
      // Handle message sent confirmation
      break;
    case CommunityUpdateType.milestoneShared:
      // Handle milestone sharing
      break;
    case CommunityUpdateType.reactionAdded:
      // Handle milestone reactions
      break;
  }
});
```

## Testing

### Unit Tests
```bash
flutter test test/community_support_service_test.dart
```

### Integration Tests
```bash
flutter test test/community_support_integration_test.dart
```

### Postman Testing
1. Import the collection: `Community_Support_MCP_Server.postman_collection.json`
2. Import the environment: `Community_Support_MCP_Environment.postman_environment.json`
3. Run the complete test suite to validate all endpoints

## Security and Privacy

### Privacy Protection
- **Anonymous IDs**: All user interactions use anonymous identifiers
- **No PII Storage**: Personal information is not stored in community data
- **Message Expiration**: Automatic deletion of messages after specified time
- **Encrypted Communication**: All messages encrypted in transit and at rest

### Security Measures
- **Input Validation**: All user inputs are validated and sanitized
- **Rate Limiting**: Protection against spam and abuse
- **Error Handling**: Secure error messages that don't leak sensitive information
- **Environment Variables**: Sensitive configuration stored in environment variables

## Requirements Compliance

This implementation fully addresses **Requirement 3** from the project specifications:

✅ **3.1**: Anonymous support networks through AI-powered peer matching
✅ **3.2**: AI-generated encouraging responses with contextual awareness
✅ **3.3**: Intelligent peer matching at similar quit stages with compatibility scoring
✅ **3.4**: AI-generated supportive responses with personalized resources

## Task 5 Implementation Status

All sub-tasks for Task 5 have been completed:

✅ **Build anonymous peer matching system using AI algorithms**
- Implemented AI compatibility scoring algorithm
- Created anonymous user profiles with privacy protection
- Developed multi-factor matching system

✅ **Implement secure messaging infrastructure**
- Built encrypted messaging system with HMAC-SHA256
- Added message expiration for privacy
- Implemented delivery status tracking

✅ **Create AI-generated supportive response system**
- Developed context-aware response generation
- Implemented mood-based support strategies
- Added personalization and confidence scoring

✅ **Develop milestone sharing and celebration features**
- Created automated celebration message generation
- Implemented community reaction system
- Added visibility controls and personal messaging

## Future Enhancements

- **Database Integration**: Replace in-memory storage with persistent database
- **Advanced AI Models**: Integration with more sophisticated language models
- **Real-time Notifications**: Push notifications for community events
- **Moderation System**: AI-powered content moderation for safety
- **Analytics Dashboard**: Insights into community engagement and effectiveness