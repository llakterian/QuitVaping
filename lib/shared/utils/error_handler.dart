import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A utility class for handling errors throughout the app
class ErrorHandler {
  // Singleton instance
  static final ErrorHandler _instance = ErrorHandler._internal();
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();

  // Error reporting callback
  Function(String, dynamic, StackTrace?)? _reportErrorCallback;

  // Initialize error handler with optional reporting mechanism
  void init({Function(String, dynamic, StackTrace?)? reportError}) {
    _reportErrorCallback = reportError;
    
    // Set up global error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleError(
        'Flutter framework error',
        details.exception,
        details.stack,
      );
      
      // Forward to Flutter's default error handler
      FlutterError.presentError(details);
    };
    
    // Handle errors that aren't caught by the Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      _handleError('Uncaught platform error', error, stack);
      // Return true to prevent the error from being handled by the platform
      return true;
    };
  }

  // Handle and log errors
  void _handleError(String source, dynamic error, StackTrace? stack) {
    // Log the error
    debugPrint('ERROR [$source]: $error');
    if (stack != null) {
      debugPrint('Stack trace: $stack');
    }
    
    // Sanitize error data before reporting to ensure no PII is included
    final sanitizedError = _sanitizeErrorData(error);
    
    // Report the error if a reporting mechanism is set up
    if (_reportErrorCallback != null) {
      _reportErrorCallback!(source, sanitizedError, stack);
    }
  }

  // Sanitize error data to remove any potential PII
  dynamic _sanitizeErrorData(dynamic error) {
    if (error is String) {
      // Sanitize common PII patterns in strings
      return _sanitizeString(error);
    } else if (error is Map) {
      // Recursively sanitize map values
      return error.map((key, value) => MapEntry(key, _sanitizeErrorData(value)));
    } else if (error is List) {
      // Recursively sanitize list items
      return error.map((item) => _sanitizeErrorData(item)).toList();
    }
    
    // Return original error for other types
    return error;
  }

  // Sanitize string to remove potential PII
  String _sanitizeString(String input) {
    // Email pattern
    final emailPattern = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
    
    // Phone number patterns (various formats)
    final phonePattern = RegExp(r'\b(\+\d{1,3}[\s-]?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\b');
    
    // Replace potential PII with placeholders
    String sanitized = input
        .replaceAll(emailPattern, '[EMAIL]')
        .replaceAll(phonePattern, '[PHONE]');
    
    return sanitized;
  }

  // Method to handle errors in async operations
  Future<T?> handleAsync<T>(Future<T> Function() operation, {
    String? operationName,
    T? fallbackValue,
    Function(dynamic error)? onError,
    bool isDataOperation = false,
  }) async {
    try {
      return await operation();
    } catch (e, stack) {
      final source = operationName ?? 'Async operation';
      _handleError(source, e, stack);
      
      if (onError != null) {
        onError(e);
      }
      
      // Log additional context for data operations
      if (isDataOperation) {
        debugPrint('Data operation failed: $source');
      }
      
      return fallbackValue;
    }
  }

  // Method to handle errors in synchronous operations
  T? handleSync<T>(T Function() operation, {
    String? operationName,
    T? fallbackValue,
    Function(dynamic error)? onError,
    bool isDataOperation = false,
  }) {
    try {
      return operation();
    } catch (e, stack) {
      final source = operationName ?? 'Sync operation';
      _handleError(source, e, stack);
      
      if (onError != null) {
        onError(e);
      }
      
      // Log additional context for data operations
      if (isDataOperation) {
        debugPrint('Data operation failed: $source');
      }
      
      return fallbackValue;
    }
  }

  // Show error dialog to the user
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show error snackbar to the user
  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  // Show privacy policy consent dialog
  Future<bool> showPrivacyConsentDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const Text(
          'We value your privacy and want to be transparent about how we collect and use your data. '
          'Please review our Privacy Policy to understand how we handle your information.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Decline'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Accept'),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }
}