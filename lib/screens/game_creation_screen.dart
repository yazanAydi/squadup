import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/game_model.dart';
import '../models/game.dart';
import '../services/service_locator.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/app_card.dart';
import '../widgets/modern_input_field.dart';

class GameCreationScreen extends ConsumerStatefulWidget {
  const GameCreationScreen({super.key});

  @override
  ConsumerState<GameCreationScreen> createState() => _GameCreationScreenState();
}

class _GameCreationScreenState extends ConsumerState<GameCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rulesController = TextEditingController();
  final _venueNameController = TextEditingController();
  final _venueDetailsController = TextEditingController();
  
  DateTime _scheduledDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _scheduledTime = const TimeOfDay(hour: 18, minute: 0);
  int _durationHours = 2;
  
  String _selectedSport = 'Football';
  String _selectedSkillLevel = 'Beginner';
  String _selectedCurrency = 'USD';
  
  int _maxPlayers = 10;
  int _minPlayers = 6;
  double _price = 0.0;
  
  final List<String> _rules = [];
  final List<String> _tags = [];
  
  bool _isPrivate = false;
  bool _requiresCheckIn = false;
  DateTime? _checkInDeadline;
  
  GameLocation? _location;
  bool _isLoadingLocation = false;
  bool _isCreatingGame = false;
  
  final List<String> _availableSports = [
    'Football', 'Basketball', 'Tennis', 'Volleyball', 'Baseball',
    'Soccer', 'Hockey', 'Cricket', 'Rugby', 'Badminton',
    'Table Tennis', 'Golf', 'Swimming', 'Running', 'Cycling',
    'Other'
  ];
  
  final List<String> _skillLevels = [
    'Beginner', 'Intermediate', 'Advanced', 'Professional', 'All Levels'
  ];
  
  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD'];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _rulesController.dispose();
    _venueNameController.dispose();
    _venueDetailsController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

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

      // Create location with coordinates
      // Note: Address geocoding requires additional packages like 'geocoding'
      // For now, we'll use coordinates and let users manually input address details
      _location = GameLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: 'Current Location (${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)})',
        city: '',
        state: '',
        country: '',
      );
    } catch (e) {
      _showLocationError('Failed to get location: $e');
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
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

  void _addRule() {
    if (_rulesController.text.trim().isNotEmpty) {
      setState(() {
        _rules.add(_rulesController.text.trim());
        _rulesController.clear();
      });
    }
  }

  void _removeRule(int index) {
    setState(() {
      _rules.removeAt(index);
    });
  }

  void _addTag() {
    // Add common tags based on sport
    final sportTags = {
      'Football': ['5v5', 'Indoor', 'Outdoor', 'Competitive', 'Casual'],
      'Basketball': ['3v3', '5v5', 'Indoor', 'Outdoor', 'Streetball'],
      'Tennis': ['Singles', 'Doubles', 'Indoor', 'Outdoor', 'Clay', 'Hard'],
      'Volleyball': ['6v6', 'Beach', 'Indoor', 'Competitive', 'Recreational'],
      'Baseball': ['9v9', 'Indoor', 'Outdoor', 'Competitive', 'Recreational'],
    };

    final availableTags = sportTags[_selectedSport] ?? ['Competitive', 'Recreational', 'Training'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Tags'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: availableTags.map((tag) {
            return CheckboxListTile(
              title: Text(tag),
              value: _tags.contains(tag),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _tags.add(tag);
                  } else {
                    _tags.remove(tag);
                  }
                });
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _scheduledDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime,
    );
    if (picked != null) {
      setState(() {
        _scheduledTime = picked;
      });
    }
  }

  Future<void> _selectCheckInDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkInDeadline ?? _scheduledDate,
      firstDate: DateTime.now(),
      lastDate: _scheduledDate,
    );
    if (picked != null) {
      setState(() {
        _checkInDeadline = picked;
      });
    }
  }

  bool _validateForm() {
    if (_location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please set a location for the game'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _createGame() async {
    if (!_formKey.currentState!.validate() || !_validateForm()) {
      return;
    }

    setState(() {
      _isCreatingGame = true;
    });

    try {
      final scheduledDateTime = DateTime(
        _scheduledDate.year,
        _scheduledDate.month,
        _scheduledDate.day,
        _scheduledTime.hour,
        _scheduledTime.minute,
      );

      final game = GameModel(
        id: 'game_${DateTime.now().millisecondsSinceEpoch}',
        name: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        sport: _selectedSport,
        createdBy: FirebaseAuth.instance.currentUser?.uid ?? 'anonymous',
        location: _location!.address,
        gameDateTime: scheduledDateTime,
        maxPlayers: _maxPlayers,
        minPlayers: _minPlayers,
        price: _price,
        currency: _selectedCurrency,
        isPublic: !_isPrivate,
        createdAt: DateTime.now(),
      );

      // Get game service from service locator
      final gameService = ServiceLocator.instance.gameService;
      final gameId = await gameService.createGame(game);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Game created successfully! ID: $gameId'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        
        // Navigate back or to game details
        Navigator.pop(context        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create game: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreatingGame = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Game'),
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
              // Basic Information Section
              _buildSectionHeader('Basic Information'),
              const SizedBox(height: 16),
              
              ModernInputField(
                controller: _titleController,
                label: 'Game Title',
                hint: 'Enter a catchy title for your game',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a game title';
                  }
                  if (value.trim().length < 3) {
                    return 'Title must be at least 3 characters long';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              ModernInputField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Describe your game, rules, and what to expect',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Sport & Skill Level Section
              _buildSectionHeader('Sport & Skill Level'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSport,
                      decoration: const InputDecoration(
                        labelText: 'Sport',
                        border: OutlineInputBorder(),
                      ),
                      items: _availableSports.map((sport) {
                        return DropdownMenuItem(
                          value: sport,
                          child: Text(sport),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSport = value!;
                          _tags.clear(); // Clear tags when sport changes
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSkillLevel,
                      decoration: const InputDecoration(
                        labelText: 'Skill Level',
                        border: OutlineInputBorder(),
                      ),
                      items: _skillLevels.map((level) {
                        return DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSkillLevel = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Date & Time Section
              _buildSectionHeader('Date & Time'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Text(
                              DateFormat('MMM dd, yyyy').format(_scheduledDate),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _selectTime,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Time', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Text(
                              _scheduledTime.format(context),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  const Text('Duration: '),
                  DropdownButton<int>(
                    value: _durationHours,
                    items: List.generate(6, (index) => index + 1).map((hours) {
                      return DropdownMenuItem(
                        value: hours,
                        child: Text('$hours hour${hours > 1 ? 's' : ''}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _durationHours = value!;
                      });
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Location Section
              _buildSectionHeader('Location'),
              const SizedBox(height: 16),
              
              if (_isLoadingLocation)
                const Center(child: CircularProgressIndicator())
              else if (_location != null)
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _location!.venueName ?? 'Current Location',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_location!.address),
                                Text('${_location!.city}, ${_location!.state}'),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: _getCurrentLocation,
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                AppCard(
                  child: Column(
                    children: [
                      const Icon(Icons.location_off, size: 48, color: Colors.grey),
                      const SizedBox(height: 8),
                      const Text('Location not set'),
                      const SizedBox(height: 8),
                      AppButton(
                        text: 'Set Location',
                        onPressed: _getCurrentLocation,
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 16),
              
              ModernInputField(
                controller: _venueNameController,
                label: 'Venue Name (Optional)',
                hint: 'e.g., Central Park, Sports Complex',
                onChanged: (value) {
                  if (_location != null) {
                    setState(() {
                      _location = _location!.copyWith(
                        venueName: value.isNotEmpty ? value : null,
                      );
                    });
                  }
                },
              ),
              
              const SizedBox(height: 16),
              
              ModernInputField(
                controller: _venueDetailsController,
                label: 'Venue Details (Optional)',
                hint: 'e.g., Field 3, Indoor Court A',
                onChanged: (value) {
                  if (_location != null) {
                    setState(() {
                      _location = _location!.copyWith(
                        venueDetails: value.isNotEmpty ? value : null,
                      );
                    });
                  }
                },
              ),
              
              const SizedBox(height: 24),
              
              // Players & Pricing Section
              _buildSectionHeader('Players & Pricing'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Min Players'),
                        Slider(
                          value: _minPlayers.toDouble(),
                          min: 1,
                          max: _maxPlayers.toDouble(),
                          divisions: _maxPlayers - 1,
                          label: _minPlayers.toString(),
                          onChanged: (value) {
                            setState(() {
                              _minPlayers = value.round();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Max Players'),
                        Slider(
                          value: _maxPlayers.toDouble(),
                          min: _minPlayers.toDouble(),
                          max: 50,
                          divisions: 50 - _minPlayers,
                          label: _maxPlayers.toString(),
                          onChanged: (value) {
                            setState(() {
                              _maxPlayers = value.round();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: ModernInputField(
                      label: 'Price',
                      hint: '0.00',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _price = double.tryParse(value) ?? 0.0;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCurrency,
                      decoration: const InputDecoration(
                        labelText: 'Currency',
                        border: OutlineInputBorder(),
                      ),
                      items: _currencies.map((currency) {
                        return DropdownMenuItem(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Rules Section
              _buildSectionHeader('Rules & Guidelines'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: ModernInputField(
                      controller: _rulesController,
                      label: 'Add Rule',
                      hint: 'e.g., Bring your own equipment',
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _addRule,
                    child: const Text('Add'),
                  ),
                ],
              ),
              
              if (_rules.isNotEmpty) ...[
                const SizedBox(height: 16),
                ...(_rules.asMap().entries.map((entry) {
                  final index = entry.key;
                  final rule = entry.value;
                  return Card(
                    child: ListTile(
                      title: Text(rule),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeRule(index),
                      ),
                    ),
                  );
                })),
              ],
              
              const SizedBox(height: 24),
              
              // Tags Section
              _buildSectionHeader('Tags'),
              const SizedBox(height: 16),
              
              if (_tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      onDeleted: () {
                        setState(() {
                          _tags.remove(tag);
                        });
                      },
                    );
                  }).toList(),
                ),
              
              const SizedBox(height: 16),
              
              AppButton(
                text: 'Add Tags',
                onPressed: _addTag,
              ),
              
              const SizedBox(height: 24),
              
              // Settings Section
              _buildSectionHeader('Settings'),
              const SizedBox(height: 16),
              
              SwitchListTile(
                title: const Text('Private Game'),
                subtitle: const Text('Only invited users can see and join'),
                value: _isPrivate,
                onChanged: (value) {
                  setState(() {
                    _isPrivate = value;
                  });
                },
              ),
              
              SwitchListTile(
                title: const Text('Require Check-in'),
                subtitle: const Text('Participants must check in before the game'),
                value: _requiresCheckIn,
                onChanged: (value) {
                  setState(() {
                    _requiresCheckIn = value;
                    if (!value) _checkInDeadline = null;
                  });
                },
              ),
              
              if (_requiresCheckIn) ...[
                const SizedBox(height: 16),
                InkWell(
                  onTap: _selectCheckInDeadline,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Check-in Deadline', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text(
                          _checkInDeadline != null
                              ? DateFormat('MMM dd, yyyy HH:mm').format(_checkInDeadline!)
                              : 'Set deadline',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 40),
              
              // Create Button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: _isCreatingGame ? 'Creating...' : 'Create Game',
                  onPressed: _isCreatingGame ? null : _createGame,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Divider(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
      ],
    );
  }
}
