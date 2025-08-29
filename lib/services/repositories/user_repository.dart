import '../interfaces/base_repository.dart';
import '../../models/user_model.dart';

/// User repository interface
abstract class UserRepository extends BaseRepository<UserModel> {
  /// Get user by email
  Future<UserModel?> getByEmail(String email);
  
  /// Get user by username
  Future<UserModel?> getByUsername(String username);
  
  /// Update user profile
  Future<void> updateProfile(String userId, Map<String, dynamic> updates);
  
  /// Update user statistics
  Future<void> updateStats(String userId, Map<String, dynamic> stats);
  
  /// Search users by name or username
  Future<List<UserModel>> searchUsers(String query);
  
  /// Get users by city
  Future<List<UserModel>> getUsersByCity(String city);
  
  /// Get users by sport
  Future<List<UserModel>> getUsersBySport(String sport);
  
  /// Get user's teams
  Future<List<String>> getUserTeams(String userId);
  
  /// Get user's games
  Future<List<String>> getUserGames(String userId);
}
