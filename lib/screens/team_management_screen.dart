import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_colors.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/app_card.dart';
import 'team_creation_screen.dart';
import 'team_discovery_screen.dart';
import 'team_chat_screen.dart';

class TeamManagementScreen extends ConsumerStatefulWidget {
  const TeamManagementScreen({super.key});

  @override
  ConsumerState<TeamManagementScreen> createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends ConsumerState<TeamManagementScreen> {
  final bool _isLoading = false;
  
  // Mock data for demonstration
  final List<Map<String, dynamic>> _myTeams = [
    {
      'id': '1',
      'name': 'Thunder Hawks',
      'sport': 'Basketball',
      'memberCount': 12,
      'maxMembers': 15,
      'role': 'Captain',
      'imageUrl': null,
      'isActive': true,
      'lastActivity': '2 days ago',
    },
    {
      'id': '2',
      'name': 'Soccer Legends',
      'sport': 'Soccer',
      'memberCount': 18,
      'maxMembers': 22,
      'role': 'Member',
      'imageUrl': null,
      'isActive': true,
      'lastActivity': '1 week ago',
    },
    {
      'id': '3',
      'name': 'Volleyball Stars',
      'sport': 'Volleyball',
      'memberCount': 8,
      'maxMembers': 12,
      'role': 'Vice Captain',
      'imageUrl': null,
      'isActive': false,
      'lastActivity': '3 weeks ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Teams'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        actions: [
                      IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeamCreationScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _myTeams.isEmpty
              ? _buildEmptyState()
              : _buildTeamsList(),
    );
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
            'No Teams Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Join a team or create your own to get started',
            style: TextStyle(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                              AppButton(
                  text: 'Join Team',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeamDiscoveryScreen(),
                      ),
                    );
                  },
                ),
              const SizedBox(width: 16),
                              AppButton(
                  text: 'Create Team',
                  onPressed: () {
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
        ],
      ),
    );
  }

  Widget _buildTeamsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _myTeams.length,
      itemBuilder: (context, index) {
        final team = _myTeams[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildTeamCard(team),
        );
      },
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
              
              // Role Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRoleColor(team['role']),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  team['role'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Team Stats
          Row(
            children: [
              _buildStatItem(
                'Members',
                '${team['memberCount']}/${team['maxMembers']}',
                Icons.people,
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                'Status',
                team['isActive'] ? 'Active' : 'Inactive',
                team['isActive'] ? Icons.check_circle : Icons.pause_circle,
                color: team['isActive'] ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                'Last Activity',
                team['lastActivity'],
                Icons.access_time,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Chat',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamChatScreen(
                          teamId: team['id'],
                          teamName: team['name'],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: 'View Team',
                  onPressed: () {
                    _showTeamDetails(team);
                  },
                ),
              ),
              const SizedBox(width: 12),
              if (team['role'] == 'Captain' || team['role'] == 'Vice Captain')
                Expanded(
                  child: AppButton(
                    text: 'Manage',
                    onPressed: () {
                      _showTeamManagement(team);
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, {Color? color}) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color ?? Colors.grey[600],
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color ?? Colors.grey[600],
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
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

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'captain':
        return Colors.red;
      case 'vice captain':
        return Colors.orange;
      case 'member':
        return Colors.blue;
      case 'coach':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _showTeamDetails(Map<String, dynamic> team) {
    // Show team details in a dialog (placeholder for now)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(team['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sport: ${team['sport']}'),
            Text('Role: ${team['role']}'),
            Text('Members: ${team['memberCount']}/${team['maxMembers']}'),
            Text('Status: ${team['isActive'] ? 'Active' : 'Inactive'}'),
            Text('Last Activity: ${team['lastActivity']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTeamManagement(Map<String, dynamic> team) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage ${team['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Manage Members'),
              onTap: () {
                Navigator.pop(context);
                // Show member management dialog (placeholder)
                _showMemberManagement(team);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Team Settings'),
              onTap: () {
                Navigator.pop(context);
                // Show team settings dialog (placeholder)
                _showTeamSettings(team);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Schedule Events'),
              onTap: () {
                Navigator.pop(context);
                // Show event scheduling dialog (placeholder)
                _showEventScheduling(team);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showMemberManagement(Map<String, dynamic> team) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage ${team['name']} Members'),
        content: const Text('Member management functionality will be implemented in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTeamSettings(Map<String, dynamic> team) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${team['name']} Settings'),
        content: const Text('Team settings functionality will be implemented in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showEventScheduling(Map<String, dynamic> team) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Schedule ${team['name']} Events'),
        content: const Text('Event scheduling functionality will be implemented in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
