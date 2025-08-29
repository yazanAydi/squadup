import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import '../core/logging/app_logger.dart';

/// Crash reporting service for SquadUp app
class CrashReportingService {
  static CrashReportingService? _instance;
  
  CrashReportingService._();
  
  static CrashReportingService get instance => _instance ??= CrashReportingService._();

  /// Initialize crash reporting
  static Future<void> initialize() async {
    try {
      // Initialize Firebase Crashlytics
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      
      // Set up error handling
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };
      
      // Set up platform error handling
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    } catch (e) {
      // Handle initialization error
      AppLogger.error('Failed to initialize crash reporting', error: e, tag: 'CrashReportingService');
    }
  }

  /// Record a non-fatal error
  static Future<void> recordError(dynamic error, StackTrace? stackTrace, {bool fatal = false}) async {
    try {
      await FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: fatal);
    } catch (e) {
      AppLogger.error('Failed to record error', error: e, tag: 'CrashReportingService');
    }
  }

  /// Set user identifier for crash reports
  static Future<void> setUserId(String userId) async {
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier(userId);
    } catch (e) {
      AppLogger.error('Failed to set user ID', error: e, tag: 'CrashReportingService');
    }
  }

  /// Set custom key-value data
  static Future<void> setCustomKey(String key, dynamic value) async {
    try {
      await FirebaseCrashlytics.instance.setCustomKey(key, value);
    } catch (e) {
      AppLogger.error('Failed to set custom key', error: e, tag: 'CrashReportingService');
    }
  }

  /// Log a message
  static Future<void> log(String message) async {
    try {
      await FirebaseCrashlytics.instance.log(message);
    } catch (e) {
      AppLogger.error('Failed to log message', error: e, tag: 'CrashReportingService');
    }
  }
}
