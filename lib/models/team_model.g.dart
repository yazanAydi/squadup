// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamModelImpl _$$TeamModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      sport: json['sport'] as String,
      createdBy: json['createdBy'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      logoUrl: json['logoUrl'] as String?,
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      pendingRequests:
          (json['pendingRequests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      maxMembers: (json['maxMembers'] as num?)?.toInt() ?? 0,
      statistics: json['statistics'] as Map<String, dynamic>? ?? const {},
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
      isPublic: json['isPublic'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastActivity: json['lastActivity'] == null
          ? null
          : DateTime.parse(json['lastActivity'] as String),
    );

Map<String, dynamic> _$$TeamModelImplToJson(_$TeamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sport': instance.sport,
      'createdBy': instance.createdBy,
      'description': instance.description,
      'location': instance.location,
      'city': instance.city,
      'country': instance.country,
      'logoUrl': instance.logoUrl,
      'members': instance.members,
      'pendingRequests': instance.pendingRequests,
      'memberCount': instance.memberCount,
      'maxMembers': instance.maxMembers,
      'statistics': instance.statistics,
      'settings': instance.settings,
      'isPublic': instance.isPublic,
      'isActive': instance.isActive,
      'isVerified': instance.isVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastActivity': instance.lastActivity?.toIso8601String(),
    };

_$TeamStatsImpl _$$TeamStatsImplFromJson(Map<String, dynamic> json) =>
    _$TeamStatsImpl(
      gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
      gamesWon: (json['gamesWon'] as num?)?.toInt() ?? 0,
      gamesLost: (json['gamesLost'] as num?)?.toInt() ?? 0,
      tournamentsWon: (json['tournamentsWon'] as num?)?.toInt() ?? 0,
      tournamentsParticipated:
          (json['tournamentsParticipated'] as num?)?.toInt() ?? 0,
      winRate: (json['winRate'] as num?)?.toDouble() ?? 0.0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRating: (json['totalRating'] as num?)?.toInt() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
      totalAssists: (json['totalAssists'] as num?)?.toInt() ?? 0,
      totalRebounds: (json['totalRebounds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TeamStatsImplToJson(_$TeamStatsImpl instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'gamesLost': instance.gamesLost,
      'tournamentsWon': instance.tournamentsWon,
      'tournamentsParticipated': instance.tournamentsParticipated,
      'winRate': instance.winRate,
      'averageRating': instance.averageRating,
      'totalRating': instance.totalRating,
      'ratingCount': instance.ratingCount,
      'totalPoints': instance.totalPoints,
      'totalAssists': instance.totalAssists,
      'totalRebounds': instance.totalRebounds,
    };

_$TeamSettingsImpl _$$TeamSettingsImplFromJson(Map<String, dynamic> json) =>
    _$TeamSettingsImpl(
      allowJoinRequests: json['allowJoinRequests'] as bool? ?? true,
      allowMemberInvites: json['allowMemberInvites'] as bool? ?? true,
      requireApproval: json['requireApproval'] as bool? ?? false,
      allowMemberChat: json['allowMemberChat'] as bool? ?? false,
      allowMemberGames: json['allowMemberGames'] as bool? ?? false,
      maxMembers: (json['maxMembers'] as num?)?.toInt() ?? 10,
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

Map<String, dynamic> _$$TeamSettingsImplToJson(_$TeamSettingsImpl instance) =>
    <String, dynamic>{
      'allowJoinRequests': instance.allowJoinRequests,
      'allowMemberInvites': instance.allowMemberInvites,
      'requireApproval': instance.requireApproval,
      'allowMemberChat': instance.allowMemberChat,
      'allowMemberGames': instance.allowMemberGames,
      'maxMembers': instance.maxMembers,
      'allowedSports': instance.allowedSports,
      'blockedUsers': instance.blockedUsers,
    };
