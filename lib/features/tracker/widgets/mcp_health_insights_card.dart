import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/mcp_manager_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/models/mcp_model.dart';
import '../../../shared/theme/app_colors.dart';

class MCPHealthInsightsCard extends StatefulWidget {
  const MCPHealthInsightsCard({Key? key}) : super(key: key);

  @override
  State<MCPHealthInsightsCard> createState() => _MCPHealthInsightsCardState();
}

class _MCPHealthInsightsCardState extends State<MCPHealthInsightsCard> {
  List<Map<String, String>>? _healthTimeline;
  List<String>? _personalizedBenefits;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadHealthInsights();
    _listenToHealthUpdates();
  }

  void _listenToHealthUpdates() {
    final mcpManager = Provider.of<MCPManagerService>(context, listen: false);
    mcpManager.healthInsightsStream.listen((response) {
      if (mounted && response.responseType == MCPResponseType.health) {
        setState(() {
          _healthTimeline = (response.data['timeline'] as List?)
              ?.cast<Map<String, dynamic>>()
              .map((item) => {
                    'time': item['time'] as String,
                    'benefit': item['benefit'] as String,
                  })
              .toList();
          _personalizedBenefits = (response.data['personalizedBenefits'] as List?)
              ?.cast<String>();
          _isLoading = false;
          _error = null;
        });
      }
    });
  }

  Future<void> _loadHealthInsights() async {
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

      final response = await mcpManager.getHealthRecoveryTimeline(user.id);
      
      if (mounted) {
        setState(() {
          _healthTimeline = (response.data['timeline'] as List?)
              ?.cast<Map<String, dynamic>>()
              .map((item) => {
                    'time': item['time'] as String,
                    'benefit': item['benefit'] as String,
                  })
              .toList();
          _personalizedBenefits = (response.data['personalizedBenefits'] as List?)
              ?.cast<String>();
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
              AppColors.success.withOpacity(0.1),
              AppColors.accent.withOpacity(0.1),
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
                      color: AppColors.success.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.success,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Real-Time Health Recovery',
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
                      onPressed: _loadHealthInsights,
                      tooltip: 'Refresh health insights',
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
                          'Unable to load real-time health data. Showing cached information.',
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else if (_healthTimeline != null || _personalizedBenefits != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_personalizedBenefits != null && _personalizedBenefits!.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: AppColors.success,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Your Personal Progress',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.success,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ..._personalizedBenefits!.map((benefit) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: AppColors.success,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      benefit,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (_healthTimeline != null && _healthTimeline!.isNotEmpty) ...[
                      Text(
                        'Recovery Timeline',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._healthTimeline!.map((milestone) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                milestone['time']!,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                milestone['benefit']!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ],
                ),
              if (_healthTimeline == null && _personalizedBenefits == null && !_isLoading && _error == null)
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
                        'Tap refresh to get real-time health insights',
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