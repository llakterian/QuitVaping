import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/mcp_model.dart';
import '../models/mcp_error_models.dart';

/// Comprehensive error handling service for MCP operations
class MCPErrorHandlingService {
  static const Map<MCPErrorType, MCPRetryConfig> _defaultRetryConfigs = {
    MCPErrorType.connectionFailed: MCPRetryConfig(
      errorType: MCPErrorType.connectionFailed,
      maxRetries: 3,
      baseDelay: Duration(seconds: 2),
      backoffMultiplier: 2.0,
      maxDelay: Duration(seconds: 30),
    ),
    MCPErrorType.serverUnavailable: MCPRetryConfig(
      errorType: MCPErrorType.serverUnavailable,
      maxRetries: 5,
      baseDelay: Duration(seconds: 1),
      backoffMultiplier: 1.5,
      maxDelay: Duration(seconds: 60),
    ),
    MCPErrorType.timeout: MCPRetryConfig(
      errorType: MCPErrorType.timeout,
      maxRetries: 2,
      baseDelay: Duration(seconds: 3),
      backoffMultiplier: 2.0,
      maxDelay: Duration(seconds: 15),
    ),
    MCPErrorType.networkError: MCPRetryConfig(
      errorType: MCPErrorType.networkError,
      maxRetries: 4,
      baseDelay: Duration(seconds: 1),
      backoffMultiplier: 2.0,
      maxDelay: Duration(seconds: 45),
    ),
    MCPErrorType.rateLimited: MCPRetryConfig(
      errorType: MCPErrorType.rateLimited,
      maxRetries: 3,
      baseDelay: Duration(seconds: 5),
      backoffMultiplier: 1.5,
      maxDelay: Duration(seconds: 120),
    ),
  };

  final StreamController<MCPError> _errorController = 
      StreamController<MCPError>.broadcast();
  final StreamController<MCPUserNotification> _notificationController = 
      StreamController<MCPUserNotification>.broadcast();
  final StreamController<MCPServiceDegradation> _degradationController = 
      StreamController<MCPServiceDegradation>.broadcast();

  final Map<String, MCPServiceDegradation> _currentDegradations = {};
  final Map<String, Timer> _retryTimers = {};
  final Random _random = Random();

  /// Stream of MCP errors
  Stream<MCPError> get errorStream => _errorController.stream;

  /// Stream of user notifications
  Stream<MCPUserNotification> get notificationStream => _notificationController.stream;

  /// Stream of service degradation updates
  Stream<MCPServiceDegradation> get degradationStream => _degradationController.stream;

  /// Handle MCP error with comprehensive error processing
  Future<MCPErrorHandlingResult> handleError(
    Exception error, {
    String? serverId,
    String? operation,
    Map<String, dynamic>? context,
  }) async {
    final mcpError = _createMCPError(error, serverId, operation, context);
    
    // Emit error for logging and monitoring
    _errorController.add(mcpError);
    
    // Determine if retry is appropriate
    final shouldRetry = _shouldRetryError(mcpError);
    
    // Create recovery options
    final recoveryOptions = _createRecoveryOptions(mcpError);
    
    // Update service degradation status
    await _updateServiceDegradation(mcpError);
    
    // Create user notification
    final notification = _createUserNotification(mcpError, recoveryOptions);
    _notificationController.add(notification);
    
    return MCPErrorHandlingResult(
      error: mcpError,
      shouldRetry: shouldRetry,
      retryDelay: shouldRetry ? _calculateRetryDelay(mcpError) : null,
      recoveryOptions: recoveryOptions,
      notification: notification,
      degradationLevel: _getDegradationLevel(mcpError),
    );
  }

  /// Execute operation with automatic retry and error handling
  Future<T> executeWithRetry<T>(
    Future<T> Function() operation, {
    String? serverId,
    String? operationName,
    Map<String, dynamic>? context,
    MCPRetryConfig? customRetryConfig,
  }) async {
    var retryCount = 0;
    Exception? lastError;
    
    while (true) {
      try {
        return await operation();
      } catch (error) {
        lastError = error is Exception ? error : Exception(error.toString());
        
        var mcpError = _createMCPError(lastError, serverId, operationName, context);
        mcpError = mcpError.copyWith(retryCount: retryCount);
        
        final retryConfig = customRetryConfig ?? _getRetryConfig(mcpError.errorType);
        
        if (retryCount >= retryConfig.maxRetries || !_shouldRetryError(mcpError)) {
          // Final attempt failed, handle error comprehensively
          await handleError(lastError, serverId: serverId, operation: operationName, context: context);
          rethrow;
        }
        
        retryCount++;
        final delay = _calculateRetryDelayFromConfig(retryConfig, retryCount);
        
        debugPrint('Retrying operation $operationName (attempt $retryCount/${retryConfig.maxRetries}) after ${delay.inMilliseconds}ms');
        
        // Create retry notification
        final retryNotification = MCPUserNotification(
          id: 'retry_${DateTime.now().millisecondsSinceEpoch}',
          title: 'Retrying...',
          message: 'Attempting to reconnect (${retryCount}/${retryConfig.maxRetries})',
          type: MCPNotificationType.info,
          timestamp: DateTime.now(),
          isDismissible: false,
          displayDuration: delay,
        );
        _notificationController.add(retryNotification);
        
        await Future.delayed(delay);
      }
    }
  }

  /// Create MCP error from exception
  MCPError _createMCPError(
    Exception error,
    String? serverId,
    String? operation,
    Map<String, dynamic>? context,
  ) {
    final errorType = _determineErrorType(error);
    final severity = _determineSeverity(errorType);
    
    return MCPError(
      id: 'error_${DateTime.now().millisecondsSinceEpoch}',
      errorType: errorType,
      message: error.toString(),
      userFriendlyMessage: _createUserFriendlyMessage(errorType, serverId),
      serverId: serverId,
      operation: operation,
      timestamp: DateTime.now(),
      isRetryable: _isRetryableError(errorType),
      context: context,
      severity: severity,
    );
  }

  /// Determine error type from exception
  MCPErrorType _determineErrorType(Exception error) {
    final errorMessage = error.toString().toLowerCase();
    
    if (errorMessage.contains('connection') || errorMessage.contains('connect')) {
      return MCPErrorType.connectionFailed;
    } else if (errorMessage.contains('timeout')) {
      return MCPErrorType.timeout;
    } else if (errorMessage.contains('network') || errorMessage.contains('socket')) {
      return MCPErrorType.networkError;
    } else if (errorMessage.contains('unavailable') || errorMessage.contains('not found')) {
      return MCPErrorType.serverUnavailable;
    } else if (errorMessage.contains('rate limit') || errorMessage.contains('too many requests')) {
      return MCPErrorType.rateLimited;
    } else if (errorMessage.contains('auth') || errorMessage.contains('unauthorized')) {
      return MCPErrorType.authenticationFailed;
    } else if (errorMessage.contains('offline')) {
      return MCPErrorType.offline;
    } else {
      return MCPErrorType.serverError;
    }
  }

  /// Determine error severity
  MCPErrorSeverity _determineSeverity(MCPErrorType errorType) {
    switch (errorType) {
      case MCPErrorType.authenticationFailed:
        return MCPErrorSeverity.critical;
      case MCPErrorType.serverUnavailable:
      case MCPErrorType.offline:
        return MCPErrorSeverity.high;
      case MCPErrorType.connectionFailed:
      case MCPErrorType.networkError:
        return MCPErrorSeverity.medium;
      case MCPErrorType.timeout:
      case MCPErrorType.rateLimited:
        return MCPErrorSeverity.low;
      default:
        return MCPErrorSeverity.medium;
    }
  }

  /// Create user-friendly error message
  String _createUserFriendlyMessage(MCPErrorType errorType, String? serverId) {
    final serviceName = _getServiceName(serverId);
    
    switch (errorType) {
      case MCPErrorType.connectionFailed:
        return 'Unable to connect to $serviceName. Please check your internet connection.';
      case MCPErrorType.serverUnavailable:
        return '$serviceName is temporarily unavailable. We\'re using offline content instead.';
      case MCPErrorType.timeout:
        return '$serviceName is taking longer than usual to respond. We\'ll keep trying.';
      case MCPErrorType.networkError:
        return 'Network connection issue detected. Some features may be limited.';
      case MCPErrorType.rateLimited:
        return 'Too many requests to $serviceName. Please wait a moment before trying again.';
      case MCPErrorType.offline:
        return 'You\'re currently offline. Using cached content and limited functionality.';
      case MCPErrorType.authenticationFailed:
        return 'Authentication issue with $serviceName. Please check your settings.';
      default:
        return '$serviceName encountered an issue. We\'re working to resolve it.';
    }
  }

  /// Get user-friendly service name
  String _getServiceName(String? serverId) {
    switch (serverId) {
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

  /// Check if error should be retried
  bool _shouldRetryError(MCPError error) {
    if (!error.isRetryable) return false;
    if (error.retryCount >= error.maxRetries) return false;
    
    switch (error.errorType) {
      case MCPErrorType.authenticationFailed:
      case MCPErrorType.invalidRequest:
        return false;
      case MCPErrorType.connectionFailed:
      case MCPErrorType.serverUnavailable:
      case MCPErrorType.timeout:
      case MCPErrorType.networkError:
      case MCPErrorType.rateLimited:
        return true;
      default:
        return false;
    }
  }

  /// Check if error type is retryable
  bool _isRetryableError(MCPErrorType errorType) {
    switch (errorType) {
      case MCPErrorType.connectionFailed:
      case MCPErrorType.serverUnavailable:
      case MCPErrorType.timeout:
      case MCPErrorType.networkError:
      case MCPErrorType.rateLimited:
        return true;
      default:
        return false;
    }
  }

  /// Calculate retry delay with exponential backoff
  Duration _calculateRetryDelay(MCPError error) {
    final config = _getRetryConfig(error.errorType);
    return _calculateRetryDelayFromConfig(config, error.retryCount + 1);
  }

  /// Calculate retry delay from configuration
  Duration _calculateRetryDelayFromConfig(MCPRetryConfig config, int retryCount) {
    if (!config.exponentialBackoff) {
      return config.baseDelay;
    }
    
    var delay = config.baseDelay.inMilliseconds * 
                pow(config.backoffMultiplier, retryCount - 1);
    
    // Add jitter to prevent thundering herd
    if (config.jitter > 0) {
      final jitterAmount = delay * config.jitter;
      delay += (_random.nextDouble() - 0.5) * 2 * jitterAmount;
    }
    
    // Cap at maximum delay
    delay = delay.clamp(config.baseDelay.inMilliseconds, config.maxDelay.inMilliseconds);
    
    return Duration(milliseconds: delay.round());
  }

  /// Get retry configuration for error type
  MCPRetryConfig _getRetryConfig(MCPErrorType errorType) {
    return _defaultRetryConfigs[errorType] ?? MCPRetryConfig(errorType: errorType);
  }

  /// Create recovery options for error
  List<MCPRecoveryOption> _createRecoveryOptions(MCPError error) {
    final options = <MCPRecoveryOption>[];
    
    switch (error.errorType) {
      case MCPErrorType.connectionFailed:
      case MCPErrorType.networkError:
        options.addAll([
          MCPRecoveryOption(
            id: 'check_connection',
            title: 'Check Connection',
            description: 'Verify your internet connection and try again',
            actionType: MCPRecoveryActionType.checkConnection,
            priority: 1.0,
          ),
          MCPRecoveryOption(
            id: 'use_offline',
            title: 'Use Offline Mode',
            description: 'Continue with limited functionality using cached content',
            actionType: MCPRecoveryActionType.useOfflineContent,
            isAutomatic: true,
            priority: 0.8,
          ),
        ]);
        break;
        
      case MCPErrorType.serverUnavailable:
        options.addAll([
          MCPRecoveryOption(
            id: 'retry_later',
            title: 'Retry Later',
            description: 'The service will automatically retry in a few minutes',
            actionType: MCPRecoveryActionType.retry,
            isAutomatic: true,
            priority: 1.0,
          ),
          MCPRecoveryOption(
            id: 'use_offline',
            title: 'Use Cached Content',
            description: 'Continue with previously downloaded content',
            actionType: MCPRecoveryActionType.useOfflineContent,
            isAutomatic: true,
            priority: 0.9,
          ),
        ]);
        break;
        
      case MCPErrorType.timeout:
        options.addAll([
          MCPRecoveryOption(
            id: 'retry_now',
            title: 'Try Again',
            description: 'Retry the request immediately',
            actionType: MCPRecoveryActionType.retry,
            priority: 1.0,
          ),
          MCPRecoveryOption(
            id: 'reduce_functionality',
            title: 'Use Basic Mode',
            description: 'Continue with essential features only',
            actionType: MCPRecoveryActionType.reduceFunctionality,
            priority: 0.7,
          ),
        ]);
        break;
        
      case MCPErrorType.rateLimited:
        options.add(
          MCPRecoveryOption(
            id: 'wait_and_retry',
            title: 'Wait and Retry',
            description: 'Automatically retry after the rate limit resets',
            actionType: MCPRecoveryActionType.retry,
            isAutomatic: true,
            priority: 1.0,
          ),
        );
        break;
        
      case MCPErrorType.offline:
        options.add(
          MCPRecoveryOption(
            id: 'offline_mode',
            title: 'Offline Mode Active',
            description: 'Using cached content and essential features',
            actionType: MCPRecoveryActionType.useOfflineContent,
            isAutomatic: true,
            priority: 1.0,
          ),
        );
        break;
        
      default:
        options.addAll([
          MCPRecoveryOption(
            id: 'manual_refresh',
            title: 'Refresh',
            description: 'Manually refresh to try again',
            actionType: MCPRecoveryActionType.manualRefresh,
            priority: 1.0,
          ),
          MCPRecoveryOption(
            id: 'contact_support',
            title: 'Contact Support',
            description: 'Report this issue if it persists',
            actionType: MCPRecoveryActionType.contactSupport,
            priority: 0.3,
          ),
        ]);
    }
    
    return options;
  }

  /// Update service degradation status
  Future<void> _updateServiceDegradation(MCPError error) async {
    if (error.serverId == null) return;
    
    final degradationLevel = _getDegradationLevel(error);
    final affectedFeatures = _getAffectedFeatures(error.serverId!, error.errorType);
    final availableFeatures = _getAvailableFeatures(error.serverId!, error.errorType);
    
    final degradation = MCPServiceDegradation(
      serviceId: error.serverId!,
      level: degradationLevel,
      description: _getDegradationDescription(degradationLevel, error.serverId!),
      affectedFeatures: affectedFeatures,
      availableFeatures: availableFeatures,
      estimatedResolution: _getEstimatedResolution(error.errorType),
      workaround: _getWorkaround(error.serverId!, error.errorType),
    );
    
    _currentDegradations[error.serverId!] = degradation;
    _degradationController.add(degradation);
  }

  /// Get degradation level for error
  MCPDegradationLevel _getDegradationLevel(MCPError error) {
    switch (error.errorType) {
      case MCPErrorType.offline:
        return MCPDegradationLevel.major;
      case MCPErrorType.serverUnavailable:
        return MCPDegradationLevel.moderate;
      case MCPErrorType.connectionFailed:
      case MCPErrorType.networkError:
        return MCPDegradationLevel.moderate;
      case MCPErrorType.timeout:
      case MCPErrorType.rateLimited:
        return MCPDegradationLevel.minor;
      default:
        return MCPDegradationLevel.minor;
    }
  }

  /// Get affected features for service and error type
  List<String> _getAffectedFeatures(String serverId, MCPErrorType errorType) {
    switch (serverId) {
      case 'health-data-server':
        return ['Real-time health insights', 'Recovery timeline updates', 'Medical recommendations'];
      case 'ai-workflow-server':
        return ['Personalized motivation', 'AI-powered interventions', 'Smart recommendations'];
      case 'external-services-server':
        return ['Weather-based insights', 'Community features', 'Financial recommendations'];
      case 'analytics-server':
        return ['Progress analytics', 'Pattern recognition', 'Predictive insights'];
      default:
        return ['Smart features'];
    }
  }

  /// Get available features during degradation
  List<String> _getAvailableFeatures(String serverId, MCPErrorType errorType) {
    switch (serverId) {
      case 'health-data-server':
        return ['Cached health information', 'Basic progress tracking', 'Offline health tips'];
      case 'ai-workflow-server':
        return ['Pre-loaded motivational content', 'Basic breathing exercises', 'Emergency interventions'];
      case 'external-services-server':
        return ['Basic community features', 'Cached weather data', 'Offline financial calculations'];
      case 'analytics-server':
        return ['Basic progress display', 'Local data storage', 'Simple statistics'];
      default:
        return ['Core app functionality'];
    }
  }

  /// Get degradation description
  String _getDegradationDescription(MCPDegradationLevel level, String serverId) {
    final serviceName = _getServiceName(serverId);
    
    switch (level) {
      case MCPDegradationLevel.minor:
        return '$serviceName is experiencing minor delays but remains functional.';
      case MCPDegradationLevel.moderate:
        return '$serviceName is partially unavailable. Using cached content where possible.';
      case MCPDegradationLevel.major:
        return '$serviceName is mostly unavailable. Operating in offline mode.';
      case MCPDegradationLevel.complete:
        return '$serviceName is completely unavailable. All features are offline.';
      default:
        return '$serviceName is operating normally.';
    }
  }

  /// Get estimated resolution time
  DateTime? _getEstimatedResolution(MCPErrorType errorType) {
    switch (errorType) {
      case MCPErrorType.rateLimited:
        return DateTime.now().add(Duration(minutes: 5));
      case MCPErrorType.timeout:
        return DateTime.now().add(Duration(minutes: 2));
      case MCPErrorType.connectionFailed:
      case MCPErrorType.networkError:
        return DateTime.now().add(Duration(minutes: 10));
      case MCPErrorType.serverUnavailable:
        return DateTime.now().add(Duration(minutes: 30));
      default:
        return null;
    }
  }

  /// Get workaround suggestion
  String? _getWorkaround(String serverId, MCPErrorType errorType) {
    switch (errorType) {
      case MCPErrorType.offline:
        return 'The app will continue working with cached content and sync when connection is restored.';
      case MCPErrorType.serverUnavailable:
        return 'Using previously downloaded content. New content will be available when service is restored.';
      case MCPErrorType.rateLimited:
        return 'Please wait a few minutes before requesting new content.';
      default:
        return null;
    }
  }

  /// Create user notification for error
  MCPUserNotification _createUserNotification(
    MCPError error,
    List<MCPRecoveryOption> recoveryOptions,
  ) {
    final notificationType = _getNotificationType(error.severity!);
    final actions = recoveryOptions
        .where((option) => !option.isAutomatic)
        .take(2)
        .map((option) => MCPNotificationAction(
              id: option.id,
              label: option.title,
              actionType: option.actionType,
              parameters: option.parameters,
            ))
        .toList();
    
    return MCPUserNotification(
      id: 'notification_${error.id}',
      title: _getNotificationTitle(error.errorType),
      message: error.userFriendlyMessage,
      type: notificationType,
      timestamp: error.timestamp,
      isDismissible: error.severity != MCPErrorSeverity.critical,
      displayDuration: _getDisplayDuration(error.severity!),
      actions: actions.isNotEmpty ? actions : null,
      metadata: {
        'errorId': error.id,
        'serverId': error.serverId,
        'errorType': error.errorType.name,
      },
    );
  }

  /// Get notification type from severity
  MCPNotificationType _getNotificationType(MCPErrorSeverity severity) {
    switch (severity) {
      case MCPErrorSeverity.critical:
        return MCPNotificationType.error;
      case MCPErrorSeverity.high:
        return MCPNotificationType.warning;
      case MCPErrorSeverity.medium:
        return MCPNotificationType.degradation;
      case MCPErrorSeverity.low:
        return MCPNotificationType.info;
    }
  }

  /// Get notification title
  String _getNotificationTitle(MCPErrorType errorType) {
    switch (errorType) {
      case MCPErrorType.offline:
        return 'Offline Mode';
      case MCPErrorType.serverUnavailable:
        return 'Service Unavailable';
      case MCPErrorType.connectionFailed:
        return 'Connection Issue';
      case MCPErrorType.timeout:
        return 'Slow Response';
      case MCPErrorType.rateLimited:
        return 'Rate Limited';
      default:
        return 'Service Issue';
    }
  }

  /// Get display duration for notification
  Duration _getDisplayDuration(MCPErrorSeverity severity) {
    switch (severity) {
      case MCPErrorSeverity.critical:
        return Duration(seconds: 10);
      case MCPErrorSeverity.high:
        return Duration(seconds: 8);
      case MCPErrorSeverity.medium:
        return Duration(seconds: 6);
      case MCPErrorSeverity.low:
        return Duration(seconds: 4);
    }
  }

  /// Get current service degradations
  Map<String, MCPServiceDegradation> getCurrentDegradations() {
    return Map.unmodifiable(_currentDegradations);
  }

  /// Clear degradation for service
  void clearDegradation(String serverId) {
    if (_currentDegradations.containsKey(serverId)) {
      _currentDegradations.remove(serverId);
      
      final clearedDegradation = MCPServiceDegradation(
        serviceId: serverId,
        level: MCPDegradationLevel.none,
        description: '${_getServiceName(serverId)} is now operating normally.',
        affectedFeatures: [],
        availableFeatures: _getAllFeatures(serverId),
      );
      
      _degradationController.add(clearedDegradation);
    }
  }

  /// Get all features for a service
  List<String> _getAllFeatures(String serverId) {
    switch (serverId) {
      case 'health-data-server':
        return ['Real-time health insights', 'Recovery timeline updates', 'Medical recommendations', 'Health progress tracking'];
      case 'ai-workflow-server':
        return ['Personalized motivation', 'AI-powered interventions', 'Smart recommendations', 'Mood analysis'];
      case 'external-services-server':
        return ['Weather-based insights', 'Community features', 'Financial recommendations', 'Location services'];
      case 'analytics-server':
        return ['Progress analytics', 'Pattern recognition', 'Predictive insights', 'Custom reports'];
      default:
        return ['All smart features'];
    }
  }

  /// Dispose of the service
  Future<void> dispose() async {
    // Cancel all retry timers
    for (final timer in _retryTimers.values) {
      timer.cancel();
    }
    _retryTimers.clear();
    
    // Close streams
    await _errorController.close();
    await _notificationController.close();
    await _degradationController.close();
  }
}

/// Result of error handling operation
class MCPErrorHandlingResult {
  final MCPError error;
  final bool shouldRetry;
  final Duration? retryDelay;
  final List<MCPRecoveryOption> recoveryOptions;
  final MCPUserNotification notification;
  final MCPDegradationLevel degradationLevel;

  MCPErrorHandlingResult({
    required this.error,
    required this.shouldRetry,
    this.retryDelay,
    required this.recoveryOptions,
    required this.notification,
    required this.degradationLevel,
  });
}