import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:local_auth/local_auth.dart'; // Removed for now

import 'home_screen.dart';
import 'user_profile_screen.dart';
import 'welcome_screen.dart';
import '../utils/page_transitions.dart';
import '../utils/safe_text.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with TickerProviderStateMixin {
  bool isLogin = true;
  bool isLoading = false;
  bool rememberMe = false;
  bool _obscurePassword = true;

  late AnimationController _formController;
  late AnimationController _switchController;
  late Animation<Offset> _formSlide;
  late Animation<double> _formFade;
  late Animation<double> _switchSlide;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Social login and biometric services
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final LocalAuthentication _localAuth = LocalAuthentication(); // Removed for now
  bool _isBiometricAvailable = false;

  // THEME
  static const Color bg = Color(0xFF0A0A0A);
  static const Color card = Color(0xFF1A1A1A);
  static const Color accent = Color(0xFF8C6CFF);
  static const Color subtle = Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    
    _formController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _switchController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _formSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeOutCubic,
    ));

    _formFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeIn,
    ));

    _switchSlide = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _switchController,
      curve: Curves.easeInOut,
    ));

    _formController.forward();
    
    // Check biometric availability
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    // Biometric authentication temporarily disabled
    if (mounted) {
      setState(() {
        _isBiometricAvailable = false;
      });
    }
  }

  @override
  void dispose() {
    _formController.dispose();
    _switchController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _switchMode() {
    _switchController.forward().then((_) {
      setState(() => isLogin = !isLogin);
      _switchController.reverse();
    });
  }

  Future<void> handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() => isLoading = true);

    try {
      if (kIsWeb) {
        await FirebaseAuth.instance.setPersistence(
          rememberMe ? Persistence.LOCAL : Persistence.NONE,
        );
      }

      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'createdAt': Timestamp.now(),
        });

        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          PageTransitions.slideRight(const UserProfileScreen()),
        );
        return;
      }

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      final hasProfile = userDoc.exists &&
          userDoc.data()?['sport'] != null ||
          userDoc.data()?['sports'] != null;

      if (!mounted) return;

      if (hasProfile) {
        Navigator.of(context).pushReplacement(
          PageTransitions.slideRight(const HomeScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          PageTransitions.slideRight(const UserProfileScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'An error occurred';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'user-not-found':
              errorMessage = 'No user found with this email';
              break;
            case 'wrong-password':
              errorMessage = 'Incorrect password';
              break;
            case 'email-already-in-use':
              errorMessage = 'Email is already registered';
              break;
            case 'weak-password':
              errorMessage = 'Password is too weak';
              break;
            case 'invalid-email':
              errorMessage = 'Invalid email address';
              break;
            default:
              errorMessage = e.message ?? 'Authentication failed';
          }
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // Google Sign-In
  Future<void> _handleGoogleSignIn() async {
    setState(() => isLoading = true);
    
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      if (!mounted) return;

      // Check if user exists in Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!mounted) return;

      if (!userDoc.exists) {
        // Create new user document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'displayName': userCredential.user!.displayName,
          'photoURL': userCredential.user!.photoURL,
          'createdAt': Timestamp.now(),
          'signInMethod': 'google',
        });

        if (!mounted) return;

        // Navigate to welcome screen for new users
        Navigator.of(context).pushReplacement(
          PageTransitions.slideRight(const WelcomeScreen()),
        );
      } else {
        // Check if profile is complete
        final hasProfile = userDoc.data()?['sport'] != null || userDoc.data()?['sports'] != null;
        
        if (!mounted) return;

        if (hasProfile) {
          Navigator.of(context).pushReplacement(
            PageTransitions.slideRight(const HomeScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageTransitions.slideRight(const UserProfileScreen()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Google sign-in failed';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'account-exists-with-different-credential':
              errorMessage = 'An account already exists with the same email address but different sign-in credentials.';
              break;
            case 'invalid-credential':
              errorMessage = 'Invalid credentials.';
              break;
            case 'operation-not-allowed':
              errorMessage = 'Google sign-in is not enabled.';
              break;
            default:
              errorMessage = e.message ?? 'Google sign-in failed';
          }
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // Apple Sign-In
  Future<void> _handleAppleSignIn() async {
    setState(() => isLoading = true);
    
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      
      if (!mounted) return;

      // Check if user exists in Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!mounted) return;

      if (!userDoc.exists) {
        // Create new user document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'displayName': '${credential.givenName ?? ''} ${credential.familyName ?? ''}'.trim(),
          'createdAt': Timestamp.now(),
          'signInMethod': 'apple',
        });

        if (!mounted) return;

        // Navigate to welcome screen for new users
        Navigator.of(context).pushReplacement(
          PageTransitions.slideRight(const WelcomeScreen()),
        );
      } else {
        // Check if profile is complete
        final hasProfile = userDoc.data()?['sport'] != null || userDoc.data()?['sports'] != null;
        
        if (!mounted) return;

        if (hasProfile) {
          Navigator.of(context).pushReplacement(
            PageTransitions.slideRight(const HomeScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageTransitions.slideRight(const UserProfileScreen()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Apple sign-in failed';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'account-exists-with-different-credential':
              errorMessage = 'An account already exists with the same email address but different sign-in credentials.';
              break;
            case 'invalid-credential':
              errorMessage = 'Invalid credentials.';
              break;
            case 'operation-not-allowed':
              errorMessage = 'Apple sign-in is not enabled.';
              break;
            default:
              errorMessage = e.message ?? 'Apple sign-in failed';
          }
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // Biometric Authentication - Temporarily disabled
  // Future<void> _handleBiometricAuth() async { ... }

  @override
  Widget build(BuildContext context) {
    // Apply text scaling limits to prevent overflow
    final textScaler = MediaQuery.of(context).textScaler.clamp(
      minScaleFactor: 1.0,
      maxScaleFactor: 1.2,
    );
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700;
    final isWideScreen = screenWidth > 400;
    
    return Scaffold(
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: textScaler),
        child: Stack(
          children: [
            // Full screen gradient background
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [bg, Color(0xFF1A0F3A)],
                ),
              ),
            ),
            
            // Content
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? 32.0 : 24.0,
                  vertical: 16.0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 32,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Top spacing - responsive
                        SizedBox(height: isSmallScreen ? 20 : 40),
                    
                        // Logo and branding
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                card.withValues(alpha: 0.3),
                                card.withValues(alpha: 0.1),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: accent.withValues(alpha: 0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Image.asset(
                              'assets/logoo.png',
                              width: isSmallScreen ? 60 : 80,
                              height: isSmallScreen ? 60 : 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.sports_soccer,
                                size: isSmallScreen ? 60 : 80,
                                color: accent,
                              ),
                            ),
                          ),
                        ),
                        
                        // Title spacing - responsive
                        SizedBox(height: isSmallScreen ? 20 : 30),
                    
                        // Title
                        SlideTransition(
                          position: _formSlide,
                          child: FadeTransition(
                            opacity: _formFade,
                            child: SafeTitleText(
                              isLogin ? 'Welcome Back!' : 'Create Account',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 28 : 32,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Subtitle
                        SlideTransition(
                          position: _formSlide,
                          child: FadeTransition(
                            opacity: _formFade,
                            child: SafeBodyText(
                              isLogin ? 'Sign in to continue' : 'Join SquadUp today',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        
                        // Form spacing - responsive
                        SizedBox(height: isSmallScreen ? 24 : 40),
                    
                        // Form
                        SlideTransition(
                          position: _formSlide,
                          child: FadeTransition(
                            opacity: _formFade,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // Email field
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          card,
                                          card.withValues(alpha: 0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      controller: emailController,
                                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Email is required';
                                        }
                                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: const TextStyle(color: subtle),
                                        prefixIcon: const Icon(Icons.email, color: subtle),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: isSmallScreen ? 12 : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  SizedBox(height: isSmallScreen ? 16 : 20),
                                  
                                  // Password field
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          card,
                                          card.withValues(alpha: 0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: _obscurePassword,
                                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Password is required';
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: const TextStyle(color: subtle),
                                        prefixIcon: const Icon(Icons.lock, color: subtle),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                            color: subtle,
                                          ),
                                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: isSmallScreen ? 12 : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  SizedBox(height: isSmallScreen ? 12 : 16),
                                  
                                  // Remember me checkbox
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.9,
                                        child: Checkbox(
                                          value: rememberMe,
                                          onChanged: (val) => setState(() => rememberMe = val ?? false),
                                          activeColor: accent,
                                          checkColor: Theme.of(context).colorScheme.onSurface,
                                          side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
                                        ),
                                      ),
                                      SafeLabelText(
                                        "Remember Me",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                          fontSize: isSmallScreen ? 13 : 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: isSmallScreen ? 16 : 24),
                                  
                                  // Submit button
                                  SizedBox(
                                    width: double.infinity,
                                    height: isSmallScreen ? 48 : 56,
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : handleAuth,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: accent,
                                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                                        elevation: 8,
                                        shadowColor: accent.withValues(alpha: 0.3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: isLoading
                                          ? SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
                                              ),
                                            )
                                          : SafeButtonText(
                                              isLogin ? 'SIGN IN' : 'CREATE ACCOUNT',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: isSmallScreen ? 14 : 16,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        // Spacing to prevent overflow
                        SizedBox(height: isSmallScreen ? 16 : 24),
                        
                        // Social login and biometric section
                        if (isLogin) ...[
                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: SafeLabelText(
                                  'OR',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                    fontSize: isSmallScreen ? 12 : 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: isSmallScreen ? 16 : 24),
                          
                          // Social login buttons
                          Row(
                            children: [
                              // Google Sign-In
                              Expanded(
                                child: Container(
                                  height: isSmallScreen ? 48 : 56,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                                        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: isLoading ? null : _handleGoogleSignIn,
                                    icon: Image.asset(
                                      'assets/google_logo.png',
                                      width: isSmallScreen ? 20 : 24,
                                      height: isSmallScreen ? 20 : 24,
                                      errorBuilder: (context, error, stackTrace) => Icon(
                                        Icons.g_mobiledata,
                                        color: Theme.of(context).colorScheme.onSurface,
                                        size: isSmallScreen ? 20 : 24,
                                      ),
                                    ),
                                    label: SafeButtonText(
                                      'Google',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontSize: isSmallScreen ? 14 : 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                              SizedBox(width: isSmallScreen ? 12 : 16),
                              
                              // Apple Sign-In
                              Expanded(
                                child: Container(
                                  height: isSmallScreen ? 48 : 56,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                                        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: isLoading ? null : _handleAppleSignIn,
                                    icon: Icon(
                                      Icons.apple,
                                      color: Theme.of(context).colorScheme.onSurface,
                                      size: isSmallScreen ? 20 : 24,
                                    ),
                                    label: SafeButtonText(
                                      'Apple',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontSize: isSmallScreen ? 14 : 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: isSmallScreen ? 16 : 20),
                          
                          // Biometric authentication button
                          if (_isBiometricAvailable) ...[
                            SizedBox(
                              width: double.infinity,
                              height: isSmallScreen ? 48 : 56,
                              child: OutlinedButton.icon(
                                onPressed: null, // Temporarily disabled
                                icon: Icon(
                                  Icons.fingerprint,
                                  color: accent,
                                  size: isSmallScreen ? 20 : 24,
                                ),
                                label: SafeButtonText(
                                  'Biometric (Coming Soon)',
                                  style: TextStyle(
                                    color: accent,
                                    fontSize: isSmallScreen ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: accent, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                        
                        // Spacing to prevent overflow
                        SizedBox(height: isSmallScreen ? 16 : 24),
                    
                        // Switch mode button
                        FadeTransition(
                          opacity: _switchSlide,
                          child: TextButton(
                            onPressed: _switchMode,
                            child: RichText(
                                text: TextSpan(
                                  text: isLogin ? "Don't have an account? " : "Already have an account? ",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                    fontSize: isSmallScreen ? 12 : 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: isLogin ? "Sign Up" : "Sign In",
                                      style: const TextStyle(
                                        color: accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ),
                        ),
                        
                        // Bottom spacing - responsive
                        SizedBox(height: isSmallScreen ? 20 : 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
