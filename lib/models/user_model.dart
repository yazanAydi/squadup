import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String displayName,
    String? username,
    String? bio,
    String? city,
    String? country,
    String? profileImageUrl,
    @Default({}) Map<String, String> sports,
    @Default({}) Map<String, dynamic> preferences,
    @Default({}) Map<String, int> statistics,
    @Default([]) List<String> teams,
    @Default([]) List<String> games,
    @Default([]) List<String> friends,
    @Default([]) List<String> blockedUsers,
    @Default(false) bool isVerified,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// User statistics model
@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    @Default(0) int gamesPlayed,
    @Default(0) int gamesWon,
    @Default(0) int gamesLost,
    @Default(0) int mvps,
    @Default(0) int totalPoints,
    @Default(0) int totalAssists,
    @Default(0) int totalRebounds,
    @Default(0.0) double winRate,
    @Default(0.0) double averageRating,
    @Default(0) int totalRating,
    @Default(0) int ratingCount,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}

/// User preferences model
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default('en') String language,
    @Default('system') String theme,
    @Default(true) bool notifications,
    @Default(true) bool emailNotifications,
    @Default(true) bool pushNotifications,
    @Default(false) bool locationSharing,
    @Default(false) bool profileVisibility,
    @Default(10) int maxDistance,
    @Default([]) List<String> favoriteSports,
    @Default([]) List<String> blockedSports,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}
