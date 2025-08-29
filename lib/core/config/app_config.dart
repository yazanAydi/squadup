import 'package:firebase_core/firebase_core.dart';

/// App configuration for SquadUp
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  // Firebase configuration
  static const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', // Replace with actual API key
    appId: '1:414224011433:android:1f71eb9a6b5b2e923799b8',
    messagingSenderId: '414224011433',
    projectId: 'squadup2-16413',
    storageBucket: 'squadup2-16413.appspot.com',
  );

  // App configuration
  static const String appName = 'SquadUp';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // API configuration
  static const String baseUrl = 'https://api.squadup.com';
  static const int timeoutDuration = 30; // seconds
  
  // Feature flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableABTesting = false;
  static const bool enableSecurityDashboard = false;
  
  // Cache configuration
  static const int cacheExpirationDays = 7;
  static const int maxCacheSize = 100; // MB
  
  // Rate limiting
  static const int maxRequestsPerMinute = 60;
  static const int maxRequestsPerHour = 1000;
}
