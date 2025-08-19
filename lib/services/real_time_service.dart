import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RealTimeService {
  static final RealTimeService _instance = RealTimeService._internal();
  static RealTimeService get instance => _instance;
  
  RealTimeService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Stream controllers for different data types
  final Map<String, StreamController<Map<String, dynamic>>> _gameStreams = {};
  final Map<String, StreamController<Map<String, dynamic>>> _teamStreams = {};
  final Map<String, StreamController<Map<String, dynamic>>> _userStreams = {};
  
  // Active listeners
  final Map<String, StreamSubscription> _activeListeners = {};

  /// Get real-time updates for a specific game
  Stream<Map<String, dynamic>> getGameUpdates(String gameId) {
    try {
      if (gameId.isEmpty) {
        throw Exception('Game ID cannot be empty');
      }
      
      if (_gameStreams.containsKey(gameId)) {
        if (kDebugMode) {
          print('RealTimeService: Returning existing game stream for $gameId');
        }
        return _gameStreams[gameId]!.stream;
      }

      if (kDebugMode) {
        print('RealTimeService: Creating new game stream for $gameId');
      }
      
      final controller = StreamController<Map<String, dynamic>>.broadcast();
      _gameStreams[gameId] = controller;

      _listenToGame(gameId, controller);
      return controller.stream;
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error getting game updates for $gameId: $e');
      }
      // Return a stream that immediately emits an error
      final errorController = StreamController<Map<String, dynamic>>.broadcast();
      errorController.addError('Unable to get game updates. Please try again later.');
      errorController.close();
      return errorController.stream;
    }
  }

  /// Get real-time updates for a specific team
  Stream<Map<String, dynamic>> getTeamUpdates(String teamId) {
    try {
      if (teamId.isEmpty) {
        throw Exception('Team ID cannot be empty');
      }
      
      if (_teamStreams.containsKey(teamId)) {
        if (kDebugMode) {
          print('RealTimeService: Returning existing team stream for $teamId');
        }
        return _teamStreams[teamId]!.stream;
      }

      if (kDebugMode) {
        print('RealTimeService: Creating new team stream for $teamId');
      }
      
      final controller = StreamController<Map<String, dynamic>>.broadcast();
      _teamStreams[teamId] = controller;

      _listenToTeam(teamId, controller);
      return controller.stream;
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error getting team updates for $teamId: $e');
      }
      // Return a stream that immediately emits an error
      final errorController = StreamController<Map<String, dynamic>>.broadcast();
      errorController.addError('Unable to get team updates. Please try again later.');
      errorController.close();
      return errorController.stream;
    }
  }

  /// Get real-time updates for user's games
  Stream<List<Map<String, dynamic>>> getUserGamesUpdates() {
    try {
      const key = 'user_games';
      if (_userStreams.containsKey(key)) {
        if (kDebugMode) {
          print('RealTimeService: Returning existing user games stream');
        }
        return _userStreams[key]!.stream.map((data) => 
          List<Map<String, dynamic>>.from(data['games'] ?? [])
        );
      }

      if (kDebugMode) {
        print('RealTimeService: Creating new user games stream');
      }
      
      final controller = StreamController<Map<String, dynamic>>.broadcast();
      _userStreams[key] = controller;

      _listenToUserGames(controller);
      return controller.stream.map((data) => 
        List<Map<String, dynamic>>.from(data['games'] ?? [])
      );
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error getting user games updates: $e');
      }
      // Return a stream that immediately emits an error
      final errorController = StreamController<List<Map<String, dynamic>>>.broadcast();
      errorController.addError('Unable to get user games updates. Please try again later.');
      errorController.close();
      return errorController.stream;
    }
  }

  /// Get real-time updates for user's teams
  Stream<List<Map<String, dynamic>>> getUserTeamsUpdates() {
    try {
      const key = 'user_teams';
      if (_userStreams.containsKey(key)) {
        if (kDebugMode) {
          print('RealTimeService: Returning existing user teams stream');
        }
        return _userStreams[key]!.stream.map((data) => 
          List<Map<String, dynamic>>.from(data['teams'] ?? [])
        );
      }

      if (kDebugMode) {
        print('RealTimeService: Creating new user teams stream');
      }
      
      final controller = StreamController<Map<String, dynamic>>.broadcast();
      _userStreams[key] = controller;

      _listenToUserTeams(controller);
      return controller.stream.map((data) => 
        List<Map<String, dynamic>>.from(data['teams'] ?? [])
      );
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error getting user teams updates: $e');
      }
      // Return a stream that immediately emits an error
      final errorController = StreamController<List<Map<String, dynamic>>>.broadcast();
      errorController.addError('Unable to get user teams updates. Please try again later.');
      errorController.close();
      return errorController.stream;
    }
  }

  /// Listen to game updates
  void _listenToGame(String gameId, StreamController<Map<String, dynamic>> controller) {
    try {
      if (kDebugMode) {
        print('RealTimeService: Setting up game listener for $gameId');
      }
      
      final subscription = _firestore
          .collection('games')
          .doc(gameId)
          .snapshots()
          .listen(
        (snapshot) {
          try {
            if (snapshot.exists && snapshot.data() != null) {
              final data = snapshot.data()!;
              final gameData = {'id': snapshot.id, ...data};
              controller.add(gameData);
              
              if (kDebugMode) {
                print('RealTimeService: Game update received for $gameId');
              }
            } else {
              if (kDebugMode) {
                print('RealTimeService: Game $gameId not found or has no data');
              }
              controller.addError('Game not found or has no data');
            }
          } catch (e) {
            if (kDebugMode) {
              print('RealTimeService: Error processing game snapshot for $gameId: $e');
            }
            controller.addError('Unable to process game data. Please try again later.');
          }
        },
        onError: (error) {
          if (kDebugMode) {
            print('RealTimeService: Error listening to game $gameId: $error');
          }
          controller.addError('Unable to listen to game updates. Please try again later.');
        },
      );

      _activeListeners['game_$gameId'] = subscription;
      
      if (kDebugMode) {
        print('RealTimeService: Game listener set up successfully for $gameId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error setting up game listener for $gameId: $e');
      }
      controller.addError('Unable to set up game listener. Please try again later.');
    }
  }

  /// Listen to team updates
  void _listenToTeam(String teamId, StreamController<Map<String, dynamic>> controller) {
    try {
      if (kDebugMode) {
        print('RealTimeService: Setting up team listener for $teamId');
      }
      
      final subscription = _firestore
          .collection('teams')
          .doc(teamId)
          .snapshots()
          .listen(
        (snapshot) {
          try {
            if (snapshot.exists && snapshot.data() != null) {
              final data = snapshot.data()!;
              final teamData = {'id': snapshot.id, ...data};
              controller.add(teamData);
              
              if (kDebugMode) {
                print('RealTimeService: Team update received for $teamId');
              }
            } else {
              if (kDebugMode) {
                print('RealTimeService: Team $teamId not found or has no data');
              }
              controller.addError('Team not found or has no data');
            }
          } catch (e) {
            if (kDebugMode) {
              print('RealTimeService: Error processing team snapshot for $teamId: $e');
            }
            controller.addError('Unable to process team data. Please try again later.');
          }
        },
        onError: (error) {
          if (kDebugMode) {
            print('RealTimeService: Error listening to team $teamId: $error');
          }
          controller.addError('Unable to listen to team updates. Please try again later.');
        },
      );

      _activeListeners['team_$teamId'] = subscription;
      
      if (kDebugMode) {
        print('RealTimeService: Team listener set up successfully for $teamId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error setting up team listener for $teamId: $e');
      }
      controller.addError('Unable to set up team listener. Please try again later.');
    }
  }

  /// Listen to user's games
  void _listenToUserGames(StreamController<Map<String, dynamic>> controller) {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('RealTimeService: No authenticated user found for user games listener');
        }
        controller.addError('User not authenticated. Please sign in again.');
        return;
      }

      if (kDebugMode) {
        print('RealTimeService: Setting up user games listener for user $uid');
      }

      final subscription = _firestore
          .collection('games')
          .where('players', arrayContains: uid)
          .snapshots()
          .listen(
        (snapshot) {
          try {
            final games = snapshot.docs.map((doc) {
              final data = doc.data();
              // ignore: unnecessary_null_comparison
              if (data != null) {
                return {'id': doc.id, ...data};
              }
              return {'id': doc.id};
            }).toList();
            
            controller.add({'games': games});
            
            if (kDebugMode) {
              print('RealTimeService: User games update received: ${games.length} games');
            }
          } catch (e) {
            if (kDebugMode) {
              print('RealTimeService: Error processing user games snapshot: $e');
            }
            controller.addError('Unable to process user games data. Please try again later.');
          }
        },
        onError: (error) {
          if (kDebugMode) {
            print('RealTimeService: Error listening to user games: $error');
          }
          controller.addError('Unable to listen to user games updates. Please try again later.');
        },
      );

      _activeListeners['user_games'] = subscription;
      
      if (kDebugMode) {
        print('RealTimeService: User games listener set up successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error setting up user games listener: $e');
      }
      controller.addError('Unable to set up user games listener. Please try again later.');
    }
  }

  /// Listen to user's teams
  void _listenToUserTeams(StreamController<Map<String, dynamic>> controller) {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('RealTimeService: No authenticated user found for user teams listener');
        }
        controller.addError('User not authenticated. Please sign in again.');
        return;
      }

      if (kDebugMode) {
        print('RealTimeService: Setting up user teams listener for user $uid');
      }

      final subscription = _firestore
          .collection('teams')
          .where('members', arrayContains: uid)
          .snapshots()
          .listen(
        (snapshot) {
          try {
            final teams = snapshot.docs.map((doc) {
              final data = doc.data();
              // ignore: unnecessary_null_comparison
              if (data != null) {
                return {'id': doc.id, ...data};
              }
              return {'id': doc.id};
            }).toList();
            
            controller.add({'teams': teams});
            
            if (kDebugMode) {
              print('RealTimeService: User teams update received: ${teams.length} teams');
            }
          } catch (e) {
            if (kDebugMode) {
              print('RealTimeService: Error processing user teams snapshot: $e');
            }
            controller.addError('Unable to process user teams data. Please try again later.');
          }
        },
        onError: (error) {
          if (kDebugMode) {
            print('RealTimeService: Error listening to user teams: $error');
          }
          controller.addError('Unable to listen to user teams updates. Please try again later.');
        },
      );

      _activeListeners['user_teams'] = subscription;
      
      if (kDebugMode) {
        print('RealTimeService: User teams listener set up successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error setting up user teams listener: $e');
      }
      controller.addError('Unable to set up user teams listener. Please try again later.');
    }
  }

  /// Get real-time notifications for user
  Stream<List<Map<String, dynamic>>> getUserNotifications() {
    try {
      const key = 'user_notifications';
      if (_userStreams.containsKey(key)) {
        if (kDebugMode) {
          print('RealTimeService: Returning existing user notifications stream');
        }
        return _userStreams[key]!.stream.map((data) => 
          List<Map<String, dynamic>>.from(data['notifications'] ?? [])
        );
      }

      if (kDebugMode) {
        print('RealTimeService: Creating new user notifications stream');
      }
      
      final controller = StreamController<Map<String, dynamic>>.broadcast();
      _userStreams[key] = controller;

      _listenToUserNotifications(controller);
      return controller.stream.map((data) => 
        List<Map<String, dynamic>>.from(data['notifications'] ?? [])
      );
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error getting user notifications: $e');
      }
      // Return a stream that immediately emits an error
      final errorController = StreamController<List<Map<String, dynamic>>>.broadcast();
      errorController.addError('Unable to get user notifications. Please try again later.');
      errorController.close();
      return errorController.stream;
    }
  }

  /// Listen to user notifications
  void _listenToUserNotifications(StreamController<Map<String, dynamic>> controller) {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('RealTimeService: No authenticated user found for notifications listener');
        }
        controller.addError('User not authenticated. Please sign in again.');
        return;
      }

      if (kDebugMode) {
        print('RealTimeService: Setting up user notifications listener for user $uid');
      }

      final subscription = _firestore
          .collection('team_invitations')
          .where('userId', isEqualTo: uid)
          .where('status', isEqualTo: 'pending')
          .snapshots()
          .listen(
        (snapshot) {
          try {
            final notifications = snapshot.docs.map((doc) {
              final data = doc.data();
              // ignore: unnecessary_null_comparison
              if (data != null) {
                return {'id': doc.id, ...data};
              }
              return {'id': doc.id};
            }).toList();
            
            controller.add({'notifications': notifications});
            
            if (kDebugMode) {
              print('RealTimeService: User notifications update received: ${notifications.length} notifications');
            }
          } catch (e) {
            if (kDebugMode) {
              print('RealTimeService: Error processing user notifications snapshot: $e');
            }
            controller.addError('Unable to process notifications data. Please try again later.');
          }
        },
        onError: (error) {
          if (kDebugMode) {
            print('RealTimeService: Error listening to user notifications: $error');
          }
          controller.addError('Unable to listen to notifications updates. Please try again later.');
        },
      );

      _activeListeners['user_notifications'] = subscription;
      
      if (kDebugMode) {
        print('RealTimeService: User notifications listener set up successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error setting up user notifications listener: $e');
      }
      controller.addError('Unable to set up notifications listener. Please try again later.');
    }
  }

  /// Get real-time updates for nearby games
  Stream<List<Map<String, dynamic>>> getNearbyGamesUpdates({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) {
    try {
      final key = 'nearby_games_${latitude}_${longitude}_$radiusKm';
      if (_gameStreams.containsKey(key)) {
        if (kDebugMode) {
          print('RealTimeService: Returning existing nearby games stream');
        }
        return _gameStreams[key]!.stream.map((data) => 
          List<Map<String, dynamic>>.from(data['games'] ?? [])
        );
      }

      if (kDebugMode) {
        print('RealTimeService: Creating new nearby games stream');
      }
      
      final controller = StreamController<Map<String, dynamic>>.broadcast();
      _gameStreams[key] = controller;

      _listenToNearbyGames(controller, latitude, longitude, radiusKm);
      return controller.stream.map((data) => 
        List<Map<String, dynamic>>.from(data['games'] ?? [])
      );
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error getting nearby games updates: $e');
      }
      // Return a stream that immediately emits an error
      final errorController = StreamController<List<Map<String, dynamic>>>.broadcast();
      errorController.addError('Unable to get nearby games updates. Please try again later.');
      errorController.close();
      return errorController.stream;
    }
  }

  /// Listen to nearby games
  void _listenToNearbyGames(
    StreamController<Map<String, dynamic>> controller,
    double latitude,
    double longitude,
    double radiusKm,
  ) {
    try {
      if (kDebugMode) {
        print('RealTimeService: Setting up nearby games listener for lat: $latitude, lon: $longitude, radius: $radiusKm km');
      }
      
      // Calculate bounding box for location-based query
      final latDelta = radiusKm / 111.0; // Approximate km per degree latitude
      
      final subscription = _firestore
          .collection('games')
          .where('location.latitude', isGreaterThanOrEqualTo: latitude - latDelta)
          .where('location.latitude', isLessThanOrEqualTo: latitude + latDelta)
          .where('status', isEqualTo: 'open')
          .snapshots()
          .listen(
        (snapshot) {
          try {
            final games = snapshot.docs.map((doc) {
              final data = doc.data();
              // ignore: unnecessary_null_comparison
              if (data != null) {
                return {'id': doc.id, ...data};
              }
              return {'id': doc.id};
            }).where((game) {
              // Filter by longitude and calculate actual distance
              final gameLat = game['location']?['latitude'] as double?;
              final gameLon = game['location']?['longitude'] as double?;
              
              if (gameLat == null || gameLon == null) return false;
              
              // Simple distance calculation (can be improved with Haversine formula)
              final latDiff = (gameLat - latitude).abs();
              final lonDiff = (gameLon - longitude).abs();
              final distance = sqrt(latDiff * latDiff + lonDiff * lonDiff) * 111.0;
              
              return distance <= radiusKm;
            }).toList();
            
            controller.add({'games': games});
            
            if (kDebugMode) {
              print('RealTimeService: Nearby games update received: ${games.length} games within $radiusKm km');
            }
          } catch (e) {
            if (kDebugMode) {
              print('RealTimeService: Error processing nearby games snapshot: $e');
            }
            controller.addError('Unable to process nearby games data. Please try again later.');
          }
        },
        onError: (error) {
          if (kDebugMode) {
            print('RealTimeService: Error listening to nearby games: $error');
          }
          controller.addError('Unable to listen to nearby games updates. Please try again later.');
        },
      );

      _activeListeners['nearby_games_${latitude}_${longitude}_$radiusKm'] = subscription;
      
      if (kDebugMode) {
        print('RealTimeService: Nearby games listener set up successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error setting up nearby games listener: $e');
      }
      controller.addError('Unable to set up nearby games listener. Please try again later.');
    }
  }

  /// Stop listening to specific updates
  void stopListening(String key) {
    try {
      final subscription = _activeListeners[key];
      if (subscription != null) {
        subscription.cancel();
        _activeListeners.remove(key);
        
        if (kDebugMode) {
          print('RealTimeService: Stopped listening to $key');
        }
      } else {
        if (kDebugMode) {
          print('RealTimeService: No active listener found for $key');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error stopping listener for $key: $e');
      }
    }
  }

  /// Stop listening to game updates
  void stopListeningToGame(String gameId) {
    try {
      stopListening('game_$gameId');
      _gameStreams.remove(gameId);
      
      if (kDebugMode) {
        print('RealTimeService: Stopped listening to game $gameId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error stopping game listener for $gameId: $e');
      }
    }
  }

  /// Stop listening to team updates
  void stopListeningToTeam(String teamId) {
    try {
      stopListening('team_$teamId');
      _teamStreams.remove(teamId);
      
      if (kDebugMode) {
        print('RealTimeService: Stopped listening to team $teamId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error stopping team listener for $teamId: $e');
      }
    }
  }

  /// Stop listening to user updates
  void stopListeningToUser(String key) {
    try {
      stopListening(key);
      _userStreams.remove(key);
      
      if (kDebugMode) {
        print('RealTimeService: Stopped listening to user updates for $key');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error stopping user listener for $key: $e');
      }
    }
  }

  /// Stop all listeners
  void stopAllListeners() {
    try {
      if (kDebugMode) {
        print('RealTimeService: Stopping all listeners...');
      }
      
      for (final subscription in _activeListeners.values) {
        try {
          subscription.cancel();
        } catch (e) {
          if (kDebugMode) {
            print('RealTimeService: Error cancelling subscription: $e');
          }
        }
      }
      _activeListeners.clear();
      
      for (final controller in _gameStreams.values) {
        try {
          controller.close();
        } catch (e) {
          if (kDebugMode) {
            print('RealTimeService: Error closing game stream controller: $e');
          }
        }
      }
      _gameStreams.clear();
      
      for (final controller in _teamStreams.values) {
        try {
          controller.close();
        } catch (e) {
          if (kDebugMode) {
            print('RealTimeService: Error closing team stream controller: $e');
          }
        }
      }
      _teamStreams.clear();
      
      for (final controller in _userStreams.values) {
        try {
          controller.close();
        } catch (e) {
          if (kDebugMode) {
            print('RealTimeService: Error closing user stream controller: $e');
          }
        }
      }
      _userStreams.clear();
      
      if (kDebugMode) {
        print('RealTimeService: All real-time listeners stopped successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error stopping all listeners: $e');
      }
    }
  }

  /// Dispose the service
  void dispose() {
    try {
      if (kDebugMode) {
        print('RealTimeService: Disposing service...');
      }
      stopAllListeners();
      
      if (kDebugMode) {
        print('RealTimeService: Service disposed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('RealTimeService: Error disposing service: $e');
      }
    }
  }
}
