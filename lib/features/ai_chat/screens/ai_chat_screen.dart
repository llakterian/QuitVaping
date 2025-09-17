import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/ai_service.dart';
import '../../../data/services/subscription_service.dart';
import '../../../data/services/mcp_manager_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/models/ai_model.dart';
import '../../../data/models/mcp_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/chat_message.dart';
import '../../subscription/widgets/premium_feature_overlay.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({Key? key}) : super(key: key);

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionService>(
      builder: (context, subscriptionService, child) {
        final isPremium = subscriptionService.isPremium;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('AI Coach'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showClearChatDialog();
                },
              ),
            ],
          ),
          body: isPremium 
              ? _buildChatContent()
              : PremiumFeatureOverlay(
                  featureName: 'Unlimited AI Coach',
                  description: 'Get unlimited access to your personal AI coach to help you through your quit journey.',
                  child: _buildChatContent(),
                ),
        );
      },
    );
  }
  
  Widget _buildChatContent() {
    return Column(
      children: [
        Expanded(
          child: Consumer<AIService>(
            builder: (context, aiService, child) {
              final messages = aiService.chatHistory;
              
              if (messages.isEmpty) {
                return _buildEmptyChat();
              }
              
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
              });
              
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ChatMessage(
                    message: message,
                    isUser: message.sender == 'user',
                  );
                },
              );
            },
          ),
        ),
        _buildInputArea(),
      ],
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.chat,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Chat with your AI Coach',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Ask questions, get support, or just chat about your quitting journey.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSuggestion('How can I handle cravings?'),
                const SizedBox(height: 8),
                _buildSuggestion('What happens to my body when I quit?'),
                const SizedBox(height: 8),
                _buildSuggestion('I\'m feeling tempted to vape right now'),
                const SizedBox(height: 8),
                _buildSuggestion('Tell me about withdrawal symptoms'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestion(String text) {
    return InkWell(
      onTap: () {
        _sendMessage(text);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 26),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 13), // 0.05 * 255 ≈ 13
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  _sendMessage(value);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () {
              if (_messageController.text.trim().isNotEmpty) {
                _sendMessage(_messageController.text);
              }
            },
            backgroundColor: AppColors.primary,
            elevation: 0,
            child: _isTyping
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    
    setState(() {
      _isTyping = true;
    });
    
    final aiService = Provider.of<AIService>(context, listen: false);
    final mcpManager = Provider.of<MCPManagerService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    
    _messageController.clear();
    
    try {
      // First, send the message through the regular AI service
      await aiService.sendMessage(text);
      
      // Then, try to enhance the response with MCP-powered insights
      final user = userService.currentUser;
      if (user != null) {
        try {
          // Create context for MCP AI workflow
          final context = AIWorkflowContext(
            userId: user.id,
            currentMood: _detectMoodFromMessage(text),
            recentActivity: [], // This would come from user's recent activities
            externalFactors: ExternalFactors(
              weather: 'unknown',
              timeOfDay: _getTimeOfDay(),
              location: 'home',
            ),
            availableInterventions: [
              InterventionType.breathing,
              InterventionType.motivation,
              InterventionType.distraction,
            ],
            learningData: UserLearningProfile(
              preferredInterventions: {'motivation': 1, 'breathing': 1},
              personalizedData: {
                'successfulStrategies': ['morning_routine', 'exercise'],
                'triggerPatterns': ['stress', 'social_situations'],
                'lastUpdated': DateTime.now().toIso8601String(),
              },
            ),
          );

          // Get enhanced response from MCP
          final mcpResponse = await mcpManager.generateMotivationContent(context);
          
          if (mcpResponse.responseType == MCPResponseType.motivation && 
              mcpResponse.data['content'] != null) {
            // Add the MCP-enhanced response as a follow-up message
            // TODO: Add MCP-enhanced response to chat when ChatMessage model is fixed
            // final enhancedMessage = ChatMessage(
            //   message: '💡 ${mcpResponse.data['content']}',
            //   isUser: false,
            // );
            debugPrint('MCP Enhanced Response: ${mcpResponse.data['content']}');
          }
        } catch (mcpError) {
          // MCP enhancement failed, but regular AI response should still work
          debugPrint('MCP enhancement failed: $mcpError');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending message: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
        _scrollToBottom();
      }
    }
  }

  MoodState _detectMoodFromMessage(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('stressed') || 
        lowerMessage.contains('anxious') || 
        lowerMessage.contains('worried') ||
        lowerMessage.contains('panic') ||
        lowerMessage.contains('craving')) {
      return MoodState.struggling;
    }
    
    if (lowerMessage.contains('good') || 
        lowerMessage.contains('great') || 
        lowerMessage.contains('happy') ||
        lowerMessage.contains('confident')) {
      return MoodState.positive;
    }
    
    return MoodState.neutral;
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat History'),
        content: const Text('Are you sure you want to clear all chat messages? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final aiService = Provider.of<AIService>(context, listen: false);
              aiService.clearData();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}