import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../interfaces/user_service_interface.dart';
import '../repositories/user_repository.dart';
import '../../utils/cache_manager.dart';
import '../../core/security/rate_limiter.dart';
import '../../core/errors/app_error_handler.dart';
import '../../models/user_profile.dart';

class UserService implements UserServiceInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository;
  final CacheManager _cacheManager;
  final RateLimiter _rateLimiter;

  UserService({
    UserRepository? userRepository,
    CacheManager? cacheManager,
    RateLimiter? rateLimiter,
  }) : _userRepository = userRepository ?? UserRepository(),
       _cacheManager = cacheManager ?? CacheManager(),
       _rateLimiter = rateLimiter ?? RateLimiter();

  @override
  Future<Map<String, dynamic>?> getUserData({bool forceRefresh = false}) async {
    try {
      if (kDebugMode) {
        print('UserService: Getting user data (forceRefresh: $forceRefresh)');
      }
      
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Check rate limiting
      final rateLimitKey = RateLimitKeys.apiKey(userId);
      if (!_rateLimiter.isAllowed(rateLimitKey, maxRequests: RateLimitConfig.apiRequests)) {
        throw Exception('Rate limit exceeded. Please try again later.');
      }

      // Try cache first if not forcing refresh
      if (!forceRefresh) {
        final cachedData = _cacheManager.get<Map<String, dynamic>>(CacheKeys.userProfileKey(userId));
        if (cachedData != null) {
          if (kDebugMode) {
            print('UserService: Data retrieved from cache');
          }
          return cachedData;
        }
      }

      // Get from repository
      final userProfile = await _userRepository.getById(userId);
      if (userProfile == null) {
        return null;
      }

      // Convert to map format for backward compatibility
      final userData = userProfile.toJson();
      
      // Cache the data
      await _cacheManager.set(
        CacheKeys.userProfileKey(userId),
        userData,
        ttl: const Duration(minutes: 15), // Cache for 15 minutes
      );
      
      if (kDebugMode) {
        print('UserService: User data retrieved successfully from repository');
      }
      
      return userData;
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.getUserData',
        severity: ErrorSeverity.error,
      );
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
        throw Exception('You must be signed in to update your profile.');
      }

      // Check rate limiting
      final rateLimitKey = RateLimitKeys.apiKey(uid);
      if (!_rateLimiter.isAllowed(rateLimitKey, maxRequests: RateLimitConfig.apiRequests)) {
        throw Exception('Rate limit exceeded. Please try again later.');
      }

      // Update in repository
      final userProfile = UserProfile.fromJson(userData);
      final success = await _userRepository.update(uid, userProfile);
      
      if (success) {
        // Update cache
        await _cacheManager.set(
          CacheKeys.userProfileKey(uid),
          userData,
          ttl: const Duration(minutes: 15),
        );
        
        if (kDebugMode) {
          print('UserService: Profile updated successfully');
        }
        return true;
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.updateUserProfile',
        severity: ErrorSeverity.error,
      );
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
        throw Exception('You must be signed in to update your sports preferences.');
      }

      // Check rate limiting
      final rateLimitKey = RateLimitKeys.apiKey(uid);
      if (!_rateLimiter.isAllowed(rateLimitKey, maxRequests: RateLimitConfig.apiRequests)) {
        throw Exception('Rate limit exceeded. Please try again later.');
      }

      // Update specific fields
      final success = await _userRepository.updateCurrentUserFields({
        'sports': sports,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
      
      if (success) {
        // Refresh cache
        await _cacheManager.remove(CacheKeys.userProfileKey(uid));
        
        if (kDebugMode) {
          print('UserService: Sports updated successfully');
        }
        return true;
      } else {
        throw Exception('Failed to update sports preferences');
      }
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.updateUserSports',
        severity: ErrorSeverity.error,
      );
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
        throw Exception('You must be signed in to update your location.');
      }

      if (city.isEmpty) {
        throw Exception('City cannot be empty.');
      }

      // Check rate limiting
      final rateLimitKey = RateLimitKeys.apiKey(uid);
      if (!_rateLimiter.isAllowed(rateLimitKey, maxRequests: RateLimitConfig.apiRequests)) {
        throw Exception('Rate limit exceeded. Please try again later.');
      }

      // Update specific fields
      final success = await _userRepository.updateCurrentUserFields({
        'city': city,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
      
      if (success) {
        // Refresh cache
        await _cacheManager.remove(CacheKeys.userProfileKey(uid));
        
        if (kDebugMode) {
          print('UserService: Location updated successfully');
        }
        return true;
      } else {
        throw Exception('Failed to update location');
      }
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.updateUserLocation',
        severity: ErrorSeverity.error,
      );
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
        throw Exception('You must be signed in to delete your account.');
      }

      // Check rate limiting
      final rateLimitKey = RateLimitKeys.apiKey(uid);
      if (!_rateLimiter.isAllowed(rateLimitKey, maxRequests: 1, window: const Duration(hours: 1))) {
        throw Exception('Rate limit exceeded. Please try again later.');
      }

      // Delete from repository
      final success = await _userRepository.delete(uid);
      
      if (success) {
        // Clear cache
        await _cacheManager.remove(CacheKeys.userProfileKey(uid));
        
        // Delete user authentication
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          await currentUser.delete();
        }
        
        if (kDebugMode) {
          print('UserService: User account deleted successfully');
        }
        return true;
      } else {
        throw Exception('Failed to delete user account');
      }
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.deleteUserAccount',
        severity: ErrorSeverity.error,
      );
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
        return {};
      }

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
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.getUserStatistics',
        severity: ErrorSeverity.error,
      );
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
        return false;
      }

      final requiredFields = ['username', 'city', 'sports'];
      for (final field in requiredFields) {
        final value = userData[field];
        if (value == null || 
            (value is String && value.isEmpty) ||
            (value is Map && value.isEmpty)) {
          return false;
        }
      }
      
      if (kDebugMode) {
        print('UserService: User profile is complete');
      }
      
      return true;
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.isProfileComplete',
        severity: ErrorSeverity.error,
      );
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
        return [];
      }

      final teamIds = List<String>.from(userData['teams'] ?? []);
      if (teamIds.isEmpty) {
        return [];
      }

      // Try cache first
      final cachedTeams = _cacheManager.get<List<Map<String, dynamic>>>(CacheKeys.userTeams);
      if (cachedTeams != null) {
        return cachedTeams;
      }

      // Get from repository (this would need to be implemented in TeamRepository)
      // For now, return empty list
      return [];
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.getUserTeams',
        severity: ErrorSeverity.error,
      );
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
        return [];
      }

      // Try cache first
      final cachedGames = _cacheManager.get<List<Map<String, dynamic>>>(CacheKeys.userGames);
      if (cachedGames != null) {
        return cachedGames;
      }

      // Get from repository (this would need to be implemented in GameRepository)
      // For now, return empty list
      return [];
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.getUserGameHistory',
        severity: ErrorSeverity.error,
      );
      return [];
    }
  }

  /// Get user profile with real-time updates
  Stream<UserProfile?> watchUserProfile() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(null);
    return _userRepository.watchById(uid);
  }

  /// Search users
  Future<List<UserProfile>> searchUsers(String query) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return [];

      // Check rate limiting
      final rateLimitKey = RateLimitKeys.searchKey(uid);
      if (!_rateLimiter.isAllowed(rateLimitKey, maxRequests: RateLimitConfig.searchRequests)) {
        throw Exception('Search rate limit exceeded. Please try again later.');
      }

      return await _userRepository.searchUsers(query);
    } catch (e, stackTrace) {
      AppErrorHandler.handleError(
        e,
        stackTrace,
        context: 'UserService.searchUsers',
        severity: ErrorSeverity.error,
      );
      return [];
    }
  }
}
