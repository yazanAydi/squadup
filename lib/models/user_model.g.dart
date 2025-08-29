// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String?,
      bio: json['bio'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      sports:
          (json['sports'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      statistics:
          (json['statistics'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      teams:
          (json['teams'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      games:
          (json['games'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      friends:
          (json['friends'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      blockedUsers:
          (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isVerified: json['isVerified'] as bool? ?? false,
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'username': instance.username,
      'bio': instance.bio,
      'city': instance.city,
      'country': instance.country,
      'profileImageUrl': instance.profileImageUrl,
      'sports': instance.sports,
      'preferences': instance.preferences,
      'statistics': instance.statistics,
      'teams': instance.teams,
      'games': instance.games,
      'friends': instance.friends,
      'blockedUsers': instance.blockedUsers,
      'isVerified': instance.isVerified,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$UserStatsImpl _$$UserStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsImpl(
      gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
      gamesWon: (json['gamesWon'] as num?)?.toInt() ?? 0,
      gamesLost: (json['gamesLost'] as num?)?.toInt() ?? 0,
      mvps: (json['mvps'] as num?)?.toInt() ?? 0,
      totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
      totalAssists: (json['totalAssists'] as num?)?.toInt() ?? 0,
      totalRebounds: (json['totalRebounds'] as num?)?.toInt() ?? 0,
      winRate: (json['winRate'] as num?)?.toDouble() ?? 0.0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRating: (json['totalRating'] as num?)?.toInt() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'gamesLost': instance.gamesLost,
      'mvps': instance.mvps,
      'totalPoints': instance.totalPoints,
      'totalAssists': instance.totalAssists,
      'totalRebounds': instance.totalRebounds,
      'winRate': instance.winRate,
      'averageRating': instance.averageRating,
      'totalRating': instance.totalRating,
      'ratingCount': instance.ratingCount,
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
  Map<String, dynamic> json,
) => _$UserPreferencesImpl(
  language: json['language'] as String? ?? 'en',
  theme: json['theme'] as String? ?? 'system',
  notifications: json['notifications'] as bool? ?? true,
  emailNotifications: json['emailNotifications'] as bool? ?? true,
  pushNotifications: json['pushNotifications'] as bool? ?? true,
  locationSharing: json['locationSharing'] as bool? ?? false,
  profileVisibility: json['profileVisibility'] as bool? ?? false,
  maxDistance: (json['maxDistance'] as num?)?.toInt() ?? 10,
  favoriteSports:
      (json['favoriteSports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  blockedSports:
      (json['blockedSports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$UserPreferencesImplToJson(
  _$UserPreferencesImpl instance,
) => <String, dynamic>{
  'language': instance.language,
  'theme': instance.theme,
  'notifications': instance.notifications,
  'emailNotifications': instance.emailNotifications,
  'pushNotifications': instance.pushNotifications,
  'locationSharing': instance.locationSharing,
  'profileVisibility': instance.profileVisibility,
  'maxDistance': instance.maxDistance,
  'favoriteSports': instance.favoriteSports,
  'blockedSports': instance.blockedSports,
};
