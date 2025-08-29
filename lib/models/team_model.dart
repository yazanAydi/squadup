import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    required String sport,
    required String createdBy,
    String? description,
    String? location,
    String? city,
    String? country,
    String? logoUrl,
    @Default([]) List<String> members,
    @Default([]) List<String> pendingRequests,
    @Default(0) int memberCount,
    @Default(0) int maxMembers,
    @Default({}) Map<String, dynamic> statistics,
    @Default({}) Map<String, dynamic> settings,
    @Default(false) bool isPublic,
    @Default(false) bool isActive,
    @Default(false) bool isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActivity,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}

/// Extension to add computed properties to TeamModel
extension TeamModelExtensions on TeamModel {
  /// Get current member count
  int get currentMemberCount => members.length;
}

/// Team statistics model
@freezed
class TeamStats with _$TeamStats {
  const factory TeamStats({
    @Default(0) int gamesPlayed,
    @Default(0) int gamesWon,
    @Default(0) int gamesLost,
    @Default(0) int tournamentsWon,
    @Default(0) int tournamentsParticipated,
    @Default(0.0) double winRate,
    @Default(0.0) double averageRating,
    @Default(0) int totalRating,
    @Default(0) int ratingCount,
    @Default(0) int totalPoints,
    @Default(0) int totalAssists,
    @Default(0) int totalRebounds,
  }) = _TeamStats;

  factory TeamStats.fromJson(Map<String, dynamic> json) =>
      _$TeamStatsFromJson(json);
}

/// Team settings model
@freezed
class TeamSettings with _$TeamSettings {
  const factory TeamSettings({
    @Default(true) bool allowJoinRequests,
    @Default(true) bool allowMemberInvites,
    @Default(false) bool requireApproval,
    @Default(false) bool allowMemberChat,
    @Default(false) bool allowMemberGames,
    @Default(10) int maxMembers,
    @Default([]) List<String> allowedSports,
    @Default([]) List<String> blockedUsers,
  }) = _TeamSettings;

  factory TeamSettings.fromJson(Map<String, dynamic> json) =>
      _$TeamSettingsFromJson(json);
}
