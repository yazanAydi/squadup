abstract class UserServiceInterface {
  /// Get current user data with optional force refresh
  Future<Map<String, dynamic>?> getUserData({bool forceRefresh = false});
  
  /// Update user profile data
  Future<bool> updateUserProfile(Map<String, dynamic> userData);
  
  /// Update user sports preferences
  Future<bool> updateUserSports(Map<String, String> sports);
  
  /// Update user location
  Future<bool> updateUserLocation(String city);
  
  /// Delete user account
  Future<bool> deleteUserAccount();
  
  /// Get user statistics (games played, MVPs, etc.)
  Future<Map<String, dynamic>> getUserStatistics();
  
  /// Check if user has completed profile setup
  Future<bool> isProfileComplete();
  
  /// Get user's team memberships
  Future<List<Map<String, dynamic>>> getUserTeams();
  
  /// Get user's game history
  Future<List<Map<String, dynamic>>> getUserGameHistory();
}
