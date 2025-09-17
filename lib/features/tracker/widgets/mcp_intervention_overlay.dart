import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/mcp_manager_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/models/mcp_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../../breathing/screens/breathing_screen.dart';
import '../../panic_mode/screens/panic_mode_screen.dart';

class MCPInterventionOverlay extends StatefulWidget {
  const MCPInterventionOverlay({Key? key}) : super(key: key);

  @override
  State<MCPInterventionOverlay> createState() => _MCPInterventionOverlayState();
}

class _MCPInterventionOverlayState extends State<MCPInterventionOverlay>
    with TickerProviderStateMixin {
  bool _isVisible = false;
  String? _interventionMessage;
  List<InterventionAction>? _recommendedActions;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _listenToInterventions();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
  }

  void _listenToInterventions() {
    final mcpManager = Provider.of<MCPManagerService>(context, listen: false);
    mcpManager.interventionStream.listen((response) {
      if (mounted && response.responseType == MCPResponseType.intervention) {
        _showIntervention(response);
      }
    });
  }

  void _showIntervention(MCPResponse response) {
    setState(() {
      _interventionMessage = response.data['message'] as String?;
      _recommendedActions = (response.data['actions'] as List?)
          ?.map((action) => InterventionAction.fromJson(action))
          .toList();
      _isVisible = true;
    });

    _animationController.forward();

    // Auto-hide after 30 seconds if user doesn't interact
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && _isVisible) {
        _hideIntervention();
      }
    });
  }

  void _hideIntervention() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _isVisible = false;
          _interventionMessage = null;
          _recommendedActions = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          right: 16,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value * 100),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.accent.withOpacity(0.9),
                        AppColors.primary.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.psychology,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'AI Intervention',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: _hideIntervention,
                              tooltip: 'Dismiss',
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (_interventionMessage != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _interventionMessage!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ),
                        if (_recommendedActions != null && _recommendedActions!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Recommended Actions:',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _recommendedActions!.map((action) => 
                              _buildActionButton(action)
                            ).toList(),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Colors.white.withOpacity(0.7),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Powered by AI pattern recognition',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(InterventionAction action) {
    return ElevatedButton(
      onPressed: () => _executeAction(action),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getActionIcon(action.type), size: 16),
          const SizedBox(width: 6),
          Text(
            action.title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  IconData _getActionIcon(String actionType) {
    switch (actionType) {
      case 'breathing':
        return Icons.self_improvement;
      case 'panic_mode':
        return Icons.emergency;
      case 'motivation':
        return Icons.psychology;
      case 'distraction':
        return Icons.games;
      default:
        return Icons.help_outline;
    }
  }

  void _executeAction(InterventionAction action) {
    _hideIntervention();

    switch (action.type) {
      case 'breathing':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BreathingScreen()),
        );
        break;
      case 'panic_mode':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PanicModeScreen()),
        );
        break;
      case 'motivation':
        _showMotivationDialog(action.content);
        break;
      case 'distraction':
        _showDistractionDialog();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action: ${action.title}')),
        );
    }
  }

  void _showMotivationDialog(String? content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.psychology, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Motivation'),
          ],
        ),
        content: Text(content ?? 'You\'ve got this! Stay strong and remember why you started.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Thanks!'),
          ),
        ],
      ),
    );
  }

  void _showDistractionDialog() {
    final distractions = [
      'Take a 5-minute walk',
      'Listen to your favorite song',
      'Call a friend or family member',
      'Do 10 jumping jacks',
      'Write in a journal',
      'Play a quick mobile game',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.games, color: AppColors.accent),
            const SizedBox(width: 8),
            const Text('Distraction Ideas'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: distractions.map((distraction) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, 
                     color: AppColors.success, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(distraction)),
              ],
            ),
          )).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}

class InterventionAction {
  final String type;
  final String title;
  final String? content;

  InterventionAction({
    required this.type,
    required this.title,
    this.content,
  });

  factory InterventionAction.fromJson(Map<String, dynamic> json) {
    return InterventionAction(
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
    );
  }
}