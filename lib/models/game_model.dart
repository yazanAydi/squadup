import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';
part 'game_model.g.dart';

enum GameStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

enum GameType {
  @JsonValue('casual')
  casual,
  @JsonValue('competitive')
  competitive,
  @JsonValue('tournament')
  tournament,
}

@freezed
class GameModel with _$GameModel {
  const factory GameModel({
    required String id,
    required String name,
    required String sport,
    required String createdBy,
    String? description,
    String? location,
    String? city,
    String? country,
    String? venue,
    @Default([]) List<String> players,
    @Default([]) List<String> pendingRequests,
    @Default(0) int currentPlayers,
    @Default(0) int maxPlayers,
    @Default(0) int minPlayers,
    required DateTime gameDateTime,
    @Default(GameStatus.pending) GameStatus status,
    @Default(GameType.casual) GameType type,
    @Default({}) Map<String, dynamic> score,
    @Default({}) Map<String, dynamic> statistics,
    @Default({}) Map<String, dynamic> settings,
    @Default(false) bool isPublic,
    @Default(false) bool isFree,
    @Default(0.0) double price,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
  }) = _GameModel;

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);
}

/// Extension to add Firestore conversion methods and computed properties
extension GameModelFirestore on GameModel {
  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return toJson();
  }
  
  /// Get game title (alias for name)
  String get title => name;
  
  /// Get participants (alias for players)
  List<String> get participants => players;
}

/// Game score model
@freezed
class GameScore with _$GameScore {
  const factory GameScore({
    @Default({}) Map<String, int> teamScores,
    @Default({}) Map<String, int> playerScores,
    @Default({}) Map<String, dynamic> statistics,
    String? winner,
    String? mvp,
    @Default(false) bool isFinal,
  }) = _GameScore;

  factory GameScore.fromJson(Map<String, dynamic> json) =>
      _$GameScoreFromJson(json);
}

/// Game statistics model
@freezed
class GameStats with _$GameStats {
  const factory GameStats({
    @Default(0) int totalPoints,
    @Default(0) int totalAssists,
    @Default(0) int totalRebounds,
    @Default(0) int totalSteals,
    @Default(0) int totalBlocks,
    @Default(0) int totalFouls,
    @Default(0) int totalTurnovers,
    @Default(0.0) double fieldGoalPercentage,
    @Default(0.0) double threePointPercentage,
    @Default(0.0) double freeThrowPercentage,
    @Default(0) int totalMinutes,
    @Default(0) int totalSeconds,
  }) = _GameStats;

  factory GameStats.fromJson(Map<String, dynamic> json) =>
      _$GameStatsFromJson(json);
}

/// Game settings model
@freezed
class GameSettings with _$GameSettings {
  const factory GameSettings({
    @Default(true) bool allowJoinRequests,
    @Default(true) bool allowSpectators,
    @Default(false) bool requireApproval,
    @Default(false) bool allowChat,
    @Default(false) bool allowLiveUpdates,
    @Default(0) int maxSpectators,
    @Default([]) List<String> allowedSports,
    @Default([]) List<String> blockedUsers,
  }) = _GameSettings;

  factory GameSettings.fromJson(Map<String, dynamic> json) =>
      _$GameSettingsFromJson(json);
}
