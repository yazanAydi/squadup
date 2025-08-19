import 'package:flutter/material.dart';

/// Application-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Information
  static const String appName = 'SquadUp';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Connect with sports teams and players';
  
  // API Constants
  static const int apiTimeoutSeconds = 30;
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Cache Constants
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration cacheExpiration = Duration(hours: 24);
  static const Duration shortCacheExpiration = Duration(minutes: 30);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  
  static const double defaultRadius = 12.0;
  static const double smallRadius = 8.0;
  static const double largeRadius = 16.0;
  static const double extraLargeRadius = 24.0;
  
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  
  // Text Constants
  static const int maxTitleLength = 50;
  static const int maxDescriptionLength = 500;
  static const int maxNameLength = 100;
  static const int maxLocationLength = 200;
  
  // Validation Constants
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int minTeamNameLength = 3;
  static const int minAge = 13;
  static const int maxAge = 120;
  
  // Sports Constants
  static const List<String> supportedSports = [
    'Basketball',
    'Soccer',
    'Volleyball',
    'Tennis',
    'Badminton',
    'Table Tennis',
    'Cricket',
    'Baseball',
    'Hockey',
    'Rugby',
    'American Football',
    'Swimming',
    'Running',
    'Cycling',
    'Gym',
    'Other',
  ];
  
  static const List<String> skillLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Mixed',
    'Professional',
  ];
  
  // Game Constants
  static const int maxPlayersPerTeam = 50;
  static const int minPlayersPerGame = 2;
  static const int maxTeamsPerGame = 10;
  
  // Team Constants
  static const int maxTeamMembers = 100;
  static const int maxPendingInvitations = 20;
  
  // User Constants
  static const int maxProfilePictures = 5;
  static const int maxUserTeams = 10;
  static const int maxUserGames = 50;
  
  // File Constants
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxProfilePictureSize = 5 * 1024 * 1024; // 5MB
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];
  
  // Network Constants
  static const int connectionTimeoutSeconds = 10;
  static const int receiveTimeoutSeconds = 30;
  static const int maxConcurrentRequests = 5;
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String permissionErrorMessage = 'Permission denied. Please check app permissions.';
  static const String authErrorMessage = 'Authentication error. Please sign in again.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  
  // Success Messages
  static const String profileUpdatedMessage = 'Profile updated successfully!';
  static const String teamCreatedMessage = 'Team created successfully!';
  static const String gameCreatedMessage = 'Game created successfully!';
  static const String invitationSentMessage = 'Invitation sent successfully!';
  static const String teamJoinedMessage = 'You have joined the team successfully!';
  
  // Loading Messages
  static const String loadingMessage = 'Loading...';
  static const String savingMessage = 'Saving...';
  static const String uploadingMessage = 'Uploading...';
  static const String processingMessage = 'Processing...';
  
  // Date Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'MMM dd, yyyy HH:mm';
  static const String shortDateFormat = 'MM/dd/yy';
  
  // Storage Keys
  static const String userPreferencesKey = 'user_preferences';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String notificationsKey = 'notifications_enabled';
  static const String biometricsKey = 'biometrics_enabled';
  
  // Animation Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve fastCurve = Curves.easeIn;
  static const Curve slowCurve = Curves.easeOut;
  static const Curve bounceCurve = Curves.bounceOut;
  
  // Responsive Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
  
  // Performance Thresholds
  static const int slowOperationThreshold = 100; // milliseconds
  static const int verySlowOperationThreshold = 500; // milliseconds
  static const int maxMemoryUsage = 200 * 1024 * 1024; // 200MB
  
  // Security Constants
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);
  static const int sessionTimeoutMinutes = 60;
  
  // Analytics Events
  static const String userSignUpEvent = 'user_sign_up';
  static const String userLoginEvent = 'user_login';
  static const String teamCreatedEvent = 'team_created';
  static const String gameCreatedEvent = 'game_created';
  static const String teamJoinedEvent = 'team_joined';
  static const String profileUpdatedEvent = 'profile_updated';
  
  // Feature Flags
  static const bool enableBiometrics = true;
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePerformanceMonitoring = true;
  
  // Development Constants
  static const bool enableDebugLogging = true;
  static const bool enablePerformanceTracking = true;
  static const bool enableErrorReporting = true;
  static const bool enableMockData = false;
}
