import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// SquadUp Dark-First Theme System
/// 
/// Design System:
/// - Primary: #8B5CF6 (Purple)
/// - Scaffold: #0F0A1F (Dark Purple-Black)
/// - Card: #1C1532 (Dark Purple)
/// - Text Primary: #FFFFFF (White)
/// - Text Secondary: #A1A1AA (Light Gray)
/// - Accent Glow: #7C3AED (Purple Glow)
/// 
/// Typography:
/// - English: Poppins/Roboto
/// - Arabic: Noto Sans Arabic
/// 
/// Components:
/// - Radius: 16px for buttons, 12px for inputs
/// - Inputs: Filled with #1C1532 background
/// - Prefix Icons: #8B5CF6 (Primary Purple)
class SquadUpTheme {
  // Private constructor
  SquadUpTheme._();

  // Color Palette
  static const Color primary = Color(0xFF8B5CF6);
  static const Color scaffold = Color(0xFF0F0A1F);
  static const Color card = Color(0xFF1C1532);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color accentGlow = Color(0xFF7C3AED);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Surface Colors
  static const Color surfaceVariant = Color(0xFF2A1F4A);
  static const Color surfaceContainer = Color(0xFF1A0F2E);
  static const Color outline = Color(0xFF3F3F46);
  static const Color outlineVariant = Color(0xFF27272A);

  // Typography
  static const String fontFamilyEnglish = 'Poppins';
  static const String fontFamilyArabic = 'NotoSansArabic';
  static const String fontFamilyFallback = 'Roboto';

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;

  // Elevation
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  /// Get the dark theme (primary theme)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamilyEnglish,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: primary,
        onPrimary: textPrimary,
        secondary: accentGlow,
        onSecondary: textPrimary,
        error: error,
        onError: textPrimary,
        surface: scaffold,
        onSurface: textPrimary,
                 surfaceContainerHighest: card,
         onSurfaceVariant: textSecondary,
         outline: outline,
         outlineVariant: outlineVariant,
         surfaceContainer: surfaceContainer,
      ),

      // Scaffold
      scaffoldBackgroundColor: scaffold,

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: fontFamilyEnglish,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Typography
      textTheme: _buildTextTheme(),

             // Card Theme
       cardTheme: CardThemeData(
        color: card,
        elevation: elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusM),
        ),
        margin: const EdgeInsets.all(spacingS),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textPrimary,
          elevation: elevationS,
          shadowColor: primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusL),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingL,
            vertical: spacingM,
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamilyEnglish,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusL),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingL,
            vertical: spacingM,
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamilyEnglish,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: const TextStyle(
            fontFamily: fontFamilyEnglish,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: outline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingM,
        ),
        hintStyle: const TextStyle(
          color: textSecondary,
          fontFamily: fontFamilyEnglish,
          fontSize: 16,
        ),
        labelStyle: const TextStyle(
          color: textSecondary,
          fontFamily: fontFamilyEnglish,
          fontSize: 16,
        ),
        prefixIconColor: primary,
        suffixIconColor: textSecondary,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: outline,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: card,
        selectedItemColor: primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: elevationM,
      ),

             // Dialog Theme
       dialogTheme: DialogThemeData(
        backgroundColor: card,
        elevation: elevationL,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: fontFamilyEnglish,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: fontFamilyEnglish,
          fontSize: 16,
          color: textSecondary,
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceVariant,
        contentTextStyle: const TextStyle(
          fontFamily: fontFamilyEnglish,
          fontSize: 14,
          color: textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusM),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primary;
          }
          return textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primary.withValues(alpha: 0.3);
          }
          return outline;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(textPrimary),
        side: const BorderSide(color: outline, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusS),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primary;
          }
          return textSecondary;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: outline,
        thumbColor: primary,
        overlayColor: primary.withValues(alpha: 0.2),
        valueIndicatorColor: primary,
        valueIndicatorTextStyle: const TextStyle(
          color: textPrimary,
          fontFamily: fontFamilyEnglish,
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: outline,
        circularTrackColor: outline,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant,
        selectedColor: primary.withValues(alpha: 0.2),
        labelStyle: const TextStyle(
          color: textPrimary,
          fontFamily: fontFamilyEnglish,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
        ),
        side: const BorderSide(color: outline),
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        textColor: textPrimary,
        iconColor: textSecondary,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingS,
        ),
      ),

             // Tab Bar Theme
       tabBarTheme: const TabBarThemeData(
        labelColor: primary,
        unselectedLabelColor: textSecondary,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primary, width: 2),
        ),
        labelStyle: TextStyle(
          fontFamily: fontFamilyEnglish,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: fontFamilyEnglish,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Build text theme with proper typography
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.22,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.33,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.50,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.43,
        letterSpacing: 0.1,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.50,
        letterSpacing: 0.15,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.33,
        letterSpacing: 0.4,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamilyEnglish,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textSecondary,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Get Arabic theme (RTL support)
  static ThemeData get arabicTheme {
    final baseTheme = darkTheme;
    return baseTheme.copyWith(
      textTheme: _buildArabicTextTheme(),
    );
  }

  /// Build Arabic text theme
  static TextTheme _buildArabicTextTheme() {
    return const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.22,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.33,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.50,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.43,
        letterSpacing: 0.1,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.50,
        letterSpacing: 0.15,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.33,
        letterSpacing: 0.4,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamilyArabic,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textSecondary,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Get theme based on locale
  static ThemeData getThemeForLocale(String locale) {
    if (locale.startsWith('ar')) {
      return arabicTheme;
    }
    return darkTheme;
  }

  /// Get text direction based on locale
  static TextDirection getTextDirectionForLocale(String locale) {
    if (locale.startsWith('ar')) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }

  /// Get edge insets that respect text direction
  static EdgeInsetsDirectional getDirectionalPadding({
    double? start,
    double? end,
    double? top,
    double? bottom,
  }) {
    return EdgeInsetsDirectional.only(
      start: start ?? 0,
      end: end ?? 0,
      top: top ?? 0,
      bottom: bottom ?? 0,
    );
  }

  /// Get horizontal padding that respects text direction
  static EdgeInsetsDirectional getHorizontalPadding(double value) {
    return EdgeInsetsDirectional.symmetric(horizontal: value);
  }

  /// Get vertical padding
  static EdgeInsets getVerticalPadding(double value) {
    return EdgeInsets.symmetric(vertical: value);
  }

  /// Get all padding that respects text direction
  static EdgeInsetsDirectional getAllPadding(double value) {
    return EdgeInsetsDirectional.all(value);
  }
}
