// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
  id: json['id'] as String?,
  name: json['name'] as String,
  sport: json['sport'] as String,
  location: json['location'] as String,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  members:
      (json['members'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  ownerId: json['ownerId'] as String,
);

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sport': instance.sport,
      'location': instance.location,
      'memberCount': instance.memberCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'members': instance.members,
      'ownerId': instance.ownerId,
    };
