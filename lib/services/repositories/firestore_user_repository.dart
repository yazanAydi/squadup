import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';
import '../repositories/user_repository.dart';

/// Firestore implementation of UserRepository
class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;
  static const String _collection = 'users';

  FirestoreUserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<String> create(UserModel item) async {
    try {
      // Convert the UserModel to JSON and ensure timestamps are proper Firestore timestamps
      final userData = item.toJson();
      
      // Convert DateTime strings to Firestore Timestamps
      if (userData['createdAt'] != null) {
        userData['createdAt'] = Timestamp.fromDate(DateTime.parse(userData['createdAt']));
      }
      if (userData['updatedAt'] != null) {
        userData['updatedAt'] = Timestamp.fromDate(DateTime.parse(userData['updatedAt']));
      }
      if (userData['lastSeen'] != null) {
        userData['lastSeen'] = Timestamp.fromDate(DateTime.parse(userData['lastSeen']));
      }
      
      // Use the user's ID as the document ID to match Firestore rules
      await _firestore.collection(_collection).doc(item.id).set(userData);
      return item.id;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<UserModel?> getById(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        final data = doc.data()!;
        
        // Convert Firestore Timestamps back to DateTime strings
        if (data['createdAt'] != null) {
          data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
        }
        if (data['updatedAt'] != null) {
          data['updatedAt'] = (data['updatedAt'] as Timestamp).toDate().toIso8601String();
        }
        if (data['lastSeen'] != null) {
          data['lastSeen'] = (data['lastSeen'] as Timestamp).toDate().toIso8601String();
        }
        
        return UserModel.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user by ID: $e');
    }
  }

  @override
  Future<List<UserModel>> getAll() async {
    try {
      final querySnapshot = await _firestore.collection(_collection).get();
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            
            // Convert Firestore Timestamps back to DateTime strings
            if (data['createdAt'] != null) {
              data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
            }
            if (data['updatedAt'] != null) {
              data['updatedAt'] = (data['updatedAt'] as Timestamp).toDate().toIso8601String();
            }
            if (data['lastSeen'] != null) {
              data['lastSeen'] = (data['lastSeen'] as Timestamp).toDate().toIso8601String();
            }
            
            return UserModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  @override
  Future<void> update(String id, UserModel item) async {
    try {
      await _firestore.collection(_collection).doc(id).update(item.toJson());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<bool> exists(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check if user exists: $e');
    }
  }

  @override
  Future<UserModel?> getByEmail(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user by email: $e');
    }
  }

  @override
  Future<UserModel?> getByUsername(String username) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user by username: $e');
    }
  }

  @override
  Future<void> updateProfile(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection(_collection).doc(userId).update(updates);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  @override
  Future<void> updateStats(String userId, Map<String, dynamic> stats) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'statistics': stats,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update user stats: $e');
    }
  }

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      // Note: Firestore doesn't support full-text search natively
      // This is a simple implementation - in production, consider using Algolia or similar
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('displayName', isGreaterThanOrEqualTo: query)
          .where('displayName', isLessThan: '$query\uf8ff')
          .limit(20)
          .get();
      
      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  @override
  Future<List<UserModel>> getUsersByCity(String city) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('city', isEqualTo: city)
          .limit(50)
          .get();
      
      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get users by city: $e');
    }
  }

  @override
  Future<List<UserModel>> getUsersBySport(String sport) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('sports', arrayContains: sport)
          .limit(50)
          .get();
      
      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get users by sport: $e');
    }
  }

  @override
  Future<List<String>> getUserTeams(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        return List<String>.from(data['teams'] ?? []);
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get user teams: $e');
    }
  }

  @override
  Future<List<String>> getUserGames(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        return List<String>.from(data['games'] ?? []);
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get user games: $e');
    }
  }
}
