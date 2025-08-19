import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'converters/timestamp_converter.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    String? id,
    String? displayName,
    String? email,
    String? photoUrl,
    String? city,
    @Default(<String, dynamic>{}) Map<String, dynamic> sports,
    @Default(<String>[]) List<String> teams,
    @Default(false) bool onboardingCompleted,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? lastUpdated,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return UserProfile.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toFirestore() {
    final map = toJson();
    map.remove('id');
    return map;
  }
}
