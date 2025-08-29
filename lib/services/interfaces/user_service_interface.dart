import '../../models/user_model.dart';

/// User service interface following Clean Architecture principles
abstract class UserServiceInterface {
  /// Get current user profile
  Future<UserModel?> getCurrentUser();
  
  /// Update user profile
  Future<void> updateProfile(UserModel user);
  
  /// Update user statistics
  Future<void> updateStats(String userId, Map<String, dynamic> stats);
  
  /// Search users by query
  Future<List<UserModel>> searchUsers(String query);
  
  /// Get users by city
  Future<List<UserModel>> getUsersByCity(String city);
  
  /// Get users by sport
  Future<List<UserModel>> getUsersBySport(String sport);
  
  /// Get user by ID
  Future<UserModel?> getUserById(String userId);
  
  /// Get user by email
  Future<UserModel?> getUserByEmail(String email);
  
  /// Get user by username
  Future<UserModel?> getUserByUsername(String username);
  
  /// Create new user
  Future<String> createUser(UserModel user);
  
  /// Delete user
  Future<void> deleteUser(String userId);
  
  /// Check if user exists
  Future<bool> userExists(String userId);
  
  /// Get user's teams
  Future<List<String>> getUserTeams(String userId);
  
  /// Get user's games
  Future<List<String>> getUserGames(String userId);
  
  /// Add friend
  Future<void> addFriend(String userId, String friendId);
  
  /// Remove friend
  Future<void> removeFriend(String userId, String friendId);
  
  /// Block user
  Future<void> blockUser(String userId, String blockedUserId);
  
  /// Unblock user
  Future<void> unblockUser(String userId, String unblockedUserId);
  
  /// Get user's friends
  Future<List<UserModel>> getUserFriends(String userId);
  
  /// Get user's blocked users
  Future<List<UserModel>> getUserBlockedUsers(String userId);
  
  /// Get user data (for compatibility)
  Future<Map<String, dynamic>?> getUserData();
  
  /// Update user profile
  Future<bool> updateUserProfile(String userId, Map<String, dynamic> profileData);
  
  /// Update user sports
  Future<bool> updateUserSports(String userId, List<String> sports);
  
  /// Update user location
  Future<bool> updateUserLocation(String userId, Map<String, dynamic> locationData);
}