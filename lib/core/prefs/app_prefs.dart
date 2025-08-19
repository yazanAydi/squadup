import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const String _darkModeKey = 'dark_mode_enabled';
  static const String _onboardingSeenKey = 'onboarding_seen';
  static const String _firstLaunchKey = 'first_launch';
  static const String _lastAppVersionKey = 'last_app_version';
  
  static SharedPreferences? _prefs;
  
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  
  // Dark mode preference
  static Future<bool> getDarkMode() async {
    await initialize();
    return _prefs!.getBool(_darkModeKey) ?? true; // Default to dark mode
  }
  
  static Future<void> setDarkMode(bool enabled) async {
    await initialize();
    await _prefs!.setBool(_darkModeKey, enabled);
  }
  
  // Onboarding seen flag
  static Future<bool> getOnboardingSeen() async {
    await initialize();
    return _prefs!.getBool(_onboardingSeenKey) ?? false;
  }
  
  static Future<void> setOnboardingSeen(bool seen) async {
    await initialize();
    await _prefs!.setBool(_onboardingSeenKey, seen);
  }
  
  // First launch flag
  static Future<bool> getFirstLaunch() async {
    await initialize();
    return _prefs!.getBool(_firstLaunchKey) ?? true;
  }
  
  static Future<void> setFirstLaunch(bool first) async {
    await initialize();
    await _prefs!.setBool(_firstLaunchKey, first);
  }
  
  // App version tracking
  static Future<String?> getLastAppVersion() async {
    await initialize();
    return _prefs!.getString(_lastAppVersionKey);
  }
  
  static Future<void> setLastAppVersion(String version) async {
    await initialize();
    await _prefs!.setString(_lastAppVersionKey, version);
  }
  
  // Clear all preferences (useful for logout)
  static Future<void> clearAll() async {
    await initialize();
    await _prefs!.clear();
  }
}
