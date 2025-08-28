import 'package:flutter_test/flutter_test.dart';
import 'package:squadup/models/team.dart';

void main() {
  group('Team Model Tests', () {
    test('should create a team with all required parameters', () {
      final team = Team(
        id: 'test-team-1',
        name: 'Test Team',
        description: 'A test team for unit testing',
        sport: 'Football',
        skillLevel: 'Intermediate',
        city: 'Test City',
        photoUrl: 'https://example.com/photo.jpg',
        motto: 'Test Motto',
        createdBy: 'user-123',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        members: [
          TeamMember(
            userId: 'user-123',
            role: TeamRole.captain,
            joinedAt: DateTime(2024, 1, 1),
            isActive: true,
          ),
        ],
        adminIds: ['user-123'],
        captainIds: ['user-123'],
        maxMembers: 20,
        isRecruiting: true,
        isActive: true,
        monthlyFee: 25.0,
        currency: 'USD',
        requiresTryout: false,
        tryoutDetails: null,
        requirements: ['Basic skills'],
        rules: {'fairplay': 'Always play fair'},
        chatChannelId: 'chat-123',
        pendingInvitations: [],
        joinRequests: [],
        gamesPlayed: 0,
        gamesWon: 0,
        totalPoints: 0,
        winRate: 0.0,
        location: TeamLocation(
          latitude: 40.7128,
          longitude: -74.0060,
          address: '123 Test St, Test City',
          city: 'Test City',
          state: 'Test State',
          country: 'Test Country',
          venueName: 'Test Venue',
          venueDetails: 'Test venue details',
        ),
        practiceDays: ['Monday', 'Wednesday'],
        practiceTime: '18:00',
        practiceLocation: 'Test Practice Venue',
      );

      expect(team.id, equals('test-team-1'));
      expect(team.name, equals('Test Team'));
      expect(team.sport, equals('Football'));
      expect(team.skillLevel, equals('Intermediate'));
      expect(team.city, equals('Test City'));
      expect(team.photoUrl, equals('https://example.com/photo.jpg'));
      expect(team.motto, equals('Test Motto'));
      expect(team.createdBy, equals('user-123'));
      expect(team.members.length, equals(1));
      expect(team.adminIds.length, equals(1));
      expect(team.captainIds.length, equals(1));
      expect(team.maxMembers, equals(20));
      expect(team.isRecruiting, isTrue);
      expect(team.isActive, isTrue);
      expect(team.monthlyFee, equals(25.0));
      expect(team.currency, equals('USD'));
      expect(team.requiresTryout, isFalse);
      expect(team.requirements, contains('Basic skills'));
      expect(team.rules['fairplay'], equals('Always play fair'));
      expect(team.chatChannelId, equals('chat-123'));
      expect(team.gamesPlayed, equals(0));
      expect(team.gamesWon, equals(0));
      expect(team.totalPoints, equals(0));
      expect(team.winRate, equals(0.0));
      expect(team.location, isNotNull);
      expect(team.practiceDays, contains('Monday'));
      expect(team.practiceTime, equals('18:00'));
      expect(team.practiceLocation, equals('Test Practice Venue'));
    });

    test('should create a team with minimal parameters', () {
      final team = Team(
        id: 'test-team-2',
        name: 'Minimal Team',
        description: 'A minimal team',
        sport: 'Basketball',
        skillLevel: 'Beginner',
        city: 'Minimal City',
        photoUrl: null,
        motto: null,
        createdBy: 'user-456',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        members: [
          TeamMember(
            userId: 'user-456',
            role: TeamRole.captain,
            joinedAt: DateTime(2024, 1, 1),
            isActive: true,
          ),
        ],
        adminIds: ['user-456'],
        captainIds: ['user-456'],
        maxMembers: 15,
        isRecruiting: true,
        isActive: true,
        monthlyFee: null,
        currency: null,
        requiresTryout: false,
        tryoutDetails: null,
        requirements: [],
        rules: {},
        chatChannelId: 'chat-456',
        pendingInvitations: [],
        joinRequests: [],
        gamesPlayed: 0,
        gamesWon: 0,
        totalPoints: 0,
        winRate: 0.0,
        location: null,
        practiceDays: [],
        practiceTime: null,
        practiceLocation: null,
      );

      expect(team.id, equals('test-team-2'));
      expect(team.name, equals('Minimal Team'));
      expect(team.photoUrl, isNull);
      expect(team.motto, isNull);
      expect(team.monthlyFee, isNull);
      expect(team.currency, isNull);
      expect(team.location, isNull);
      expect(team.practiceDays, isEmpty);
      expect(team.practiceTime, isNull);
      expect(team.practiceLocation, isNull);
    });

    test('should create a team using factory method', () {
      final team = Team.create(
        name: 'Factory Team',
        description: 'A team created using factory',
        sport: 'Tennis',
        skillLevel: 'Advanced',
        city: 'Factory City',
        photoUrl: 'https://example.com/tennis.jpg',
        motto: 'Factory Motto',
        createdBy: 'user-789',
        maxMembers: 25,
        monthlyFee: 50.0,
        currency: 'EUR',
        requiresTryout: true,
        tryoutDetails: 'Advanced skills required',
        requirements: ['Advanced skills', 'Tournament experience'],
        rules: {'etiquette': 'Follow tennis etiquette'},
        location: TeamLocation(
          latitude: 51.5074,
          longitude: -0.1278,
          address: '456 Factory St, Factory City',
          city: 'Factory City',
          state: 'Factory State',
          country: 'Factory Country',
          venueName: 'Factory Tennis Club',
          venueDetails: 'Professional tennis facility',
        ),
        practiceDays: ['Tuesday', 'Thursday', 'Saturday'],
        practiceTime: '19:00',
        practiceLocation: 'Factory Tennis Club',
      );

      expect(team.name, equals('Factory Team'));
      expect(team.sport, equals('Tennis'));
      expect(team.skillLevel, equals('Advanced'));
      expect(team.city, equals('Factory City'));
      expect(team.createdBy, equals('user-789'));
      expect(team.maxMembers, equals(25));
      expect(team.monthlyFee, equals(50.0));
      expect(team.currency, equals('EUR'));
      expect(team.requiresTryout, isTrue);
      expect(team.tryoutDetails, equals('Advanced skills required'));
      expect(team.requirements, contains('Advanced skills'));
      expect(team.rules['etiquette'], equals('Follow tennis etiquette'));
      expect(team.location, isNotNull);
      expect(team.practiceDays.length, equals(3));
      expect(team.practiceTime, equals('19:00'));
      expect(team.practiceLocation, equals('Factory Tennis Club'));
      
      // Check that creator is automatically added as captain
      expect(team.members.length, equals(1));
      expect(team.members.first.userId, equals('user-789'));
      expect(team.members.first.role, equals(TeamRole.captain));
      expect(team.adminIds, contains('user-789'));
      expect(team.captainIds, contains('user-789'));
    });

    test('should compute derived properties correctly', () {
      final team = Team(
        id: 'test-team-3',
        name: 'Derived Team',
        description: 'A team for testing derived properties',
        sport: 'Volleyball',
        skillLevel: 'Intermediate',
        city: 'Derived City',
        photoUrl: null,
        motto: null,
        createdBy: 'user-999',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        members: [
          TeamMember(
            userId: 'user-999',
            role: TeamRole.captain,
            joinedAt: DateTime(2024, 1, 1),
            isActive: true,
          ),
          TeamMember(
            userId: 'user-888',
            role: TeamRole.player,
            joinedAt: DateTime(2024, 1, 2),
            isActive: true,
          ),
          TeamMember(
            userId: 'user-777',
            role: TeamRole.player,
            joinedAt: DateTime(2024, 1, 3),
            isActive: false, // Inactive member
          ),
        ],
        adminIds: ['user-999'],
        captainIds: ['user-999'],
        maxMembers: 12,
        isRecruiting: true,
        isActive: true,
        monthlyFee: null,
        currency: null,
        requiresTryout: false,
        tryoutDetails: null,
        requirements: [],
        rules: {},
        chatChannelId: 'chat-999',
        pendingInvitations: [],
        joinRequests: [],
        gamesPlayed: 10,
        gamesWon: 7,
        totalPoints: 35,
        winRate: 0.7,
        location: null,
        practiceDays: [],
        practiceTime: null,
        practiceLocation: null,
      );

      expect(team.currentMemberCount, equals(2)); // Only active members
      expect(team.isFull, isFalse); // 2 < 12
      expect(team.hasVacancies, isTrue); // 2 < 12
      expect(team.fillPercentage, equals(2 / 12));
      expect(team.isUserCaptain('user-999'), isTrue);
      expect(team.isUserCaptain('user-888'), isFalse);
      expect(team.isUserAdmin('user-999'), isTrue);
      expect(team.isUserAdmin('user-888'), isFalse);
      expect(team.isUserMember('user-999'), isTrue);
      expect(team.isUserMember('user-777'), isFalse); // Inactive
      expect(team.activeMembers.length, equals(2));
      expect(team.inactiveMembers.length, equals(1));
      expect(team.canJoin, isTrue); // Recruiting and has vacancies
      expect(team.needsMorePlayers, isTrue); // 2 < 8.4 (70% of 12)
    });

    test('should convert to and from JSON correctly', () {
      final originalTeam = Team(
        id: 'json-test-team',
        name: 'JSON Test Team',
        description: 'A team for testing JSON serialization',
        sport: 'Soccer',
        skillLevel: 'Beginner',
        city: 'JSON City',
        photoUrl: 'https://example.com/soccer.jpg',
        motto: 'JSON Motto',
        createdBy: 'user-json',
        createdAt: DateTime(2024, 1, 1, 12, 0, 0),
        updatedAt: DateTime(2024, 1, 1, 12, 0, 0),
        members: [
          TeamMember(
            userId: 'user-json',
            role: TeamRole.captain,
            joinedAt: DateTime(2024, 1, 1, 12, 0, 0),
            isActive: true,
          ),
        ],
        adminIds: ['user-json'],
        captainIds: ['user-json'],
        maxMembers: 22,
        isRecruiting: true,
        isActive: true,
        monthlyFee: 30.0,
        currency: 'USD',
        requiresTryout: false,
        tryoutDetails: null,
        requirements: ['Basic soccer skills'],
        rules: {'fairplay': 'No foul play'},
        chatChannelId: 'chat-json',
        pendingInvitations: [],
        joinRequests: [],
        gamesPlayed: 5,
        gamesWon: 3,
        totalPoints: 15,
        winRate: 0.6,
        location: TeamLocation(
          latitude: 40.7128,
          longitude: -74.0060,
          address: '789 JSON St, JSON City',
          city: 'JSON City',
          state: 'JSON State',
          country: 'JSON Country',
          venueName: 'JSON Soccer Field',
          venueDetails: 'Professional soccer field',
        ),
        practiceDays: ['Monday', 'Wednesday', 'Friday'],
        practiceTime: '17:00',
        practiceLocation: 'JSON Soccer Field',
      );

      final json = originalTeam.toJson();
      expect(json['id'], equals('json-test-team'));
      expect(json['name'], equals('JSON Test Team'));
      expect(json['sport'], equals('Soccer'));
      expect(json['skillLevel'], equals('Beginner'));
      expect(json['city'], equals('JSON City'));
      expect(json['photoUrl'], equals('https://example.com/soccer.jpg'));
      expect(json['motto'], equals('JSON Motto'));
      expect(json['createdBy'], equals('user-json'));
      expect(json['maxMembers'], equals(22));
      expect(json['monthlyFee'], equals(30.0));
      expect(json['currency'], equals('USD'));
      expect(json['requiresTryout'], isFalse);
      expect(json['requirements'], contains('Basic soccer skills'));
      expect(json['rules']['fairplay'], equals('No foul play'));
      expect(json['chatChannelId'], equals('chat-json'));
      expect(json['gamesPlayed'], equals(5));
      expect(json['gamesWon'], equals(3));
      expect(json['totalPoints'], equals(15));
      expect(json['winRate'], equals(0.6));
      expect(json['location'], isNotNull);
      expect(json['practiceDays'], contains('Monday'));
      expect(json['practiceTime'], equals('17:00'));
      expect(json['practiceLocation'], equals('JSON Soccer Field'));
      expect(json['members'], isNotNull);
      expect(json['adminIds'], contains('user-json'));
      expect(json['captainIds'], contains('user-json'));
    });

    test('should copy with updated fields correctly', () {
      final originalTeam = Team(
        id: 'copy-test-team',
        name: 'Copy Test Team',
        description: 'A team for testing copyWith',
        sport: 'Baseball',
        skillLevel: 'Intermediate',
        city: 'Copy City',
        photoUrl: null,
        motto: null,
        createdBy: 'user-copy',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        members: [
          TeamMember(
            userId: 'user-copy',
            role: TeamRole.captain,
            joinedAt: DateTime(2024, 1, 1),
            isActive: true,
          ),
        ],
        adminIds: ['user-copy'],
        captainIds: ['user-copy'],
        maxMembers: 18,
        isRecruiting: true,
        isActive: true,
        monthlyFee: null,
        currency: null,
        requiresTryout: false,
        tryoutDetails: null,
        requirements: [],
        rules: {},
        chatChannelId: 'chat-copy',
        pendingInvitations: [],
        joinRequests: [],
        gamesPlayed: 0,
        gamesWon: 0,
        totalPoints: 0,
        winRate: 0.0,
        location: null,
        practiceDays: [],
        practiceTime: null,
        practiceLocation: null,
      );

      final updatedTeam = originalTeam.copyWith(
        name: 'Updated Copy Team',
        skillLevel: 'Advanced',
        maxMembers: 25,
        isRecruiting: false,
        monthlyFee: 40.0,
        currency: 'EUR',
        requiresTryout: true,
        tryoutDetails: 'Advanced skills required',
        requirements: ['Advanced skills'],
        rules: {'advanced': 'Advanced rules apply'},
      );

      expect(updatedTeam.id, equals(originalTeam.id));
      expect(updatedTeam.name, equals('Updated Copy Team'));
      expect(updatedTeam.skillLevel, equals('Advanced'));
      expect(updatedTeam.maxMembers, equals(25));
      expect(updatedTeam.isRecruiting, isFalse);
      expect(updatedTeam.monthlyFee, equals(40.0));
      expect(updatedTeam.currency, equals('EUR'));
      expect(updatedTeam.requiresTryout, isTrue);
      expect(updatedTeam.tryoutDetails, equals('Advanced skills required'));
      expect(updatedTeam.requirements, contains('Advanced skills'));
      expect(updatedTeam.rules['advanced'], equals('Advanced rules apply'));
      
      // Unchanged fields should remain the same
      expect(updatedTeam.sport, equals(originalTeam.sport));
      expect(updatedTeam.city, equals(originalTeam.city));
      expect(updatedTeam.createdBy, equals(originalTeam.createdBy));
      expect(updatedTeam.members, equals(originalTeam.members));
    });

    test('should handle team member roles correctly', () {
      final team = Team(
        id: 'roles-test-team',
        name: 'Roles Test Team',
        description: 'A team for testing member roles',
        sport: 'Hockey',
        skillLevel: 'Advanced',
        city: 'Roles City',
        photoUrl: null,
        motto: null,
        createdBy: 'user-roles',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        members: [
          TeamMember(
            userId: 'user-roles',
            role: TeamRole.captain,
            joinedAt: DateTime(2024, 1, 1),
            isActive: true,
          ),
          TeamMember(
            userId: 'user-admin',
            role: TeamRole.admin,
            joinedAt: DateTime(2024, 1, 2),
            isActive: true,
          ),
          TeamMember(
            userId: 'user-player',
            role: TeamRole.player,
            joinedAt: DateTime(2024, 1, 3),
            isActive: true,
          ),
          TeamMember(
            userId: 'user-reserve',
            role: TeamRole.reserve,
            joinedAt: DateTime(2024, 1, 4),
            isActive: true,
          ),
          TeamMember(
            userId: 'user-coach',
            role: TeamRole.coach,
            joinedAt: DateTime(2024, 1, 5),
            isActive: true,
          ),
        ],
        adminIds: ['user-roles', 'user-admin'],
        captainIds: ['user-roles'],
        maxMembers: 20,
        isRecruiting: true,
        isActive: true,
        monthlyFee: null,
        currency: null,
        requiresTryout: false,
        tryoutDetails: null,
        requirements: [],
        rules: {},
        chatChannelId: 'chat-roles',
        pendingInvitations: [],
        joinRequests: [],
        gamesPlayed: 0,
        gamesWon: 0,
        totalPoints: 0,
        winRate: 0.0,
        location: null,
        practiceDays: [],
        practiceTime: null,
        practiceLocation: null,
      );

      expect(team.members.length, equals(5));
      expect(team.adminIds.length, equals(2));
      expect(team.captainIds.length, equals(1));
      
      // Test role-specific checks
      expect(team.isUserCaptain('user-roles'), isTrue);
      expect(team.isUserCaptain('user-admin'), isFalse);
      expect(team.isUserAdmin('user-roles'), isTrue);
      expect(team.isUserAdmin('user-admin'), isTrue);
      expect(team.isUserAdmin('user-player'), isFalse);
      expect(team.isUserMember('user-roles'), isTrue);
      expect(team.isUserMember('user-player'), isTrue);
      expect(team.isUserMember('user-reserve'), isTrue);
      expect(team.isUserMember('user-coach'), isTrue);
    });

    test('should handle team invitations and requests correctly', () {
      final team = Team(
        id: 'invitations-test-team',
        name: 'Invitations Test Team',
        description: 'A team for testing invitations and requests',
        sport: 'Rugby',
        skillLevel: 'Intermediate',
        city: 'Invitations City',
        photoUrl: null,
        motto: null,
        createdBy: 'user-invitations',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        members: [
          TeamMember(
            userId: 'user-invitations',
            role: TeamRole.captain,
            joinedAt: DateTime(2024, 1, 1),
            isActive: true,
          ),
        ],
        adminIds: ['user-invitations'],
        captainIds: ['user-invitations'],
        maxMembers: 15,
        isRecruiting: true,
        isActive: true,
        monthlyFee: null,
        currency: null,
        requiresTryout: false,
        tryoutDetails: null,
        requirements: [],
        rules: {},
        chatChannelId: 'chat-invitations',
        pendingInvitations: [
          TeamInvitation.create(
            teamId: 'invitations-test-team',
            invitedUserId: 'user-invited-1',
            invitedBy: 'user-invitations',
            message: 'Join our rugby team!',
          ),
          TeamInvitation.create(
            teamId: 'invitations-test-team',
            invitedUserId: 'user-invited-2',
            invitedBy: 'user-invitations',
            message: 'We need more players',
          ),
        ],
        joinRequests: [
          TeamRequest.create(
            teamId: 'invitations-test-team',
            userId: 'user-requesting-1',
            message: 'I would like to join your team',
          ),
          TeamRequest.create(
            teamId: 'invitations-test-team',
            userId: 'user-requesting-2',
            message: 'I have experience in rugby',
          ),
        ],
        gamesPlayed: 0,
        gamesWon: 0,
        totalPoints: 0,
        winRate: 0.0,
        location: null,
        practiceDays: [],
        practiceTime: null,
        practiceLocation: null,
      );

      expect(team.pendingInvitations.length, equals(2));
      expect(team.joinRequests.length, equals(2));
      
      // Test invitation properties
      final firstInvitation = team.pendingInvitations.first;
      expect(firstInvitation.teamId, equals('invitations-test-team'));
      expect(firstInvitation.invitedUserId, equals('user-invited-1'));
      expect(firstInvitation.invitedBy, equals('user-invitations'));
      expect(firstInvitation.message, equals('Join our rugby team!'));
      expect(firstInvitation.status, equals(InvitationStatus.pending));
      expect(firstInvitation.isExpired, isFalse);
      expect(firstInvitation.canAccept, isTrue);
      
      // Test join request properties
      final firstRequest = team.joinRequests.first;
      expect(firstRequest.teamId, equals('invitations-test-team'));
      expect(firstRequest.userId, equals('user-requesting-1'));
      expect(firstRequest.message, equals('I would like to join your team'));
      expect(firstRequest.status, equals(RequestStatus.pending));
      expect(firstRequest.canReview, isTrue);
    });
  });
}
