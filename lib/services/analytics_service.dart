import 'package:firebase_analytics/firebase_analytics.dart';
import '../core/logging/app_logger.dart';

/// Analytics service for SquadUp app
class AnalyticsService {
  static AnalyticsService? _instance;
  static FirebaseAnalytics? _analytics;
  
  AnalyticsService._();
  
  static AnalyticsService get instance => _instance ??= AnalyticsService._();

  /// Initialize analytics service
  static Future<void> initialize() async {
    try {
      _analytics = FirebaseAnalytics.instance;
      await _analytics!.setAnalyticsCollectionEnabled(true);
    } catch (e) {
      AppLogger.error('Failed to initialize analytics', error: e, tag: 'AnalyticsService');
    }
  }

  /// Log a custom event
  static Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    try {
      await _analytics?.logEvent(name: name, parameters: parameters);
    } catch (e) {
      AppLogger.error('Failed to log event', error: e, tag: 'AnalyticsService');
    }
  }

  /// Set user properties
  static Future<void> setUserProperty(String name, String? value) async {
    try {
      await _analytics?.setUserProperty(name: name, value: value);
    } catch (e) {
      AppLogger.error('Failed to set user property', error: e, tag: 'AnalyticsService');
    }
  }

  /// Set user ID
  static Future<void> setUserId(String? userId) async {
    try {
      await _analytics?.setUserId(id: userId);
    } catch (e) {
      AppLogger.error('Failed to set user ID', error: e, tag: 'AnalyticsService');
    }
  }

  /// Log screen view
  static Future<void> logScreenView(String screenName, {String? screenClass}) async {
    try {
      await _analytics?.logScreenView(screenName: screenName, screenClass: screenClass);
    } catch (e) {
      AppLogger.error('Failed to log screen view', error: e, tag: 'AnalyticsService');
    }
  }

  /// Log login event
  static Future<void> logLogin({String? loginMethod}) async {
    try {
      await _analytics?.logLogin(loginMethod: loginMethod);
    } catch (e) {
      AppLogger.error('Failed to log login', error: e, tag: 'AnalyticsService');
    }
  }

  /// Log sign up event
  static Future<void> logSignUp({String? signUpMethod}) async {
    try {
      await _analytics?.logSignUp(signUpMethod: signUpMethod ?? 'unknown');
    } catch (e) {
      AppLogger.error('Failed to log sign up', error: e, tag: 'AnalyticsService');
    }
  }
}
