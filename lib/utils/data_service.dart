import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/team.dart';
import '../models/game.dart';
import '../models/user_profile.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  static DataService get instance => _instance;
  
  DataService._internal();

  late FirebaseFirestore _firestore;
  bool _isInitialized = false;

  /// Initialize the data service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      _firestore = FirebaseFirestore.instance;
      
      _isInitialized = true;
      
      if (kDebugMode) {
        print('DataService initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing DataService: $e');
      }
      rethrow;
    }
  }

  /// Get user data directly from Firestore
  Future<Map<String, dynamic>?> getUserData({bool forceRefresh = false}) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      return doc.data();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user data: $e');
      }
      rethrow;
    }
  }

  /// Get user data with real-time updates (legacy Map format)
  Stream<Map<String, dynamic>?> getUserDataStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Stream.value(null);

      return _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots(includeMetadataChanges: true)
          .map((doc) => doc.data());
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user data stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get user profile with real-time updates (typed)
  Stream<UserProfile?> getUserProfileStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Stream.value(null);
      return _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots(includeMetadataChanges: true)
          .map((doc) => UserProfile.fromFirestore(doc));
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user profile stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get teams data with real-time updates (legacy Map format)
  Stream<List<Map<String, dynamic>>> getTeamsDataStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      return _firestore
          .collection('teams')
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs.map((doc) {
                final data = doc.data();
                return {'id': doc.id, ...data};
              }).toList());
    } catch (e) {
      if (kDebugMode) {
        print('Error getting teams data stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get teams data with real-time updates (typed)
  Stream<List<Team>> getTeamsStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      return _firestore
          .collection('teams')
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs
              .map((doc) => Team.fromFirestore(doc))
              .toList());
    } catch (e) {
      if (kDebugMode) {
        print('Error getting teams stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get games data with real-time updates (legacy Map format)
  Stream<List<Map<String, dynamic>>> getGamesDataStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      return _firestore
          .collection('games')
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs.map((doc) {
                final data = doc.data();
                return {'id': doc.id, ...data};
              }).toList());
    } catch (e) {
      if (kDebugMode) {
        print('Error getting games data stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get games data with real-time updates (typed)
  Stream<List<Game>> getGamesStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      return _firestore
          .collection('games')
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs
              .map((doc) => Game.fromFirestore(doc))
              .toList());
    } catch (e) {
      if (kDebugMode) {
        print('Error getting games stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get user's teams with real-time updates
  Stream<List<Map<String, dynamic>>> getUserTeamsStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Stream.value([]);

      return _firestore
          .collection('teams')
          .where('members', arrayContains: user.uid)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs.map((doc) {
                final data = doc.data();
                return {'id': doc.id, ...data};
              }).toList());
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user teams stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get user's games with real-time updates
  Stream<List<Map<String, dynamic>>> getUserGamesStream() {
    if (!_isInitialized) {
      initialize();
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Stream.value([]);

      return _firestore
          .collection('games')
          .where('participants', arrayContains: user.uid)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs.map((doc) {
                final data = doc.data();
                return {'id': doc.id, ...data};
              }).toList());
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user games stream: $e');
      }
      return Stream.error(e);
    }
  }

  /// Get teams data (for backward compatibility)
  Future<List<Map<String, dynamic>>> getTeamsData({bool forceRefresh = false}) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final snapshot = await _firestore.collection('teams').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {'id': doc.id, ...data};
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting teams data: $e');
      }
      rethrow;
    }
  }

  /// Get games data (for backward compatibility)
  Future<List<Map<String, dynamic>>> getGamesData({bool forceRefresh = false}) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final snapshot = await _firestore.collection('games').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {'id': doc.id, ...data};
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting games data: $e');
      }
      rethrow;
    }
  }

  /// Clear cache (no-op for backward compatibility - Firestore handles caching)
  Future<void> clearCache() async {
    if (kDebugMode) {
      print('DataService: Cache clearing requested but not needed (Firestore handles caching)');
    }
    // No-op since Firestore handles offline persistence automatically
  }

  /// Get user profile (typed, for backward compatibility)
  Future<UserProfile?> getUserProfile() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      return UserProfile.fromFirestore(doc);
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user profile: $e');
      }
      rethrow;
    }
  }

  /// Get teams (typed, for backward compatibility)
  Future<List<Team>> getTeams() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final snapshot = await _firestore.collection('teams').get();
      return snapshot.docs.map((doc) => Team.fromFirestore(doc)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting teams: $e');
      }
      rethrow;
    }
  }

  /// Get games (typed, for backward compatibility)
  Future<List<Game>> getGames() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final snapshot = await _firestore.collection('games').get();
      return snapshot.docs.map((doc) => Game.fromFirestore(doc)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting games: $e');
      }
      rethrow;
    }
  }
}
