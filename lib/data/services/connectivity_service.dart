import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

import '../../shared/utils/error_handler.dart';

class ConnectivityService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  bool _isConnected = false;
  final List<Function()> _pendingOperations = [];
  
  // Privacy settings
  bool _dataCollectionEnabled = true;
  
  ConnectivityService() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  
  // Getters
  bool get isConnected => _isConnected;
  ConnectivityResult get connectionStatus => _connectionStatus;
  bool get dataCollectionEnabled => _dataCollectionEnabled;
  
  // Set data collection preference
  void setDataCollectionEnabled(bool enabled) {
    _dataCollectionEnabled = enabled;
    notifyListeners();
  }
  
  // Initialize connectivity
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Could not check connectivity status: $e');
      _connectionStatus = ConnectivityResult.none;
      _isConnected = false;
    }
  }
  
  // Update connection status
  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    final wasConnected = _isConnected;
    _isConnected = result != ConnectivityResult.none;
    
    if (!wasConnected && _isConnected) {
      // Connection restored, execute pending operations
      _executePendingOperations();
    }
    
    notifyListeners();
  }
  
  // Execute pending operations when connection is restored
  void _executePendingOperations() {
    if (_pendingOperations.isNotEmpty) {
      debugPrint('Executing ${_pendingOperations.length} pending operations');
      
      for (final operation in _pendingOperations) {
        try {
          operation();
        } catch (e) {
          // Use error handler to sanitize any potential PII in error messages
          ErrorHandler().handleSync(
            () => throw e,
            operationName: 'Pending operation execution',
            isDataOperation: true,
          );
        }
      }
      
      _pendingOperations.clear();
    }
  }
  
  // Queue operation for later execution when offline
  void queueOperation(Function() operation) {
    if (_isConnected) {
      // Execute immediately if connected
      try {
        operation();
      } catch (e) {
        // Use error handler to sanitize any potential PII in error messages
        ErrorHandler().handleSync(
          () => throw e,
          operationName: 'Immediate operation execution',
          isDataOperation: true,
        );
      }
    } else {
      // Queue for later if offline
      _pendingOperations.add(operation);
      debugPrint('Operation queued for later execution (offline)');
    }
  }
  
  // Execute operation with connectivity check
  Future<T?> executeWithConnectivity<T>(Future<T> Function() operation, {
    bool requiresPrivacyConsent = false,
    String operationType = 'unknown',
  }) async {
    // Check if operation requires privacy consent and if data collection is enabled
    if (requiresPrivacyConsent && !_dataCollectionEnabled) {
      debugPrint('Operation skipped: Data collection disabled');
      return null;
    }
    
    // Check if operation requires internet
    if (!_isConnected) {
      debugPrint('Operation skipped: No internet connection');
      return null;
    }
    
    // Execute operation with error handling
    return await ErrorHandler().handleAsync(
      operation,
      operationName: 'Network operation: $operationType',
      isDataOperation: true,
    );
  }
  
  // Check if specific operation requires internet
  bool requiresInternet(String operationType) {
    const internetRequiredOperations = [
      'ai_chat',
      'sync_data',
      'backup_data',
      'restore_purchases',
      'load_ads',
      'analytics',
    ];
    
    return internetRequiredOperations.contains(operationType);
  }
  
  // Check if operation requires privacy consent
  bool requiresPrivacyConsent(String operationType) {
    const privacyRequiredOperations = [
      'analytics',
      'ai_chat',
      'sync_data',
      'backup_data',
      'crash_reporting',
    ];
    
    return privacyRequiredOperations.contains(operationType);
  }
  
  // Helper method to check privacy settings before executing an operation
  Future<bool> checkPrivacySettings(BuildContext context, String operationType) async {
    if (requiresPrivacyConsent(operationType) && !_dataCollectionEnabled) {
      // Show privacy consent dialog
      final consentGiven = await ErrorHandler().showPrivacyConsentDialog(context);
      
      if (consentGiven) {
        setDataCollectionEnabled(true);
        return true;
      }
      return false;
    }
    
    return true;
  }
  
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}