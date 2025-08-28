import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a team in the SquadUp app
class Team {
  final String id;
  final String name;
  final String description;
  final String sport;
  final String skillLevel;
  final String city;
  final String? photoUrl;
  final String? motto;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Team composition
  final List<TeamMember> members;
  final List<String> adminIds;
  final List<String> captainIds;
  final int maxMembers;
  final bool isRecruiting;
  final bool isActive;
  
  // Team settings
  final double? monthlyFee;
  final String? currency;
  final bool requiresTryout;
  final String? tryoutDetails;
  final List<String> requirements;
  final Map<String, String> rules;
  
  // Chat and communication
  final String chatChannelId;
  final List<TeamInvitation> pendingInvitations;
  final List<TeamRequest> joinRequests;
  
  // Team statistics
  final int gamesPlayed;
  final int gamesWon;
  final int totalPoints;
  final double winRate;
  
  // Location and scheduling
  final TeamLocation? location;
  final List<String> practiceDays;
  final String? practiceTime;
  final String? practiceLocation;

  const Team({
    required this.id,
    required this.name,
    required this.description,
    required this.sport,
    required this.skillLevel,
    required this.city,
    this.photoUrl,
    this.motto,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
    required this.adminIds,
    required this.captainIds,
    required this.maxMembers,
    required this.isRecruiting,
    required this.isActive,
    this.monthlyFee,
    this.currency,
    required this.requiresTryout,
    this.tryoutDetails,
    required this.requirements,
    required this.rules,
    required this.chatChannelId,
    required this.pendingInvitations,
    required this.joinRequests,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.totalPoints,
    required this.winRate,
    this.location,
    required this.practiceDays,
    this.practiceTime,
    this.practiceLocation,
  });

  /// Create a new team
  factory Team.create({
    required String name,
    required String description,
    required String sport,
    required String skillLevel,
    required String city,
    String? photoUrl,
    String? motto,
    required String createdBy,
    int maxMembers = 20,
    double? monthlyFee,
    String? currency,
    bool requiresTryout = false,
    String? tryoutDetails,
    List<String> requirements = const [],
    Map<String, String> rules = const {},
    TeamLocation? location,
    List<String> practiceDays = const [],
    String? practiceTime,
    String? practiceLocation,
  }) {
    final now = DateTime.now();
    final chatChannelId = 'team_${DateTime.now().millisecondsSinceEpoch}';
    
    return Team(
      id: '',
      name: name,
      description: description,
      sport: sport,
      skillLevel: skillLevel,
      city: city,
      photoUrl: photoUrl,
      motto: motto,
      createdBy: createdBy,
      createdAt: now,
      updatedAt: now,
      members: [
        TeamMember(
          userId: createdBy,
          role: TeamRole.captain,
          joinedAt: now,
          isActive: true,
        ),
      ],
      adminIds: [createdBy],
      captainIds: [createdBy],
      maxMembers: maxMembers,
      isRecruiting: true,
      isActive: true,
      monthlyFee: monthlyFee,
      currency: currency,
      requiresTryout: requiresTryout,
      tryoutDetails: tryoutDetails,
      requirements: requirements,
      rules: rules,
      chatChannelId: chatChannelId,
      pendingInvitations: [],
      joinRequests: [],
      gamesPlayed: 0,
      gamesWon: 0,
      totalPoints: 0,
      winRate: 0.0,
      location: location,
      practiceDays: practiceDays,
      practiceTime: practiceTime,
      practiceLocation: practiceLocation,
    );
  }

  /// Create from Firestore document
  factory Team.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null');
    }

    // Convert Firestore Timestamps to DateTime
    DateTime? createdAt;
    DateTime? updatedAt;
    
    if (data['createdAt'] is Timestamp) {
      createdAt = (data['createdAt'] as Timestamp).toDate();
    }
    if (data['updatedAt'] is Timestamp) {
      updatedAt = (data['updatedAt'] as Timestamp).toDate();
    }

    // Parse members
    final membersData = data['members'] as List<dynamic>? ?? [];
    final members = membersData.map((memberData) {
      if (memberData is Map<String, dynamic>) {
        return TeamMember.fromJson(memberData);
      }
      return null;
    }).whereType<TeamMember>().toList();

    // Parse invitations
    final invitationsData = data['pendingInvitations'] as List<dynamic>? ?? [];
    final pendingInvitations = invitationsData.map((invData) {
      if (invData is Map<String, dynamic>) {
        return TeamInvitation.fromJson(invData);
      }
      return null;
    }).whereType<TeamInvitation>().toList();

    // Parse join requests
    final requestsData = data['joinRequests'] as List<dynamic>? ?? [];
    final joinRequests = requestsData.map((reqData) {
      if (reqData is Map<String, dynamic>) {
        return TeamRequest.fromJson(reqData);
      }
      return null;
    }).whereType<TeamRequest>().toList();

    // Parse location
    TeamLocation? location;
    if (data['location'] is Map<String, dynamic>) {
      location = TeamLocation.fromJson(data['location'] as Map<String, dynamic>);
    }

    return Team(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      sport: data['sport'] ?? '',
      skillLevel: data['skillLevel'] ?? '',
      city: data['city'] ?? '',
      photoUrl: data['photoUrl'],
      motto: data['motto'],
      createdBy: data['createdBy'] ?? '',
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      members: members,
      adminIds: List<String>.from(data['adminIds'] ?? []),
      captainIds: List<String>.from(data['captainIds'] ?? []),
      maxMembers: data['maxMembers'] ?? 20,
      isRecruiting: data['isRecruiting'] ?? true,
      isActive: data['isActive'] ?? true,
      monthlyFee: data['monthlyFee']?.toDouble(),
      currency: data['currency'],
      requiresTryout: data['requiresTryout'] ?? false,
      tryoutDetails: data['tryoutDetails'],
      requirements: List<String>.from(data['requirements'] ?? []),
      rules: Map<String, String>.from(data['rules'] ?? {}),
      chatChannelId: data['chatChannelId'] ?? '',
      pendingInvitations: pendingInvitations,
      joinRequests: joinRequests,
      gamesPlayed: data['gamesPlayed'] ?? 0,
      gamesWon: data['gamesWon'] ?? 0,
      totalPoints: data['totalPoints'] ?? 0,
      winRate: data['winRate']?.toDouble() ?? 0.0,
      location: location,
      practiceDays: List<String>.from(data['practiceDays'] ?? []),
      practiceTime: data['practiceTime'],
      practiceLocation: data['practiceLocation'],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sport': sport,
      'skillLevel': skillLevel,
      'city': city,
      'photoUrl': photoUrl,
      'motto': motto,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'members': members.map((member) => member.toJson()).toList(),
      'adminIds': adminIds,
      'captainIds': captainIds,
      'maxMembers': maxMembers,
      'isRecruiting': isRecruiting,
      'isActive': isActive,
      'monthlyFee': monthlyFee,
      'currency': currency,
      'requiresTryout': requiresTryout,
      'tryoutDetails': tryoutDetails,
      'requirements': requirements,
      'rules': rules,
      'chatChannelId': chatChannelId,
      'pendingInvitations': pendingInvitations.map((inv) => inv.toJson()).toList(),
      'joinRequests': joinRequests.map((req) => req.toJson()).toList(),
      'gamesPlayed': gamesPlayed,
      'gamesWon': gamesWon,
      'totalPoints': totalPoints,
      'winRate': winRate,
      'location': location?.toJson(),
      'practiceDays': practiceDays,
      'practiceTime': practiceTime,
      'practiceLocation': practiceLocation,
    };
  }

  /// Convert to Firestore format (excludes id)
  Map<String, dynamic> toFirestore() {
    final map = toJson();
    map.remove('id');
    
    // Convert DateTime to Timestamp for Firestore
    if (map['createdAt'] != null) {
      map['createdAt'] = Timestamp.fromDate(createdAt);
    }
    if (map['updatedAt'] != null) {
      map['updatedAt'] = Timestamp.fromDate(updatedAt);
    }
    
    return map;
  }

  /// Create a copy with updated fields
  Team copyWith({
    String? id,
    String? name,
    String? description,
    String? sport,
    String? skillLevel,
    String? city,
    String? photoUrl,
    String? motto,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TeamMember>? members,
    List<String>? adminIds,
    List<String>? captainIds,
    int? maxMembers,
    bool? isRecruiting,
    bool? isActive,
    double? monthlyFee,
    String? currency,
    bool? requiresTryout,
    String? tryoutDetails,
    List<String>? requirements,
    Map<String, String>? rules,
    String? chatChannelId,
    List<TeamInvitation>? pendingInvitations,
    List<TeamRequest>? joinRequests,
    int? gamesPlayed,
    int? gamesWon,
    int? totalPoints,
    double? winRate,
    TeamLocation? location,
    List<String>? practiceDays,
    String? practiceTime,
    String? practiceLocation,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sport: sport ?? this.sport,
      skillLevel: skillLevel ?? this.skillLevel,
      city: city ?? this.city,
      photoUrl: photoUrl ?? this.photoUrl,
      motto: motto ?? this.motto,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      members: members ?? this.members,
      adminIds: adminIds ?? this.adminIds,
      captainIds: captainIds ?? this.captainIds,
      maxMembers: maxMembers ?? this.maxMembers,
      isRecruiting: isRecruiting ?? this.isRecruiting,
      isActive: isActive ?? this.isActive,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      currency: currency ?? this.currency,
      requiresTryout: requiresTryout ?? this.requiresTryout,
      tryoutDetails: tryoutDetails ?? this.tryoutDetails,
      requirements: requirements ?? this.requirements,
      rules: rules ?? this.rules,
      chatChannelId: chatChannelId ?? this.chatChannelId,
      pendingInvitations: pendingInvitations ?? this.pendingInvitations,
      joinRequests: joinRequests ?? this.joinRequests,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      gamesWon: gamesWon ?? this.gamesWon,
      totalPoints: totalPoints ?? this.totalPoints,
      winRate: winRate ?? this.winRate,
      location: location ?? this.location,
      practiceDays: practiceDays ?? this.practiceDays,
      practiceTime: practiceTime ?? this.practiceTime,
      practiceLocation: practiceLocation ?? this.practiceLocation,
    );
  }

  // Computed properties
  int get currentMemberCount => members.where((m) => m.isActive).length;
  bool get isFull => currentMemberCount >= maxMembers;
  bool get hasVacancies => currentMemberCount < maxMembers;
  double get fillPercentage => currentMemberCount / maxMembers;
  
  bool isUserCaptain(String userId) => captainIds.contains(userId);
  bool isUserAdmin(String userId) => adminIds.contains(userId);
  bool isUserMember(String userId) => members.any((m) => m.userId == userId && m.isActive);
  
  List<TeamMember> get activeMembers => members.where((m) => m.isActive).toList();
  List<TeamMember> get inactiveMembers => members.where((m) => !m.isActive).toList();
  
  bool get canJoin => isRecruiting && hasVacancies;
  bool get needsMorePlayers => currentMemberCount < (maxMembers * 0.7).round();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Team && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, sport: $sport, members: $currentMemberCount/$maxMembers)';
  }
}

/// Represents a team member with role and status
class TeamMember {
  final String userId;
  final TeamRole role;
  final DateTime joinedAt;
  final bool isActive;
  final DateTime? lastActive;
  final String? position;
  final Map<String, dynamic>? stats;

  const TeamMember({
    required this.userId,
    required this.role,
    required this.joinedAt,
    required this.isActive,
    this.lastActive,
    this.position,
    this.stats,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      userId: json['userId'] ?? '',
      role: TeamRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => TeamRole.player,
      ),
      joinedAt: DateTime.parse(json['joinedAt']),
      isActive: json['isActive'] ?? true,
      lastActive: json['lastActive'] != null ? DateTime.parse(json['lastActive']) : null,
      position: json['position'],
      stats: json['stats'] != null ? Map<String, dynamic>.from(json['stats']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role.name,
      'joinedAt': joinedAt.toIso8601String(),
      'isActive': isActive,
      'lastActive': lastActive?.toIso8601String(),
      'position': position,
      'stats': stats,
    };
  }

  TeamMember copyWith({
    String? userId,
    TeamRole? role,
    DateTime? joinedAt,
    bool? isActive,
    DateTime? lastActive,
    String? position,
    Map<String, dynamic>? stats,
  }) {
    return TeamMember(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
      lastActive: lastActive ?? this.lastActive,
      position: position ?? this.position,
      stats: stats ?? this.stats,
    );
  }
}

/// Team member roles
enum TeamRole {
  captain,    // Team captain with full control
  admin,      // Admin with management permissions
  player,     // Regular team member
  reserve,    // Reserve player
  coach,      // Team coach
}

/// Team invitation for new members
class TeamInvitation {
  final String id;
  final String teamId;
  final String invitedUserId;
  final String invitedBy;
  final DateTime invitedAt;
  final DateTime expiresAt;
  final String? message;
  final InvitationStatus status;

  const TeamInvitation({
    required this.id,
    required this.teamId,
    required this.invitedUserId,
    required this.invitedBy,
    required this.invitedAt,
    required this.expiresAt,
    this.message,
    required this.status,
  });

  factory TeamInvitation.create({
    required String teamId,
    required String invitedUserId,
    required String invitedBy,
    String? message,
    Duration validity = const Duration(days: 7),
  }) {
    final now = DateTime.now();
    return TeamInvitation(
      id: 'inv_${DateTime.now().millisecondsSinceEpoch}',
      teamId: teamId,
      invitedUserId: invitedUserId,
      invitedBy: invitedBy,
      invitedAt: now,
      expiresAt: now.add(validity),
      message: message,
      status: InvitationStatus.pending,
    );
  }

  factory TeamInvitation.fromJson(Map<String, dynamic> json) {
    return TeamInvitation(
      id: json['id'] ?? '',
      teamId: json['teamId'] ?? '',
      invitedUserId: json['invitedUserId'] ?? '',
      invitedBy: json['invitedBy'] ?? '',
      invitedAt: DateTime.parse(json['invitedAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
      message: json['message'],
      status: InvitationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => InvitationStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'invitedUserId': invitedUserId,
      'invitedBy': invitedBy,
      'invitedAt': invitedAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'message': message,
      'status': status.name,
    };
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get canAccept => status == InvitationStatus.pending && !isExpired;

  TeamInvitation copyWith({
    String? id,
    String? teamId,
    String? invitedUserId,
    String? invitedBy,
    DateTime? invitedAt,
    DateTime? expiresAt,
    String? message,
    InvitationStatus? status,
  }) {
    return TeamInvitation(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      invitedUserId: invitedUserId ?? this.invitedUserId,
      invitedBy: invitedBy ?? this.invitedBy,
      invitedAt: invitedAt ?? this.invitedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}

/// Invitation status
enum InvitationStatus {
  pending,
  accepted,
  declined,
  expired,
  cancelled,
}

/// Join request from a user
class TeamRequest {
  final String id;
  final String teamId;
  final String userId;
  final DateTime requestedAt;
  final String? message;
  final RequestStatus status;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final String? reviewNotes;

  const TeamRequest({
    required this.id,
    required this.teamId,
    required this.userId,
    required this.requestedAt,
    this.message,
    required this.status,
    this.reviewedBy,
    this.reviewedAt,
    this.reviewNotes,
  });

  factory TeamRequest.create({
    required String teamId,
    required String userId,
    String? message,
  }) {
    return TeamRequest(
      id: 'req_${DateTime.now().millisecondsSinceEpoch}',
      teamId: teamId,
      userId: userId,
      requestedAt: DateTime.now(),
      message: message,
      status: RequestStatus.pending,
    );
  }

  factory TeamRequest.fromJson(Map<String, dynamic> json) {
    return TeamRequest(
      id: json['id'] ?? '',
      teamId: json['teamId'] ?? '',
      userId: json['userId'] ?? '',
      requestedAt: DateTime.parse(json['requestedAt']),
      message: json['message'],
      status: RequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RequestStatus.pending,
      ),
      reviewedBy: json['reviewedBy'],
      reviewedAt: json['reviewedAt'] != null ? DateTime.parse(json['reviewedAt']) : null,
      reviewNotes: json['reviewNotes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'userId': userId,
      'requestedAt': requestedAt.toIso8601String(),
      'message': message,
      'status': status.name,
      'reviewedBy': reviewedBy,
      'reviewedAt': reviewedAt?.toIso8601String(),
      'reviewNotes': reviewNotes,
    };
  }

  bool get canReview => status == RequestStatus.pending;

  TeamRequest copyWith({
    String? id,
    String? teamId,
    String? userId,
    DateTime? requestedAt,
    String? message,
    RequestStatus? status,
    String? reviewedBy,
    DateTime? reviewedAt,
    String? reviewNotes,
  }) {
    return TeamRequest(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      userId: userId ?? this.userId,
      requestedAt: requestedAt ?? this.requestedAt,
      message: message ?? this.message,
      status: status ?? this.status,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewNotes: reviewNotes ?? this.reviewNotes,
    );
  }
}

/// Request status
enum RequestStatus {
  pending,
  approved,
  rejected,
  withdrawn,
}

/// Team location information
class TeamLocation {
  final double latitude;
  final double longitude;
  final String address;
  final String? city;
  final String? state;
  final String? country;
  final String? venueName;
  final String? venueDetails;

  const TeamLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
    this.city,
    this.state,
    this.country,
    this.venueName,
    this.venueDetails,
  });

  factory TeamLocation.fromJson(Map<String, dynamic> json) {
    return TeamLocation(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      address: json['address'] ?? '',
      city: json['city'],
      state: json['state'],
      country: json['country'],
      venueName: json['venueName'],
      venueDetails: json['venueDetails'],
    );
  }

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

  TeamLocation copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? state,
    String? country,
    String? venueName,
    String? venueDetails,
  }) {
    return TeamLocation(
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
}
