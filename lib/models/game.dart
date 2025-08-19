import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'converters/timestamp_converter.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  const Game._();

  const factory Game({
    String? id,
    required String title,
    required String sport,
    required String location,
    @TimestampConverter() DateTime? scheduledAt,
    String? description,
    @Default(<String>[]) List<String> participants,
    @Default(0) int maxPlayers,
    required String hostId,
    @TimestampConverter() DateTime? createdAt,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  factory Game.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return Game.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toFirestore() {
    final map = toJson();
    map.remove('id');
    return map;
  }
}
