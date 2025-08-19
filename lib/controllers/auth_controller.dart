import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/di/providers.dart';

class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController(this._auth) : super(const AsyncValue.loading()) {
    _auth.authStateChanges().listen((user) {
      state = AsyncValue.data(user);
    });
  }

  final FirebaseAuth _auth;

  Future<void> signOut() async {
    try {
      state = const AsyncValue.loading();
      await _auth.signOut();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteAccount() async {
    try {
      state = const AsyncValue.loading();
      await _auth.currentUser?.delete();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  User? get currentUser => _auth.currentUser;
  bool get isAuthenticated => _auth.currentUser != null;
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthController(auth);
});
