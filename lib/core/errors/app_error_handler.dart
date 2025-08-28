import 'package:flutter/foundation.dart';

import 'dart:async';

/// Centralized error handling for the entire application
class AppErrorHandler {
  static final AppErrorHandler _instance = AppErrorHandler._internal();
  factory AppErrorHandler() => _instance;
  AppErrorHandler._internal();

  // Global error stream for UI error handling
  static final StreamController<AppError> _errorController = StreamController<AppError>.broadcast();
  static Stream<AppError> get errorStream => _errorController.stream;

  // Error reporting callbacks
  static Function(AppError)? _crashReportingCallback;
  static Function(AppError)? _analyticsCallback;
  static Function(AppError)? _userNotificationCallback;

  /// Initialize error handler with callbacks
  static void initialize({
    Function(AppError)? crashReporting,
    Function(AppError)? analytics,
    Function(AppError)? userNotification,
  }) {
    _crashReportingCallback = crashReporting ?? _defaultCrashReporting;
    _analyticsCallback = analytics ?? _defaultAnalytics;
    _userNotificationCallback = userNotification ?? _defaultUserNotification;
  }

  /// Default crash reporting implementation
  static void _defaultCrashReporting(AppError error) {
    // Import here to avoid circular dependencies
    try {
      // This would be called dynamically to avoid import issues
      // CrashReportingService.recordError(error.error, error.stackTrace, ...);
    } catch (e) {
      // Silently fail if service not available
    }
  }

  /// Default analytics implementation
  static void _defaultAnalytics(AppError error) {
    try {
      // This would be called dynamically to avoid import issues
      // AnalyticsService.trackError(...);
    } catch (e) {
      // Silently fail if service not available
    }
  }

  /// Default user notification implementation
  static void _defaultUserNotification(AppError error) {
    // Default implementation - could show in-app notifications
    if (kDebugMode) {
      print('User notification: ${error.message}');
    }
  }

  /// Handle errors with proper logging and user feedback
  static void handleError(
    dynamic error,
    StackTrace? stackTrace, {
    String? context,
    bool showUserMessage = true,
    ErrorSeverity severity = ErrorSeverity.error,
  }) {
    final appError = AppError(
      error: error,
      stackTrace: stackTrace,
      context: context,
      severity: severity,
      timestamp: DateTime.now(),
    );

    // Log error for debugging
    if (kDebugMode) {
      print('🚨 ERROR in $context: $error');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }

    // Send to error stream for UI handling
    _errorController.add(appError);

    // Call registered callbacks
    _crashReportingCallback?.call(appError);
    _analyticsCallback?.call(appError);

    // Show user-friendly error message if needed
    if (showUserMessage) {
      _userNotificationCallback?.call(appError);
    }
  }

  /// Handle uncaught errors globally
  static void setupGlobalErrorHandling() {
    FlutterError.onError = (FlutterErrorDetails details) {
      handleError(
        details.exception,
        details.stack,
        context: 'Flutter Error',
        severity: ErrorSeverity.critical,
      );
    };

    // Handle async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      handleError(
        error,
        stack,
        context: 'Platform Error',
        severity: ErrorSeverity.critical,
      );
      return true;
    };
  }



  /// Handle specific error types
  static void handleNetworkError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Network', severity: ErrorSeverity.warning);
  }

  static void handleAuthError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Authentication', severity: ErrorSeverity.error);
  }

  static void handleDatabaseError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Database', severity: ErrorSeverity.error);
  }

  static void handleValidationError(dynamic error, StackTrace? stackTrace) {
    handleError(error, stackTrace, context: 'Validation', severity: ErrorSeverity.warning);
  }

  /// Dispose resources
  static void dispose() {
    _errorController.close();
  }
}

/// Error severity levels
enum ErrorSeverity {
  info,
  warning,
  error,
  critical,
}

/// Structured error information
class AppError {
  final dynamic error;
  final StackTrace? stackTrace;
  final String? context;
  final ErrorSeverity severity;
  final DateTime timestamp;
  final String? userId;
  final Map<String, dynamic>? metadata;

  const AppError({
    required this.error,
    this.stackTrace,
    this.context,
    this.severity = ErrorSeverity.error,
    required this.timestamp,
    this.userId,
    this.metadata,
  });

  String get message => error.toString();
  String get errorType => error.runtimeType.toString();

  @override
  String toString() => 'AppError: $message (Context: $context, Severity: $severity)';
}

/// Custom exception classes for better error handling
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final ErrorSeverity severity;

  const AppException(
    this.message, {
    this.code,
    this.originalError,
    this.severity = ErrorSeverity.error,
  });

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.originalError, super.severity});
}

class AuthException extends AppException {
  const AuthException(super.message, {super.code, super.originalError, super.severity});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.code, super.originalError, super.severity});
}

class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.code, super.originalError, super.severity});
}
