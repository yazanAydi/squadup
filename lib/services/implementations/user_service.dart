import '../interfaces/user_service_interface.dart';
import '../repositories/user_repository.dart';
import '../../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/logging/app_logger.dart';

/// User service implementation following Clean Architecture principles
class UserService implements UserServiceInterface {
  final UserRepository _userRepository;

  UserService({UserRepository? userRepository}) 
      : _userRepository = userRepository ?? (throw ArgumentError('UserRepository is required'));

  @override
  Future<UserModel?> getCurrentUser() async {
    // Implementation would get current user from auth service
    throw UnimplementedError('getCurrentUser not implemented');
  }

  @override
  Future<void> updateProfile(UserModel user) async {
    await _userRepository.update(user.id, user);
  }

  @override
  Future<void> updateStats(String userId, Map<String, dynamic> stats) async {
    await _userRepository.updateStats(userId, stats);
  }

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    return await _userRepository.searchUsers(query);
  }

  @override
  Future<List<UserModel>> getUsersByCity(String city) async {
    return await _userRepository.getUsersByCity(city);
  }

  @override
  Future<List<UserModel>> getUsersBySport(String sport) async {
    return await _userRepository.getUsersBySport(sport);
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    return await _userRepository.getById(userId);
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    return await _userRepository.getByEmail(email);
  }

  @override
  Future<UserModel?> getUserByUsername(String username) async {
    return await _userRepository.getByUsername(username);
  }

  @override
  Future<String> createUser(UserModel user) async {
    return await _userRepository.create(user);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _userRepository.delete(userId);
  }

  @override
  Future<bool> userExists(String userId) async {
    return await _userRepository.exists(userId);
  }

  @override
  Future<List<String>> getUserTeams(String userId) async {
    return await _userRepository.getUserTeams(userId);
  }

  @override
  Future<List<String>> getUserGames(String userId) async {
    return await _userRepository.getUserGames(userId);
  }

  @override
  Future<void> addFriend(String userId, String friendId) async {
    // Implementation would add friend relationship
    throw UnimplementedError('addFriend not implemented');
  }

  @override
  Future<void> removeFriend(String userId, String friendId) async {
    // Implementation would remove friend relationship
    throw UnimplementedError('removeFriend not implemented');
  }

  @override
  Future<void> blockUser(String userId, String blockedUserId) async {
    // Implementation would block user
    throw UnimplementedError('blockUser not implemented');
  }

  @override
  Future<void> unblockUser(String userId, String unblockedUserId) async {
    // Implementation would unblock user
    throw UnimplementedError('unblockUser not implemented');
  }

  @override
  Future<List<UserModel>> getUserFriends(String userId) async {
    // Implementation would get user's friends
    throw UnimplementedError('getUserFriends not implemented');
  }

  @override
  Future<List<UserModel>> getUserBlockedUsers(String userId) async {
    // Implementation would get user's blocked users
    throw UnimplementedError('getUserBlockedUsers not implemented');
  }

  @override
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      // Get current user from Firebase Auth
      final auth = FirebaseAuth.instance;
      final currentUser = auth.currentUser;
      
      if (currentUser == null) {
        return null;
      }
      
      // Get user data from repository
      final userModel = await _userRepository.getById(currentUser.uid);
      
      if (userModel == null) {
        return null;
      }
      
      // Convert UserModel to Map for the profile screen
      return {
        'username': userModel.displayName,
        'email': userModel.email,
        'city': userModel.city,
        'level': userModel.preferences['level'] ?? 'Beginner',
        'bio': userModel.bio,
        'profilePicUrl': userModel.profileImageUrl,
        'games': userModel.statistics['gamesPlayed'] ?? 0,
        'mvps': userModel.statistics['mvps'] ?? 0,
        'sports': userModel.sports,
        'createdAt': userModel.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'updatedAt': userModel.updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };
    } catch (e) {
      AppLogger.error('Error getting user data: $e');
      return null;
    }
  }

  @override
  Future<bool> updateUserProfile(String userId, Map<String, dynamic> profileData) async {
    // Implementation would update user profile
    throw UnimplementedError('updateUserProfile not implemented');
  }

  @override
  Future<bool> updateUserSports(String userId, List<String> sports) async {
    // Implementation would update user sports
    throw UnimplementedError('updateUserSports not implemented');
  }

  @override
  Future<bool> updateUserLocation(String userId, Map<String, dynamic> locationData) async {
    // Implementation would update user location
    throw UnimplementedError('updateUserLocation not implemented');
  }
}