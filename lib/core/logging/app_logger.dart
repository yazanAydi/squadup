import 'package:flutter/foundation.dart';

/// Log levels for different types of messages
enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  fatal,
}

/// Structured logging system for the application
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  static const String _appName = 'SquadUp';
  static LogLevel _minLevel = LogLevel.info;

  /// Set the minimum log level (only messages at or above this level will be shown)
  static void setMinLevel(LogLevel level) {
    _minLevel = level;
  }

  /// Log a message with the specified level
  static void log(
    String message, {
    LogLevel level = LogLevel.info,
    String? tag,
    Map<String, dynamic>? context,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level.index < _minLevel.index) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelEmoji = _getLevelEmoji(level);
    final tagStr = tag != null ? '[$tag]' : '';
    final contextStr = context != null ? ' | Context: $context' : '';
    final errorStr = error != null ? ' | Error: $error' : '';

    final logMessage = '$levelEmoji $_appName$tagStr | $timestamp | $message$contextStr$errorStr';

    if (kDebugMode) {
      print(logMessage);
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }

    // Hooks for production analytics / persistence
    if (!kDebugMode) {
      // Example: send to your logging backend / analytics
      // Analytics.logEvent(name: 'log', parameters: {
      //   'level': level.toString(), 'message': message, 'tag': tag, ...
      // });
    }
  }

  /// Get emoji for log level
  static String _getLevelEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
        return '🔍';
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
      case LogLevel.fatal:
        return '💀';
    }
  }

  /// Convenience methods for different log levels
  static void verbose(String message, {String? tag, Map<String, dynamic>? context}) {
    log(message, level: LogLevel.verbose, tag: tag, context: context);
  }

  static void debug(String message, {String? tag, Map<String, dynamic>? context}) {
    log(message, level: LogLevel.debug, tag: tag, context: context);
  }

  static void info(String message, {String? tag, Map<String, dynamic>? context}) {
    log(message, level: LogLevel.info, tag: tag, context: context);
  }

  static void warning(String message, {String? tag, Map<String, dynamic>? context}) {
    log(message, level: LogLevel.warning, tag: tag, context: context);
  }

  static void error(String message, {String? tag, Map<String, dynamic>? context, Object? error, StackTrace? stackTrace}) {
    log(message, level: LogLevel.error, tag: tag, context: context, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, {String? tag, Map<String, dynamic>? context, Object? error, StackTrace? stackTrace}) {
    log(message, level: LogLevel.fatal, tag: tag, context: context, error: error, stackTrace: stackTrace);
  }

  /// Log performance metrics
  static void logPerformance(String operation, Duration duration, {String? tag}) {
    info('Performance: $operation took ${duration.inMilliseconds}ms', tag: tag);
  }

  /// Log user actions for analytics
  static void logUserAction(String action, {String? tag, Map<String, dynamic>? context}) {
    info('User Action: $action', tag: tag, context: context);
  }

  /// Log API calls
  static void logApiCall(String endpoint, {String? tag, Map<String, dynamic>? context}) {
    info('API Call: $endpoint', tag: tag, context: context);
  }

  /// Log navigation events
  static void logNavigation(String from, String to, {String? tag}) {
    info('Navigation: $from → $to', tag: tag);
  }
}
