import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/theme_manager.dart';

/// Localization provider for SquadUp app
class LocalizationProvider extends StateNotifier<Locale> {
  LocalizationProvider() : super(const Locale('en', 'US'));

  /// Initialize localization
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    final countryCode = prefs.getString('country_code') ?? 'US';
    state = Locale(languageCode, countryCode);
  }

  /// Set locale
  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('country_code', locale.countryCode ?? '');
    state = locale;
  }

  /// Get supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('ar', 'SA'), // Arabic
    Locale('es', 'ES'), // Spanish
    Locale('fr', 'FR'), // French
    Locale('de', 'DE'), // German
    Locale('it', 'IT'), // Italian
    Locale('pt', 'BR'), // Portuguese
    Locale('ru', 'RU'), // Russian
    Locale('zh', 'CN'), // Chinese
    Locale('ja', 'JP'), // Japanese
    Locale('ko', 'KR'), // Korean
  ];

  /// Check if locale is RTL
  bool isRTL(Locale locale) {
    return locale.languageCode == 'ar' || 
           locale.languageCode == 'he' || 
           locale.languageCode == 'fa';
  }

  /// Get current locale is RTL
  bool get isCurrentLocaleRTL => isRTL(state);
}

/// Localization provider instance
final localizationProvider = StateNotifierProvider<LocalizationProvider, Locale>((ref) {
  return LocalizationProvider();
});

/// Theme mode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// Theme manager provider
final themeManagerProvider = Provider<ThemeManager>((ref) {
  return ThemeManager.instance;
});
