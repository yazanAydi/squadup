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
// import '../../services/repositories/user_repository.dart';
// import '../../services/repositories/team_repository.dart';
// import '../../services/repositories/game_repository.dart';
// import '../../services/interfaces/base_repository.dart';
import '../../controllers/user_profile_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/team_controller.dart';
import '../../controllers/game_feed_controller.dart';
import '../../models/user_model.dart';
import '../../models/team_model.dart';
import '../../models/game_model.dart';
import '../../utils/cache_manager.dart';

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
final cacheManagerProvider = FutureProvider<CacheManager>((ref) async {
  return await CacheManager.getInstance();
});

// Rate Limiter Provider (placeholder)
// final rateLimiterProvider = Provider<RateLimiter>((ref) {
//   return RateLimiter();
// });

// Repository Providers (placeholder - repositories are abstract interfaces)
// final userRepositoryProvider = Provider<UserRepository>((ref) {
//   final firestore = ref.watch(firebaseFirestoreProvider);
//   final auth = ref.watch(firebaseAuthProvider);
//   return UserRepository(firestore: firestore, auth: auth);
// });

// final teamRepositoryProvider = Provider<BaseRepository<TeamModel>>((ref) {
//   final firestore = ref.watch(firebaseFirestoreProvider);
//   return TeamRepository(firestore: firestore);
// });

// final gameRepositoryProvider = Provider<BaseRepository<GameModel>>((ref) {
//   final firestore = ref.watch(firebaseFirestoreProvider);
//   return GameRepository(firestore: firestore);
// });

// Service Providers
final userServiceProvider = Provider<UserServiceInterface>((ref) {
  return UserService();
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
final userProfileControllerProvider = AsyncNotifierProvider<UserProfileController, UserModel?>(() {
  return UserProfileController();
});

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthController(auth);
});

final teamControllerProvider = StateNotifierProvider<TeamController, AsyncValue<List<TeamModel>>>((ref) {
  final teamService = ref.watch(teamServiceProvider);
  return TeamController(teamService);
});

final gameFeedControllerProvider = StateNotifierProvider<GameFeedController, AsyncValue<List<GameModel>>>((ref) {
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

final currentUserProfileProvider = Provider<AsyncValue<UserModel?>>((ref) {
  return ref.watch(userProfileControllerProvider);
});

final userTeamsProvider = Provider<AsyncValue<List<TeamModel>>>((ref) {
  return ref.watch(teamControllerProvider);
});

final gameFeedProvider = Provider<AsyncValue<List<GameModel>>>((ref) {
  return ref.watch(gameFeedControllerProvider);
});

// Cache and Performance Providers
final cacheStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final cacheManager = await ref.watch(cacheManagerProvider.future);
  return cacheManager.getStats();
});

// final rateLimitStatsProvider = Provider<Map<String, dynamic>>((ref) {
//   final rateLimiter = ref.watch(rateLimiterProvider);
//   return rateLimiter.getStats();
// });

// Provider for managing cache cleanup
final cacheCleanupProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final cacheManager = await ref.read(cacheManagerProvider.future);
    await cacheManager.cleanup();
  };
});
