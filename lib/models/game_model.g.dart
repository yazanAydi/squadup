// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameModelImpl _$$GameModelImplFromJson(
  Map<String, dynamic> json,
) => _$GameModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  sport: json['sport'] as String,
  createdBy: json['createdBy'] as String,
  description: json['description'] as String?,
  location: json['location'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String?,
  venue: json['venue'] as String?,
  players:
      (json['players'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  pendingRequests:
      (json['pendingRequests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  currentPlayers: (json['currentPlayers'] as num?)?.toInt() ?? 0,
  maxPlayers: (json['maxPlayers'] as num?)?.toInt() ?? 0,
  minPlayers: (json['minPlayers'] as num?)?.toInt() ?? 0,
  gameDateTime: DateTime.parse(json['gameDateTime'] as String),
  status:
      $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
      GameStatus.pending,
  type: $enumDecodeNullable(_$GameTypeEnumMap, json['type']) ?? GameType.casual,
  score: json['score'] as Map<String, dynamic>? ?? const {},
  statistics: json['statistics'] as Map<String, dynamic>? ?? const {},
  settings: json['settings'] as Map<String, dynamic>? ?? const {},
  isPublic: json['isPublic'] as bool? ?? false,
  isFree: json['isFree'] as bool? ?? false,
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  currency: json['currency'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
);

Map<String, dynamic> _$$GameModelImplToJson(_$GameModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sport': instance.sport,
      'createdBy': instance.createdBy,
      'description': instance.description,
      'location': instance.location,
      'city': instance.city,
      'country': instance.country,
      'venue': instance.venue,
      'players': instance.players,
      'pendingRequests': instance.pendingRequests,
      'currentPlayers': instance.currentPlayers,
      'maxPlayers': instance.maxPlayers,
      'minPlayers': instance.minPlayers,
      'gameDateTime': instance.gameDateTime.toIso8601String(),
      'status': _$GameStatusEnumMap[instance.status]!,
      'type': _$GameTypeEnumMap[instance.type]!,
      'score': instance.score,
      'statistics': instance.statistics,
      'settings': instance.settings,
      'isPublic': instance.isPublic,
      'isFree': instance.isFree,
      'price': instance.price,
      'currency': instance.currency,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
    };

const _$GameStatusEnumMap = {
  GameStatus.pending: 'pending',
  GameStatus.active: 'active',
  GameStatus.completed: 'completed',
  GameStatus.cancelled: 'cancelled',
};

const _$GameTypeEnumMap = {
  GameType.casual: 'casual',
  GameType.competitive: 'competitive',
  GameType.tournament: 'tournament',
};

_$GameScoreImpl _$$GameScoreImplFromJson(Map<String, dynamic> json) =>
    _$GameScoreImpl(
      teamScores:
          (json['teamScores'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      playerScores:
          (json['playerScores'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      statistics: json['statistics'] as Map<String, dynamic>? ?? const {},
      winner: json['winner'] as String?,
      mvp: json['mvp'] as String?,
      isFinal: json['isFinal'] as bool? ?? false,
    );

Map<String, dynamic> _$$GameScoreImplToJson(_$GameScoreImpl instance) =>
    <String, dynamic>{
      'teamScores': instance.teamScores,
      'playerScores': instance.playerScores,
      'statistics': instance.statistics,
      'winner': instance.winner,
      'mvp': instance.mvp,
      'isFinal': instance.isFinal,
    };

_$GameStatsImpl _$$GameStatsImplFromJson(
  Map<String, dynamic> json,
) => _$GameStatsImpl(
  totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
  totalAssists: (json['totalAssists'] as num?)?.toInt() ?? 0,
  totalRebounds: (json['totalRebounds'] as num?)?.toInt() ?? 0,
  totalSteals: (json['totalSteals'] as num?)?.toInt() ?? 0,
  totalBlocks: (json['totalBlocks'] as num?)?.toInt() ?? 0,
  totalFouls: (json['totalFouls'] as num?)?.toInt() ?? 0,
  totalTurnovers: (json['totalTurnovers'] as num?)?.toInt() ?? 0,
  fieldGoalPercentage: (json['fieldGoalPercentage'] as num?)?.toDouble() ?? 0.0,
  threePointPercentage:
      (json['threePointPercentage'] as num?)?.toDouble() ?? 0.0,
  freeThrowPercentage: (json['freeThrowPercentage'] as num?)?.toDouble() ?? 0.0,
  totalMinutes: (json['totalMinutes'] as num?)?.toInt() ?? 0,
  totalSeconds: (json['totalSeconds'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$GameStatsImplToJson(_$GameStatsImpl instance) =>
    <String, dynamic>{
      'totalPoints': instance.totalPoints,
      'totalAssists': instance.totalAssists,
      'totalRebounds': instance.totalRebounds,
      'totalSteals': instance.totalSteals,
      'totalBlocks': instance.totalBlocks,
      'totalFouls': instance.totalFouls,
      'totalTurnovers': instance.totalTurnovers,
      'fieldGoalPercentage': instance.fieldGoalPercentage,
      'threePointPercentage': instance.threePointPercentage,
      'freeThrowPercentage': instance.freeThrowPercentage,
      'totalMinutes': instance.totalMinutes,
      'totalSeconds': instance.totalSeconds,
    };

_$GameSettingsImpl _$$GameSettingsImplFromJson(Map<String, dynamic> json) =>
    _$GameSettingsImpl(
      allowJoinRequests: json['allowJoinRequests'] as bool? ?? true,
      allowSpectators: json['allowSpectators'] as bool? ?? true,
      requireApproval: json['requireApproval'] as bool? ?? false,
      allowChat: json['allowChat'] as bool? ?? false,
      allowLiveUpdates: json['allowLiveUpdates'] as bool? ?? false,
      maxSpectators: (json['maxSpectators'] as num?)?.toInt() ?? 0,
      allowedSports:
          (json['allowedSports'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      blockedUsers:
          (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameSettingsImplToJson(_$GameSettingsImpl instance) =>
    <String, dynamic>{
      'allowJoinRequests': instance.allowJoinRequests,
      'allowSpectators': instance.allowSpectators,
      'requireApproval': instance.requireApproval,
      'allowChat': instance.allowChat,
      'allowLiveUpdates': instance.allowLiveUpdates,
      'maxSpectators': instance.maxSpectators,
      'allowedSports': instance.allowedSports,
      'blockedUsers': instance.blockedUsers,
    };
