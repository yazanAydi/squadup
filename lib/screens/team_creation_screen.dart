import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../core/theme/app_colors.dart';
import '../widgets/common/app_button.dart';
import '../services/service_locator.dart';

import '../widgets/modern_input_field.dart';
import '../models/team_model.dart';

class TeamCreationScreen extends ConsumerStatefulWidget {
  const TeamCreationScreen({super.key});

  @override
  ConsumerState<TeamCreationScreen> createState() => _TeamCreationScreenState();
}

class _TeamCreationScreenState extends ConsumerState<TeamCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _mottoController = TextEditingController();
  
  String _selectedSport = 'Football';
  String _selectedSkillLevel = 'All Levels';
  String _selectedLocation = 'Current Location';
  String _selectedPrivacy = 'Public';
  

  int _maxMembers = 20;
  bool _isRecruiting = true;
  bool _requiresTryout = false;
  double? _monthlyFee = 0.0;
  bool _isLoading = false;
  
  final List<String> _availableSports = [
    'Football', 'Basketball', 'Tennis', 'Volleyball', 'Baseball',
    'Soccer', 'Hockey', 'Cricket', 'Rugby', 'Badminton',
    'Table Tennis', 'Golf', 'Swimming', 'Running', 'Cycling', 'Other'
  ];
  
  final List<String> _skillLevels = [
    'Beginner', 'Intermediate', 'Advanced', 'Professional', 'All Levels'
  ];
  
  final List<String> _privacyOptions = [
    'Public', 'Private', 'Invite Only'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _mottoController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationError('Location permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationError('Location permissions are permanently denied');
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() {
        _selectedLocation = '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      });
    } catch (e) {
      _showLocationError('Failed to get location: $e');
    }
  }

  void _showLocationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _createTeam() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Show loading state
      setState(() {
        _isLoading = true;
      });

      // Get team service
      final teamService = ServiceLocator.instance.teamService;
      
      // Prepare team data
      final teamData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'sport': _selectedSport,
        'skillLevel': _selectedSkillLevel,
        'city': _selectedLocation,
        'motto': _mottoController.text.trim(),
        'maxMembers': _maxMembers,
        'isRecruiting': _isRecruiting,
        'requiresTryout': _requiresTryout,
        'monthlyFee': _monthlyFee ?? 0.0,
        'isActive': true,
        'isPublic': _selectedPrivacy == 'Public',
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      };

      // Create team using service
      final teamModel = TeamModel(
        id: 'team_${DateTime.now().millisecondsSinceEpoch}',
        name: (teamData['name'] as String?) ?? '',
        sport: (teamData['sport'] as String?) ?? '',
        city: (teamData['city'] as String?) ?? '',
        maxMembers: (teamData['maxMembers'] as int?) ?? 10,
        createdBy: (teamData['createdBy'] as String?) ?? '',
      );
      final teamId = await teamService.createTeam(teamModel);
      
      if (teamId.isNotEmpty && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Team created successfully!'),
            backgroundColor: AppColors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        
        // Navigate back
        Navigator.of(context).pop();
      } else {
        throw Exception('Failed to create team');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create team: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Team'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information
              _buildSectionHeader('Basic Information', Icons.info),
              const SizedBox(height: 16),
              
              ModernInputField(
                controller: _nameController,
                label: 'Team Name',
                hint: 'Enter your team name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Team name is required';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              ModernInputField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Describe your team',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              ModernInputField(
                controller: _mottoController,
                label: 'Team Motto (Optional)',
                hint: 'e.g., "Together we win"',
              ),
              
              const SizedBox(height: 24),
              
              // Sport & Level
              _buildSectionHeader('Sport & Level', Icons.sports),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedSport,
                decoration: const InputDecoration(
                  labelText: 'Primary Sport',
                  border: OutlineInputBorder(),
                ),
                items: _availableSports.map((sport) {
                  return DropdownMenuItem(value: sport, child: Text(sport));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSport = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedSkillLevel,
                decoration: const InputDecoration(
                  labelText: 'Skill Level',
                  border: OutlineInputBorder(),
                ),
                items: _skillLevels.map((level) {
                  return DropdownMenuItem(value: level, child: Text(level));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSkillLevel = value!;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              
              // Team Settings
              _buildSectionHeader('Team Settings', Icons.settings),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedPrivacy,
                decoration: const InputDecoration(
                  labelText: 'Privacy',
                  border: OutlineInputBorder(),
                ),
                items: _privacyOptions.map((option) {
                  return DropdownMenuItem(value: option, child: Text(option));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPrivacy = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Max Members: $_maxMembers',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _maxMembers.toDouble(),
                      min: 5,
                      max: 50,
                      divisions: 45,
                      label: _maxMembers.toString(),
                      onChanged: (value) {
                        setState(() {
                          _maxMembers = value.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              SwitchListTile(
                title: const Text('Currently Recruiting'),
                value: _isRecruiting,
                onChanged: (value) {
                  setState(() {
                    _isRecruiting = value;
                  });
                },
              ),
              
              SwitchListTile(
                title: const Text('Requires Tryout'),
                value: _requiresTryout,
                onChanged: (value) {
                  setState(() {
                    _requiresTryout = value;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              
              // Location
              _buildSectionHeader('Location', Icons.location_on),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Location: $_selectedLocation',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  AppButton(
                    text: 'Get Current',
                    onPressed: _getCurrentLocation,
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Monthly Fee
              _buildSectionHeader('Membership', Icons.payment),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Monthly Fee: \$${_monthlyFee?.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _monthlyFee ?? 0.0,
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      label: '\$${_monthlyFee?.toStringAsFixed(2) ?? '0.00'}',
                      onChanged: (value) {
                        setState(() {
                          _monthlyFee = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Create Button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: _isLoading ? 'Creating Team...' : 'Create Team',
                  onPressed: _isLoading ? null : _createTeam,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
