import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../interfaces/user_service_interface.dart';
import '../../utils/data_service.dart';

class UserService implements UserServiceInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DataService _dataService = DataService.instance;

  @override
  Future<Map<String, dynamic>?> getUserData({bool forceRefresh = false}) async {
    try {
      if (kDebugMode) {
        print('UserService: Getting user data (forceRefresh: $forceRefresh)');
      }
      
      final result = await _dataService.getUserData(forceRefresh: forceRefresh);
      
      if (kDebugMode) {
        print('UserService: User data retrieved successfully');
      }
      
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in getUserData: $e');
      }
      throw Exception('Unable to retrieve user data. Please check your connection and try again.');
    }
  }

  @override
  Future<bool> updateUserProfile(Map<String, dynamic> userData) async {
    try {
      if (kDebugMode) {
        print('UserService: Updating user profile with data: ${userData.keys.toList()}');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('UserService: No authenticated user found for profile update');
        }
        throw Exception('You must be signed in to update your profile.');
      }

      // Update in Firebase
      try {
        await _firestore.collection('users').doc(uid).update(userData);
        
        if (kDebugMode) {
          print('UserService: Profile updated successfully in Firebase');
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error updating profile in Firebase: $e');
        }
        throw Exception('Unable to update profile. Please check your connection and try again.');
      }
      
      // Update cache
      try {
        final updatedData = await _dataService.getUserData(forceRefresh: true);
        if (updatedData != null) {
          if (kDebugMode) {
            print('UserService: Cache updated successfully');
          }
          return true;
        } else {
          if (kDebugMode) {
            print('UserService: Cache update failed - no data returned');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error updating cache: $e');
        }
        // Don't fail the entire operation if cache update fails
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in updateUserProfile: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> updateUserSports(Map<String, String> sports) async {
    try {
      if (kDebugMode) {
        print('UserService: Updating user sports: ${sports.keys.toList()}');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('UserService: No authenticated user found for sports update');
        }
        throw Exception('You must be signed in to update your sports preferences.');
      }

      try {
        await _firestore.collection('users').doc(uid).update({
          'sports': sports,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
        
        if (kDebugMode) {
          print('UserService: Sports updated successfully in Firebase');
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error updating sports in Firebase: $e');
        }
        throw Exception('Unable to update sports preferences. Please check your connection and try again.');
      }
      
      // Refresh cache
      try {
        await _dataService.getUserData(forceRefresh: true);
        
        if (kDebugMode) {
          print('UserService: Cache refreshed successfully');
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error refreshing cache: $e');
        }
        // Don't fail the entire operation if cache refresh fails
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in updateUserSports: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> updateUserLocation(String city) async {
    try {
      if (kDebugMode) {
        print('UserService: Updating user location to: $city');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('UserService: No authenticated user found for location update');
        }
        throw Exception('You must be signed in to update your location.');
      }

      if (city.isEmpty) {
        if (kDebugMode) {
          print('UserService: City cannot be empty');
        }
        throw Exception('City cannot be empty.');
      }

      try {
        await _firestore.collection('users').doc(uid).update({
          'city': city,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
        
        if (kDebugMode) {
          print('UserService: Location updated successfully in Firebase');
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error updating location in Firebase: $e');
        }
        throw Exception('Unable to update location. Please check your connection and try again.');
      }
      
      // Refresh cache
      try {
        await _dataService.getUserData(forceRefresh: true);
        
        if (kDebugMode) {
          print('UserService: Cache refreshed successfully');
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error refreshing cache: $e');
        }
        // Don't fail the entire operation if cache refresh fails
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in updateUserLocation: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> deleteUserAccount() async {
    try {
      if (kDebugMode) {
        print('UserService: Deleting user account');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('UserService: No authenticated user found for account deletion');
        }
        throw Exception('You must be signed in to delete your account.');
      }

      // Delete user data from Firestore
      try {
        await _firestore.collection('users').doc(uid).delete();
        
        if (kDebugMode) {
          print('UserService: User data deleted successfully from Firestore');
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error deleting user data from Firestore: $e');
        }
        throw Exception('Unable to delete user data. Please check your connection and try again.');
      }
      
      // Delete user authentication
      try {
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          await currentUser.delete();
          
          if (kDebugMode) {
            print('UserService: User authentication deleted successfully');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error deleting user authentication: $e');
        }
        throw Exception('Unable to delete user account. Please try again later.');
      }
      
      // Clear cache
      try {
        await _dataService.clearCache();
        
        if (kDebugMode) {
          print('UserService: Cache cleared successfully');
        }
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error clearing cache: $e');
        }
        // Don't fail the entire operation if cache clearing fails
      }
      
      if (kDebugMode) {
        print('UserService: User account deleted successfully');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in deleteUserAccount: $e');
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getUserStatistics() async {
    try {
      if (kDebugMode) {
        print('UserService: Getting user statistics');
      }
      
      final userData = await getUserData();
      if (userData == null) {
        if (kDebugMode) {
          print('UserService: No user data found for statistics');
        }
        return {};
      }

      try {
        final stats = {
          'gamesPlayed': userData['games'] ?? 0,
          'mvps': userData['mvps'] ?? 0,
          'sportsCount': (userData['sports'] as Map<String, dynamic>?)?.length ?? 0,
          'teamsCount': (userData['teams'] as List<dynamic>?)?.length ?? 0,
          'memberSince': userData['createdAt'],
          'lastActive': userData['lastUpdated'],
        };
        
        if (kDebugMode) {
          print('UserService: User statistics retrieved successfully');
        }
        
        return stats;
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error processing user statistics: $e');
        }
        return {};
      }
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in getUserStatistics: $e');
      }
      return {};
    }
  }

  @override
  Future<bool> isProfileComplete() async {
    try {
      if (kDebugMode) {
        print('UserService: Checking if user profile is complete');
      }
      
      final userData = await getUserData();
      if (userData == null) {
        if (kDebugMode) {
          print('UserService: No user data found for profile completeness check');
        }
        return false;
      }

      try {
        final requiredFields = ['username', 'city', 'sports'];
        for (final field in requiredFields) {
          final value = userData[field];
          if (value == null || 
              (value is String && value.isEmpty) ||
              (value is Map && value.isEmpty)) {
            if (kDebugMode) {
              print('UserService: Profile incomplete - missing or empty field: $field');
            }
            return false;
          }
        }
        
        if (kDebugMode) {
          print('UserService: User profile is complete');
        }
        
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error checking profile completeness: $e');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in isProfileComplete: $e');
      }
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUserTeams() async {
    try {
      if (kDebugMode) {
        print('UserService: Getting user teams');
      }
      
      final userData = await getUserData();
      if (userData == null) {
        if (kDebugMode) {
          print('UserService: No user data found for teams');
        }
        return [];
      }

      try {
        final teamIds = List<String>.from(userData['teams'] ?? []);
        if (teamIds.isEmpty) {
          if (kDebugMode) {
            print('UserService: User has no teams');
          }
          return [];
        }

        final teams = await _dataService.getTeamsData();
        final userTeams = teams.where((team) => teamIds.contains(team['id'])).toList();
        
        if (kDebugMode) {
          print('UserService: Retrieved ${userTeams.length} user teams');
        }
        
        return userTeams;
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error processing user teams: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in getUserTeams: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUserGameHistory() async {
    try {
      if (kDebugMode) {
        print('UserService: Getting user game history');
      }
      
      final userData = await getUserData();
      if (userData == null) {
        if (kDebugMode) {
          print('UserService: No user data found for game history');
        }
        return [];
      }

      try {
        final games = await _dataService.getGamesData();
        final userId = _auth.currentUser?.uid;
        
        if (userId == null) {
          if (kDebugMode) {
            print('UserService: No authenticated user found for game history');
          }
          return [];
        }

        // Filter games where user participated
        final userGames = games.where((game) {
          try {
            final participants = List<String>.from(game['participants'] ?? []);
            return participants.contains(userId);
          } catch (e) {
            if (kDebugMode) {
              print('UserService: Error processing game participants: $e');
            }
            return false;
          }
        }).toList();
        
        if (kDebugMode) {
          print('UserService: Retrieved ${userGames.length} user games');
        }
        
        return userGames;
      } catch (e) {
        if (kDebugMode) {
          print('UserService: Error processing user game history: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('UserService: Error in getUserGameHistory: $e');
      }
      return [];
    }
  }
}
