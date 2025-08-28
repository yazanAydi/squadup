import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static final List<Map<String, dynamic>> _logBuffer = [];
  static const int _maxBufferSize = 1000;
  static const String _logPrefsKey = 'app_logs';
  static String? _currentUserId;
  static int _totalLogs = 0;
  static int _errorCount = 0;
  static int _warningCount = 0;

  /// Initialize the logging system
  static Future<void> initialize() async {
    try {
      await _loadLogsFromStorage();
      info('Logging system initialized');
      if (kDebugMode) {
        print('✅ AppLogger initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to initialize AppLogger: $e');
      }
    }
  }

  /// Set the current user ID for log correlation
  static void setUserId(String? userId) {
    _currentUserId = userId;
    info('User ID set for logging', context: {'userId': userId?.substring(0, 8)});
  }

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

    final timestamp = DateTime.now();
    final levelEmoji = _getLevelEmoji(level);
    final tagStr = tag != null ? '[$tag]' : '';
    final contextStr = context != null ? ' | Context: $context' : '';
    final errorStr = error != null ? ' | Error: $error' : '';

    final logMessage = '$levelEmoji $_appName$tagStr | ${timestamp.toIso8601String()} | $message$contextStr$errorStr';

    // Store in buffer
    final logEntry = {
      'timestamp': timestamp.toIso8601String(),
      'level': level.name,
      'message': message,
      'tag': tag,
      'context': context,
      'error': error?.toString(),
      'stackTrace': stackTrace?.toString(),
      'userId': _currentUserId,
    };

    _logBuffer.add(logEntry);
    _totalLogs++;

    // Update counters
    if (level == LogLevel.error || level == LogLevel.fatal) {
      _errorCount++;
    } else if (level == LogLevel.warning) {
      _warningCount++;
    }

    // Maintain buffer size
    if (_logBuffer.length > _maxBufferSize) {
      _logBuffer.removeAt(0);
    }

    if (kDebugMode) {
      print(logMessage);
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }

    // Save to storage periodically
    if (_totalLogs % 20 == 0) {
      _saveLogsToStorage();
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

  /// Save logs to persistent storage
  static Future<void> _saveLogsToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logsJson = jsonEncode(_logBuffer.take(100).toList()); // Save last 100 logs
      await prefs.setString(_logPrefsKey, logsJson);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to save logs to storage: $e');
      }
    }
  }

  /// Load logs from persistent storage
  static Future<void> _loadLogsFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logsJson = prefs.getString(_logPrefsKey);
      
      if (logsJson != null) {
        final logsList = jsonDecode(logsJson) as List;
        _logBuffer.clear();
        _logBuffer.addAll(logsList.cast<Map<String, dynamic>>());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load logs from storage: $e');
      }
    }
  }

  /// Export logs to file
  static Future<File?> exportLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_logs_${DateTime.now().millisecondsSinceEpoch}.json');
      
      final logsJson = jsonEncode(_logBuffer);
      await file.writeAsString(logsJson);
      
      info('Logs exported to ${file.path}');
      return file;
    } catch (e) {
      error('Failed to export logs: $e');
      return null;
    }
  }

  /// Get recent logs
  static List<Map<String, dynamic>> getRecentLogs({int limit = 100}) {
    return _logBuffer.take(limit).toList();
  }

  /// Get logs by level
  static List<Map<String, dynamic>> getLogsByLevel(LogLevel level) {
    return _logBuffer.where((log) => log['level'] == level.name).toList();
  }

  /// Get logging statistics
  static Map<String, dynamic> getStats() {
    return {
      'total_logs': _totalLogs,
      'buffer_size': _logBuffer.length,
      'error_count': _errorCount,
      'warning_count': _warningCount,
      'current_user_id': _currentUserId,
      'min_level': _minLevel.name,
      'log_levels': LogLevel.values.map((l) => l.name).toList(),
    };
  }

  /// Clear all logs
  static Future<void> clearLogs() async {
    _logBuffer.clear();
    _totalLogs = 0;
    _errorCount = 0;
    _warningCount = 0;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_logPrefsKey);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to clear logs from storage: $e');
      }
    }
    
    info('All logs cleared');
  }
}
