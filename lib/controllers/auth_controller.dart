import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController(this._auth) : super(const AsyncValue.loading()) {
    _authSubscription = _auth.authStateChanges().listen((user) {
      state = AsyncValue.data(user);
    });
  }

  final FirebaseAuth _auth;
  StreamSubscription<User?>? _authSubscription;

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

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
