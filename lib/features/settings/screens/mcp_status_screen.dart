import 'package:flutter/material.dart';

import '../../../data/models/mcp_error_models.dart';
import '../../../data/models/mcp_feedback_models.dart';
import '../../../data/services/mcp_manager_service.dart';
import '../widgets/mcp_error_notification_widget.dart';
import '../widgets/mcp_performance_monitor.dart';

/// Screen for displaying comprehensive MCP service status and error handling
class MCPStatusScreen extends StatefulWidget {
  final MCPManagerService mcpManager;

  const MCPStatusScreen({
    super.key,
    required this.mcpManager,
  });

  @override
  State<MCPStatusScreen> createState() => _MCPStatusScreenState();
}

class _MCPStatusScreenState extends State<MCPStatusScreen> {
  late Stream<MCPUserNotification> _notificationStream;
  late Stream<MCPUserFeedback> _feedbackStream;
  late Stream<MCPServiceStatus> _serviceStatusStream;

  final List<MCPUserNotification> _notifications = [];
  final List<MCPUserFeedback> _feedbacks = [];
  Map<String, MCPServiceStatus> _serviceStatuses = {};
  MCPSystemHealth? _systemHealth;

  @override
  void initState() {
    super.initState();
    _initializeStreams();
    _loadCurrentStatus();
  }

  void _initializeStreams() {
    _notificationStream = widget.mcpManager.errorNotificationStream;
    _feedbackStream = widget.mcpManager.userFeedbackStream;
    _serviceStatusStream = widget.mcpManager.serviceStatusStream;

    _notificationStream.listen((notification) {
      setState(() {
        _notifications.insert(0, notification);
        // Keep only last 20 notifications
        if (_notifications.length > 20) {
          _notifications.removeLast();
        }
      });
    });

    _feedbackStream.listen((feedback) {
      setState(() {
        _feedbacks.insert(0, feedback);
        // Keep only last 20 feedbacks
        if (_feedbacks.length > 20) {
          _feedbacks.removeLast();
        }
      });
    });

    _serviceStatusStream.listen((serviceStatus) {
      setState(() {
        _serviceStatuses[serviceStatus.serviceId] = serviceStatus;
        _systemHealth = widget.mcpManager.getSystemHealth();
      });
    });
  }

  void _loadCurrentStatus() {
    setState(() {
      _serviceStatuses = widget.mcpManager.getCurrentServiceStatuses();
      _systemHealth = widget.mcpManager.getSystemHealth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Features Status'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshStatus,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshStatus,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSystemHealthCard(),
            const SizedBox(height: 16),
            _buildServiceStatusSection(),
            const SizedBox(height: 16),
            const MCPPerformanceMonitor(),
            const SizedBox(height: 16),
            _buildNotificationsSection(),
            const SizedBox(height: 16),
            _buildFeedbackSection(),
            const SizedBox(height: 16),
            _buildDegradationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemHealthCard() {
    if (_systemHealth == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MCPSystemHealthWidget(
      systemHealth: _systemHealth!,
      onTap: () => _showSystemHealthDetails(),
    );
  }

  Widget _buildServiceStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Status',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (_serviceStatuses.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No service status available'),
            ),
          )
        else
          ..._serviceStatuses.values.map((status) => MCPServiceStatusWidget(
                serviceStatus: status,
                onTap: () => _showServiceDetails(status),
              )),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Error Notifications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_notifications.isNotEmpty)
              TextButton(
                onPressed: _clearNotifications,
                child: const Text('Clear All'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (_notifications.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(width: 12),
                  const Text('No error notifications'),
                ],
              ),
            ),
          )
        else
          ..._notifications.map((notification) => MCPErrorNotificationWidget(
                notification: notification,
                onActionTapped: _handleRecoveryAction,
                onDismiss: () => _dismissNotification(notification),
              )),
      ],
    );
  }

  Widget _buildFeedbackSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'System Feedback',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_feedbacks.isNotEmpty)
              TextButton(
                onPressed: _clearFeedbacks,
                child: const Text('Clear All'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (_feedbacks.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No system feedback'),
            ),
          )
        else
          ..._feedbacks.take(5).map((feedback) => _buildFeedbackCard(feedback)),
      ],
    );
  }

  Widget _buildFeedbackCard(MCPUserFeedback feedback) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getFeedbackIcon(feedback.type),
                  color: _getFeedbackColor(feedback.type),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feedback.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  _formatTime(feedback.timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              feedback.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (feedback.details?.technicalDetails != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  feedback.details!.technicalDetails!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDegradationSection() {
    final degradations = widget.mcpManager.getCurrentDegradations();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Degradations',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (degradations.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(width: 12),
                  const Text('All services operating normally'),
                ],
              ),
            ),
          )
        else
          ...degradations.values.map((degradation) => _buildDegradationCard(degradation)),
      ],
    );
  }

  Widget _buildDegradationCard(MCPServiceDegradation degradation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getDegradationIcon(degradation.level),
                  color: _getDegradationColor(degradation.level),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    degradation.serviceId,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getDegradationColor(degradation.level).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    degradation.level.name.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getDegradationColor(degradation.level),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              degradation.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (degradation.affectedFeatures.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Affected Features:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...degradation.affectedFeatures.map((feature) => Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('• $feature'),
                  )),
            ],
            if (degradation.workaround != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.blue.shade600,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        degradation.workaround!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _refreshStatus() async {
    await widget.mcpManager.handleRecoveryAction(
      MCPRecoveryActionType.manualRefresh,
      null,
    );
    _loadCurrentStatus();
  }

  void _handleRecoveryAction(
    MCPRecoveryActionType actionType,
    Map<String, dynamic>? parameters,
  ) async {
    try {
      await widget.mcpManager.handleRecoveryAction(actionType, parameters);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recovery action executed: ${actionType.name}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recovery action failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _dismissNotification(MCPUserNotification notification) {
    setState(() {
      _notifications.remove(notification);
    });
  }

  void _clearNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  void _clearFeedbacks() {
    setState(() {
      _feedbacks.clear();
    });
  }

  void _showSystemHealthDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('System Health Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overall Status: ${_systemHealth!.level.name}'),
            const SizedBox(height: 8),
            Text('Healthy Services: ${_systemHealth!.healthyServices}'),
            Text('Degraded Services: ${_systemHealth!.degradedServices}'),
            Text('Unhealthy Services: ${_systemHealth!.unhealthyServices}'),
            Text('Offline Services: ${_systemHealth!.offlineServices}'),
            Text('Total Services: ${_systemHealth!.totalServices}'),
            const SizedBox(height: 8),
            Text('Last Updated: ${_formatTime(_systemHealth!.lastUpdated)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showServiceDetails(MCPServiceStatus status) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${status.serviceName} Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${status.status.name}'),
            Text('Last Updated: ${_formatTime(status.lastUpdated)}'),
            if (status.error != null) ...[
              const SizedBox(height: 8),
              Text('Error: ${status.error}'),
            ],
            if (status.retryCount > 0) ...[
              const SizedBox(height: 8),
              Text('Retry Count: ${status.retryCount}/${status.maxRetries}'),
            ],
            const SizedBox(height: 8),
            const Text('Features:'),
            ...status.features.map((feature) => Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('• ${feature.name}: ${feature.status.name}'),
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  IconData _getFeedbackIcon(MCPUserFeedbackType type) {
    switch (type) {
      case MCPUserFeedbackType.info:
        return Icons.info_outline;
      case MCPUserFeedbackType.success:
        return Icons.check_circle_outline;
      case MCPUserFeedbackType.warning:
        return Icons.warning_amber_outlined;
      case MCPUserFeedbackType.error:
        return Icons.error_outline;
      case MCPUserFeedbackType.offline:
        return Icons.offline_bolt_outlined;
      case MCPUserFeedbackType.degradation:
        return Icons.trending_down;
    }
  }

  Color _getFeedbackColor(MCPUserFeedbackType type) {
    switch (type) {
      case MCPUserFeedbackType.info:
        return Colors.blue.shade600;
      case MCPUserFeedbackType.success:
        return Colors.green.shade600;
      case MCPUserFeedbackType.warning:
        return Colors.orange.shade600;
      case MCPUserFeedbackType.error:
        return Colors.red.shade600;
      case MCPUserFeedbackType.offline:
        return Colors.grey.shade600;
      case MCPUserFeedbackType.degradation:
        return Colors.amber.shade600;
    }
  }

  IconData _getDegradationIcon(MCPDegradationLevel level) {
    switch (level) {
      case MCPDegradationLevel.none:
        return Icons.check_circle;
      case MCPDegradationLevel.minor:
        return Icons.info;
      case MCPDegradationLevel.moderate:
        return Icons.warning;
      case MCPDegradationLevel.major:
        return Icons.error;
      case MCPDegradationLevel.complete:
        return Icons.cancel;
    }
  }

  Color _getDegradationColor(MCPDegradationLevel level) {
    switch (level) {
      case MCPDegradationLevel.none:
        return Colors.green.shade600;
      case MCPDegradationLevel.minor:
        return Colors.blue.shade600;
      case MCPDegradationLevel.moderate:
        return Colors.orange.shade600;
      case MCPDegradationLevel.major:
        return Colors.red.shade600;
      case MCPDegradationLevel.complete:
        return Colors.red.shade800;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}