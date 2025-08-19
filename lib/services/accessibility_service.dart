import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityService {
  static AccessibilityService? _instance;
  static AccessibilityService get instance => _instance ??= AccessibilityService._();
  
  AccessibilityService._();
  
  // Accessibility preferences
  bool _isHighContrastEnabled = false;
  bool _isLargeTextEnabled = false;
  bool _isScreenReaderEnabled = false;
  bool _isReducedMotionEnabled = false;
  double _textScaleFactor = 1.0;
  
  // Getters
  bool get isHighContrastEnabled => _isHighContrastEnabled;
  bool get isLargeTextEnabled => _isLargeTextEnabled;
  bool get isScreenReaderEnabled => _isScreenReaderEnabled;
  bool get isReducedMotionEnabled => _isReducedMotionEnabled;
  double get textScaleFactor => _textScaleFactor;
  
  // Stream controllers for real-time updates
  final _accessibilityController = StreamController<AccessibilitySettings>.broadcast();
  Stream<AccessibilitySettings> get accessibilityStream => _accessibilityController.stream;
  
  /// Initialize accessibility service
  Future<void> initialize() async {
    await _loadPreferences();
    await _checkSystemAccessibility();
  }
  
  /// Load accessibility preferences from storage
  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isHighContrastEnabled = prefs.getBool('accessibility_high_contrast') ?? false;
      _isLargeTextEnabled = prefs.getBool('accessibility_large_text') ?? false;
      _isScreenReaderEnabled = prefs.getBool('accessibility_screen_reader') ?? false;
      _isReducedMotionEnabled = prefs.getBool('accessibility_reduced_motion') ?? false;
      _textScaleFactor = prefs.getDouble('accessibility_text_scale') ?? 1.0;
    } catch (e) {
      // Use default values if loading fails
      debugPrint('Error loading accessibility preferences: $e');
    }
  }
  
  /// Check system accessibility settings
  Future<void> _checkSystemAccessibility() async {
    try {
      // Check if screen reader is enabled
      final platform = WidgetsBinding.instance.platformDispatcher;
      _isScreenReaderEnabled = platform.accessibilityFeatures.accessibleNavigation;
      
      // Check if high contrast is enabled
      _isHighContrastEnabled = platform.accessibilityFeatures.highContrast;
      
      // Check if reduced motion is enabled
      _isReducedMotionEnabled = platform.accessibilityFeatures.reduceMotion;
      
      // Update text scale factor
      _textScaleFactor = platform.textScaleFactor;
      
      _notifyListeners();
    } catch (e) {
      debugPrint('Error checking system accessibility: $e');
    }
  }
  
  /// Update high contrast setting
  Future<void> setHighContrast(bool enabled) async {
    _isHighContrastEnabled = enabled;
    await _savePreference('accessibility_high_contrast', enabled);
    _notifyListeners();
  }
  
  /// Update large text setting
  Future<void> setLargeText(bool enabled) async {
    _isLargeTextEnabled = enabled;
    await _savePreference('accessibility_large_text', enabled);
    _notifyListeners();
  }
  
  /// Update screen reader setting
  Future<void> setScreenReader(bool enabled) async {
    _isScreenReaderEnabled = enabled;
    await _savePreference('accessibility_screen_reader', enabled);
    _notifyListeners();
  }
  
  /// Update reduced motion setting
  Future<void> setReducedMotion(bool enabled) async {
    _isReducedMotionEnabled = enabled;
    await _savePreference('accessibility_reduced_motion', enabled);
    _notifyListeners();
  }
  
  /// Update text scale factor
  Future<void> setTextScaleFactor(double factor) async {
    _textScaleFactor = factor.clamp(0.8, 2.0);
    await _savePreference('accessibility_text_scale', _textScaleFactor);
    _notifyListeners();
  }
  
  /// Save preference to storage
  Future<void> _savePreference(String key, dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      }
    } catch (e) {
      debugPrint('Error saving accessibility preference: $e');
    }
  }
  
  /// Notify listeners of changes
  void _notifyListeners() {
    final settings = AccessibilitySettings(
      isHighContrastEnabled: _isHighContrastEnabled,
      isLargeTextEnabled: _isLargeTextEnabled,
      isScreenReaderEnabled: _isScreenReaderEnabled,
      isReducedMotionEnabled: _isReducedMotionEnabled,
      textScaleFactor: _textScaleFactor,
    );
    _accessibilityController.add(settings);
  }
  
  /// Get accessibility-aware text style
  TextStyle getAccessibleTextStyle(TextStyle baseStyle) {
    double fontSize = baseStyle.fontSize ?? 14.0;
    
    if (_isLargeTextEnabled) {
      fontSize *= 1.2;
    }
    
    fontSize *= _textScaleFactor;
    
    return baseStyle.copyWith(
      fontSize: fontSize,
      fontWeight: _isHighContrastEnabled 
          ? (baseStyle.fontWeight ?? FontWeight.normal).index < FontWeight.w600.index 
              ? FontWeight.w600 
              : baseStyle.fontWeight
          : baseStyle.fontWeight,
    );
  }
  
  /// Get accessibility-aware color
  Color getAccessibleColor(Color baseColor, {Color? highContrastColor}) {
    if (_isHighContrastEnabled && highContrastColor != null) {
      return highContrastColor;
    }
    return baseColor;
  }
  
  /// Get accessibility-aware animation duration
  Duration getAccessibleDuration(Duration baseDuration) {
    if (_isReducedMotionEnabled) {
      return Duration.zero;
    }
    return baseDuration;
  }
  
  /// Get accessibility-aware curve
  Curve getAccessibleCurve(Curve baseCurve) {
    if (_isReducedMotionEnabled) {
      return Curves.linear;
    }
    return baseCurve;
  }
  
  /// Check if accessibility features are enabled
  bool get hasAccessibilityFeatures => 
      _isHighContrastEnabled || 
      _isLargeTextEnabled || 
      _isScreenReaderEnabled || 
      _isReducedMotionEnabled ||
      _textScaleFactor != 1.0;
  
  /// Reset all accessibility settings to default
  Future<void> resetToDefaults() async {
    _isHighContrastEnabled = false;
    _isLargeTextEnabled = false;
    _isScreenReaderEnabled = false;
    _isReducedMotionEnabled = false;
    _textScaleFactor = 1.0;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    _notifyListeners();
  }
  
  /// Dispose resources
  void dispose() {
    _accessibilityController.close();
  }
}

/// Data class for accessibility settings
class AccessibilitySettings {
  final bool isHighContrastEnabled;
  final bool isLargeTextEnabled;
  final bool isScreenReaderEnabled;
  final bool isReducedMotionEnabled;
  final double textScaleFactor;
  
  const AccessibilitySettings({
    required this.isHighContrastEnabled,
    required this.isLargeTextEnabled,
    required this.isScreenReaderEnabled,
    required this.isReducedMotionEnabled,
    required this.textScaleFactor,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessibilitySettings &&
          runtimeType == other.runtimeType &&
          isHighContrastEnabled == other.isHighContrastEnabled &&
          isLargeTextEnabled == other.isLargeTextEnabled &&
          isScreenReaderEnabled == other.isScreenReaderEnabled &&
          isReducedMotionEnabled == other.isReducedMotionEnabled &&
          textScaleFactor == other.textScaleFactor;
  
  @override
  int get hashCode =>
      isHighContrastEnabled.hashCode ^
      isLargeTextEnabled.hashCode ^
      isScreenReaderEnabled.hashCode ^
      isReducedMotionEnabled.hashCode ^
      textScaleFactor.hashCode;
}
