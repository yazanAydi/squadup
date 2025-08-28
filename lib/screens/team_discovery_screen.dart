import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_colors.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/app_card.dart';
import '../widgets/modern_input_field.dart';
import '../services/service_locator.dart';
import 'team_creation_screen.dart';

class TeamDiscoveryScreen extends ConsumerStatefulWidget {
  const TeamDiscoveryScreen({super.key});

  @override
  ConsumerState<TeamDiscoveryScreen> createState() => _TeamDiscoveryScreenState();
}

class _TeamDiscoveryScreenState extends ConsumerState<TeamDiscoveryScreen> {
  final _searchController = TextEditingController();
  
  List<Map<String, dynamic>> _teams = [];
  List<Map<String, dynamic>> _filteredTeams = [];
  bool _isLoading = false;
  
  // Filters
  String _selectedSport = 'All';
  String _selectedSkillLevel = 'All';
  String _selectedLocation = 'All';
  bool _showOnlyRecruiting = true;
  bool _showOnlyActive = true;
  bool _showOnlyFree = false;
  
  final List<String> _availableSports = [
    'All', 'Football', 'Basketball', 'Tennis', 'Volleyball', 'Baseball',
    'Soccer', 'Hockey', 'Cricket', 'Rugby', 'Badminton',
    'Table Tennis', 'Golf', 'Swimming', 'Running', 'Cycling', 'Other'
  ];
  
  final List<String> _skillLevels = [
    'All', 'Beginner', 'Intermediate', 'Advanced', 'Professional', 'All Levels'
  ];
  
  final List<String> _locations = [
    'All', 'Current Location', 'Nearby', 'City Center', 'Suburbs'
  ];

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTeams() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Mock data for demonstration
      await Future.delayed(const Duration(seconds: 1));
      
      final teams = [
        {
          'id': '1',
          'name': 'Thunder Hawks',
          'sport': 'Basketball',
          'skillLevel': 'Intermediate',
          'location': 'Downtown',
          'memberCount': 12,
          'maxMembers': 15,
          'isRecruiting': true,
          'isActive': true,
          'description': 'Competitive basketball team looking for dedicated players',
          'monthlyFee': 25.0,
          'requiresTryout': true,
        },
        {
          'id': '2',
          'name': 'Soccer Legends',
          'sport': 'Soccer',
          'skillLevel': 'All Levels',
          'location': 'City Park',
          'memberCount': 18,
          'maxMembers': 22,
          'isRecruiting': true,
          'isActive': true,
          'description': 'Casual soccer team for all skill levels',
          'monthlyFee': 0.0,
          'requiresTryout': false,
        },
        {
          'id': '3',
          'name': 'Volleyball Stars',
          'sport': 'Volleyball',
          'skillLevel': 'Advanced',
          'location': 'Sports Complex',
          'memberCount': 8,
          'maxMembers': 12,
          'isRecruiting': false,
          'isActive': true,
          'description': 'Advanced volleyball team, full roster',
          'monthlyFee': 30.0,
          'requiresTryout': true,
        },
        {
          'id': '4',
          'name': 'Tennis Club',
          'sport': 'Tennis',
          'skillLevel': 'Beginner',
          'location': 'Tennis Courts',
          'memberCount': 6,
          'maxMembers': 20,
          'isRecruiting': true,
          'isActive': true,
          'description': 'Beginner-friendly tennis club',
          'monthlyFee': 15.0,
          'requiresTryout': false,
        },
      ];
      
      setState(() {
        _teams = teams;
        _filteredTeams = teams;
      });
      
      _applyFilters();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load teams: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredTeams = _teams.where((team) {
        // Sport filter
        if (_selectedSport != 'All' && team['sport'] != _selectedSport) {
          return false;
        }
        
        // Skill level filter
        if (_selectedSkillLevel != 'All' && team['skillLevel'] != _selectedSkillLevel) {
          return false;
        }
        
        // Location filter
        if (_selectedLocation != 'All' && team['location'] != _selectedLocation) {
          return false;
        }
        
        // Recruiting filter
        if (_showOnlyRecruiting && !team['isRecruiting']) {
          return false;
        }
        
        // Active filter
        if (_showOnlyActive && !team['isActive']) {
          return false;
        }

        // Free filter
        if (_showOnlyFree && team['monthlyFee'] > 0) {
          return false;
        }
        
        // Search query filter
        if (_searchController.text.isNotEmpty) {
          final query = _searchController.text.toLowerCase();
          if (!team['name'].toLowerCase().contains(query) &&
              !team['description'].toLowerCase().contains(query) &&
              !team['sport'].toLowerCase().contains(query)) {
            return false;
          }
        }
        
        return true;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _applyFilters();
  }

  void _onFilterChanged() {
    _applyFilters();
  }

  Future<void> _joinTeam(Map<String, dynamic> team) async {
    try {
      // Show loading state
      setState(() {
        _isLoading = true;
      });

      // Get team service
      final teamService = ServiceLocator.instance.teamService;
      
      // Join team using service
      final success = await teamService.joinTeam(team['id']);
      
      if (success && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully joined ${team['name']}!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        
        // Refresh teams list to show updated member count
        _loadTeams();
      } else {
        throw Exception('Failed to join team');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to join team: $e'),
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

  void _showFiltersDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _buildFiltersSheet(),
    );
  }

  Widget _buildFiltersSheet() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedSport = 'All';
                    _selectedSkillLevel = 'All';
                    _selectedLocation = 'All';
                    _showOnlyRecruiting = true;
                    _showOnlyActive = true;
                    _showOnlyFree = false;
                  });
                  _onFilterChanged();
                  Navigator.pop(context);
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Sport filter
          const Text('Sport', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            value: _selectedSport,
            decoration: const InputDecoration(border: OutlineInputBorder()),
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
          
          // Skill level filter
          const Text('Skill Level', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            value: _selectedSkillLevel,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: _skillLevels.map((level) {
              return DropdownMenuItem(value: level, child: Text(level));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedSkillLevel = value!;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // Location filter
          const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            value: _selectedLocation,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: _locations.map((location) {
              return DropdownMenuItem(value: location, child: Text(location));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLocation = value!;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // Other filters
          SwitchListTile(
            title: const Text('Show only recruiting teams'),
            value: _showOnlyRecruiting,
            onChanged: (value) {
              setState(() {
                _showOnlyRecruiting = value;
              });
            },
          ),
          
          SwitchListTile(
            title: const Text('Show only active teams'),
            value: _showOnlyActive,
            onChanged: (value) {
              setState(() {
                _showOnlyActive = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text('Show only free teams'),
            value: _showOnlyFree,
            onChanged: (value) {
              setState(() {
                _showOnlyFree = value;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: 'Apply Filters',
              onPressed: () {
                _onFilterChanged();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard(Map<String, dynamic> team) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Team Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  _getSportIcon(team['sport']),
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Team Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      team['sport'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: team['isRecruiting'] ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  team['isRecruiting'] ? 'Recruiting' : 'Full',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Text(
            team['description'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              _buildStatItem(
                'Members',
                '${team['memberCount']}/${team['maxMembers']}',
                Icons.people,
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                'Level',
                team['skillLevel'],
                Icons.trending_up,
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                'Location',
                team['location'],
                Icons.location_on,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              if (team['monthlyFee'] > 0) ...[
                Icon(Icons.attach_money, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '\$${team['monthlyFee'].toStringAsFixed(0)}/month',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
              ],
              
              if (team['requiresTryout']) ...[
                Icon(Icons.sports, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(
                  'Tryout Required',
                  style: TextStyle(color: Colors.orange),
                ),
                const SizedBox(width: 16),
              ],
            ],
          ),
          
          const SizedBox(height: 16),
          
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: team['isRecruiting'] ? 'Request to Join' : 'Team Full',
              onPressed: team['isRecruiting'] ? () => _joinTeam(team) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball':
        return Icons.sports_basketball;
      case 'soccer':
        return Icons.sports_soccer;
      case 'volleyball':
        return Icons.sports_volleyball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'baseball':
        return Icons.sports_baseball;
      case 'hockey':
        return Icons.sports_hockey;
      case 'cricket':
        return Icons.sports_cricket;
      case 'rugby':
        return Icons.sports_rugby;
      case 'badminton':
        return Icons.sports_tennis;
      case 'table tennis':
        return Icons.sports_tennis;
      case 'golf':
        return Icons.sports_golf;
      case 'swimming':
        return Icons.pool;
      case 'running':
        return Icons.directions_run;
      case 'cycling':
        return Icons.directions_bike;
      default:
        return Icons.sports;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No teams found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search terms',
            style: TextStyle(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Create a Team',
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeamCreationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Teams'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        actions: [
          IconButton(
            onPressed: _showFiltersDialog,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filters bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ModernInputField(
                  controller: _searchController,
                  label: 'Search teams',
                  hint: 'Search by name, sport, or description...',
                  onChanged: _onSearchChanged,
                ),
                
                const SizedBox(height: 12),
                
                // Quick filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildQuickFilterChip('Recruiting', _showOnlyRecruiting, (value) {
                        setState(() {
                          _showOnlyRecruiting = value;
                        });
                        _onFilterChanged();
                      }),
                      const SizedBox(width: 8),
                      _buildQuickFilterChip('Active', _showOnlyActive, (value) {
                        setState(() {
                          _showOnlyActive = value;
                        });
                        _onFilterChanged();
                      }),
                      const SizedBox(width: 8),
                      _buildQuickFilterChip('Free', _showOnlyFree, (value) {
                        setState(() {
                          _showOnlyFree = value;
                        });
                        _onFilterChanged();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredTeams.length} team${_filteredTeams.length != 1 ? 's' : ''} found',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Teams list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredTeams.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: _loadTeams,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _filteredTeams.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemBuilder: (context, index) => _buildTeamCard(_filteredTeams[index]),
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TeamCreationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuickFilterChip(String label, bool isSelected, ValueChanged<bool> onChanged) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onChanged,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }
}
