import 'package:flutter/foundation.dart';
import '../logging/app_logger.dart';

/// Performance tracking utility for monitoring app performance
class PerformanceTracker {
  static final PerformanceTracker _instance = PerformanceTracker._internal();
  factory PerformanceTracker() => _instance;
  PerformanceTracker._internal();

  final Map<String, DateTime> _startTimes = {};
  final Map<String, List<Duration>> _measurements = {};

  /// Start timing an operation
  void startTimer(String operationName) {
    if (kDebugMode) {
      _startTimes[operationName] = DateTime.now();
      AppLogger.debug('Performance: Started timing $operationName');
    }
  }

  /// End timing an operation and log the duration
  void endTimer(String operationName) {
    if (kDebugMode) {
      final startTime = _startTimes.remove(operationName);
      if (startTime != null) {
        final duration = DateTime.now().difference(startTime);
        _addMeasurement(operationName, duration);
        AppLogger.logPerformance(operationName, duration);
        
        // Log slow operations
        if (duration.inMilliseconds > 100) {
          AppLogger.warning('Performance: Slow operation detected: $operationName took ${duration.inMilliseconds}ms');
        }
      } else {
        AppLogger.warning('Performance: Attempted to end timer for unknown operation: $operationName');
      }
    }
  }

  /// Add a measurement to the tracker
  void _addMeasurement(String operationName, Duration duration) {
    _measurements.putIfAbsent(operationName, () => []).add(duration);
  }

  /// Get average duration for an operation
  Duration? getAverageDuration(String operationName) {
    final measurements = _measurements[operationName];
    if (measurements == null || measurements.isEmpty) return null;
    
    final totalMicroseconds = measurements.fold<int>(
      0, (sum, duration) => sum + duration.inMicroseconds);
    return Duration(microseconds: totalMicroseconds ~/ measurements.length);
  }

  /// Get all performance statistics
  Map<String, Map<String, dynamic>> getPerformanceStats() {
    final stats = <String, Map<String, dynamic>>{};
    
    for (final entry in _measurements.entries) {
      final operationName = entry.key;
      final measurements = entry.value;
      
      if (measurements.isNotEmpty) {
        final totalMicroseconds = measurements.fold<int>(
          0, (sum, duration) => sum + duration.inMicroseconds);
        final average = totalMicroseconds ~/ measurements.length;
        final min = measurements.map((d) => d.inMicroseconds).reduce((a, b) => a < b ? a : b);
        final max = measurements.map((d) => d.inMicroseconds).reduce((a, b) => a > b ? a : b);
        
        stats[operationName] = {
          'count': measurements.length,
          'average': Duration(microseconds: average),
          'min': Duration(microseconds: min),
          'max': Duration(microseconds: max),
          'total': Duration(microseconds: totalMicroseconds),
        };
      }
    }
    
    return stats;
  }

  /// Clear all performance data
  void clearData() {
    _startTimes.clear();
    _measurements.clear();
    AppLogger.info('Performance: All performance data cleared');
  }

  /// Track widget build performance
  void trackWidgetBuild(String widgetName, VoidCallback buildCallback) {
    startTimer('Widget Build: $widgetName');
    buildCallback();
    endTimer('Widget Build: $widgetName');
  }

  /// Track async operation performance
  Future<T> trackAsyncOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    startTimer(operationName);
    try {
      final result = await operation();
      return result;
    } finally {
      endTimer(operationName);
    }
  }

  /// Track database operation performance
  Future<T> trackDatabaseOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    return trackAsyncOperation('Database: $operationName', operation);
  }

  /// Track network operation performance
  Future<T> trackNetworkOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    return trackAsyncOperation('Network: $operationName', operation);
  }

  /// Track file operation performance
  Future<T> trackFileOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    return trackAsyncOperation('File: $operationName', operation);
  }

  /// Get performance summary for logging
  String getPerformanceSummary() {
    final stats = getPerformanceStats();
    if (stats.isEmpty) return 'No performance data available';
    
    final buffer = StringBuffer();
    buffer.writeln('=== Performance Summary ===');
    
    for (final entry in stats.entries) {
      final operationName = entry.key;
      final data = entry.value;
      buffer.writeln('$operationName:');
      buffer.writeln('  Count: ${data['count']}');
      buffer.writeln('  Average: ${data['average']}');
      buffer.writeln('  Min: ${data['min']}');
      buffer.writeln('  Max: ${data['max']}');
      buffer.writeln('  Total: ${data['total']}');
      buffer.writeln('');
    }
    
    return buffer.toString();
  }

  /// Log performance summary
  void logPerformanceSummary() {
    AppLogger.info('Performance Summary:\n${getPerformanceSummary()}');
  }
}

/// Extension for easier performance tracking
extension PerformanceTracking on Object {
  /// Track performance of a method call
  T trackPerformance<T>(String operationName, T Function() operation) {
    final tracker = PerformanceTracker();
    tracker.startTimer(operationName);
    try {
      final result = operation();
      return result;
    } finally {
      tracker.endTimer(operationName);
    }
  }

  /// Track performance of an async method call
  Future<T> trackAsyncPerformance<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    final tracker = PerformanceTracker();
    return tracker.trackAsyncOperation(operationName, operation);
  }
}
