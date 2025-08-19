import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'converters/timestamp_converter.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@freezed
class Team with _$Team {
  const Team._();

  const factory Team({
    String? id,
    required String name,
    required String sport,
    required String location,
    @Default(0) int memberCount,
    @TimestampConverter() DateTime? createdAt,
    String? description,
    String? imageUrl,
    @Default(<String>[]) List<String> members,
    required String ownerId,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  factory Team.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return Team.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toFirestore() {
    final map = toJson();
    map.remove('id');
    return map;
  }
}
