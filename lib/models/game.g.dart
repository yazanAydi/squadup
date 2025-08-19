// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
  id: json['id'] as String?,
  title: json['title'] as String,
  sport: json['sport'] as String,
  location: json['location'] as String,
  scheduledAt: const TimestampConverter().fromJson(json['scheduledAt']),
  description: json['description'] as String?,
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  maxPlayers: (json['maxPlayers'] as num?)?.toInt() ?? 0,
  hostId: json['hostId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sport': instance.sport,
      'location': instance.location,
      'scheduledAt': const TimestampConverter().toJson(instance.scheduledAt),
      'description': instance.description,
      'participants': instance.participants,
      'maxPlayers': instance.maxPlayers,
      'hostId': instance.hostId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
