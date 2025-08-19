import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../interfaces/game_service_interface.dart';

class GameService implements GameServiceInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<List<Map<String, dynamic>>> getGames({bool forceRefresh = false}) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games (forceRefresh: $forceRefresh)');
      }
      
      final snapshot = await _firestore.collection('games').get();
      
      final games = snapshot.docs.map((doc) {
        try {
                  final data = doc.data();
        // ignore: unnecessary_null_comparison
        if (data != null) {
          return {'id': doc.id, ...data};
        }
          return {'id': doc.id};
        } catch (e) {
          if (kDebugMode) {
            print('GameService: Error processing game document ${doc.id}: $e');
          }
          return {'id': doc.id};
        }
      }).toList();
      
      if (kDebugMode) {
        print('GameService: Retrieved ${games.length} games successfully');
      }
      
      return games;
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting games: $e');
      }
      throw Exception('Unable to retrieve games. Please check your connection and try again.');
    }
  }

  @override
  Future<Map<String, dynamic>?> getGameById(String gameId) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting game by ID: $gameId');
      }
      
      if (gameId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID cannot be empty');
        }
        return null;
      }
      
      final doc = await _firestore.collection('games').doc(gameId).get();
      if (doc.exists) {
        try {
          final data = doc.data();
          // ignore: unnecessary_null_comparison
          if (data != null) {
            final game = {'id': doc.id, ...data};
            
            if (kDebugMode) {
              print('GameService: Game retrieved successfully');
            }
            
            return game;
          }
        } catch (e) {
          if (kDebugMode) {
            print('GameService: Error processing game data: $e');
          }
          return {'id': doc.id};
        }
      }
      
      if (kDebugMode) {
        print('GameService: Game not found');
      }
      
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting game by ID: $e');
      }
      throw Exception('Unable to retrieve game. Please check your connection and try again.');
    }
  }

  @override
  Future<String?> createGame(Map<String, dynamic> gameData) async {
    try {
      if (kDebugMode) {
        print('GameService: Creating game with data: ${gameData.keys.toList()}');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('GameService: No authenticated user found for game creation');
        }
        throw Exception('You must be signed in to create a game.');
      }

      try {
        final docRef = await _firestore.collection('games').add({
          ...gameData,
          'createdBy': uid,
          'createdAt': FieldValue.serverTimestamp(),
          'currentPlayers': 1,
          'players': [uid],
          'status': 'open',
        });
        
        if (kDebugMode) {
          print('GameService: Game created successfully with ID: ${docRef.id}');
        }
        
        return docRef.id;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error creating game in Firebase: $e');
        }
        throw Exception('Unable to create game. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error creating game: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> updateGame(String gameId, Map<String, dynamic> gameData) async {
    try {
      if (kDebugMode) {
        print('GameService: Updating game: $gameId with data: ${gameData.keys.toList()}');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('GameService: No authenticated user found for game update');
        }
        throw Exception('You must be signed in to update a game.');
      }

      if (gameId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID cannot be empty');
        }
        throw Exception('Invalid game ID.');
      }

      try {
        // Check if user can modify this game
        final gameDoc = await _firestore.collection('games').doc(gameId).get();
        if (!gameDoc.exists) {
          if (kDebugMode) {
            print('GameService: Game not found for update');
          }
          throw Exception('Game not found.');
        }
        
        final existingGameData = gameDoc.data();
        if (existingGameData == null) {
          if (kDebugMode) {
            print('GameService: Game data is null');
          }
          throw Exception('Game data not found.');
        }
        
        if (existingGameData['createdBy'] != uid && 
            !(existingGameData['players'] as List<dynamic>).contains(uid)) {
          if (kDebugMode) {
            print('GameService: User not authorized to modify this game');
          }
          throw Exception('You are not authorized to modify this game.');
        }

        await _firestore.collection('games').doc(gameId).update({
          ...gameData,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        if (kDebugMode) {
          print('GameService: Game updated successfully');
        }
        
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error updating game: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error updating game: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> deleteGame(String gameId) async {
    try {
      if (kDebugMode) {
        print('GameService: Deleting game: $gameId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('GameService: No authenticated user found for game deletion');
        }
        throw Exception('You must be signed in to delete a game.');
      }

      if (gameId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID cannot be empty');
        }
        throw Exception('Invalid game ID.');
      }

      try {
        // Check if user is the creator
        final gameDoc = await _firestore.collection('games').doc(gameId).get();
        if (!gameDoc.exists) {
          if (kDebugMode) {
            print('GameService: Game not found for deletion');
          }
          throw Exception('Game not found.');
        }
        
        final gameData = gameDoc.data();
        if (gameData == null) {
          if (kDebugMode) {
            print('GameService: Game data is null');
          }
          throw Exception('Game data not found.');
        }
        
        if (gameData['createdBy'] != uid) {
          if (kDebugMode) {
            print('GameService: Only the creator can delete this game');
          }
          throw Exception('Only the creator can delete this game.');
        }

        await _firestore.collection('games').doc(gameId).delete();
        
        if (kDebugMode) {
          print('GameService: Game deleted successfully');
        }
        
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error deleting game: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error deleting game: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> searchGames({
    required String query,
    String? sport,
    String? type,
    String? location,
    DateTime? date,
    bool forceRefresh = false,
  }) async {
    try {
      if (kDebugMode) {
        print('GameService: Searching games with query: $query, sport: $sport, type: $type, location: $location');
      }
      
      Query gamesQuery = _firestore.collection('games');

      // Apply filters
      if (sport != null && sport != 'All') {
        gamesQuery = gamesQuery.where('sport', isEqualTo: sport);
      }
      if (type != null && type != 'All Types') {
        gamesQuery = gamesQuery.where('gameType', isEqualTo: type);
      }
      if (location != null && location.isNotEmpty) {
        gamesQuery = gamesQuery.where('location', isGreaterThanOrEqualTo: location)
            .where('location', isLessThan: '$location\uf8ff');
      }
      if (date != null) {
        final startOfDay = DateTime(date.year, date.month, date.day);
        final endOfDay = startOfDay.add(const Duration(days: 1));
        gamesQuery = gamesQuery.where('gameDateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
            .where('gameDateTime', isLessThan: Timestamp.fromDate(endOfDay));
      }

      final snapshot = await gamesQuery.get();
      
      if (kDebugMode) {
        print('GameService: Found ${snapshot.docs.length} games from Firestore query');
      }
      
      List<Map<String, dynamic>> games = snapshot.docs.map((doc) {
        try {
          final data = doc.data();
          // ignore: unnecessary_null_comparison
          if (data != null) {
            return <String, dynamic>{'id': doc.id, ...(data as Map<String, dynamic>)};
          }
          return <String, dynamic>{'id': doc.id};
        } catch (e) {
          if (kDebugMode) {
            print('GameService: Error processing game document ${doc.id}: $e');
          }
          return <String, dynamic>{'id': doc.id};
        }
      }).toList();

      // Apply text search if query is provided
      if (query.isNotEmpty) {
        try {
          games = games.where((game) {
            try {
              final title = (game['name'] ?? '').toString().toLowerCase();
              final sport = (game['sport'] ?? '').toString().toLowerCase();
              final location = (game['location'] ?? '').toString().toLowerCase();
              final searchQuery = query.toLowerCase();
              
              return title.contains(searchQuery) || 
                     sport.contains(searchQuery) || 
                     location.contains(searchQuery);
            } catch (e) {
              if (kDebugMode) {
                print('GameService: Error filtering game by query: $e');
              }
              return false;
            }
          }).toList();
        } catch (e) {
          if (kDebugMode) {
            print('GameService: Error applying text search: $e');
          }
        }
      }

      if (kDebugMode) {
        print('GameService: Search completed successfully. Returning ${games.length} games');
      }
      
      return games;
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error searching games: $e');
      }
      throw Exception('Unable to search games. Please check your connection and try again.');
    }
  }

  @override
  Future<bool> joinGame(String gameId) async {
    try {
      if (kDebugMode) {
        print('GameService: Joining game: $gameId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('GameService: No authenticated user found for joining game');
        }
        throw Exception('You must be signed in to join a game.');
      }

      if (gameId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID cannot be empty');
        }
        throw Exception('Invalid game ID.');
      }

      try {
        final gameRef = _firestore.collection('games').doc(gameId);
        
        return await _firestore.runTransaction<bool>((transaction) async {
          try {
            final gameDoc = await transaction.get(gameRef);
            if (!gameDoc.exists) {
              if (kDebugMode) {
                print('GameService: Game not found for joining');
              }
              throw Exception('Game not found.');
            }
            
            final gameData = gameDoc.data();
            if (gameData == null) {
              if (kDebugMode) {
                print('GameService: Game data is null');
              }
              throw Exception('Game data not found.');
            }
            
            final currentPlayers = List<String>.from(gameData['players'] ?? []);
            final maxPlayers = gameData['maxPlayers'] ?? 0;
            
            if (currentPlayers.contains(uid)) {
              if (kDebugMode) {
                print('GameService: User already joined this game');
              }
              throw Exception('You have already joined this game.');
            }
            
            if (currentPlayers.length >= maxPlayers) {
              if (kDebugMode) {
                print('GameService: Game is full');
              }
              throw Exception('Game is full.');
            }
            
            currentPlayers.add(uid);
            
            transaction.update(gameRef, {
              'players': currentPlayers,
              'currentPlayers': currentPlayers.length,
              'updatedAt': FieldValue.serverTimestamp(),
            });
            
            if (kDebugMode) {
              print('GameService: User joined game successfully');
            }
            
            return true;
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error in transaction for joining game: $e');
            }
            rethrow;
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error joining game: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error joining game: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> leaveGame(String gameId) async {
    try {
      if (kDebugMode) {
        print('GameService: Leaving game: $gameId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('GameService: No authenticated user found for leaving game');
        }
        throw Exception('You must be signed in to leave a game.');
      }

      if (gameId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID cannot be empty');
        }
        throw Exception('Invalid game ID.');
      }

      try {
        final gameRef = _firestore.collection('games').doc(gameId);
        
        return await _firestore.runTransaction<bool>((transaction) async {
          try {
            final gameDoc = await transaction.get(gameRef);
            if (!gameDoc.exists) {
              if (kDebugMode) {
                print('GameService: Game not found for leaving');
              }
              throw Exception('Game not found.');
            }
            
            final gameData = gameDoc.data();
            if (gameData == null) {
              if (kDebugMode) {
                print('GameService: Game data is null');
              }
              throw Exception('Game data not found.');
            }
            
            final currentPlayers = List<String>.from(gameData['players'] ?? []);
            
            if (!currentPlayers.contains(uid)) {
              if (kDebugMode) {
                print('GameService: User not joined to this game');
              }
              throw Exception('You are not joined to this game.');
            }
            
            currentPlayers.remove(uid);
            
            transaction.update(gameRef, {
              'players': currentPlayers,
              'currentPlayers': currentPlayers.length,
              'updatedAt': FieldValue.serverTimestamp(),
            });
            
            if (kDebugMode) {
              print('GameService: User left game successfully');
            }
            
            return true;
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error in transaction for leaving game: $e');
            }
            rethrow;
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error leaving game: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error leaving game: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGameParticipants(String gameId) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting game participants for: $gameId');
      }
      
      if (gameId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID cannot be empty');
        }
        return [];
      }
      
      try {
        final gameDoc = await _firestore.collection('games').doc(gameId).get();
        if (!gameDoc.exists) {
          if (kDebugMode) {
            print('GameService: Game not found for getting participants');
          }
          throw Exception('Game not found.');
        }
        
        final gameData = gameDoc.data();
        if (gameData == null) {
          if (kDebugMode) {
            print('GameService: Game data is null');
          }
          return [];
        }
        
        final playerIds = List<String>.from(gameData['players'] ?? []);
        
        if (playerIds.isEmpty) {
          if (kDebugMode) {
            print('GameService: Game has no participants');
          }
          return [];
        }
        
        final usersSnapshot = await _firestore.collection('users')
            .where(FieldPath.documentId, whereIn: playerIds)
            .get();
        
        final participants = usersSnapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing participant ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${participants.length} game participants');
        }
        
        return participants;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting game participants: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting game participants: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGamesBySport(String sport) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games by sport: $sport');
      }
      
      if (sport.isEmpty) {
        if (kDebugMode) {
          print('GameService: Sport cannot be empty');
        }
        return [];
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('sport', isEqualTo: sport)
            .orderBy('gameDateTime', descending: true)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} games for sport: $sport');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting games by sport: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting games by sport: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGamesByType(String type) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games by type: $type');
      }
      
      if (type.isEmpty) {
        if (kDebugMode) {
          print('GameService: Type cannot be empty');
        }
        return [];
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('gameType', isEqualTo: type)
            .orderBy('gameDateTime', descending: true)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} games for type: $type');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting games by type: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting games by type: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGamesByLocation(String location) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games by location: $location');
      }
      
      if (location.isEmpty) {
        if (kDebugMode) {
          print('GameService: Location cannot be empty');
        }
        return [];
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('location', isGreaterThanOrEqualTo: location)
            .where('location', isLessThan: '$location\uf8ff')
            .orderBy('gameDateTime', descending: true)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} games for location: $location');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting games by location: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting games by location: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGamesByDateRange(DateTime start, DateTime end) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games by date range: ${start.toIso8601String()} to ${end.toIso8601String()}');
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('gameDateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
            .where('gameDateTime', isLessThanOrEqualTo: Timestamp.fromDate(end))
            .orderBy('gameDateTime', descending: true)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} games for date range');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting games by date range: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting games by date range: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUpcomingGames() async {
    try {
      if (kDebugMode) {
        print('GameService: Getting upcoming games');
      }
      
      try {
        final now = DateTime.now();
        final snapshot = await _firestore.collection('games')
            .where('gameDateTime', isGreaterThan: Timestamp.fromDate(now))
            .where('status', isEqualTo: 'open')
            .orderBy('gameDateTime', descending: false)
            .limit(20)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} upcoming games');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting upcoming games: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting upcoming games: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPastGames() async {
    try {
      if (kDebugMode) {
        print('GameService: Getting past games');
      }
      
      try {
        final now = DateTime.now();
        final snapshot = await _firestore.collection('games')
            .where('gameDateTime', isLessThan: Timestamp.fromDate(now))
            .orderBy('gameDateTime', descending: true)
            .limit(20)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} past games');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting past games: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting past games: $e');
      }
      return [];
    }
  }

  @override
  Future<bool> isUserInGame(String gameId, String userId) async {
    try {
      if (kDebugMode) {
        print('GameService: Checking if user $userId is in game $gameId');
      }
      
      if (gameId.isEmpty || userId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID or User ID cannot be empty');
        }
        return false;
      }
      
      try {
        final gameDoc = await _firestore.collection('games').doc(gameId).get();
        if (!gameDoc.exists) {
          if (kDebugMode) {
            print('GameService: Game not found for checking user participation');
          }
          return false;
        }
        
        final gameData = gameDoc.data();
        if (gameData == null) {
          if (kDebugMode) {
            print('GameService: Game data is null');
          }
          return false;
        }
        
        final players = List<String>.from(gameData['players'] ?? []);
        final isInGame = players.contains(userId);
        
        if (kDebugMode) {
          print('GameService: User $userId is in game $gameId: $isInGame');
        }
        
        return isInGame;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error checking if user is in game: $e');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error checking if user is in game: $e');
      }
      return false;
    }
  }

  // Additional methods for specific use cases
  Future<List<Map<String, dynamic>>> getUserCreatedGames(String userId) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games created by user: $userId');
      }
      
      if (userId.isEmpty) {
        if (kDebugMode) {
          print('GameService: User ID cannot be empty');
        }
        return [];
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('createdBy', isEqualTo: userId)
            .orderBy('gameDateTime', descending: true)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} games created by user $userId');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting user created games: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting user created games: $e');
      }
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getUserJoinedGames(String userId) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games joined by user: $userId');
      }
      
      if (userId.isEmpty) {
        if (kDebugMode) {
          print('GameService: User ID cannot be empty');
        }
        return [];
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('players', arrayContains: userId)
            .orderBy('gameDateTime', descending: true)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} games joined by user $userId');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting user joined games: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting user joined games: $e');
      }
      return [];
    }
  }

  // Additional methods for my_games_screen
  @override
  Future<List<Map<String, dynamic>>> getGamesByCreator(String userId) async {
    return getUserCreatedGames(userId);
  }

  @override
  Future<List<Map<String, dynamic>>> getGamesByPlayer(String userId) async {
    try {
      if (kDebugMode) {
        print('GameService: Getting games where user is a player (not creator): $userId');
      }
      
      if (userId.isEmpty) {
        if (kDebugMode) {
          print('GameService: User ID cannot be empty');
        }
        return [];
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('players', arrayContains: userId)
            .orderBy('gameDateTime', descending: true)
            .get();
        
        // Filter out games where user is the creator
        final games = snapshot.docs.where((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return data['createdBy'] != userId;
            }
            return false;
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error filtering game ${doc.id}: $e');
            }
            return false;
          }
        }).map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {'id': doc.id, ...data};
            }
            return {'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return {'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} games where user $userId is a player (not creator)');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting user joined games: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting user joined games: $e');
      }
      return [];
    }
  }

  @override
  Future<bool> cancelGame(String gameId) async {
    try {
      if (kDebugMode) {
        print('GameService: Cancelling game: $gameId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('GameService: No authenticated user found for cancelling game');
        }
        throw Exception('You must be signed in to cancel a game.');
      }

      if (gameId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID cannot be empty');
        }
        throw Exception('Invalid game ID.');
      }

      try {
        // Check if user is the creator
        final gameDoc = await _firestore.collection('games').doc(gameId).get();
        if (!gameDoc.exists) {
          if (kDebugMode) {
            print('GameService: Game not found for cancellation');
          }
          throw Exception('Game not found.');
        }
        
        final gameData = gameDoc.data();
        if (gameData == null) {
          if (kDebugMode) {
            print('GameService: Game data is null');
          }
          throw Exception('Game data not found.');
        }
        
        if (gameData['createdBy'] != uid) {
          if (kDebugMode) {
            print('GameService: Only the creator can cancel this game');
          }
          throw Exception('Only the creator can cancel this game.');
        }

        await _firestore.collection('games').doc(gameId).update({
          'status': 'cancelled',
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        if (kDebugMode) {
          print('GameService: Game cancelled successfully');
        }
        
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error cancelling game: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error cancelling game: $e');
      }
      rethrow;
    }
  }

  Future<bool> leaveGameAsUser(String gameId, String userId) async {
    try {
      if (kDebugMode) {
        print('GameService: User $userId leaving game: $gameId');
      }
      
      if (gameId.isEmpty || userId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID or User ID cannot be empty');
        }
        throw Exception('Invalid game ID or user ID.');
      }
      
      try {
        final gameRef = _firestore.collection('games').doc(gameId);
        
        return await _firestore.runTransaction<bool>((transaction) async {
          try {
            final gameDoc = await transaction.get(gameRef);
            if (!gameDoc.exists) {
              if (kDebugMode) {
                print('GameService: Game not found for leaving');
              }
              throw Exception('Game not found.');
            }
            
            final gameData = gameDoc.data();
            if (gameData == null) {
              if (kDebugMode) {
                print('GameService: Game data is null');
              }
              throw Exception('Game data not found.');
            }
            
            final currentPlayers = List<String>.from(gameData['players'] ?? []);
            
            if (!currentPlayers.contains(userId)) {
              if (kDebugMode) {
                print('GameService: User not joined to this game');
              }
              throw Exception('User is not joined to this game.');
            }
            
            currentPlayers.remove(userId);
            
            transaction.update(gameRef, {
              'players': currentPlayers,
              'currentPlayers': currentPlayers.length,
              'updatedAt': FieldValue.serverTimestamp(),
            });
            
            if (kDebugMode) {
              print('GameService: User left game successfully');
            }
            
            return true;
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error in transaction for leaving game: $e');
            }
            rethrow;
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error leaving game: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error leaving game: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllGames() async {
    try {
      if (kDebugMode) {
        print('GameService: Getting all open games');
      }
      
      try {
        final snapshot = await _firestore.collection('games')
            .where('status', isEqualTo: 'open')
            .orderBy('gameDateTime', descending: false)
            .get();
        
        final games = snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return <String, dynamic>{'id': doc.id, ...data};
            }
            return <String, dynamic>{'id': doc.id};
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error processing game document ${doc.id}: $e');
            }
            return <String, dynamic>{'id': doc.id};
          }
        }).toList();
        
        if (kDebugMode) {
          print('GameService: Retrieved ${games.length} open games');
        }
        
        return games;
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error getting all games: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error getting all games: $e');
      }
      return [];
    }
  }

  @override
  Future<bool> addPlayerToGame(String gameId, String userId) async {
    try {
      if (kDebugMode) {
        print('GameService: Adding player $userId to game: $gameId');
      }
      
      if (gameId.isEmpty || userId.isEmpty) {
        if (kDebugMode) {
          print('GameService: Game ID or User ID cannot be empty');
        }
        throw Exception('Invalid game ID or user ID.');
      }
      
      try {
        final gameRef = _firestore.collection('games').doc(gameId);
        
        return await _firestore.runTransaction<bool>((transaction) async {
          try {
            final gameDoc = await transaction.get(gameRef);
            if (!gameDoc.exists) {
              if (kDebugMode) {
                print('GameService: Game not found for adding player');
              }
              throw Exception('Game not found.');
            }
            
            final gameData = gameDoc.data();
            if (gameData == null) {
              if (kDebugMode) {
                print('GameService: Game data is null');
              }
              throw Exception('Game data not found.');
            }
            
            final currentPlayers = List<String>.from(gameData['players'] ?? []);
            final maxPlayers = gameData['maxPlayers'] ?? 0;
            
            if (currentPlayers.contains(userId)) {
              if (kDebugMode) {
                print('GameService: User already joined this game');
              }
              throw Exception('User has already joined this game.');
            }
            
            if (currentPlayers.length >= maxPlayers) {
              if (kDebugMode) {
                print('GameService: Game is full');
              }
              throw Exception('Game is full.');
            }
            
            currentPlayers.add(userId);
            
            transaction.update(gameRef, {
              'players': currentPlayers,
              'currentPlayers': currentPlayers.length,
              'updatedAt': FieldValue.serverTimestamp(),
            });
            
            if (kDebugMode) {
              print('GameService: Player added to game successfully');
            }
            
            return true;
          } catch (e) {
            if (kDebugMode) {
              print('GameService: Error in transaction for adding player: $e');
            }
            rethrow;
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('GameService: Error adding player to game: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('GameService: Error adding player to game: $e');
      }
      rethrow;
    }
  }
}
