import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/interfaces/team_service_interface.dart';
import '../services/service_locator.dart';
import '../utils/safe_text.dart';
import '../services/image_uploader.dart';

class TeamCreationScreen extends StatefulWidget {
  const TeamCreationScreen({super.key});

  @override
  State<TeamCreationScreen> createState() => _TeamCreationScreenState();
}

class _TeamCreationScreenState extends State<TeamCreationScreen>
    with TickerProviderStateMixin {
  late AnimationController _formController;
  late Animation<Offset> _formSlide;
  late Animation<double> _formFade;

  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  String _selectedSport = 'Basketball';
  String _selectedLevel = 'Mixed';
  int _maxMembers = 10;
  bool _isLoading = false;
  String? _teamLogoUrl;
  late final TeamServiceInterface _teamService;

  // Colors will be accessed directly via Theme.of(context)

  final List<String> _sports = [
    'Basketball',
    'Soccer',
    'Volleyball',
    'Tennis',
    'Badminton',
    'Table Tennis',
    'Cricket',
    'Baseball',
    'Hockey',
    'Rugby',
    'American Football',
    'Swimming',
    'Running',
    'Cycling',
    'Gym',
    'Other'
  ];

  final List<String> _levels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Mixed',
    'Professional'
  ];

  @override
  void initState() {
    super.initState();
    _teamService = ServiceLocator.instance.teamService;
    
    _formController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _formSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
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

    _formController.forward();
  }

  @override
  void dispose() {
    _formController.dispose();
    _teamNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball':
        return 'assets/basketball.png';
      case 'soccer':
        return 'assets/ball.png';
      case 'volleyball':
        return 'assets/volleyball.png';
      default:
        return 'assets/basketball.png';
    }
  }

  // Show image picker for logo selection
  Future<void> _showLogoPicker() async {
    final ImagePicker picker = ImagePicker();
    final navigator = Navigator.of(context);
    
    try {
      final XFile? image = await showDialog<XFile>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Choose Team Logo'),
          content: const Text('Select an image from your device'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final XFile? pickedImage = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 512,
                  maxHeight: 512,
                  imageQuality: 80,
                );
                if (mounted) {
                  navigator.pop(pickedImage);
                }
              },
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () async {
                final XFile? pickedImage = await picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 512,
                  maxHeight: 512,
                  imageQuality: 80,
                );
                if (mounted) {
                  navigator.pop(pickedImage);
                }
              },
              child: const Text('Camera'),
            ),
          ],
        ),
      );
      
      if (image != null) {
        await _uploadLogo(File(image.path));
      }
    } catch (e) {
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Handle logo upload
  Future<void> _uploadLogo(File imageFile) async {
    try {
      setState(() => _isLoading = true);
      
      // Upload to Firebase Storage
      final downloadUrl = await ImageUploader.uploadImage(
        imageFile,
        pathPrefix: 'team_logos',
      );
      
      setState(() {
        _teamLogoUrl = downloadUrl;
        _isLoading = false;
      });
      
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Logo selected successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          SnackBar(
            content: Text('Error uploading logo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _createTeam() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not authenticated');

      final teamData = {
        'name': _teamNameController.text.trim(),
        'sport': _selectedSport,
        'location': _locationController.text.trim(),
        'description': _descriptionController.text.trim(),
        'level': _selectedLevel,
        'maxMembers': _maxMembers,
        'memberCount': 1, // Creator is the first member
        'createdBy': uid,
        'createdAt': Timestamp.now(),
        'members': [uid], // Creator is automatically a member
        'pendingRequests': [],
        'imageUrl': _teamLogoUrl, // Include team logo URL if selected
      };

      final success = await _teamService.createTeam(teamData);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Flexible(
              child: Text(
                'Team "${_teamNameController.text.trim()}" created successfully!',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context, true); // Return true to indicate success
      } else {
        throw Exception('Failed to create team');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Flexible(
              child: Text(
                'Error creating team: ${e.toString()}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: textScaler),
        child: Container(
                  decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.surface],
          ),
        ),
          child: SafeArea(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ),
                      Expanded(
                        child: SafeTitleText(
                          'Create Team',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                    ],
                  ),
                ),

                // Form
                Expanded(
                  child: SlideTransition(
                    position: _formSlide,
                    child: FadeTransition(
                      opacity: _formFade,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sport Selection
                              SafeLabelText(
                                'Sport',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.surface,
                                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
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
                                child: DropdownButtonFormField<String>(
                                  value: _selectedSport,
                                  dropdownColor: Theme.of(context).colorScheme.surface,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  items: _sports.map((sport) {
                                    return DropdownMenuItem(
                                      value: sport,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            _getSportIcon(sport),
                                            width: MediaQuery.of(context).size.width * 0.06,
                                            height: MediaQuery.of(context).size.width * 0.06,
                                            errorBuilder: (context, error, stackTrace) => Icon(
                                              Icons.sports_soccer,
                                              size: MediaQuery.of(context).size.width * 0.06,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                          SafeLabelText(
                                            sport,
                                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(() => _selectedSport = value!),
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                              // Team Name
                              SafeLabelText(
                                'Team Name',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.surface,
                                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
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
                                  controller: _teamNameController,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  decoration: InputDecoration(
                                    hintText: 'Enter team name',
                                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Team name is required';
                                    }
                                    if (value.trim().length < 3) {
                                      return 'Team name must be at least 3 characters';
                                    }
                                    if (value.trim().length > 50) {
                                      return 'Team name must be less than 50 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                              // Location
                              SafeLabelText(
                                'Location',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.surface,
                                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
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
                                  controller: _locationController,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  decoration: InputDecoration(
                                    hintText: 'Where do you play?',
                                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).colorScheme.secondary,
                                      size: MediaQuery.of(context).size.width * 0.06,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Location is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                              // Level
                              SafeLabelText(
                                'Skill Level',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.surface,
                                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
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
                                child: DropdownButtonFormField<String>(
                                  value: _selectedLevel,
                                  dropdownColor: Theme.of(context).colorScheme.surface,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  items: _levels.map((level) {
                                    return DropdownMenuItem(
                                      value: level,
                                      child: SafeLabelText(
                                        level,
                                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(() => _selectedLevel = value!),
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                              // Max Members
                              SafeLabelText(
                                'Maximum Members',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.surface,
                                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
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
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Theme.of(context).colorScheme.primary,
                                    inactiveTrackColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                                    thumbColor: Theme.of(context).colorScheme.primary,
                                    overlayColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                                    valueIndicatorColor: Theme.of(context).colorScheme.primary,
                                    valueIndicatorTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                  child: Slider(
                                    value: _maxMembers.toDouble(),
                                    min: 5,
                                    max: 30,
                                    divisions: 25,
                                    label: _maxMembers.toString(),
                                    onChanged: (value) => setState(() => _maxMembers = value.round()),
                                  ),
                                ),
                              ),
                              Center(
                                child: SafeLabelText(
                                  '$_maxMembers members',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                              // Team Logo
                              SafeLabelText(
                                'Team Logo (Optional)',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.surface,
                                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                                ),
                                child: Column(
                                  children: [
                                    // Current logo or placeholder
                                    Container(
                                      height: 80,
                                      width: 80,
                                      margin: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),
                                      ),
                                      child: _teamLogoUrl != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(40),
                                              child: Image.network(
                                                _teamLogoUrl!,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => Icon(
                                                  Icons.sports_soccer,
                                                  size: 40,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            )
                                          : Icon(
                                              Icons.add_photo_alternate,
                                              size: 40,
                                              color: Colors.grey[400],
                                            ),
                                    ),
                                    // Logo selection button
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: TextButton.icon(
                                        onPressed: _showLogoPicker,
                                        icon: const Icon(Icons.photo_library, size: 16),
                                        label: const Text('Choose Logo'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                              // Description
                              SafeLabelText(
                                'Description (Optional)',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.surface,
                                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
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
                                  controller: _descriptionController,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  maxLines: 4,
                                  maxLength: 200,
                                  decoration: InputDecoration(
                                    hintText: 'Tell others about your team...',
                                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    contentPadding: const EdgeInsets.all(16),
                                    counterStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                                  ),
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                              // Logo upload section
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                              // Create Button
                              SizedBox(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _createTeam,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                                    elevation: 8,
                                    shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.06,
                                          height: MediaQuery.of(context).size.width * 0.06,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
                                          ),
                                        )
                                      : SafeButtonText(
                                          'CREATE TEAM',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.width * 0.04,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                            ],
                          ),
                        ),
                      ),
                    ),
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
