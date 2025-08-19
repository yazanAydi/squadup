// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      city: json['city'] as String?,
      sports:
          json['sports'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      teams:
          (json['teams'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      lastUpdated: const TimestampConverter().fromJson(json['lastUpdated']),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'city': instance.city,
      'sports': instance.sports,
      'teams': instance.teams,
      'onboardingCompleted': instance.onboardingCompleted,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'lastUpdated': const TimestampConverter().toJson(instance.lastUpdated),
    };
