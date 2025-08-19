import 'package:flutter_test/flutter_test.dart';
import 'package:squadup/models/team.dart';

void main() {
  group('Team Model Tests', () {
    test('should create Team from JSON', () {
      final teamData = {
        'name': 'Test Team',
        'sport': 'Basketball',
        'location': 'New York',
        'memberCount': 5,
        'createdAt': '2024-01-01T00:00:00.000Z',
        'description': 'A test team',
        'imageUrl': 'https://example.com/image.jpg',
        'members': ['user1', 'user2'],
        'ownerId': 'owner1',
      };

      final team = Team.fromJson(teamData).copyWith(id: 'team1');

      expect(team.id, 'team1');
      expect(team.name, 'Test Team');
      expect(team.sport, 'Basketball');
      expect(team.location, 'New York');
      expect(team.memberCount, 5);
      expect(team.createdAt?.year, 2024);
      expect(team.createdAt?.month, 1);
      expect(team.createdAt?.day, 1);
      expect(team.description, 'A test team');
      expect(team.imageUrl, 'https://example.com/image.jpg');
      expect(team.members, ['user1', 'user2']);
      expect(team.ownerId, 'owner1');
    });

    test('should convert Team to JSON', () {
      final team = Team(
        id: 'team1',
        name: 'Test Team',
        sport: 'Basketball',
        location: 'New York',
        memberCount: 5,
        createdAt: DateTime(2024, 1, 1),
        description: 'A test team',
        imageUrl: 'https://example.com/image.jpg',
        members: ['user1', 'user2'],
        ownerId: 'owner1',
      );

      final json = team.toJson();

      expect(json['name'], 'Test Team');
      expect(json['sport'], 'Basketball');
      expect(json['location'], 'New York');
      expect(json['memberCount'], 5);
      expect(json['createdAt'], isNotNull);
      expect(json['description'], 'A test team');
      expect(json['imageUrl'], 'https://example.com/image.jpg');
      expect(json['members'], ['user1', 'user2']);
      expect(json['ownerId'], 'owner1');
    });

    test('should create Team with copyWith', () {
      final originalTeam = Team(
        id: 'team1',
        name: 'Original Team',
        sport: 'Basketball',
        location: 'New York',
        memberCount: 5,
        createdAt: DateTime(2024, 1, 1),
        description: 'Original description',
        imageUrl: 'https://example.com/original.jpg',
        members: ['user1'],
        ownerId: 'owner1',
      );

      final updatedTeam = originalTeam.copyWith(
        name: 'Updated Team',
        memberCount: 10,
        description: 'Updated description',
      );

      expect(updatedTeam.id, 'team1');
      expect(updatedTeam.name, 'Updated Team');
      expect(updatedTeam.sport, 'Basketball');
      expect(updatedTeam.location, 'New York');
      expect(updatedTeam.memberCount, 10);
      expect(updatedTeam.createdAt?.year, 2024);
      expect(updatedTeam.createdAt?.month, 1);
      expect(updatedTeam.createdAt?.day, 1);
      expect(updatedTeam.description, 'Updated description');
      expect(updatedTeam.imageUrl, 'https://example.com/original.jpg');
      expect(updatedTeam.members, ['user1']);
      expect(updatedTeam.ownerId, 'owner1');
    });

    test('should handle null values in fromJson', () {
      final teamData = {
        'name': 'Test Team',
        'sport': 'Basketball',
        'location': 'New York',
        'memberCount': 5,
        'createdAt': '2024-01-01T00:00:00.000Z',
        'members': ['user1'],
        'ownerId': 'owner1',
      };

      final team = Team.fromJson(teamData).copyWith(id: 'team1');

      expect(team.id, 'team1');
      expect(team.name, 'Test Team');
      expect(team.sport, 'Basketball');
      expect(team.location, 'New York');
      expect(team.memberCount, 5);
      expect(team.createdAt, isNotNull);
      expect(team.description, isNull);
      expect(team.imageUrl, isNull);
      expect(team.members, ['user1']);
      expect(team.ownerId, 'owner1');
    });

    test('should create Team with minimal required fields', () {
      final team = Team(
        name: 'Minimal Team',
        sport: 'Soccer',
        location: 'Los Angeles',
        ownerId: 'owner2',
      );

      expect(team.name, 'Minimal Team');
      expect(team.sport, 'Soccer');
      expect(team.location, 'Los Angeles');
      expect(team.memberCount, 0); // Default value
      expect(team.createdAt, isNull);
      expect(team.description, isNull);
      expect(team.imageUrl, isNull);
      expect(team.members, isEmpty);
      expect(team.ownerId, 'owner2');
    });

    test('should create Team with all fields', () {
      final team = Team(
        name: 'Full Team',
        sport: 'Tennis',
        location: 'Chicago',
        memberCount: 8,
        createdAt: DateTime(2024, 6, 15),
        description: 'A complete team',
        imageUrl: 'https://example.com/team.jpg',
        members: ['user1', 'user2', 'user3'],
        ownerId: 'owner3',
      );

      expect(team.name, 'Full Team');
      expect(team.sport, 'Tennis');
      expect(team.location, 'Chicago');
      expect(team.memberCount, 8);
      expect(team.createdAt?.year, 2024);
      expect(team.createdAt?.month, 6);
      expect(team.createdAt?.day, 15);
      expect(team.description, 'A complete team');
      expect(team.imageUrl, 'https://example.com/team.jpg');
      expect(team.members, ['user1', 'user2', 'user3']);
      expect(team.ownerId, 'owner3');
    });

    test('should handle empty members list', () {
      final team = Team(
        name: 'Empty Team',
        sport: 'Volleyball',
        location: 'Miami',
        ownerId: 'owner4',
        members: [],
      );

      expect(team.members, isEmpty);
      expect(team.memberCount, 0);
    });

    test('should handle large member count', () {
      final team = Team(
        name: 'Large Team',
        sport: 'Football',
        location: 'Dallas',
        memberCount: 100,
        ownerId: 'owner5',
      );

      expect(team.memberCount, 100);
    });

    test('should create Team from Firestore document', () {
      // This test simulates what fromFirestore would do
      final teamData = {
        'name': 'Firestore Team',
        'sport': 'Hockey',
        'location': 'Boston',
        'memberCount': 12,
        'createdAt': '2024-03-01T00:00:00.000Z',
        'description': 'A team from Firestore',
        'imageUrl': 'https://example.com/firestore.jpg',
        'members': ['user1', 'user2', 'user3', 'user4'],
        'ownerId': 'owner6',
      };

      final team = Team.fromJson(teamData).copyWith(id: 'firestore-team-id');

      expect(team.id, 'firestore-team-id');
      expect(team.name, 'Firestore Team');
      expect(team.sport, 'Hockey');
      expect(team.location, 'Boston');
      expect(team.memberCount, 12);
      expect(team.createdAt, isNotNull);
      expect(team.description, 'A team from Firestore');
      expect(team.imageUrl, 'https://example.com/firestore.jpg');
      expect(team.members, ['user1', 'user2', 'user3', 'user4']);
      expect(team.ownerId, 'owner6');
    });

    test('should convert Team to Firestore format', () {
      final team = Team(
        id: 'firestore-team',
        name: 'Firestore Team',
        sport: 'Basketball',
        location: 'Phoenix',
        memberCount: 6,
        createdAt: DateTime(2024, 2, 14),
        description: 'A team for Firestore',
        imageUrl: 'https://example.com/firestore.jpg',
        members: ['user1', 'user2'],
        ownerId: 'owner7',
      );

      final firestoreData = team.toFirestore();

      expect(firestoreData['name'], 'Firestore Team');
      expect(firestoreData['sport'], 'Basketball');
      expect(firestoreData['location'], 'Phoenix');
      expect(firestoreData['memberCount'], 6);
      expect(firestoreData['createdAt'], isNotNull);
      expect(firestoreData['description'], 'A team for Firestore');
      expect(firestoreData['imageUrl'], 'https://example.com/firestore.jpg');
      expect(firestoreData['members'], ['user1', 'user2']);
      expect(firestoreData['ownerId'], 'owner7');
      expect(firestoreData.containsKey('id'), false); // ID should not be in Firestore data
    });
  });
}
