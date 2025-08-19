import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../core/di/providers.dart';

class UserProfileController extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    final userService = ref.read(userServiceProvider);
    final userData = await userService.getUserData();
    if (userData == null) return null;
    
    // Convert Map to UserProfile model
    return UserProfile.fromJson(userData);
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    final userService = ref.read(userServiceProvider);
    final success = await userService.updateUserProfile(updates);
    
    if (success) {
      // Refresh the profile data
      ref.invalidateSelf();
    }
  }

  Future<void> updateSports(Map<String, String> sports) async {
    final userService = ref.read(userServiceProvider);
    final success = await userService.updateUserSports(sports);
    
    if (success) {
      ref.invalidateSelf();
    }
  }

  Future<void> updateLocation(String city) async {
    final userService = ref.read(userServiceProvider);
    final success = await userService.updateUserLocation(city);
    
    if (success) {
      ref.invalidateSelf();
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

final userProfileControllerProvider = AsyncNotifierProvider<UserProfileController, UserProfile?>(() {
  return UserProfileController();
});
