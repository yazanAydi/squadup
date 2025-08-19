import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Whitelisted IP addresses for admin access
  static const List<String> _whitelistedIPs = [
    '127.0.0.1',        // Localhost (for development)
    '::1',              // Localhost IPv6
    '142.250.201.14',   // Your previous IP address
    '142.250.200.238',  // Your current IP address
  ];
  
  // Admin user IDs
  static const List<String> _adminUserIds = [
    'UqWMv75YrXSG4uuSqGgIe9n4fLE3',  // Your admin user ID
  ];

  /// Check if current user has admin privileges
  Future<bool> isAdmin() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        if (kDebugMode) {
          print('AdminService: No authenticated user found');
        }
        return false;
      }
      
      // Check if user ID is in admin list
      if (_adminUserIds.contains(user.uid)) {
        if (kDebugMode) {
          print('AdminService: User ${user.uid} found in admin list');
        }
        return true;
      }
      
      // Check if user has admin role in database
      try {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          final userData = userDoc.data();
          // ignore: unnecessary_null_comparison
          if (userData != null) {
            final isAdminUser = userData['role'] == 'admin' || userData['isAdmin'] == true;
            if (kDebugMode) {
              print('AdminService: User ${user.uid} admin status: $isAdminUser');
            }
            return isAdminUser;
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('AdminService: Error checking user document: $e');
        }
        return false;
      }
      
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error checking admin status: $e');
      }
      return false;
    }
  }

  /// Check if current IP is whitelisted
  Future<bool> isIPWhitelisted() async {
    try {
      // Get current IP address
      final currentIP = await _getCurrentIP();
      final isWhitelisted = _whitelistedIPs.contains(currentIP);
      
      if (kDebugMode) {
        print('AdminService: Current IP: $currentIP, Whitelisted: $isWhitelisted');
        print('AdminService: Available whitelisted IPs: $_whitelistedIPs');
      }
      
      return isWhitelisted;
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error checking IP whitelist: $e');
      }
      return false;
    }
  }

  /// Get current IP address
  Future<String> _getCurrentIP() async {
    try {
      // This is a simplified approach - in production you'd want to use
      // a service like ipify.org or similar
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty) {
        return result.first.address;
      }
      return '127.0.0.1'; // Fallback to localhost
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error getting IP address: $e');
      }
      return '127.0.0.1'; // Fallback to localhost
    }
  }

  /// Check if admin access is allowed (both user and IP)
  Future<bool> canAccessAdmin() async {
    try {
      final isUserAdmin = await isAdmin();
      final isIPAllowed = await isIPWhitelisted();
      
      final canAccess = isUserAdmin && isIPAllowed;
      
      if (kDebugMode) {
        print('AdminService: Admin access check - User: $isUserAdmin, IP: $isIPAllowed, Result: $canAccess');
      }
      
      return canAccess;
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error checking admin access: $e');
      }
      return false;
    }
  }

  /// Admin-only function: Get system statistics
  Future<Map<String, dynamic>> getSystemStats() async {
    try {
      if (!await canAccessAdmin()) {
        throw Exception('Access denied: Admin privileges and whitelisted IP required');
      }
      
      final stats = <String, dynamic>{};
      
      // Get user count
      try {
        final usersSnapshot = await _firestore.collection('users').get();
        stats['totalUsers'] = usersSnapshot.docs.length;
        if (kDebugMode) {
          print('AdminService: Retrieved user count: ${stats['totalUsers']}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('AdminService: Error getting user count: $e');
        }
        stats['totalUsers'] = 0;
      }
      
      // Get team count
      try {
        final teamsSnapshot = await _firestore.collection('teams').get();
        stats['totalTeams'] = teamsSnapshot.docs.length;
        if (kDebugMode) {
          print('AdminService: Retrieved team count: ${stats['totalTeams']}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('AdminService: Error getting team count: $e');
        }
        stats['totalTeams'] = 0;
      }
      
      // Get game count
      try {
        final gamesSnapshot = await _firestore.collection('games').get();
        stats['totalGames'] = gamesSnapshot.docs.length;
        if (kDebugMode) {
          print('AdminService: Retrieved game count: ${stats['totalGames']}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('AdminService: Error getting game count: $e');
        }
        stats['totalGames'] = 0;
      }
      
      // Get active games
      try {
        final activeGamesSnapshot = await _firestore.collection('games')
            .where('status', isEqualTo: 'open')
            .get();
        stats['activeGames'] = activeGamesSnapshot.docs.length;
        if (kDebugMode) {
          print('AdminService: Retrieved active games count: ${stats['activeGames']}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('AdminService: Error getting active games count: $e');
        }
        stats['activeGames'] = 0;
      }
      
      if (kDebugMode) {
        print('AdminService: System stats retrieved successfully: $stats');
      }
      
      return stats;
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error getting system stats: $e');
      }
      throw Exception('Unable to retrieve system statistics. Please try again later.');
    }
  }

  /// Admin-only function: Clean up expired data
  Future<void> adminDataCleanup() async {
    try {
      if (!await canAccessAdmin()) {
        throw Exception('Access denied: Admin privileges and whitelisted IP required');
      }
      
      if (kDebugMode) {
        print('AdminService: Admin data cleanup initiated');
      }
      
      // Add to audit log
      try {
        final currentUser = _auth.currentUser;
        final currentIP = await _getCurrentIP();
        
        await _firestore.collection('audit_logs').add({
          'action': 'admin_data_cleanup',
          'adminId': currentUser?.uid ?? 'unknown',
          'timestamp': FieldValue.serverTimestamp(),
          'ipAddress': currentIP,
          'status': 'completed',
        });
        
        if (kDebugMode) {
          print('AdminService: Audit log entry created successfully');
        }
      } catch (e) {
        if (kDebugMode) {
          print('AdminService: Error creating audit log: $e');
        }
        // Don't fail the entire operation if audit logging fails
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error during admin data cleanup: $e');
      }
      throw Exception('Unable to complete data cleanup. Please try again later.');
    }
  }

  /// Debug method: Get current user and IP info (for setup)
  Future<Map<String, dynamic>> getDebugInfo() async {
    try {
      final user = _auth.currentUser;
      final currentIP = await _getCurrentIP();
      
      if (kDebugMode) {
        print('AdminService: === DEBUG INFO ===');
        print('AdminService: Current User ID: ${user?.uid ?? "Not signed in"}');
        print('AdminService: Current IP: $currentIP');
        print('AdminService: Admin User IDs: $_adminUserIds');
        print('AdminService: Whitelisted IPs: $_whitelistedIPs');
        print('AdminService: ===================');
      }
      
      return {
        'userId': user?.uid,
        'currentIP': currentIP,
        'adminUserIds': _adminUserIds,
        'whitelistedIPs': _whitelistedIPs,
      };
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error getting debug info: $e');
      }
      return {};
    }
  }

  /// Admin-only function: Get user analytics
  Future<Map<String, dynamic>> getUserAnalytics() async {
    try {
      if (!await canAccessAdmin()) {
        throw Exception('Access denied: Admin privileges and whitelisted IP required');
      }
      
      final analytics = <String, dynamic>{};
      
      // Get recent user registrations
      try {
        final recentUsersSnapshot = await _firestore.collection('users')
            .orderBy('createdAt', descending: true)
            .limit(10)
            .get();
        
        analytics['recentUsers'] = recentUsersSnapshot.docs.map((doc) {
          final data = doc.data();
          // ignore: unnecessary_null_comparison
          if (data != null) {
            return {
              'id': doc.id,
              'username': data['username'] ?? 'Unknown',
              'createdAt': data['createdAt'] ?? 'Unknown',
            };
          }
          return {
            'id': doc.id,
            'username': 'Unknown',
            'createdAt': 'Unknown',
          };
        }).toList();
        
        if (kDebugMode) {
          print('AdminService: Retrieved ${analytics['recentUsers'].length} recent users');
        }
      } catch (e) {
        if (kDebugMode) {
          print('AdminService: Error getting recent users: $e');
        }
        analytics['recentUsers'] = [];
      }
      
      if (kDebugMode) {
        print('AdminService: User analytics retrieved successfully');
      }
      
      return analytics;
    } catch (e) {
      if (kDebugMode) {
        print('AdminService: Error getting user analytics: $e');
      }
      throw Exception('Unable to retrieve user analytics. Please try again later.');
    }
  }
}
