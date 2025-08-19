import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/image_uploader.dart';

class GameCreationScreen extends StatefulWidget {
  const GameCreationScreen({super.key});

  @override
  State<GameCreationScreen> createState() => _GameCreationScreenState();
}

class _GameCreationScreenState extends State<GameCreationScreen>
    with TickerProviderStateMixin {
  late AnimationController _formController;
  late Animation<Offset> _formSlide;
  late Animation<double> _formFade;

  final _formKey = GlobalKey<FormState>();
  final _gameNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _maxPlayersController = TextEditingController();

  String _selectedSport = 'Basketball';
  String _selectedGameType = 'Pickup';
  String _selectedLevel = 'Mixed';
  String _selectedLocation = 'Indoor';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isPrivate = false;
  bool _isFree = true;
  double _entryFee = 0.0;
  bool _isLoading = false;
  String? _posterBackgroundUrl;

  // THEME
  static const Color bg = Color(0xFF0A0A0A);
  static const Color card = Color(0xFF1A1A1A);
  static const Color accent = Color(0xFF8C6CFF);
  static const Color subtle = Color(0xFF6B7280);

  List<String> sports = ['Basketball', 'Soccer', 'Volleyball', 'Tennis', 'Badminton'];
  List<String> gameTypes = ['Pickup', 'Scheduled', 'Tournament', 'League'];
  List<String> levels = ['Beginner', 'Intermediate', 'Advanced', 'Mixed'];
  List<String> locations = ['Indoor', 'Outdoor', 'Both'];

  @override
  void initState() {
    super.initState();
    
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
    _gameNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _maxPlayersController.dispose();
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: accent,
              onPrimary: Theme.of(context).colorScheme.onSurface,
              surface: card,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: bg,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: accent,
              onPrimary: Theme.of(context).colorScheme.onSurface,
              surface: card,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: bg,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Show image picker for poster background selection
  Future<void> _showPosterPicker() async {
    final ImagePicker picker = ImagePicker();
    final navigator = Navigator.of(context);
    
    try {
      final XFile? image = await showDialog<XFile>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Choose Poster Background'),
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
                  maxWidth: 1024,
                  maxHeight: 1024,
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
                  maxWidth: 1024,
                  maxHeight: 1024,
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
        await _uploadPosterBackground(File(image.path));
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

  // Handle poster background upload
  Future<void> _uploadPosterBackground(File imageFile) async {
    try {
      setState(() => _isLoading = true);
      
      // Upload to Firebase Storage
      final downloadUrl = await ImageUploader.uploadImage(
        imageFile,
        pathPrefix: 'game_posters',
      );
      
      setState(() {
        _posterBackgroundUrl = downloadUrl;
        _isLoading = false;
      });
      
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Poster background selected successfully!'),
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
            content: Text('Error uploading poster background: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _createGame() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not authenticated');

      // Combine date and time
      final gameDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final gameData = {
        'name': _gameNameController.text.trim(),
        'sport': _selectedSport,
        'gameType': _selectedGameType,
        'level': _selectedLevel,
        'location': _locationController.text.trim(),
        'locationType': _selectedLocation,
        'description': _descriptionController.text.trim(),
        'maxPlayers': int.parse(_maxPlayersController.text),
        'currentPlayers': 1, // Creator is the first player
        'createdBy': uid,
        'createdAt': Timestamp.now(),
        'gameDateTime': Timestamp.fromDate(gameDateTime),
        'isPrivate': _isPrivate,
        'isFree': _isFree,
        'entryFee': _entryFee,
        'status': 'open', // open, full, cancelled, completed
        'players': [uid], // Creator is automatically a player
        'pendingRequests': [],
        'teams': [], // For team-based games
        'rules': [], // Custom rules
        'equipment': [], // Required equipment
      };

      final docRef = await FirebaseFirestore.instance.collection('games').add(gameData);

      // Add game reference to user's created games
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'createdGames': FieldValue.arrayUnion([docRef.id]),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Game "${_gameNameController.text.trim()}" created successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context, true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating game: ${e.toString()}'),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bg, Theme.of(context).colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Text(
                        'Create Game',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
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
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sport Selection
                            Text(
                              'Sport',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: card.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedSport,
                                onChanged: (value) => setState(() => _selectedSport = value!),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                dropdownColor: card,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                items: sports.map((sport) {
                                  return DropdownMenuItem(
                                    value: sport,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          _getSportIcon(sport),
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(sport),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Game Type Selection
                            Text(
                              'Game Type',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: card.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedGameType,
                                onChanged: (value) => setState(() => _selectedGameType = value!),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                dropdownColor: card,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                items: gameTypes.map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Game Name
                            Text(
                              'Game Name',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
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
                              ),
                              child: TextFormField(
                                controller: _gameNameController,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Game name is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter game name',
                                  labelStyle: const TextStyle(color: subtle),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Event Poster Generation
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Event Poster (Optional)',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  decoration: BoxDecoration(
                                    color: card.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                                  ),
                                  child: Column(
                                    children: [
                                      // Current poster preview
                                      if (_posterBackgroundUrl != null)
                                        Container(
                                          height: 120,
                                          width: double.infinity,
                                          margin: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: FileImage(File(_posterBackgroundUrl!)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.black.withValues(alpha: 0.6),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _gameNameController.text.isNotEmpty 
                                                        ? _gameNameController.text 
                                                        : 'Game Name',
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    _formatDate(_selectedDate),
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                                  ),
                                                  Text(
                                                    _locationController.text.isNotEmpty 
                                                        ? _locationController.text 
                                                        : 'Location',
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      // Poster generation button
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: TextButton.icon(
                                          onPressed: _showPosterPicker,
                                          icon: const Icon(Icons.image, size: 16),
                                          label: Text(_posterBackgroundUrl != null 
                                              ? 'Change Background' 
                                              : 'Generate Poster'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: accent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Date and Time Selection
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: _selectDate,
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: card.withValues(alpha: 0.8),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _formatDate(_selectedDate),
                                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                                              ),
                                              const Icon(Icons.calendar_today, color: accent),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: _selectTime,
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: card.withValues(alpha: 0.8),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _formatTime(_selectedTime),
                                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                                              ),
                                              const Icon(Icons.access_time, color: accent),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Location
                            Text(
                              'Location',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
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
                              ),
                              child: TextFormField(
                                controller: _locationController,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Location is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter location (e.g., Central Park)',
                                  labelStyle: const TextStyle(color: subtle),
                                  prefixIcon: const Icon(Icons.location_on, color: subtle),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Location Type
                            Text(
                              'Location Type',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: card.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedLocation,
                                onChanged: (value) => setState(() => _selectedLocation = value!),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                dropdownColor: card,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                items: locations.map((location) {
                                  return DropdownMenuItem(
                                    value: location,
                                    child: Text(location),
                                  );
                                }).toList(),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Level
                            Text(
                              'Skill Level',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: card.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedLevel,
                                onChanged: (value) => setState(() => _selectedLevel = value!),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                dropdownColor: card,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                items: levels.map((level) {
                                  return DropdownMenuItem(
                                    value: level,
                                    child: Text(level),
                                  );
                                }).toList(),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Max Players
                            Text(
                              'Maximum Players',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
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
                              ),
                              child: TextFormField(
                                controller: _maxPlayersController,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Maximum players is required';
                                  }
                                  final number = int.tryParse(value);
                                  if (number == null || number < 2) {
                                    return 'Must be at least 2 players';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter max number of players',
                                  labelStyle: const TextStyle(color: subtle),
                                  prefixIcon: const Icon(Icons.people, color: subtle),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Description
                            Text(
                              'Description',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
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
                              ),
                              child: TextFormField(
                                controller: _descriptionController,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: 'Describe your game (optional)',
                                  labelStyle: const TextStyle(color: subtle),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Game Settings
                            Text(
                              'Game Settings',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // Private Game
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: card.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.lock, color: subtle),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Private Game',
                                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                                    ),
                                  ),
                                  Switch(
                                    value: _isPrivate,
                                    onChanged: (value) => setState(() => _isPrivate = value),
                                    activeColor: accent,
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Free Game
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: card.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.attach_money, color: subtle),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Free Game',
                                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                                    ),
                                  ),
                                  Switch(
                                    value: _isFree,
                                    onChanged: (value) => setState(() => _isFree = value),
                                    activeColor: accent,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Entry Fee (if not free)
                            if (!_isFree) ...[
                              SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: card.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.payment, color: subtle),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Entry Fee: \$${_entryFee.toStringAsFixed(2)}',
                                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                                      ),
                                    ),
                                    Slider(
                                      value: _entryFee,
                                      min: 0.0,
                                      max: 100.0,
                                      divisions: 100,
                                      activeColor: accent,
                                      onChanged: (value) => setState(() => _entryFee = value),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            
                            const SizedBox(height: 32),
                            
                            // Poster upload section
                            const SizedBox(height: 16),
                            
                            // Create Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _createGame,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accent,
                                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                                  elevation: 8,
                                  shadowColor: accent.withValues(alpha: 0.3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: _isLoading
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
                                        ),
                                      )
                                    : const Text(
                                        'CREATE GAME',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                        ),
                                      ),
                              ),
                            ),
                            
                            const SizedBox(height: 20),
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
    );
  }
}
