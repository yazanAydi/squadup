import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme manager service for SquadUp app
class ThemeManager {
  static ThemeManager? _instance;
  static SharedPreferences? _prefs;
  
  ThemeManager._();
  
  static ThemeManager get instance => _instance ??= ThemeManager._();

  /// Initialize theme manager
  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Get current theme mode
  ThemeMode get currentThemeMode {
    final themeIndex = _prefs?.getInt('theme_mode') ?? 0;
    return ThemeMode.values[themeIndex];
  }

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _prefs?.setInt('theme_mode', themeMode.index);
  }

  /// Get current color scheme
  ColorScheme get currentColorScheme {
    final isDark = currentThemeMode == ThemeMode.dark;
    return isDark ? _darkColorScheme : _lightColorScheme;
  }

  /// Light color scheme
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF8B5CF6),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFA78BFA),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFEF4444),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1F2937),
    surfaceContainerHighest: Color(0xFFF9FAFB),
    onSurfaceVariant: Color(0xFF1F2937),
  );

  /// Dark color scheme
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF8B5CF6),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFA78BFA),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFEF4444),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFF1C1532),
    onSurface: Color(0xFFFFFFFF),
    surfaceContainerHighest: Color(0xFF0F0A1F),
    onSurfaceVariant: Color(0xFFFFFFFF),
  );

  /// Get theme data
  ThemeData getThemeData() {
    final colorScheme = currentColorScheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }

  /// Get light theme
  ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _lightColorScheme.surface,
        foregroundColor: _lightColorScheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: _lightColorScheme.surface,
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightColorScheme.primary,
          foregroundColor: _lightColorScheme.onPrimary,
        ),
      ),
    );
  }

  /// Get dark theme
  ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _darkColorScheme.surface,
        foregroundColor: _darkColorScheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: _darkColorScheme.surface,
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkColorScheme.primary,
          foregroundColor: _darkColorScheme.onPrimary,
        ),
      ),
    );
  }
}
