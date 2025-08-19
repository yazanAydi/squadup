import 'package:flutter/foundation.dart';

/// Centralized error handling for the entire application
class AppErrorHandler {
  static final AppErrorHandler _instance = AppErrorHandler._internal();
  factory AppErrorHandler() => _instance;
  AppErrorHandler._internal();

  /// Handle errors with proper logging and user feedback
  static void handleError(
    dynamic error,
    StackTrace? stackTrace, {
    String? context,
    bool showUserMessage = true,
  }) {
    // Log error for debugging
    if (kDebugMode) {
      print('🚨 ERROR in $context: $error');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }

    // Crash/analytics hooks (integrate Firebase Crashlytics/Analytics here if desired)
    // Using debug print for now to avoid external dependencies
    if (!kDebugMode) {
      // Placeholders for production reporting
      // Crashlytics.instance.recordError(error, stackTrace, reason: context);
      // Analytics.logEvent(name: 'app_error', parameters: {'context': context, 'error': error.toString()});
    }

    // Show user-friendly error message if needed
    if (showUserMessage) {
      _showUserFriendlyError(error);
    }
  }

  /// Show user-friendly error messages
  static void _showUserFriendlyError(dynamic error) {
    // A UI hook can be wired to display snackbars/dialogs from a global navigator key
    // Intentionally kept lightweight here to avoid BuildContext coupling
    if (kDebugMode) {
      print('User-friendly error message would be shown for: $error');
    }
  }

  /// Handle specific error types
  static void handleNetworkError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Network');
  }

  static void handleAuthError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Authentication');
  }

  static void handleDatabaseError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Database');
  }

  static void handleValidationError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Validation');
  }
}

/// Custom exception classes for better error handling
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.originalError});
}

class AuthException extends AppException {
  const AuthException(super.message, {super.code, super.originalError});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.code, super.originalError});
}
