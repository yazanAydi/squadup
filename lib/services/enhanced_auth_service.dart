import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../core/logging/app_logger.dart';

/// Enhanced authentication service for SquadUp app
class EnhancedAuthService {
  static EnhancedAuthService? _instance;
  static FirebaseAuth? _auth;
  static GoogleSignIn? _googleSignIn;
  
  EnhancedAuthService._();
  
  static EnhancedAuthService get instance => _instance ??= EnhancedAuthService._();

  /// Initialize the authentication service
  Future<void> initialize() async {
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
  }
  
  /// Initialize synchronously (for immediate use)
  void _ensureInitialized() {
    _auth ??= FirebaseAuth.instance;
    _googleSignIn ??= GoogleSignIn();
  }

  /// Sign in with email and password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      // Ensure auth is initialized
      _ensureInitialized();
      
      final credential = await _auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      AppLogger.error('Sign in error', error: e, tag: 'EnhancedAuthService');
      rethrow;
    }
  }

  /// Sign up with email and password
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      // Ensure auth is initialized
      _ensureInitialized();
      
      final credential = await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      AppLogger.error('Sign up error', error: e, tag: 'EnhancedAuthService');
      rethrow;
    }
  }

  /// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Ensure services are initialized
      _ensureInitialized();
      
      final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth!.signInWithCredential(credential);
    } catch (e) {
      AppLogger.error('Google sign in error', error: e, tag: 'EnhancedAuthService');
      rethrow;
    }
  }

  /// Sign in with Apple
  Future<UserCredential?> signInWithApple() async {
    try {
      // Ensure auth is initialized
      _ensureInitialized();
      
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await _auth!.signInWithCredential(oauthCredential);
    } catch (e) {
      AppLogger.error('Apple sign in error', error: e, tag: 'EnhancedAuthService');
      rethrow;
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Ensure auth is initialized
      _ensureInitialized();
      
      await _auth!.sendPasswordResetEmail(email: email);
    } catch (e) {
      AppLogger.error('Password reset error', error: e, tag: 'EnhancedAuthService');
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      // Ensure services are initialized
      _ensureInitialized();
      
      await _auth!.signOut();
      await _googleSignIn!.signOut();
    } catch (e) {
      AppLogger.error('Sign out error', error: e, tag: 'EnhancedAuthService');
      rethrow;
    }
  }

  /// Get current user
  User? get currentUser => _auth?.currentUser;

  /// Check if user is signed in
  bool get isSignedIn => currentUser != null;

  /// Get auth state changes stream
  Stream<User?> get authStateChanges {
    _ensureInitialized();
    return _auth!.authStateChanges();
  }
}
