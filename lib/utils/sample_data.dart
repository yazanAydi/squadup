import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SampleData {
  static final List<Map<String, dynamic>> sampleTeams = [
    {
      'name': 'Downtown Ballers',
      'sport': 'Basketball',
      'location': 'Downtown Court',
      'description': 'A competitive basketball team looking for dedicated players. We practice twice a week and play in local leagues.',
      'level': 'Intermediate',
      'memberCount': 8,
      'maxMembers': 12,
      'createdAt': Timestamp.now(),
      'createdBy': 'sample_user_1',
    },
    {
      'name': 'Soccer Stars FC',
      'sport': 'Soccer',
      'location': 'Central Park Field',
      'description': 'Casual soccer team for players of all skill levels. We focus on having fun and staying active.',
      'level': 'Mixed',
      'memberCount': 15,
      'maxMembers': 20,
      'createdAt': Timestamp.now(),
      'createdBy': 'sample_user_2',
    },
    {
      'name': 'Volleyball Warriors',
      'sport': 'Volleyball',
      'location': 'Beach Court',
      'description': 'Beach volleyball team for intermediate to advanced players. We play both indoor and outdoor.',
      'level': 'Advanced',
      'memberCount': 6,
      'maxMembers': 10,
      'createdAt': Timestamp.now(),
      'createdBy': 'sample_user_3',
    },
    {
      'name': 'Weekend Warriors',
      'sport': 'Basketball',
      'location': 'Community Center',
      'description': 'Weekend basketball team for busy professionals. We play every Saturday morning.',
      'level': 'Beginner',
      'memberCount': 5,
      'maxMembers': 10,
      'createdAt': Timestamp.now(),
      'createdBy': 'sample_user_4',
    },
    {
      'name': 'Elite Soccer Club',
      'sport': 'Soccer',
      'location': 'Sports Complex',
      'description': 'Competitive soccer team participating in local tournaments. Looking for experienced players.',
      'level': 'Advanced',
      'memberCount': 18,
      'maxMembers': 22,
      'createdAt': Timestamp.now(),
      'createdBy': 'sample_user_5',
    },
    {
      'name': 'Spike Masters',
      'sport': 'Volleyball',
      'location': 'Indoor Arena',
      'description': 'Indoor volleyball team with regular practice sessions. All skill levels welcome.',
      'level': 'Mixed',
      'memberCount': 8,
      'maxMembers': 12,
      'createdAt': Timestamp.now(),
      'createdBy': 'sample_user_6',
    },
  ];

  static Future<void> addSampleTeams() async {
    final firestore = FirebaseFirestore.instance;
    
    for (final team in sampleTeams) {
      try {
        await firestore.collection('teams').add(team);
        if (kDebugMode) {
          print('Added sample team: ${team['name']}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error adding sample team: $e');
        }
      }
    }
  }

  static Future<void> clearSampleTeams() async {
    final firestore = FirebaseFirestore.instance;
    
    try {
      final snapshot = await firestore.collection('teams').get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      if (kDebugMode) {
        print('Cleared all teams');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing teams: $e');
      }
    }
  }
}
