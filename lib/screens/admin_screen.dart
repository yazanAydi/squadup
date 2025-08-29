import 'package:flutter/material.dart';
import '../services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/theme/app_colors.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  
  @override
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  final _adminService = ServiceLocator.instance.adminService;
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic>? _systemStats;
  Map<String, dynamic>? _userAnalytics;
  bool _isLoading = false;
  bool _canAccess = false;
  String _currentUserId = '';

  @override
  void initState() {
    super.initState();
    _checkAdminAccess();
  }

  Future<void> _checkAdminAccess() async {
    setState(() => _isLoading = true);
    
    try {
      // Get current user ID for display
      final user = _auth.currentUser;
      if (user != null) {
        _currentUserId = user.uid;
      }

      // Check admin access
      final canAccess = await _adminService.canAccessAdmin(_currentUserId);
      setState(() => _canAccess = canAccess);
      
      if (canAccess) {
        await _loadAdminData();
      } else {
        // Show why access was denied
        final isAdmin = await _adminService.isAdmin(_currentUserId);
        final isIPAllowed = await _adminService.isIPWhitelisted('127.0.0.1');
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Access denied: Admin: $isAdmin, IP: $isIPAllowed',
                style: TextStyle(fontSize: 12),
              ),
              duration: Duration(seconds: 5),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadAdminData() async {
    try {
      final stats = await _adminService.getSystemStats();
      final analytics = await _adminService.getUserAnalytics();
      
      setState(() {
        _systemStats = stats;
        _userAnalytics = analytics;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  Future<void> _showDebugInfo() async {
    try {
      final debugInfo = await _adminService.getDebuginfo();
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
          title: Text('Debug Information'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Current User ID:'),
                Text(
                  debugInfo['userId'] ?? 'Not signed in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('Current IP:'),
                Text(
                  debugInfo['currentIP'] ?? 'Unknown',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('Admin User IDs:'),
                Text(
                  (debugInfo['adminUserIds'] as List?)?.join(', ') ?? 'None',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('Whitelisted IPs:'),
                Text(
                  (debugInfo['whitelistedIPs'] as List?)?.join(', ') ?? 'None',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting debug info: $e')),
        );
      }
    }
  }

  Future<void> _runDataCleanup() async {
    try {
      setState(() => _isLoading = true);
      await _adminService.adminDataCleanup();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data cleanup completed successfully!')),
        );
      }
      // Refresh data after cleanup
      await _loadAdminData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during cleanup: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Admin Panel')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: AppColors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadAdminData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Access Status
            Card(
              color: _canAccess ? AppColors.green.withValues(alpha: 0.1) : AppColors.red.withValues(alpha: 0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _canAccess ? Icons.check_circle : Icons.cancel,
                          color: _canAccess ? AppColors.green : AppColors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _canAccess ? 'Admin Access Granted' : 'Admin Access Denied',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: _canAccess ? AppColors.green : AppColors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('User ID: $_currentUserId'),
                    if (!_canAccess) ...[
                      SizedBox(height: 8),
                      Text(
                        'To get admin access:\n1. Add your user ID to admin list\n2. Add your IP to whitelist',
                        style: TextStyle(color: AppColors.red),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: Icon(Icons.bug_report),
                        label: Text('Debug Info'),
                        onPressed: _showDebugInfo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            if (_canAccess) ...[
              SizedBox(height: 16),
              
              // System Statistics
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Statistics',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 16),
                      if (_systemStats != null) ...[
                        _buildStatRow('Total Users', _systemStats!['totalUsers']?.toString() ?? '0'),
                        _buildStatRow('Total Teams', _systemStats!['totalTeams']?.toString() ?? '0'),
                        _buildStatRow('Total Games', _systemStats!['totalGames']?.toString() ?? '0'),
                        _buildStatRow('Active Games', _systemStats!['activeGames']?.toString() ?? '0'),
                      ] else ...[
                        Text('No data available'),
                      ],
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              // User Analytics
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Users',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 16),
                      if (_userAnalytics != null && _userAnalytics!['recentUsers'] != null) ...[
                        ...(_userAnalytics!['recentUsers'] as List).map((user) => 
                          ListTile(
                            leading: CircleAvatar(
                              child: Text((user['username'] ?? 'U')[0].toUpperCase()),
                            ),
                            title: Text(user['username'] ?? 'Unknown'),
                            subtitle: Text('Joined: ${user['createdAt'] ?? 'Unknown'}'),
                          ),
                        ),
                      ] else ...[
                        Text('No recent users data'),
                      ],
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              // Admin Actions
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Actions',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: Icon(Icons.cleaning_services),
                        label: Text('Run Data Cleanup'),
                        onPressed: _runDataCleanup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This will clean up expired invitations, old games, and rate limit data',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
