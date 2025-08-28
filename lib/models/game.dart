import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

/// Represents a game/event in the SquadUp app
class Game {
  final String id;
  final String title;
  final String description;
  final DateTime scheduledTime;
  final DateTime endTime;
  final GameLocation location;
  final String sport;
  final String skillLevel;
  final int maxPlayers;
  final int minPlayers;
  final double price;
  final String currency;
  final List<String> rules;
  final GameStatus status;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> participants;
  final List<String> waitlist;
  final List<String> declined;
  final Map<String, ParticipantStatus> participantStatuses;
  final bool isPrivate;
  final List<String> invitedUsers;
  final Map<String, dynamic> metadata;
  final String? imageUrl;
  final List<String> tags;
  final bool requiresCheckIn;
  final DateTime? checkInDeadline;
  final Map<String, DateTime> checkIns;

  const Game({
    required this.id,
    required this.title,
    required this.description,
    required this.scheduledTime,
    required this.endTime,
    required this.location,
    required this.sport,
    required this.skillLevel,
    required this.maxPlayers,
    required this.minPlayers,
    required this.price,
    required this.currency,
    required this.rules,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.participants,
    required this.waitlist,
    required this.declined,
    required this.participantStatuses,
    required this.isPrivate,
    required this.invitedUsers,
    required this.metadata,
    this.imageUrl,
    required this.tags,
    required this.requiresCheckIn,
    this.checkInDeadline,
    required this.checkIns,
  });

  /// Create a new game
  factory Game.create({
    required String title,
    required String description,
    required DateTime scheduledTime,
    required DateTime endTime,
    required GameLocation location,
    required String sport,
    required String skillLevel,
    required int maxPlayers,
    required int minPlayers,
    required double price,
    required String currency,
    required List<String> rules,
    required String createdBy,
    List<String> tags = const [],
    bool isPrivate = false,
    bool requiresCheckIn = false,
    DateTime? checkInDeadline,
  }) {
    final now = DateTime.now();
    return Game(
      id: '', // Will be set by Firestore
      title: title,
      description: description,
      scheduledTime: scheduledTime,
      endTime: endTime,
      location: location,
      sport: sport,
      skillLevel: skillLevel,
      maxPlayers: maxPlayers,
      minPlayers: minPlayers,
      price: price,
      currency: currency,
      rules: rules,
      status: GameStatus.upcoming,
      createdBy: createdBy,
      createdAt: now,
      updatedAt: now,
      participants: [createdBy], // Creator is automatically a participant
      waitlist: [],
      declined: [],
      participantStatuses: {
        createdBy: ParticipantStatus.confirmed,
      },
      isPrivate: isPrivate,
      invitedUsers: [],
      metadata: {},
      tags: tags,
      requiresCheckIn: requiresCheckIn,
      checkInDeadline: checkInDeadline,
      checkIns: {},
    );
  }

  /// Copy with modifications
  Game copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? scheduledTime,
    DateTime? endTime,
    GameLocation? location,
    String? sport,
    String? skillLevel,
    int? maxPlayers,
    int? minPlayers,
    double? price,
    String? currency,
    List<String>? rules,
    GameStatus? status,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? participants,
    List<String>? waitlist,
    List<String>? declined,
    Map<String, ParticipantStatus>? participantStatuses,
    bool? isPrivate,
    List<String>? invitedUsers,
    Map<String, dynamic>? metadata,
    String? imageUrl,
    List<String>? tags,
    bool? requiresCheckIn,
    DateTime? checkInDeadline,
    Map<String, DateTime>? checkIns,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      sport: sport ?? this.sport,
      skillLevel: skillLevel ?? this.skillLevel,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      minPlayers: minPlayers ?? this.minPlayers,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      rules: rules ?? this.rules,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      participants: participants ?? this.participants,
      waitlist: waitlist ?? this.waitlist,
      declined: declined ?? this.declined,
      participantStatuses: participantStatuses ?? this.participantStatuses,
      isPrivate: isPrivate ?? this.isPrivate,
      invitedUsers: invitedUsers ?? this.invitedUsers,
      metadata: metadata ?? this.metadata,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      requiresCheckIn: requiresCheckIn ?? this.requiresCheckIn,
      checkInDeadline: checkInDeadline ?? this.checkInDeadline,
      checkIns: checkIns ?? this.checkIns,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'scheduledTime': Timestamp.fromDate(scheduledTime),
      'endTime': Timestamp.fromDate(endTime),
      'location': location.toFirestore(),
      'sport': sport,
      'skillLevel': skillLevel,
      'maxPlayers': maxPlayers,
      'minPlayers': minPlayers,
      'price': price,
      'currency': currency,
      'rules': rules,
      'status': status.name,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'participants': participants,
      'waitlist': waitlist,
      'declined': declined,
      'participantStatuses': participantStatuses.map(
        (key, value) => MapEntry(key, value.name),
      ),
      'isPrivate': isPrivate,
      'invitedUsers': invitedUsers,
      'metadata': metadata,
      'imageUrl': imageUrl,
      'tags': tags,
      'requiresCheckIn': requiresCheckIn,
      'checkInDeadline': checkInDeadline != null 
          ? Timestamp.fromDate(checkInDeadline!) 
          : null,
      'checkIns': checkIns.map(
        (key, value) => MapEntry(key, Timestamp.fromDate(value)),
      ),
    };
  }

  /// Create from Firestore document
  factory Game.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Game(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      scheduledTime: (data['scheduledTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      location: GameLocation.fromFirestore(data['location']),
      sport: data['sport'] ?? '',
      skillLevel: data['skillLevel'] ?? '',
      maxPlayers: data['maxPlayers'] ?? 0,
      minPlayers: data['minPlayers'] ?? 0,
      price: (data['price'] ?? 0.0).toDouble(),
      currency: data['currency'] ?? 'USD',
      rules: List<String>.from(data['rules'] ?? []),
      status: GameStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => GameStatus.upcoming,
      ),
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      participants: List<String>.from(data['participants'] ?? []),
      waitlist: List<String>.from(data['waitlist'] ?? []),
      declined: List<String>.from(data['declined'] ?? []),
      participantStatuses: Map<String, ParticipantStatus>.fromEntries(
        (data['participantStatuses'] as Map<String, dynamic>? ?? {}).entries.map(
          (e) => MapEntry(e.key, ParticipantStatus.values.firstWhere(
            (status) => status.name == e.value,
            orElse: () => ParticipantStatus.pending,
          )),
        ),
      ),
      isPrivate: data['isPrivate'] ?? false,
      invitedUsers: List<String>.from(data['invitedUsers'] ?? []),
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
      imageUrl: data['imageUrl'],
      tags: List<String>.from(data['tags'] ?? []),
      requiresCheckIn: data['requiresCheckIn'] ?? false,
      checkInDeadline: data['checkInDeadline'] != null 
          ? (data['checkInDeadline'] as Timestamp).toDate() 
          : null,
      checkIns: Map<String, DateTime>.fromEntries(
        (data['checkIns'] as Map<String, dynamic>? ?? {}).entries.map(
          (e) => MapEntry(e.key, (e.value as Timestamp).toDate()),
        ),
      ),
    );
  }

  /// Convert to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'scheduledTime': scheduledTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location.toJson(),
      'sport': sport,
      'skillLevel': skillLevel,
      'maxPlayers': maxPlayers,
      'minPlayers': minPlayers,
      'price': price,
      'currency': currency,
      'rules': rules,
      'status': status.name,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'participants': participants,
      'waitlist': waitlist,
      'declined': declined,
      'participantStatuses': participantStatuses.map(
        (key, value) => MapEntry(key, value.name),
      ),
      'isPrivate': isPrivate,
      'invitedUsers': invitedUsers,
      'metadata': metadata,
      'imageUrl': imageUrl,
      'tags': tags,
      'requiresCheckIn': requiresCheckIn,
      'checkInDeadline': checkInDeadline?.toIso8601String(),
      'checkIns': checkIns.map(
        (key, value) => MapEntry(key, value.toIso8601String()),
      ),
    };
  }

  /// Create from JSON
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      scheduledTime: DateTime.parse(json['scheduledTime']),
      endTime: DateTime.parse(json['endTime']),
      location: GameLocation.fromJson(json['location']),
      sport: json['sport'] ?? '',
      skillLevel: json['skillLevel'] ?? '',
      maxPlayers: json['maxPlayers'] ?? 0,
      minPlayers: json['minPlayers'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'USD',
      rules: List<String>.from(json['rules'] ?? []),
      status: GameStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => GameStatus.upcoming,
      ),
      createdBy: json['createdBy'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      participants: List<String>.from(json['participants'] ?? []),
      waitlist: List<String>.from(json['waitlist'] ?? []),
      declined: List<String>.from(json['declined'] ?? []),
      participantStatuses: Map<String, ParticipantStatus>.fromEntries(
        (json['participantStatuses'] as Map<String, dynamic>? ?? {}).entries.map(
          (e) => MapEntry(e.key, ParticipantStatus.values.firstWhere(
            (status) => status.name == e.value,
            orElse: () => ParticipantStatus.pending,
          )),
        ),
      ),
      isPrivate: json['isPrivate'] ?? false,
      invitedUsers: List<String>.from(json['invitedUsers'] ?? []),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      imageUrl: json['imageUrl'],
      tags: List<String>.from(json['tags'] ?? []),
      requiresCheckIn: json['requiresCheckIn'] ?? false,
      checkInDeadline: json['checkInDeadline'] != null 
          ? DateTime.parse(json['checkInDeadline']) 
          : null,
      checkIns: Map<String, DateTime>.fromEntries(
        (json['checkIns'] as Map<String, dynamic>? ?? {}).entries.map(
          (e) => MapEntry(e.key, DateTime.parse(e.value)),
        ),
      ),
    );
  }

  /// Check if a user can join the game
  bool canJoin(String userId) {
    if (participants.contains(userId) || waitlist.contains(userId)) {
      return false; // Already participating or on waitlist
    }
    if (status != GameStatus.upcoming) {
      return false; // Game is not open for joining
    }
    if (participants.length < maxPlayers) {
      return true; // Direct join
    }
    return true; // Can join waitlist
  }

  /// Join the game
  Game join(String userId) {
    if (!canJoin(userId)) {
      return this;
    }

    if (participants.length < maxPlayers) {
      // Direct join
      final newParticipants = List<String>.from(participants)..add(userId);
      final newStatuses = Map<String, ParticipantStatus>.from(participantStatuses)
        ..[userId] = ParticipantStatus.confirmed;
      
      return copyWith(
        participants: newParticipants,
        participantStatuses: newStatuses,
        updatedAt: DateTime.now(),
      );
    } else {
      // Join waitlist
      final newWaitlist = List<String>.from(waitlist)..add(userId);
      final newStatuses = Map<String, ParticipantStatus>.from(participantStatuses)
        ..[userId] = ParticipantStatus.waitlisted;
      
      return copyWith(
        waitlist: newWaitlist,
        participantStatuses: newStatuses,
        updatedAt: DateTime.now(),
      );
    }
  }

  /// Leave the game
  Game leave(String userId) {
    final newParticipants = List<String>.from(participants)..remove(userId);
    final newWaitlist = List<String>.from(waitlist)..remove(userId);
    final newStatuses = Map<String, ParticipantStatus>.from(participantStatuses)
      ..remove(userId);

    // Promote someone from waitlist if possible
    if (newParticipants.length < maxPlayers && newWaitlist.isNotEmpty) {
      final promotedUser = newWaitlist.removeAt(0);
      newParticipants.add(promotedUser);
      newStatuses[promotedUser] = ParticipantStatus.confirmed;
    }

    return copyWith(
      participants: newParticipants,
      waitlist: newWaitlist,
      participantStatuses: newStatuses,
      updatedAt: DateTime.now(),
    );
  }

  /// Check in a participant
  Game checkIn(String userId) {
    if (!participants.contains(userId)) {
      return this; // Can't check in if not a participant
    }

    final newCheckIns = Map<String, DateTime>.from(checkIns)
      ..[userId] = DateTime.now();

    return copyWith(
      checkIns: newCheckIns,
      updatedAt: DateTime.now(),
    );
  }

  /// Get current participation count
  int get currentPlayerCount => participants.length;

  /// Check if game is full
  bool get isFull => participants.length >= maxPlayers;

  /// Check if game has waitlist
  bool get hasWaitlist => waitlist.isNotEmpty;

  /// Get available spots
  int get availableSpots => maxPlayers - participants.length;

  /// Check if game is happening soon (within 24 hours)
  bool get isHappeningSoon {
    final now = DateTime.now();
    final timeUntilGame = scheduledTime.difference(now);
    return timeUntilGame.inHours <= 24 && timeUntilGame.isNegative == false;
  }

  /// Check if game is ongoing
  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(scheduledTime) && now.isBefore(endTime);
  }

  /// Check if game is finished
  bool get isFinished => DateTime.now().isAfter(endTime);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Game && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Game(id: $id, title: $title, sport: $sport, scheduledTime: $scheduledTime, participants: ${participants.length}/$maxPlayers)';
  }
}

/// Game location with coordinates and address
class GameLocation {
  final double latitude;
  final double longitude;
  final String address;
  final String city;
  final String state;
  final String country;
  final String? venueName;
  final String? venueDetails;

  const GameLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    this.venueName,
    this.venueDetails,
  });

  /// Create from current location
  factory GameLocation.fromPosition(Position position, String address) {
    return GameLocation(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
      city: '', // Will be filled by geocoding
      state: '',
      country: '',
    );
  }

  /// Copy with modifications
  GameLocation copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? state,
    String? country,
    String? venueName,
    String? venueDetails,
  }) {
    return GameLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      venueName: venueName ?? this.venueName,
      venueDetails: venueDetails ?? this.venueDetails,
    );
  }

  /// Calculate distance to another location
  double distanceTo(GameLocation other) {
    return Geolocator.distanceBetween(
      latitude,
      longitude,
      other.latitude,
      other.longitude,
    );
  }

  /// Convert to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'venueName': venueName,
      'venueDetails': venueDetails,
    };
  }

  /// Create from Firestore data
  factory GameLocation.fromFirestore(Map<String, dynamic> data) {
    return GameLocation(
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      country: data['country'] ?? '',
      venueName: data['venueName'],
      venueDetails: data['venueDetails'],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'venueName': venueName,
      'venueDetails': venueDetails,
    };
  }

  /// Create from JSON
  factory GameLocation.fromJson(Map<String, dynamic> json) {
    return GameLocation(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      venueName: json['venueName'],
      venueDetails: json['venueDetails'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GameLocation &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'GameLocation(lat: $latitude, lng: $longitude, address: $address)';
  }
}

/// Game status enum
enum GameStatus {
  upcoming,
  ongoing,
  finished,
  cancelled,
  postponed,
}

/// Participant status enum
enum ParticipantStatus {
  pending,
  confirmed,
  waitlisted,
  declined,
  checkedIn,
  noShow,
}
