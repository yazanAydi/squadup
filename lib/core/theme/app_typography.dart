import 'package:flutter/material.dart';

/// SquadUp App Typography following the brand guidelines
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // Font Families (using system fonts)
  static const String primaryFont = 'Roboto';
  static const String secondaryFont = 'Roboto';
  static const String arabicFont = 'Roboto';

  // Display Styles
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFFFFFF),
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFFFFFF),
    height: 1.3,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFFFFFF),
    height: 1.3,
  );

  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.4,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.4,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.4,
  );

  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.5,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.5,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.5,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFFFFFF),
    height: 1.6,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFFFFFF),
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFFA1A1AA),
    height: 1.6,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFFFFFFFF),
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFFFFFFFF),
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Color(0xFFA1A1AA),
    height: 1.4,
  );

  // Button Styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.2,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.2,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.2,
  );

  // Caption Styles
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: Color(0xFFA1A1AA),
    height: 1.4,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Color(0xFFA1A1AA),
    height: 1.4,
    letterSpacing: 1.5,
  );

  // Arabic Typography
  static const TextStyle arabicDisplayLarge = TextStyle(
    fontFamily: arabicFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFFFFFF),
    height: 1.2,
  );

  static const TextStyle arabicHeadlineLarge = TextStyle(
    fontFamily: arabicFont,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.4,
  );

  static const TextStyle arabicBodyLarge = TextStyle(
    fontFamily: arabicFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFFFFFF),
    height: 1.6,
  );

  static const TextStyle arabicButtonLarge = TextStyle(
    fontFamily: arabicFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.2,
  );

  // Special Styles
  static const TextStyle logo = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF8B5CF6),
    height: 1.2,
    letterSpacing: 1.0,
  );

  static const TextStyle splash = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w300,
    color: Color(0xFFFFFFFF),
    height: 1.3,
    letterSpacing: 2.0,
  );

  static const TextStyle error = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFFEF4444),
    height: 1.4,
  );

  static const TextStyle success = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFF10B981),
    height: 1.4,
  );

  static const TextStyle warning = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFFF59E0B),
    height: 1.4,
  );

  static const TextStyle info = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFF3B82F6),
    height: 1.4,
  );

  // Text Theme for Material Design compatibility
  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
