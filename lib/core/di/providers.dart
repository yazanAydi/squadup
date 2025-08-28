import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../services/interfaces/user_service_interface.dart';
import '../../services/interfaces/team_service_interface.dart';
import '../../services/interfaces/game_service_interface.dart';
import '../../services/implementations/user_service.dart';
import '../../services/implementations/team_service.dart';
import '../../services/implementations/game_service.dart';
import '../../services/repositories/user_repository.dart';
import '../../services/repositories/team_repository.dart';
import '../../services/repositories/game_repository.dart';
import '../../services/interfaces/base_repository.dart';
import '../../controllers/user_profile_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/team_controller.dart';
import '../../controllers/game_feed_controller.dart';
import '../../models/user_profile.dart';
import '../../models/team.dart';
import '../../models/game.dart';
import '../../utils/cache_manager.dart';
import '../../core/security/rate_limiter.dart';

// Firebase Core Provider
final firebaseCoreProvider = Provider<FirebaseApp>((ref) {
  throw UnimplementedError('Firebase must be initialized before accessing this provider');
});

// Firebase Auth Provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// Firebase Firestore Provider
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Firebase Storage Provider
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

// Cache Manager Provider
final cacheManagerProvider = Provider<CacheManager>((ref) {
  return CacheManager();
});

// Rate Limiter Provider
final rateLimiterProvider = Provider<RateLimiter>((ref) {
  return RateLimiter();
});

// Repository Providers
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  return UserRepository(firestore: firestore, auth: auth);
});

final teamRepositoryProvider = Provider<BaseRepository<Team>>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return TeamRepository(firestore: firestore);
});

final gameRepositoryProvider = Provider<BaseRepository<Game>>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return GameRepository(firestore: firestore);
});

// Service Providers
final userServiceProvider = Provider<UserServiceInterface>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final cacheManager = ref.watch(cacheManagerProvider);
  final rateLimiter = ref.watch(rateLimiterProvider);
  return UserService(
    userRepository: userRepository,
    cacheManager: cacheManager,
    rateLimiter: rateLimiter,
  );
});

final teamServiceProvider = Provider<TeamServiceInterface>((ref) {
  return TeamService();
});

final gameServiceProvider = Provider<GameServiceInterface>((ref) {
  return GameService();
});

// Current User Stream Provider
final currentUserProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});

// User ID Provider
final userIdProvider = Provider<String?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.uid,
    loading: () => null,
    error: (error, stackTrace) => null,
  );
});

// Authentication State Provider
final authStateProvider = Provider<AuthState>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user != null ? AuthState.authenticated : AuthState.unauthenticated,
    loading: () => AuthState.loading,
    error: (error, stackTrace) => AuthState.error,
  );
});

// Enum for authentication states
enum AuthState {
  loading,
  authenticated,
  unauthenticated,
  error,
}

// Controller Providers
final userProfileControllerProvider = AsyncNotifierProvider<UserProfileController, UserProfile?>(() {
  return UserProfileController();
});

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthController(auth);
});

final teamControllerProvider = StateNotifierProvider<TeamController, AsyncValue<List<Team>>>((ref) {
  final teamService = ref.watch(teamServiceProvider);
  return TeamController(teamService);
});

final gameFeedControllerProvider = StateNotifierProvider<GameFeedController, AsyncValue<List<Game>>>((ref) {
  final gameService = ref.watch(gameServiceProvider);
  return GameFeedController(gameService);
});

// Convenience providers for common state
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
});

final currentUserProfileProvider = Provider<AsyncValue<UserProfile?>>((ref) {
  return ref.watch(userProfileControllerProvider);
});

final userTeamsProvider = Provider<AsyncValue<List<Team>>>((ref) {
  return ref.watch(teamControllerProvider);
});

final gameFeedProvider = Provider<AsyncValue<List<Game>>>((ref) {
  return ref.watch(gameFeedControllerProvider);
});

// Cache and Performance Providers
final cacheStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final cacheManager = ref.watch(cacheManagerProvider);
  return cacheManager.getStats();
});

final rateLimitStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final rateLimiter = ref.watch(rateLimiterProvider);
  return rateLimiter.getStats();
});

// Provider for managing cache cleanup
final cacheCleanupProvider = Provider<Future<void> Function()>((ref) {
  final cacheManager = ref.watch(cacheManagerProvider);
  final rateLimiter = ref.watch(rateLimiterProvider);
  
  return () async {
    await cacheManager.cleanup();
    rateLimiter.cleanup();
  };
});
