import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../core/di/providers.dart';

class UserProfileController extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    final userService = ref.read(userServiceProvider);
    final userData = await userService.getUserData();
    if (userData == null) return null;
    
    // Convert Map to UserModel
    return UserModel.fromJson(userData);
  }

  Future<void> updateProfile(String userId, Map<String, dynamic> updates) async {
    final userService = ref.read(userServiceProvider);
    final success = await userService.updateUserProfile(userId, updates);
    
    if (success) {
      // Refresh the profile data
      ref.invalidateSelf();
    }
  }

  Future<void> updateSports(String userId, List<String> sports) async {
    final userService = ref.read(userServiceProvider);
    final success = await userService.updateUserSports(userId, sports);
    
    if (success) {
      ref.invalidateSelf();
    }
  }

  Future<void> updateLocation(String userId, Map<String, dynamic> locationData) async {
    final userService = ref.read(userServiceProvider);
    final success = await userService.updateUserLocation(userId, locationData);
    
    if (success) {
      ref.invalidateSelf();
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

final userProfileControllerProvider = AsyncNotifierProvider<UserProfileController, UserModel?>(() {
  return UserProfileController();
});
