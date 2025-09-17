import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/mcp_error_models.dart';
import '../models/mcp_feedback_models.dart';
import '../models/mcp_model.dart';

/// Service for providing transparent user feedback about MCP service status
class MCPUserFeedbackService {
  final StreamController<MCPServiceStatus> _serviceStatusController = 
      StreamController<MCPServiceStatus>.broadcast();
  final StreamController<MCPUserFeedback> _userFeedbackController = 
      StreamController<MCPUserFeedback>.broadcast();

  final Map<String, MCPServiceStatus> _serviceStatuses = {};
  final Map<String, Timer> _statusUpdateTimers = {};

  /// Stream of service status updates
  Stream<MCPServiceStatus> get serviceStatusStream => _serviceStatusController.stream;

  /// Stream of user feedback messages
  Stream<MCPUserFeedback> get userFeedbackStream => _userFeedbackController.stream;

  /// Initialize the user feedback service
  Future<void> initialize() async {
    // Initialize default service statuses
    _initializeDefaultStatuses();
    
    debugPrint('MCP User Feedback Service initialized');
  }

  /// Initialize default service statuses
  void _initializeDefaultStatuses() {
    final services = [
      'health-data-server',
      'ai-workflow-server',
      'external-services-server',
      'analytics-server',
    ];

    for (final serviceId in services) {
      _serviceStatuses[serviceId] = MCPServiceStatus(
        serviceId: serviceId,
        serviceName: _getServiceName(serviceId),
        status: MCPServiceHealthStatus.unknown,
        lastUpdated: DateTime.now(),
        features: _getServiceFeatures(serviceId),
        degradation: null,
      );
    }
  }

  /// Update service status based on server status
  void updateServiceStatus(MCPServerStatus serverStatus) {
    final serviceId = serverStatus.serverId;
    final currentStatus = _serviceStatuses[serviceId];
    
    if (currentStatus == null) return;

    final healthStatus = _mapConnectionStatusToHealth(serverStatus.status);
    final features = _updateFeatureStatus(serviceId, healthStatus, serverStatus.error);
    
    final updatedStatus = currentStatus.copyWith(
      status: healthStatus,
      lastUpdated: DateTime.now(),
      error: serverStatus.error,
      features: features,
      retryCount: serverStatus.retryCount,
      maxRetries: serverStatus.maxRetries,
    );

    _serviceStatuses[serviceId] = updatedStatus;
    _serviceStatusController.add(updatedStatus);

    // Create user feedback based on status change
    _createStatusChangeFeedback(currentStatus, updatedStatus);
    
    // Schedule periodic status updates for degraded services
    _scheduleStatusUpdates(serviceId, healthStatus);
  }

  /// Update service degradation
  void updateServiceDegradation(MCPServiceDegradation degradation) {
    final serviceId = degradation.serviceId;
    final currentStatus = _serviceStatuses[serviceId];
    
    if (currentStatus == null) return;

    final updatedStatus = currentStatus.copyWith(
      degradation: degradation,
      lastUpdated: DateTime.now(),
    );

    _serviceStatuses[serviceId] = updatedStatus;
    _serviceStatusController.add(updatedStatus);

    // Create degradation feedback
    _createDegradationFeedback(degradation);
  }

  /// Create feedback for status changes
  void _createStatusChangeFeedback(MCPServiceStatus oldStatus, MCPServiceStatus newStatus) {
    if (oldStatus.status == newStatus.status) return;

    final feedback = _createServiceStatusFeedback(newStatus, oldStatus.status);
    _userFeedbackController.add(feedback);
  }

  /// Create feedback for service degradation
  void _createDegradationFeedback(MCPServiceDegradation degradation) {
    final feedback = MCPUserFeedback(
      id: 'degradation_${degradation.serviceId}_${DateTime.now().millisecondsSinceEpoch}',
      type: MCPUserFeedbackType.degradation,
      title: 'Service Update',
      message: degradation.description,
      serviceName: _getServiceName(degradation.serviceId),
      timestamp: DateTime.now(),
      priority: _getDegradationPriority(degradation.level),
      isActionable: degradation.workaround != null,
      details: MCPFeedbackDetails(
        affectedFeatures: degradation.affectedFeatures,
        availableFeatures: degradation.availableFeatures,
        workaround: degradation.workaround,
        estimatedResolution: degradation.estimatedResolution,
        technicalDetails: 'Service degradation level: ${degradation.level.name}',
      ),
    );

    _userFeedbackController.add(feedback);
  }

  /// Create service status feedback
  MCPUserFeedback _createServiceStatusFeedback(
    MCPServiceStatus status,
    MCPServiceHealthStatus? previousStatus,
  ) {
    final feedbackType = _getFeedbackType(status.status);
    final title = _getStatusTitle(status.status, status.serviceName);
    final message = _getStatusMessage(status, previousStatus);
    
    return MCPUserFeedback(
      id: 'status_${status.serviceId}_${DateTime.now().millisecondsSinceEpoch}',
      type: feedbackType,
      title: title,
      message: message,
      serviceName: status.serviceName,
      timestamp: status.lastUpdated,
      priority: _getStatusPriority(status.status),
      isActionable: _isStatusActionable(status.status),
      details: MCPFeedbackDetails(
        affectedFeatures: _getAffectedFeatures(status),
        availableFeatures: _getAvailableFeatures(status),
        technicalDetails: status.error,
        retryInfo: status.retryCount > 0 
            ? 'Retry attempt ${status.retryCount}/${status.maxRetries}'
            : null,
      ),
    );
  }

  /// Map connection status to health status
  MCPServiceHealthStatus _mapConnectionStatusToHealth(MCPConnectionStatus connectionStatus) {
    switch (connectionStatus) {
      case MCPConnectionStatus.connected:
        return MCPServiceHealthStatus.healthy;
      case MCPConnectionStatus.connecting:
        return MCPServiceHealthStatus.connecting;
      case MCPConnectionStatus.retrying:
        return MCPServiceHealthStatus.degraded;
      case MCPConnectionStatus.error:
        return MCPServiceHealthStatus.unhealthy;
      case MCPConnectionStatus.disconnected:
        return MCPServiceHealthStatus.offline;
    }
  }

  /// Update feature status based on service health
  List<MCPServiceFeature> _updateFeatureStatus(
    String serviceId,
    MCPServiceHealthStatus healthStatus,
    String? error,
  ) {
    final baseFeatures = _getServiceFeatures(serviceId);
    
    return baseFeatures.map((feature) {
      final featureStatus = _getFeatureStatus(healthStatus, feature.isEssential);
      return feature.copyWith(
        status: featureStatus,
        statusMessage: _getFeatureStatusMessage(featureStatus, feature.name),
      );
    }).toList();
  }

  /// Get feature status based on service health
  MCPFeatureStatus _getFeatureStatus(MCPServiceHealthStatus serviceHealth, bool isEssential) {
    switch (serviceHealth) {
      case MCPServiceHealthStatus.healthy:
        return MCPFeatureStatus.available;
      case MCPServiceHealthStatus.connecting:
        return isEssential ? MCPFeatureStatus.limited : MCPFeatureStatus.unavailable;
      case MCPServiceHealthStatus.degraded:
        return isEssential ? MCPFeatureStatus.limited : MCPFeatureStatus.unavailable;
      case MCPServiceHealthStatus.unhealthy:
        return isEssential ? MCPFeatureStatus.offline : MCPFeatureStatus.unavailable;
      case MCPServiceHealthStatus.offline:
        return isEssential ? MCPFeatureStatus.offline : MCPFeatureStatus.unavailable;
      case MCPServiceHealthStatus.unknown:
        return MCPFeatureStatus.unknown;
    }
  }

  /// Get feature status message
  String _getFeatureStatusMessage(MCPFeatureStatus status, String featureName) {
    switch (status) {
      case MCPFeatureStatus.available:
        return '$featureName is working normally';
      case MCPFeatureStatus.limited:
        return '$featureName is available with limited functionality';
      case MCPFeatureStatus.offline:
        return '$featureName is using cached content';
      case MCPFeatureStatus.unavailable:
        return '$featureName is temporarily unavailable';
      case MCPFeatureStatus.unknown:
        return '$featureName status is unknown';
    }
  }

  /// Get service features
  List<MCPServiceFeature> _getServiceFeatures(String serviceId) {
    switch (serviceId) {
      case 'health-data-server':
        return [
          MCPServiceFeature(
            id: 'health_insights',
            name: 'Health Insights',
            description: 'Real-time health recovery information',
            isEssential: true,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'recovery_timeline',
            name: 'Recovery Timeline',
            description: 'Personalized health recovery milestones',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'medical_recommendations',
            name: 'Medical Recommendations',
            description: 'Evidence-based health guidance',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
        ];
      case 'ai-workflow-server':
        return [
          MCPServiceFeature(
            id: 'motivation_content',
            name: 'Personalized Motivation',
            description: 'AI-generated motivational content',
            isEssential: true,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'intervention_plans',
            name: 'Smart Interventions',
            description: 'AI-powered craving intervention strategies',
            isEssential: true,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'mood_analysis',
            name: 'Mood Analysis',
            description: 'Intelligent mood tracking and response',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
        ];
      case 'external-services-server':
        return [
          MCPServiceFeature(
            id: 'weather_insights',
            name: 'Weather Insights',
            description: 'Weather-based craving predictions',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'community_features',
            name: 'Community Support',
            description: 'Peer support and community features',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'financial_insights',
            name: 'Financial Insights',
            description: 'Savings tracking and investment suggestions',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
        ];
      case 'analytics-server':
        return [
          MCPServiceFeature(
            id: 'progress_analytics',
            name: 'Progress Analytics',
            description: 'Detailed progress analysis and insights',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'pattern_recognition',
            name: 'Pattern Recognition',
            description: 'Automatic detection of behavior patterns',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
          MCPServiceFeature(
            id: 'predictive_insights',
            name: 'Predictive Insights',
            description: 'AI-powered success predictions',
            isEssential: false,
            status: MCPFeatureStatus.unknown,
          ),
        ];
      default:
        return [];
    }
  }

  /// Get service name
  String _getServiceName(String serviceId) {
    switch (serviceId) {
      case 'health-data-server':
        return 'Health Insights';
      case 'ai-workflow-server':
        return 'AI Support';
      case 'external-services-server':
        return 'External Services';
      case 'analytics-server':
        return 'Analytics';
      default:
        return 'Smart Features';
    }
  }

  /// Get feedback type from service health status
  MCPUserFeedbackType _getFeedbackType(MCPServiceHealthStatus status) {
    switch (status) {
      case MCPServiceHealthStatus.healthy:
        return MCPUserFeedbackType.success;
      case MCPServiceHealthStatus.connecting:
        return MCPUserFeedbackType.info;
      case MCPServiceHealthStatus.degraded:
        return MCPUserFeedbackType.warning;
      case MCPServiceHealthStatus.unhealthy:
        return MCPUserFeedbackType.error;
      case MCPServiceHealthStatus.offline:
        return MCPUserFeedbackType.offline;
      case MCPServiceHealthStatus.unknown:
        return MCPUserFeedbackType.info;
    }
  }

  /// Get status title
  String _getStatusTitle(MCPServiceHealthStatus status, String serviceName) {
    switch (status) {
      case MCPServiceHealthStatus.healthy:
        return '$serviceName Restored';
      case MCPServiceHealthStatus.connecting:
        return 'Connecting to $serviceName';
      case MCPServiceHealthStatus.degraded:
        return '$serviceName Limited';
      case MCPServiceHealthStatus.unhealthy:
        return '$serviceName Unavailable';
      case MCPServiceHealthStatus.offline:
        return '$serviceName Offline';
      case MCPServiceHealthStatus.unknown:
        return '$serviceName Status Unknown';
    }
  }

  /// Get status message
  String _getStatusMessage(MCPServiceStatus status, MCPServiceHealthStatus? previousStatus) {
    switch (status.status) {
      case MCPServiceHealthStatus.healthy:
        return previousStatus != MCPServiceHealthStatus.healthy
            ? '${status.serviceName} is now working normally. All features are available.'
            : '${status.serviceName} is working normally.';
      case MCPServiceHealthStatus.connecting:
        return 'Connecting to ${status.serviceName}. Please wait...';
      case MCPServiceHealthStatus.degraded:
        return '${status.serviceName} is experiencing issues. Some features may be limited.';
      case MCPServiceHealthStatus.unhealthy:
        return '${status.serviceName} is currently unavailable. Using offline alternatives.';
      case MCPServiceHealthStatus.offline:
        return '${status.serviceName} is offline. Essential features are available using cached content.';
      case MCPServiceHealthStatus.unknown:
        return 'Checking ${status.serviceName} status...';
    }
  }

  /// Get affected features
  List<String> _getAffectedFeatures(MCPServiceStatus status) {
    return status.features
        .where((feature) => feature.status != MCPFeatureStatus.available)
        .map((feature) => feature.name)
        .toList();
  }

  /// Get available features
  List<String> _getAvailableFeatures(MCPServiceStatus status) {
    return status.features
        .where((feature) => 
            feature.status == MCPFeatureStatus.available || 
            feature.status == MCPFeatureStatus.limited ||
            feature.status == MCPFeatureStatus.offline)
        .map((feature) => feature.name)
        .toList();
  }

  /// Get status priority
  MCPFeedbackPriority _getStatusPriority(MCPServiceHealthStatus status) {
    switch (status) {
      case MCPServiceHealthStatus.unhealthy:
        return MCPFeedbackPriority.high;
      case MCPServiceHealthStatus.degraded:
        return MCPFeedbackPriority.medium;
      case MCPServiceHealthStatus.offline:
        return MCPFeedbackPriority.medium;
      case MCPServiceHealthStatus.connecting:
        return MCPFeedbackPriority.low;
      case MCPServiceHealthStatus.healthy:
        return MCPFeedbackPriority.low;
      case MCPServiceHealthStatus.unknown:
        return MCPFeedbackPriority.low;
    }
  }

  /// Get degradation priority
  MCPFeedbackPriority _getDegradationPriority(MCPDegradationLevel level) {
    switch (level) {
      case MCPDegradationLevel.complete:
        return MCPFeedbackPriority.high;
      case MCPDegradationLevel.major:
        return MCPFeedbackPriority.high;
      case MCPDegradationLevel.moderate:
        return MCPFeedbackPriority.medium;
      case MCPDegradationLevel.minor:
        return MCPFeedbackPriority.low;
      case MCPDegradationLevel.none:
        return MCPFeedbackPriority.low;
    }
  }

  /// Check if status is actionable
  bool _isStatusActionable(MCPServiceHealthStatus status) {
    switch (status) {
      case MCPServiceHealthStatus.unhealthy:
      case MCPServiceHealthStatus.degraded:
      case MCPServiceHealthStatus.offline:
        return true;
      default:
        return false;
    }
  }

  /// Schedule periodic status updates for degraded services
  void _scheduleStatusUpdates(String serviceId, MCPServiceHealthStatus status) {
    // Cancel existing timer
    _statusUpdateTimers[serviceId]?.cancel();
    
    // Schedule updates for degraded services
    if (status == MCPServiceHealthStatus.degraded || 
        status == MCPServiceHealthStatus.unhealthy ||
        status == MCPServiceHealthStatus.offline) {
      
      _statusUpdateTimers[serviceId] = Timer.periodic(
        Duration(minutes: 5),
        (timer) => _sendPeriodicStatusUpdate(serviceId),
      );
    }
  }

  /// Send periodic status update
  void _sendPeriodicStatusUpdate(String serviceId) {
    final status = _serviceStatuses[serviceId];
    if (status == null) return;

    final feedback = MCPUserFeedback(
      id: 'periodic_${serviceId}_${DateTime.now().millisecondsSinceEpoch}',
      type: MCPUserFeedbackType.info,
      title: 'Service Status Update',
      message: 'Still working to restore ${status.serviceName}. Using offline alternatives in the meantime.',
      serviceName: status.serviceName,
      timestamp: DateTime.now(),
      priority: MCPFeedbackPriority.low,
      isActionable: false,
      details: MCPFeedbackDetails(
        availableFeatures: _getAvailableFeatures(status),
        technicalDetails: 'Automatic retry in progress',
      ),
    );

    _userFeedbackController.add(feedback);
  }

  /// Get current service statuses
  Map<String, MCPServiceStatus> getCurrentStatuses() {
    return Map.unmodifiable(_serviceStatuses);
  }

  /// Get overall system health
  MCPSystemHealth getSystemHealth() {
    final statuses = _serviceStatuses.values.toList();
    
    final healthyCount = statuses.where((s) => s.status == MCPServiceHealthStatus.healthy).length;
    final degradedCount = statuses.where((s) => s.status == MCPServiceHealthStatus.degraded).length;
    final unhealthyCount = statuses.where((s) => s.status == MCPServiceHealthStatus.unhealthy).length;
    final offlineCount = statuses.where((s) => s.status == MCPServiceHealthStatus.offline).length;
    
    MCPSystemHealthLevel overallHealth;
    if (unhealthyCount > 0 || offlineCount > statuses.length / 2) {
      overallHealth = MCPSystemHealthLevel.critical;
    } else if (degradedCount > 0 || offlineCount > 0) {
      overallHealth = MCPSystemHealthLevel.degraded;
    } else if (healthyCount == statuses.length) {
      overallHealth = MCPSystemHealthLevel.healthy;
    } else {
      overallHealth = MCPSystemHealthLevel.unknown;
    }
    
    return MCPSystemHealth(
      level: overallHealth,
      healthyServices: healthyCount,
      degradedServices: degradedCount,
      unhealthyServices: unhealthyCount,
      offlineServices: offlineCount,
      totalServices: statuses.length,
      lastUpdated: DateTime.now(),
    );
  }

  /// Create system health feedback
  void createSystemHealthFeedback() {
    final systemHealth = getSystemHealth();
    
    final feedback = MCPUserFeedback(
      id: 'system_health_${DateTime.now().millisecondsSinceEpoch}',
      type: _getSystemHealthFeedbackType(systemHealth.level),
      title: 'System Status',
      message: _getSystemHealthMessage(systemHealth),
      serviceName: 'System',
      timestamp: DateTime.now(),
      priority: _getSystemHealthPriority(systemHealth.level),
      isActionable: systemHealth.level != MCPSystemHealthLevel.healthy,
      details: MCPFeedbackDetails(
        technicalDetails: 'Services: ${systemHealth.healthyServices}/${systemHealth.totalServices} healthy',
      ),
    );

    _userFeedbackController.add(feedback);
  }

  /// Get system health feedback type
  MCPUserFeedbackType _getSystemHealthFeedbackType(MCPSystemHealthLevel level) {
    switch (level) {
      case MCPSystemHealthLevel.healthy:
        return MCPUserFeedbackType.success;
      case MCPSystemHealthLevel.degraded:
        return MCPUserFeedbackType.warning;
      case MCPSystemHealthLevel.critical:
        return MCPUserFeedbackType.error;
      case MCPSystemHealthLevel.unknown:
        return MCPUserFeedbackType.info;
    }
  }

  /// Get system health message
  String _getSystemHealthMessage(MCPSystemHealth health) {
    switch (health.level) {
      case MCPSystemHealthLevel.healthy:
        return 'All smart features are working normally.';
      case MCPSystemHealthLevel.degraded:
        return '${health.degradedServices + health.offlineServices} of ${health.totalServices} services are experiencing issues. Core functionality remains available.';
      case MCPSystemHealthLevel.critical:
        return 'Multiple services are unavailable. The app is operating in offline mode with essential features only.';
      case MCPSystemHealthLevel.unknown:
        return 'Checking system status...';
    }
  }

  /// Get system health priority
  MCPFeedbackPriority _getSystemHealthPriority(MCPSystemHealthLevel level) {
    switch (level) {
      case MCPSystemHealthLevel.critical:
        return MCPFeedbackPriority.high;
      case MCPSystemHealthLevel.degraded:
        return MCPFeedbackPriority.medium;
      case MCPSystemHealthLevel.healthy:
        return MCPFeedbackPriority.low;
      case MCPSystemHealthLevel.unknown:
        return MCPFeedbackPriority.low;
    }
  }

  /// Dispose of the service
  Future<void> dispose() async {
    // Cancel all timers
    for (final timer in _statusUpdateTimers.values) {
      timer.cancel();
    }
    _statusUpdateTimers.clear();
    
    // Close streams
    await _serviceStatusController.close();
    await _userFeedbackController.close();
  }
}

