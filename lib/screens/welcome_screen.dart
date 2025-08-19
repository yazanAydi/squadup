import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'onboarding_wizard_screen.dart';
import 'home_screen.dart';
import '../utils/page_transitions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _subtitleController;
  late AnimationController _buttonController;
  late AnimationController _logoController;

  late Animation<double> _titleScale;
  late Animation<double> _titleFade;
  late Animation<double> _subtitleFade;
  late Animation<double> _buttonScale;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();
    
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _subtitleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _titleScale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.elasticOut,
    ));

    _titleFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeIn,
    ));

    _subtitleFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeIn,
    ));

    _buttonScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    ));

    _logoRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    _startAnimations();
    _checkUserStatus(); // Check user status and redirect if needed
  }

  void _startAnimations() async {
    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    await _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    await _subtitleController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    await _buttonController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _buttonController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  Future<void> _checkUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Check if user has completed onboarding
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      
      if (userDoc.exists && userDoc.data()?['onboardingCompleted'] == true) {
        // User has completed onboarding, go to home
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageTransitions.slideRight(const HomeScreen()),
          );
        }
      } else {
        // User exists but hasn't completed onboarding
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageTransitions.slideRight(const OnboardingWizardScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
              Color(0xFF2A1B4A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Logo Section
              Expanded(
                flex: 2,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _logoRotation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _logoRotation.value * 0.1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25, // Responsive width (25% of screen width)
                          height: MediaQuery.of(context).size.width * 0.25, // Responsive height (25% of screen width)
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF8C6CFF),
                                const Color(0xFF6C4CFF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF8C6CFF).withValues(alpha: 0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.sports_soccer,
                            size: MediaQuery.of(context).size.width * 0.125, // Responsive icon size (12.5% of screen width)
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Title Section
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _titleScale,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _titleScale.value,
                          child: AnimatedBuilder(
                            animation: _titleFade,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _titleFade.value,
                                child: Text(
                                  'Welcome to SquadUp',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: MediaQuery.of(context).size.width * 0.09, // Responsive font size (9% of screen width)
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    AnimatedBuilder(
                      animation: _subtitleFade,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _subtitleFade.value,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.1, // Responsive padding (10% of screen width)
                            ),
                            child: Text(
                              'Connect with players, join games, and build teams in your area. Your sports community starts here.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size (4.5% of screen width)
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Button Section
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.1, // Responsive padding (10% of screen width)
                  ),
                  child: AnimatedBuilder(
                    animation: _buttonScale,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _buttonScale.value,
                                                  child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.07, // Responsive height (7% of screen height)
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageTransitions.slideRight(const OnboardingWizardScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C6CFF),
                              foregroundColor: Theme.of(context).colorScheme.onSurface,
                              elevation: 8,
                              shadowColor: const Color(0xFF8C6CFF).withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.05, // Responsive font size (5% of screen width)
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
