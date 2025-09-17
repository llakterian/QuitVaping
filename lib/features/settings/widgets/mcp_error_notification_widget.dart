import 'package:flutter/material.dart';

import '../../../data/models/mcp_error_models.dart';
import '../../../data/models/mcp_feedback_models.dart';

/// Widget for displaying MCP error notifications with recovery options
class MCPErrorNotificationWidget extends StatelessWidget {
  final MCPUserNotification notification;
  final Function(MCPRecoveryActionType, Map<String, dynamic>?)? onActionTapped;
  final VoidCallback? onDismiss;

  const MCPErrorNotificationWidget({
    super.key,
    required this.notification,
    this.onActionTapped,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: _getElevation(),
      color: _getBackgroundColor(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            _buildMessage(context),
            if (notification.actions?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              _buildActions(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _buildIcon(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getTextColor(context),
                ),
              ),
              Text(
                notification.serviceName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getTextColor(context).withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        if (notification.isDismissible && onDismiss != null)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDismiss,
            iconSize: 20,
            color: _getTextColor(context).withOpacity(0.7),
          ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getIconBackgroundColor().withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        _getIcon(),
        color: _getIconColor(),
        size: 24,
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      notification.message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: _getTextColor(context),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: notification.actions!.map((action) {
        return _buildActionButton(context, action);
      }).toList(),
    );
  }

  Widget _buildActionButton(BuildContext context, MCPNotificationAction action) {
    return OutlinedButton.icon(
      onPressed: () => onActionTapped?.call(action.actionType, action.parameters),
      icon: Icon(_getActionIcon(action.actionType), size: 16),
      label: Text(action.label),
      style: OutlinedButton.styleFrom(
        foregroundColor: _getActionColor(context),
        side: BorderSide(color: _getActionColor(context)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }

  double _getElevation() {
    switch (notification.type) {
      case MCPNotificationType.error:
        return 8;
      case MCPNotificationType.warning:
        return 6;
      case MCPNotificationType.degradation:
        return 4;
      default:
        return 2;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (notification.type) {
      case MCPNotificationType.error:
        return Theme.of(context).colorScheme.errorContainer;
      case MCPNotificationType.warning:
        return Colors.orange.shade50;
      case MCPNotificationType.degradation:
        return Colors.amber.shade50;
      case MCPNotificationType.success:
        return Theme.of(context).colorScheme.primaryContainer;
      case MCPNotificationType.info:
        return Theme.of(context).colorScheme.surfaceVariant;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (notification.type) {
      case MCPNotificationType.error:
        return Theme.of(context).colorScheme.onErrorContainer;
      case MCPNotificationType.warning:
        return Colors.orange.shade800;
      case MCPNotificationType.degradation:
        return Colors.amber.shade800;
      case MCPNotificationType.success:
        return Theme.of(context).colorScheme.onPrimaryContainer;
      case MCPNotificationType.info:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }

  IconData _getIcon() {
    switch (notification.type) {
      case MCPNotificationType.error:
        return Icons.error_outline;
      case MCPNotificationType.warning:
        return Icons.warning_amber_outlined;
      case MCPNotificationType.degradation:
        return Icons.info_outline;
      case MCPNotificationType.success:
        return Icons.check_circle_outline;
      case MCPNotificationType.info:
        return Icons.info_outline;
    }
  }

  Color _getIconColor() {
    switch (notification.type) {
      case MCPNotificationType.error:
        return Colors.red.shade600;
      case MCPNotificationType.warning:
        return Colors.orange.shade600;
      case MCPNotificationType.degradation:
        return Colors.amber.shade600;
      case MCPNotificationType.success:
        return Colors.green.shade600;
      case MCPNotificationType.info:
        return Colors.blue.shade600;
    }
  }

  Color _getIconBackgroundColor() {
    switch (notification.type) {
      case MCPNotificationType.error:
        return Colors.red;
      case MCPNotificationType.warning:
        return Colors.orange;
      case MCPNotificationType.degradation:
        return Colors.amber;
      case MCPNotificationType.success:
        return Colors.green;
      case MCPNotificationType.info:
        return Colors.blue;
    }
  }

  Color _getActionColor(BuildContext context) {
    switch (notification.type) {
      case MCPNotificationType.error:
        return Colors.red.shade600;
      case MCPNotificationType.warning:
        return Colors.orange.shade600;
      case MCPNotificationType.degradation:
        return Colors.amber.shade600;
      case MCPNotificationType.success:
        return Colors.green.shade600;
      case MCPNotificationType.info:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _getActionIcon(MCPRecoveryActionType actionType) {
    switch (actionType) {
      case MCPRecoveryActionType.retry:
        return Icons.refresh;
      case MCPRecoveryActionType.useOfflineContent:
        return Icons.offline_bolt;
      case MCPRecoveryActionType.switchServer:
        return Icons.swap_horiz;
      case MCPRecoveryActionType.reduceFunctionality:
        return Icons.tune;
      case MCPRecoveryActionType.manualRefresh:
        return Icons.refresh;
      case MCPRecoveryActionType.contactSupport:
        return Icons.support_agent;
      case MCPRecoveryActionType.checkConnection:
        return Icons.wifi;
    }
  }
}

/// Widget for displaying service status with degradation information
class MCPServiceStatusWidget extends StatelessWidget {
  final MCPServiceStatus serviceStatus;
  final VoidCallback? onTap;

  const MCPServiceStatusWidget({
    super.key,
    required this.serviceStatus,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              _buildFeaturesList(context),
              if (serviceStatus.degradation?.workaround != null) ...[
                const SizedBox(height: 12),
                _buildWorkaround(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _buildStatusIndicator(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serviceStatus.serviceName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _getStatusText(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getStatusColor(),
                ),
              ),
            ],
          ),
        ),
        if (serviceStatus.retryCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Retry ${serviceStatus.retryCount}/${serviceStatus.maxRetries}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.orange.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _getStatusColor(),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final availableFeatures = serviceStatus.features
        .where((f) => f.status == MCPFeatureStatus.available || f.status == MCPFeatureStatus.limited)
        .toList();
    final unavailableFeatures = serviceStatus.features
        .where((f) => f.status == MCPFeatureStatus.unavailable)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (availableFeatures.isNotEmpty) ...[
          Text(
            'Available Features:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 4),
          ...availableFeatures.map((feature) => _buildFeatureItem(context, feature, true)),
        ],
        if (unavailableFeatures.isNotEmpty) ...[
          if (availableFeatures.isNotEmpty) const SizedBox(height: 8),
          Text(
            'Affected Features:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 4),
          ...unavailableFeatures.map((feature) => _buildFeatureItem(context, feature, false)),
        ],
      ],
    );
  }

  Widget _buildFeatureItem(BuildContext context, MCPServiceFeature feature, bool isAvailable) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 2),
      child: Row(
        children: [
          Icon(
            isAvailable ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isAvailable ? Colors.green.shade600 : Colors.red.shade600,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isAvailable ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
          ),
          if (feature.status == MCPFeatureStatus.limited)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Limited',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.orange.shade800,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWorkaround(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: Colors.blue.shade600,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              serviceStatus.degradation!.workaround!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.blue.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText() {
    switch (serviceStatus.status) {
      case MCPServiceHealthStatus.healthy:
        return 'All features working normally';
      case MCPServiceHealthStatus.connecting:
        return 'Connecting...';
      case MCPServiceHealthStatus.degraded:
        return 'Limited functionality';
      case MCPServiceHealthStatus.unhealthy:
        return 'Service unavailable';
      case MCPServiceHealthStatus.offline:
        return 'Offline mode active';
      case MCPServiceHealthStatus.unknown:
        return 'Status unknown';
    }
  }

  Color _getStatusColor() {
    switch (serviceStatus.status) {
      case MCPServiceHealthStatus.healthy:
        return Colors.green.shade600;
      case MCPServiceHealthStatus.connecting:
        return Colors.blue.shade600;
      case MCPServiceHealthStatus.degraded:
        return Colors.orange.shade600;
      case MCPServiceHealthStatus.unhealthy:
        return Colors.red.shade600;
      case MCPServiceHealthStatus.offline:
        return Colors.grey.shade600;
      case MCPServiceHealthStatus.unknown:
        return Colors.grey.shade400;
    }
  }
}

/// Widget for displaying system health overview
class MCPSystemHealthWidget extends StatelessWidget {
  final MCPSystemHealth systemHealth;
  final VoidCallback? onTap;

  const MCPSystemHealthWidget({
    super.key,
    required this.systemHealth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              _buildHealthBar(context),
              const SizedBox(height: 8),
              _buildStats(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          _getSystemHealthIcon(),
          color: _getSystemHealthColor(),
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Health',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _getSystemHealthText(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getSystemHealthColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthBar(BuildContext context) {
    final total = systemHealth.totalServices;
    final healthy = systemHealth.healthyServices;
    final degraded = systemHealth.degradedServices;
    final unhealthy = systemHealth.unhealthyServices;
    final offline = systemHealth.offlineServices;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: healthy,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
            ),
            if (degraded > 0)
              Expanded(
                flex: degraded,
                child: Container(
                  height: 8,
                  color: Colors.orange.shade600,
                ),
              ),
            if (unhealthy > 0)
              Expanded(
                flex: unhealthy,
                child: Container(
                  height: 8,
                  color: Colors.red.shade600,
                ),
              ),
            if (offline > 0)
              Expanded(
                flex: offline,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$healthy/$total services healthy',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Updated ${_formatTime(systemHealth.lastUpdated)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    return Row(
      children: [
        _buildStatItem(context, 'Healthy', systemHealth.healthyServices, Colors.green.shade600),
        if (systemHealth.degradedServices > 0)
          _buildStatItem(context, 'Limited', systemHealth.degradedServices, Colors.orange.shade600),
        if (systemHealth.unhealthyServices > 0)
          _buildStatItem(context, 'Down', systemHealth.unhealthyServices, Colors.red.shade600),
        if (systemHealth.offlineServices > 0)
          _buildStatItem(context, 'Offline', systemHealth.offlineServices, Colors.grey.shade600),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, int count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSystemHealthIcon() {
    switch (systemHealth.level) {
      case MCPSystemHealthLevel.healthy:
        return Icons.check_circle;
      case MCPSystemHealthLevel.degraded:
        return Icons.warning;
      case MCPSystemHealthLevel.critical:
        return Icons.error;
      case MCPSystemHealthLevel.unknown:
        return Icons.help;
    }
  }

  Color _getSystemHealthColor() {
    switch (systemHealth.level) {
      case MCPSystemHealthLevel.healthy:
        return Colors.green.shade600;
      case MCPSystemHealthLevel.degraded:
        return Colors.orange.shade600;
      case MCPSystemHealthLevel.critical:
        return Colors.red.shade600;
      case MCPSystemHealthLevel.unknown:
        return Colors.grey.shade600;
    }
  }

  String _getSystemHealthText() {
    switch (systemHealth.level) {
      case MCPSystemHealthLevel.healthy:
        return 'All systems operational';
      case MCPSystemHealthLevel.degraded:
        return 'Some services limited';
      case MCPSystemHealthLevel.critical:
        return 'Multiple services down';
      case MCPSystemHealthLevel.unknown:
        return 'Checking status...';
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