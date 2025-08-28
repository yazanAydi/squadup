
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../utils/responsive_utils.dart';
import '../services/image_uploader.dart';
import '../core/theme/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Autofill controllers
  final _usernameCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();

  String _level = ''; // Beginner / Intermediate / Advanced
  int _games = 0;
  int _mvps = 0;
  Map<String, String> _sports = {}; // {sportName: position}

  // If you add Storage later, you can track a picked file here.
  //File? _newImageFile; 
  String? _photoUrl;

  bool _isLoading = false;

  // THEME


  // Supported sports + positions
  static const List<String> kSports = ['Basketball', 'Soccer', 'Volleyball'];
  static const Map<String, List<String>> kPositions = {
    'Basketball': ['Point Guard','Shooting Guard','Small Forward','Power Forward','Center'],
    'Soccer': ['Goalkeeper','Defender','Midfielder','Winger','Striker'],
    'Volleyball': ['Setter','Outside Hitter','Opposite','Middle Blocker','Libero'],
  };

  static String iconFor(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball': return 'assets/basketball.png';
      case 'soccer': return 'assets/ball.png';
      case 'volleyball': return 'assets/volleyball.png';
      default: return 'assets/basketball.png';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _cityCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!mounted) return;
    
    final data = doc.data();
    if (data != null) {
      setState(() {
        _usernameCtrl.text = (data['username'] ?? '').toString();
        _cityCtrl.text = (data['city'] ?? '').toString();
        _bioCtrl.text = (data['bio'] ?? '').toString();
        _level = (data['level'] ?? '').toString();
        _games = data['games'] ?? 0;
        _mvps = data['mvps'] ?? 0;
        _photoUrl = data['profilePicUrl'];
        _sports = Map<String, String>.from(data['sports'] ?? {});
      });
    }
  }

  // Save profile text fields (name, city, level, bio, games, mvps)
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameCtrl.text.trim();
    final city = _cityCtrl.text.trim();
    final bio = _bioCtrl.text.trim();

    setState(() => _isLoading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

      final payload = {
        'username': username,
        'city': city,
        'bio': bio,
        'level': _level.isEmpty ? 'Intermediate' : _level,
        'games': _games,
        'mvps': _mvps,
        // keep current photo URL (we'll wire uploads later)
        'profilePicUrl': _photoUrl,
        // keep current sports untouched here
        'sports': _sports,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      try {
        await docRef.update(payload);
      } on FirebaseException catch (e) {
        if (e.code == 'not-found') {
          await docRef.set({
            ...payload,
            'createdAt': FieldValue.serverTimestamp(),
            'email': FirebaseAuth.instance.currentUser!.email,
          });
        } else {
          rethrow;
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: AppColors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error saving profile: ${e.toString()}"),
            backgroundColor: AppColors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Sports-only persist (call this if you edit sports here)
  Future<void> _persistSports() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      await docRef.update({'sports': _sports, 'updatedAt': FieldValue.serverTimestamp()});
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        await docRef.set(
          {'sports': _sports, 'updatedAt': FieldValue.serverTimestamp()},
          SetOptions(merge: true),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<void> _openSportPicker({String? editingSport}) async {
    final already = _sports.keys.toSet();
    final available = kSports.where((s) => editingSport == s || !already.contains(s)).toList();
    if (available.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("All supported sports are already added."),
            backgroundColor: AppColors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    String selectedSport = editingSport ?? available.first;
    String selectedPosition = _sports[editingSport] ?? (kPositions[selectedSport]!.first);

    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocalState) => Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                editingSport != null ? 'Edit Sport' : 'Add Sport',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedSport,
                dropdownColor: AppColors.surface,
                decoration: _dropdownDecoration('Sport'),
                iconEnabledColor: Theme.of(context).colorScheme.onSurface,
                items: available
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Row(
                            children: [
                              Image.asset(iconFor(s), width: 20, height: 20),
                              const SizedBox(width: 8),
                              Text(s, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val == null) return;
                  setLocalState(() {
                    selectedSport = val;
                    selectedPosition = kPositions[selectedSport]!.first;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedPosition,
                dropdownColor: AppColors.surface,
                decoration: _dropdownDecoration('Position'),
                iconEnabledColor: Theme.of(context).colorScheme.onSurface,
                items: kPositions[selectedSport]!
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                        ))
                    .toList(),
                onChanged: (val) => setLocalState(() => selectedPosition = val ?? selectedPosition),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    setState(() {
                      if (editingSport != null && editingSport != selectedSport) {
                        _sports.remove(editingSport);
                      }
                      _sports[selectedSport] = selectedPosition;
                    });
                    Navigator.pop(ctx);
                    await _persistSports();
                    
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(editingSport != null 
                            ? 'Sport updated successfully!' 
                            : 'Sport added successfully!'),
                          backgroundColor: AppColors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(editingSport != null ? 'Update' : 'Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteSport(String sport) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Delete Sport', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        content: Text(
          'Are you sure you want to remove $sport from your profile?',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => _sports.remove(sport));
      await _persistSports();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$sport removed from your profile'),
            backgroundColor: AppColors.orange,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Show image picker for avatar selection
  Future<void> _showImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final navigator = Navigator.of(context);
    
    try {
      final XFile? image = await showDialog<XFile>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Choose Avatar'),
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
        await _uploadAvatar(File(image.path));
      }
    } catch (e) {
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  // Handle avatar upload
  Future<void> _uploadAvatar(File imageFile) async {
    try {
      setState(() => _isLoading = true);
      
      // Upload to Firebase Storage
      final downloadUrl = await ImageUploader.uploadImage(
        imageFile,
        pathPrefix: 'avatars',
      );
      
      // Save URL to Firestore
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'profilePicUrl': downloadUrl});
      
      setState(() {
        _photoUrl = downloadUrl;
        _isLoading = false;
      });
      
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Avatar updated successfully!'),
            backgroundColor: AppColors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          SnackBar(
            content: Text('Error updating avatar: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Edit Profile'),
        actions: [
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _saveProfile,
                  child: Text('Save', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  ResponsiveUtils.isSmallScreen(context) ? 12 : 16, 
                  16, 
                  ResponsiveUtils.isSmallScreen(context) ? 12 : 16, 
                  16 + MediaQuery.of(context).viewInsets.bottom
                ),
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Avatar section
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: ResponsiveUtils.getResponsiveAvatarRadius(context),
                                  backgroundColor: AppColors.surface,
                                  backgroundImage: _photoUrl != null
                                      ? NetworkImage(_photoUrl!)
                                      : const AssetImage('assets/default_avatar.png') as ImageProvider,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.background, width: 2),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: _showImagePicker,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: _showImagePicker,
                              icon: const Icon(Icons.photo_library, size: 16),
                              label: const Text('Choose Avatar'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),

                      // Name
                      TextFormField(
                        controller: _usernameCtrl,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        decoration: _inputDecoration('Username'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Username is required';
                          }
                          if (value.trim().length < 3) {
                            return 'Username must be at least 3 characters';
                          }
                          if (value.trim().length > 20) {
                            return 'Username must be less than 20 characters';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value.trim())) {
                            return 'Username can only contain letters, numbers, and underscores';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),

                      // City
                      TextFormField(
                        controller: _cityCtrl,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        decoration: _inputDecoration('City'),
                        validator: (value) {
                          if (value != null && value.trim().length > 50) {
                            return 'City name must be less than 50 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),

                      // Level
                      DropdownButtonFormField<String>(
                        value: _level.isEmpty ? null : _level,
                        dropdownColor: AppColors.surface,
                        decoration: _inputDecoration('Level'),
                        items: const ['Beginner', 'Intermediate', 'Advanced']
                            .map((l) => DropdownMenuItem(
                                  value: l,
                                  child: Text(l, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                                ))
                            .toList(),
                        onChanged: (val) => setState(() => _level = val ?? _level),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),

                      // Bio
                      TextFormField(
                        controller: _bioCtrl,
                        maxLines: 4,
                        maxLength: 160,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        decoration: _inputDecoration('Bio (optional)'),
                        validator: (value) {
                          if (value != null && value.trim().length > 160) {
                            return 'Bio must be less than 160 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),

                      // Games / MVPs
                      TextFormField(
                        initialValue: _games.toString(),
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        decoration: _inputDecoration('Games'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final games = int.tryParse(value ?? '0');
                          if (games == null || games < 0) {
                            return 'Please enter a valid number (0 or higher)';
                          }
                          if (games > 9999) {
                            return 'Games count seems too high';
                          }
                          return null;
                        },
                        onSaved: (v) => _games = int.tryParse(v ?? '0') ?? 0,
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                      TextFormField(
                        initialValue: _mvps.toString(),
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        decoration: _inputDecoration('MVPs'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final mvps = int.tryParse(value ?? '0');
                          if (mvps == null || mvps < 0) {
                            return 'Please enter a valid number (0 or higher)';
                          }
                          if (mvps > _games) {
                            return 'MVPs cannot exceed total games';
                          }
                          return null;
                        },
                        onSaved: (v) => _mvps = int.tryParse(v ?? '0') ?? 0,
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 2),
                      
                      // Avatar upload section
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),

                      // Sports section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sports', 
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface, 
                              fontSize: ResponsiveUtils.getResponsiveFontSize(context, small: 14, medium: 16), 
                              fontWeight: FontWeight.w600
                            )
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _openSportPicker(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Sports display
                      _sports.isEmpty
                          ? Container(
                              width: double.infinity,
                              padding: ResponsiveUtils.getResponsivePadding(context),
                              decoration: BoxDecoration(
                                color: AppColors.surface.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.sports_basketball,
                                    size: ResponsiveUtils.getResponsiveIconSize(context, small: 40, medium: 48),
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                                  ),
                                  SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                                  Text(
                                    'No sports added yet',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, small: 14, medium: 16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 0.75),
                                  Text(
                                    'Add your favorite sports and positions to help teams find you!',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, small: 12, medium: 14),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
                                  ElevatedButton.icon(
                                    onPressed: () => _openSportPicker(),
                                    icon: const Icon(Icons.add, size: 18),
                                    label: const Text('Add Sport'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                return SizedBox(
                                  height: 160, // Fixed height that's large enough for all content
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _sports.length,
                                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                                    itemBuilder: (ctx, i) {
                                      final sport = _sports.keys.elementAt(i);
                                      final pos = _sports[sport]!;
                                      return Container(
                                        width: 140, // Fixed width that's large enough for all content
                                        decoration: BoxDecoration(
                                          color: AppColors.surface, 
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Sport icon
                                            Image.asset(
                                              iconFor(sport), 
                                              width: 36, 
                                              height: 36,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 8),
                                            
                                            // Sport name
                                            Text(
                                              sport,
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface, 
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            
                                            // Position
                                            Text(
                                              pos,
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6), 
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            
                                            const Spacer(),
                                            
                                            // Action buttons
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  padding: EdgeInsets.zero,
                                                  constraints: const BoxConstraints(
                                                    minWidth: 28,
                                                    minHeight: 28,
                                                  ),
                                                  onPressed: () => _openSportPicker(editingSport: sport),
                                                ),
                                                const SizedBox(width: 6),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete, 
                                                    color: AppColors.red, 
                                                    size: 18
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                  constraints: const BoxConstraints(
                                                    minWidth: 28,
                                                    minHeight: 28,
                                                  ),
                                                  onPressed: () => _deleteSport(sport),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.outline),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.06),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.15)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );

  InputDecoration _dropdownDecoration(String label) => _inputDecoration(label);
}
