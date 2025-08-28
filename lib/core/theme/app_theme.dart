import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.primary,
    surface: AppColors.surface,
    onPrimary: AppColors.textPrimary,
    onSecondary: AppColors.textPrimary,
    onSurface: AppColors.textPrimary,
    error: AppColors.red,
    brightness: Brightness.dark,
  ).copyWith(
    tertiary: AppColors.yellow,
    outline: AppColors.outline,
    surfaceContainerHighest: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.textSecondary,
    primaryContainer: AppColors.primary.withValues(alpha: 0.2),
    onPrimaryContainer: AppColors.textPrimary,
    secondaryContainer: AppColors.yellow.withValues(alpha: 0.2),
    onSecondaryContainer: AppColors.textPrimary,
    shadow: Colors.black26,
  ),
  scaffoldBackgroundColor: AppColors.background,
  textTheme: AppTypography.textTheme,
  
  // Enhanced card theme with modern design and gradients
  cardTheme: CardThemeData(
    color: AppColors.surface,
    elevation: 8,
    shadowColor: AppColors.primary.withValues(alpha: 0.3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    surfaceTintColor: Colors.transparent,
  ),
  
  // Enhanced elevated button theme with modern styling and gradients
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textPrimary,
      elevation: 8,
      shadowColor: AppColors.primary.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w800, 
        letterSpacing: 0.8,
        fontSize: 16,
      ),
    ),
  ),
  
  // Enhanced input decoration theme with modern styling and glow effects
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppColors.outline, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: AppColors.outline.withValues(alpha: 0.6), width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppColors.primary, width: 3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppColors.red, width: 3),
    ),
    hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 16),
    labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 16),
    prefixIconColor: AppColors.primary,
    suffixIconColor: AppColors.textSecondary,
  ),
  
  // Enhanced app bar theme with modern styling and gradients
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 4,
    surfaceTintColor: Colors.transparent,
    shadowColor: AppColors.primary.withValues(alpha: 0.2),
    titleTextStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 24,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.8,
    ),
  ),
  
  // Enhanced icon theme with glow effects
  iconTheme: const IconThemeData(
    color: AppColors.primary,
    size: 28,
  ),
  
  // Enhanced floating action button theme with gradients
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textPrimary,
    elevation: 12,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    extendedPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
  ),
  
  // Enhanced bottom navigation bar theme with modern styling
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 12,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 11,
    ),
  ),
  
  // Enhanced chip theme with gradients and modern styling
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surface,
    selectedColor: AppColors.primary.withValues(alpha: 0.3),
    labelStyle: const TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
    elevation: 4,
    shadowColor: AppColors.primary.withValues(alpha: 0.2),
  ),
  
  // Enhanced divider theme with gradients
  dividerTheme: const DividerThemeData(
    color: AppColors.outline,
    thickness: 2,
    space: 1,
    indent: 20,
    endIndent: 20,
  ),
  
  // Enhanced switch theme with modern styling
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.textSecondary;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary.withValues(alpha: 0.4);
      }
      return AppColors.outline.withValues(alpha: 0.6);
    }),
  ),
  
  // Enhanced slider theme with modern styling
  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.outline.withValues(alpha: 0.4),
    thumbColor: AppColors.primary,
    overlayColor: AppColors.primary.withValues(alpha: 0.3),
    trackHeight: 6,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
  ),
  
  // Enhanced progress indicator theme
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.surface,
    circularTrackColor: AppColors.surface,
  ),
  
  // Enhanced checkbox theme
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(AppColors.textPrimary),
    side: const BorderSide(color: AppColors.outline, width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  ),
  
  // Enhanced radio theme
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.outline;
    }),
  ),
);
