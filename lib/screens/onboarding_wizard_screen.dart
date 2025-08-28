import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../utils/page_transitions.dart';
import '../utils/safe_text.dart';
import '../utils/cache_manager.dart';
import 'home_screen.dart';

class OnboardingWizardScreen extends StatefulWidget {
  const OnboardingWizardScreen({super.key});

  @override
  State<OnboardingWizardScreen> createState() => _OnboardingWizardScreenState();
}

class _OnboardingWizardScreenState extends State<OnboardingWizardScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ImagePicker _imagePicker = ImagePicker();

  // Supported sports + positions
  static const List<String> kSports = ['Basketball', 'Soccer', 'Volleyball'];
  static const Map<String, List<String>> kPositions = {
    'Basketball': ['Point Guard','Shooting Guard','Small Forward','Power Forward','Center'],
    'Soccer': ['Goalkeeper','Defender','Midfielder','Winger','Striker'],
    'Volleyball': ['Setter','Outside Hitter','Opposite','Middle Blocker','Libero'],
  };

  // User data
  String _displayName = '';
  String? _photoURL;
  final Map<String, String> _selectedSports = {};
  String _skillLevel = 'Beginner';
  String _location = '';
  final List<String> _goals = [];
  String _selectedLanguage = 'en'; // Default to English

  int _currentStep = 0;
  bool _isLoading = false;

  // Colors will be accessed directly via Theme.of(context)

  // Available options
  final List<String> _availableSports = kSports;

  final List<String> _skillLevels = [
    'Beginner', 'Intermediate', 'Advanced', 'Professional'
  ];

  final List<String> _goalOptions = [
    'Make new friends', 'Improve skills', 'Join competitive teams',
    'Stay active', 'Have fun', 'Network professionally'
  ];

  final Map<String, String> _languageOptions = {
    'en': 'English',
    'ar': 'العربية',
  };

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    await _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 5) {
      setState(() => _currentStep++);
      _startAnimation();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _startAnimation();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _photoURL = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Flexible(
              child: Text(
                'Error picking image: ${e.toString()}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Choose Image Source',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.primary),
                title: Text(
                  'Camera',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Theme.of(context).colorScheme.primary),
                title: Text(
                  'Gallery',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _requestLocationPermission() async {
    try {
      // For now, we'll just show a message since we don't have geolocation package
      // In a real app, you'd use geolocator or similar package
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SafeBodyText(
              'Location permission would be requested here. For now, please enter your location manually.',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary, // #8B5CF6
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SafeBodyText(
              'Error requesting location permission: ${e.toString()}',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _completeOnboarding() async {
    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Update user document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
        'displayName': _displayName,
        'photoURL': _photoURL,
        'sports': _selectedSports,
        'skillLevel': _skillLevel,
        'city': _location,
        'goals': _goals,
        'preferredLanguage': _selectedLanguage,
        'isOnboardingCompleted': true,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'id': user.uid,
        'email': user.email,
      }, SetOptions(merge: true));

      // Clear user cache to ensure fresh data on next sign-in
      final cacheManager = CacheManager();
      await cacheManager.remove(CacheKeys.userProfileKey(user.uid));

      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageTransitions.slideRight(const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Flexible(
              child: Text(
                'Error saving profile: ${e.toString()}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildStepIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Row(
        children: List.generate(6, (index) {
          final isActive = index == _currentStep;
          final isCompleted = index < _currentStep;
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01,
              ),
              height: 4,
              decoration: BoxDecoration(
                color: isActive 
                  ? Theme.of(context).colorScheme.primary // #8B5CF6
                  : isCompleted 
                    ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2), // #A1A1AA with opacity
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildLanguageStep();
      case 2:
        return _buildProfileStep();
      case 3:
        return _buildSportsStep();
      case 4:
        return _buildLocationStep();
      case 5:
        return _buildGoalsStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildWelcomeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with proper SquadUp primary color
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary, // #8B5CF6
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_emotions,
              size: MediaQuery.of(context).size.width * 0.15,
              color: Colors.white, // #FFFFFF
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SafeTitleText(
            'Let\'s Get You Set Up!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, // #FFFFFF
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SafeBodyText(
            'We\'ll help you create your perfect sports profile in just a few steps.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7), // #A1A1AA
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // Next button with proper SquadUp theming
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.07,
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary, // #8B5CF6
                foregroundColor: Colors.white, // #FFFFFF
                elevation: 8,
                shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // SquadUp rule: 16px radius
                ),
              ),
              child: Text(
                'Next',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  letterSpacing: 1,
                  color: Colors.white, // #FFFFFF
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.language,
            size: MediaQuery.of(context).size.width * 0.2,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SafeTitleText(
            'Choose Your Language',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: SafeBodyText(
              'Select your preferred language for the app',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: MediaQuery.of(context).size.width * 0.04,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          
          // Language Options
          ..._languageOptions.entries.map((entry) {
            final languageCode = entry.key;
            final languageName = entry.value;
            final isSelected = _selectedLanguage == languageCode;
            
            return Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLanguage = languageCode;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        size: MediaQuery.of(context).size.width * 0.06,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      Expanded(
                        child: SafeBodyText(
                          languageName,
                          style: TextStyle(
                            color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProfileStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeTitleText(
            'Tell Us About Yourself',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          
          // Profile Picture
          GestureDetector(
            onTap: () async {
              _showImageSourceDialog();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.125,
                ),
                border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              child: _photoURL != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.12,
                      ),
                      child: _photoURL!.startsWith('http')
                          ? Image.network(
                              _photoURL!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.125,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          : Image.file(
                              File(_photoURL!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.125,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                    )
                  : Icon(
                      Icons.person_add,
                      size: MediaQuery.of(context).size.width * 0.125,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ),
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          
          // Display Name
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
            ),
            child: TextField(
              onChanged: (value) => _displayName = value,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: 'Display Name',
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportsStep() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeTitleText(
            'What Sports Do You Play?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SafeBodyText(
            'Select sports and choose your preferred position',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width > 600 ? 200 : 150,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.015,
                childAspectRatio: 1.2,
              ),
              itemCount: _availableSports.length,
              itemBuilder: (context, index) {
                final sport = _availableSports[index];
                final isSelected = _selectedSports.containsKey(sport);
                final position = _selectedSports[sport];
                
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      setState(() {
                        _selectedSports.remove(sport);
                      });
                    } else {
                      _showPositionPicker(sport);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SafeTitleText(
                          sport,
                          style: TextStyle(
                            color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        if (isSelected && position != null && position != 'Select Position')
                          SafeBodyText(
                            position,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          
          // Skill Level
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
            ),
            child: DropdownButtonFormField<String>(
              value: _skillLevel,
              onChanged: (value) => setState(() => _skillLevel = value!),
              decoration: InputDecoration(
                labelText: 'Skill Level',
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              dropdownColor: Theme.of(context).colorScheme.surface,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              items: _skillLevels.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: SafeLabelText(
                    level,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showPositionPicker(String sport) {
    final positions = kPositions[sport] ?? [];
    if (positions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Flexible(
            child: Text(
              'No positions available for $sport.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: SafeTitleText(
            'Choose Position for $sport',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            maxLines: 2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...positions.map((position) {
                final isSelected = _selectedSports[sport] == position;
                return ListTile(
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  title: SafeTitleText(
                    position,
                    style: TextStyle(color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                    maxLines: 2,
                  ),
                  onTap: () {
                    setState(() {
                      _selectedSports[sport] = position;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: MediaQuery.of(context).size.width * 0.2,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SafeTitleText(
            'Where Are You Located?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SafeBodyText(
            'This helps us find games and teams near you. You can also use your current location.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          
          // Location Permission Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _requestLocationPermission();
              },
              icon: Icon(Icons.my_location, color: Theme.of(context).colorScheme.onSurface),
              label: SafeButtonText(
                'Use Current Location',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          
          SafeBodyText(
            'Or enter manually:',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
            ),
            child: TextField(
              onChanged: (value) => _location = value,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: 'City, State, or Area',
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsStep() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flag,
            size: MediaQuery.of(context).size.width * 0.2,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SafeTitleText(
            'What Are Your Goals?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SafeBodyText(
            'Select what you hope to achieve',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          
          Expanded(
            child: ListView.builder(
              itemCount: _goalOptions.length,
              itemBuilder: (context, index) {
                final goal = _goalOptions[index];
                final isSelected = _goals.contains(goal);
                
                return Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.015,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _goals.remove(goal);
                        } else {
                          _goals.add(goal);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.check_circle : Icons.circle_outlined,
                            color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                            size: MediaQuery.of(context).size.width * 0.06,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                          Expanded(
                            child: SafeBodyText(
                              goal,
                              style: TextStyle(
                                color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Apply text scaling limits to prevent overflow
    final textScaler = MediaQuery.of(context).textScaler.clamp(
      minScaleFactor: 1.0,
      maxScaleFactor: 1.2,
    );
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: textScaler),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    children: [
                      if (_currentStep > 0)
                        IconButton(
                          onPressed: _previousStep,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      Expanded(
                        child: SafeTitleText(
                          'Step ${_currentStep + 1} of 6',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (_currentStep > 0)
                        SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                    ],
                  ),
                ),

                // Progress Indicator
                _buildStepIndicator(),

                // Content
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildStepContent(),
                    ),
                  ),
                ),

                // Navigation Buttons
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    children: [
                      if (_currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _previousStep,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(context).colorScheme.onSurface,
                              side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.02,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: SafeButtonText(
                              'Back',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      
                      if (_currentStep > 0) 
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _currentStep == 5 
                              ? (_isLoading ? null : _completeOnboarding)
                              : _nextStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onSurface,
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                  height: MediaQuery.of(context).size.width * 0.05,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
                                  ),
                                )
                              : SafeButtonText(
                                  _currentStep == 5 ? 'Complete Setup' : 'Next',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

