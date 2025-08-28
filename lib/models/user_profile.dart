import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a user profile in the SquadUp app
class UserProfile {
  final String? id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final String? city;
  final Map<String, dynamic> sports;
  final List<String> teams;
  final bool onboardingCompleted;
  final DateTime? createdAt;
  final DateTime? lastUpdated;

  const UserProfile({
    this.id,
    this.displayName,
    this.email,
    this.photoUrl,
    this.city,
    this.sports = const <String, dynamic>{},
    this.teams = const <String>[],
    this.onboardingCompleted = false,
    this.createdAt,
    this.lastUpdated,
  });

  /// Create a copy with updated fields
  UserProfile copyWith({
    String? id,
    String? displayName,
    String? email,
    String? photoUrl,
    String? city,
    Map<String, dynamic>? sports,
    List<String>? teams,
    bool? onboardingCompleted,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return UserProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      city: city ?? this.city,
      sports: sports ?? this.sports,
      teams: teams ?? this.teams,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'city': city,
      'sports': sports,
      'teams': teams,
      'onboardingCompleted': onboardingCompleted,
      'createdAt': createdAt?.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  /// Create from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      city: json['city'] as String?,
      sports: json['sports'] != null
          ? Map<String, dynamic>.from(json['sports'] as Map)
          : const <String, dynamic>{},
      teams: json['teams'] != null
          ? List<String>.from(json['teams'] as List)
          : const <String>[],
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }

  /// Create from Firestore document
  factory UserProfile.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    
    // Handle Firestore Timestamp conversion
    Map<String, dynamic> processedData = Map<String, dynamic>.from(data);
    
    // Convert Timestamp to ISO string for createdAt
    if (processedData['createdAt'] != null && 
        processedData['createdAt'].runtimeType.toString().contains('Timestamp')) {
      processedData['createdAt'] = (processedData['createdAt'] as dynamic).toDate().toIso8601String();
    }
    
    // Convert Timestamp to ISO string for lastUpdated
    if (processedData['lastUpdated'] != null && 
        processedData['lastUpdated'].runtimeType.toString().contains('Timestamp')) {
      processedData['lastUpdated'] = (processedData['lastUpdated'] as dynamic).toDate().toIso8601String();
    }
    
    return UserProfile.fromJson(processedData).copyWith(id: doc.id);
  }

  /// Convert to Firestore format (excludes id)
  Map<String, dynamic> toFirestore() {
    final map = toJson();
    map.remove('id');
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.id == id &&
        other.displayName == displayName &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.city == city &&
        other.sports == sports &&
        other.teams == teams &&
        other.onboardingCompleted == onboardingCompleted &&
        other.createdAt == createdAt &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      displayName,
      email,
      photoUrl,
      city,
      sports,
      teams,
      onboardingCompleted,
      createdAt,
      lastUpdated,
    );
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, displayName: $displayName, email: $email, photoUrl: $photoUrl, city: $city, sports: $sports, teams: $teams, onboardingCompleted: $onboardingCompleted, createdAt: $createdAt, lastUpdated: $lastUpdated)';
  }
}
