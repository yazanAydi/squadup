import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'core/errors/app_error_handler.dart' show AppErrorHandler, ErrorSeverity;
import 'core/logging/app_logger.dart';
import 'core/security/security_dashboard_service.dart';
import 'services/crash_reporting_service.dart';
import 'services/analytics_service.dart';
import 'services/ab_testing_service.dart';
import 'app/theme.dart';
import 'screens/splash_screen.dart';
import 'l10n/app_localizations.dart';
import 'providers/localization_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize core services
  await AppLogger.initialize();
  AppLogger.info('App starting up', tag: 'Main');
  
  // Setup global error handling
  AppErrorHandler.setupGlobalErrorHandling();
  
  try {
    // Initialize Firebase with secure configuration
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    // Enable Firestore offline persistence globally
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    
    AppLogger.info('Firebase initialized successfully', tag: 'Firebase');
    
    // Initialize crash reporting
    await CrashReportingService.initialize();
    
    // Initialize analytics
    await AnalyticsService.initialize();
    
    // Initialize A/B testing
    await ABTestingService.initialize();
    
    // Initialize security dashboard service
    await SecurityDashboardService.instance.initialize();
    
    AppLogger.info('All services initialized successfully', tag: 'Main');
    
    if (kDebugMode) {
      print('✅ All services initialized successfully');
    }
  } catch (e, stackTrace) {
    // Initialization error - log and handle gracefully
    AppErrorHandler.handleError(
      e,
      stackTrace,
      context: 'App Initialization',
      severity: ErrorSeverity.critical,
    );
    
    AppLogger.error('App initialization failed: $e', 
                   tag: 'Main', error: e, stackTrace: stackTrace);
    
    if (kDebugMode) {
      print('❌ App initialization failed: $e');
    }
  }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localizationProvider);
    
    return MaterialApp(
      title: 'SquadUp',
      debugShowCheckedModeBanner: false,
      theme: SquadUpTheme.getThemeForLocale(currentLocale.languageCode),
      home: const SplashScreen(),
      
      // Localization support following SquadUp rules
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: currentLocale, // Dynamic locale from provider
      
      // Add error handling for the app
      builder: (context, child) {
        // Set up global error widget builder
        ErrorWidget.builder = (FlutterErrorDetails details) {
          AppErrorHandler.handleError(
            details.exception,
            details.stack,
            context: 'Widget Error',
            severity: ErrorSeverity.critical,
          );
          return Material(
            child: Container(
              color: Colors.red[100],
              child: const Center(
                child: Text(
                  'Something went wrong. Please restart the app.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        };
        return child!;
      },
    );
  }
}

