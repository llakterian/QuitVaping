import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/mcp_manager_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/models/mcp_model.dart';
import '../../../shared/theme/app_colors.dart';

class MCPMotivationCard extends StatefulWidget {
  const MCPMotivationCard({Key? key}) : super(key: key);

  @override
  State<MCPMotivationCard> createState() => _MCPMotivationCardState();
}

class _MCPMotivationCardState extends State<MCPMotivationCard> {
  String? _motivationContent;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMotivationContent();
    _listenToMotivationUpdates();
  }

  void _listenToMotivationUpdates() {
    final mcpManager = Provider.of<MCPManagerService>(context, listen: false);
    mcpManager.motivationStream.listen((response) {
      if (mounted && response.responseType == MCPResponseType.motivation) {
        setState(() {
          _motivationContent = response.data['content'] as String?;
          _isLoading = false;
          _error = null;
        });
      }
    });
  }

  Future<void> _loadMotivationContent() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final userService = Provider.of<UserService>(context, listen: false);
      final mcpManager = Provider.of<MCPManagerService>(context, listen: false);
      final user = userService.currentUser;
      
      if (user == null) {
        setState(() {
          _error = 'User not found';
          _isLoading = false;
        });
        return;
      }

      // Create AI workflow context
      final aiWorkflowContext = AIWorkflowContext(
        userId: user.id,
        currentMood: MoodState.neutral, // This would come from user's current state
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

      final response = await mcpManager.generateMotivationContent(aiWorkflowContext);
      
      if (mounted) {
        setState(() {
          _motivationContent = response.data['content'] as String?;
          _isLoading = false;
          _error = response.error;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.psychology,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'AI-Powered Motivation',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (_isLoading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.refresh, size: 20),
                      onPressed: _loadMotivationContent,
                      tooltip: 'Refresh motivation',
                    ),
                ],
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: AppColors.error, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Unable to load personalized motivation. Using offline content.',
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else if (_motivationContent != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.format_quote,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _motivationContent!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 16,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Personalized for you',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (_motivationContent == null && !_isLoading && _error == null)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_off,
                        color: Colors.grey[400],
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap refresh to get personalized motivation',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}