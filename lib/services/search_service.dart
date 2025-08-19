import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SearchService {
  static final SearchService _instance = SearchService._internal();
  static SearchService get instance => _instance;
  
  SearchService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Advanced search for games with multiple filters
  Future<List<Map<String, dynamic>>> searchGames({
    String? query,
    String? sport,
    String? gameType,
    String? location,
    DateTime? dateFrom,
    DateTime? dateTo,
    int? minPlayers,
    int? maxPlayers,
    double? latitude,
    double? longitude,
    double? radiusKm = 10.0,
    String? skillLevel,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      if (kDebugMode) {
        print('SearchService: Starting game search with filters - sport: $sport, location: $location, limit: $limit');
      }
      
      Query queryRef = _firestore.collection('games');

      // Apply filters
      if (sport != null && sport.isNotEmpty) {
        queryRef = queryRef.where('sport', isEqualTo: sport);
      }

      if (gameType != null && gameType.isNotEmpty) {
        queryRef = queryRef.where('gameType', isEqualTo: gameType);
      }

      if (isOpen != null) {
        queryRef = queryRef.where('status', isEqualTo: isOpen ? 'open' : 'closed');
      }

      if (dateFrom != null) {
        queryRef = queryRef.where('gameDateTime', isGreaterThanOrEqualTo: dateFrom);
      }

      if (dateTo != null) {
        queryRef = queryRef.where('gameDateTime', isLessThanOrEqualTo: dateTo);
      }

      if (minPlayers != null) {
        queryRef = queryRef.where('currentPlayers', isGreaterThanOrEqualTo: minPlayers);
      }

      if (maxPlayers != null) {
        queryRef = queryRef.where('maxPlayers', isLessThanOrEqualTo: maxPlayers);
      }

      // Location-based filtering
      if (latitude != null && longitude != null && radiusKm != null) {
        final latDelta = radiusKm / 111.0;
        queryRef = queryRef
            .where('location.latitude', isGreaterThanOrEqualTo: latitude - latDelta)
            .where('location.latitude', isLessThanOrEqualTo: latitude + latDelta);
      }

      // Apply limit and ordering
      queryRef = queryRef
          .orderBy('gameDateTime', descending: false)
          .limit(limit);

      final snapshot = await queryRef.get();
      
      if (kDebugMode) {
        print('SearchService: Found ${snapshot.docs.length} games from Firestore query');
      }
      
      var games = snapshot.docs.map((doc) {
        try {
          final data = doc.data();
          // ignore: unnecessary_null_comparison
          if (data != null) {
            return <String, dynamic>{'id': doc.id, ...data as Map<String, dynamic>};
          }
          return <String, dynamic>{'id': doc.id};
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error processing game document ${doc.id}: $e');
          }
          return <String, dynamic>{'id': doc.id};
        }
      }).toList();

      // Apply additional filters that can't be done in Firestore
      if (query != null && query.isNotEmpty) {
        final queryLower = query.toLowerCase();
        games = games.where((game) {
          try {
            final name = (game['name']?.toString() ?? '').toLowerCase();
            final description = (game['description']?.toString() ?? '').toLowerCase();
            final gameLocation = (game['location']?.toString() ?? '').toLowerCase();
            
            return name.contains(queryLower) || 
                   description.contains(queryLower) || 
                   gameLocation.contains(queryLower);
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering game by query: $e');
            }
            return false;
          }
        }).toList();
      }

      if (location != null && location.isNotEmpty) {
        final locationLower = location.toLowerCase();
        games = games.where((game) {
          try {
            final gameLocation = (game['location']?.toString() ?? '').toLowerCase();
            return gameLocation.contains(locationLower);
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering game by location: $e');
            }
            return false;
          }
        }).toList();
      }

      if (skillLevel != null && skillLevel.isNotEmpty) {
        games = games.where((game) {
          try {
            final gameSkillLevel = game['skillLevel']?.toString() ?? '';
            return gameSkillLevel == skillLevel;
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering game by skill level: $e');
            }
            return false;
          }
        }).toList();
      }

      // Apply precise location filtering if coordinates provided
      if (latitude != null && longitude != null && radiusKm != null) {
        games = games.where((game) {
          try {
            final gameLat = game['location']?['latitude'] as double?;
            final gameLon = game['location']?['longitude'] as double?;
            
            if (gameLat == null || gameLon == null) return false;
            
            final distance = _calculateDistance(latitude, longitude, gameLat, gameLon);
            return distance <= radiusKm;
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering game by distance: $e');
            }
            return false;
          }
        }).toList();
      }

      // Sort by relevance (closest to search location if provided)
      if (latitude != null && longitude != null) {
        try {
          games.sort((a, b) {
            try {
              final aLat = a['location']?['latitude'] as double?;
              final aLon = a['location']?['longitude'] as double?;
              final bLat = b['location']?['latitude'] as double?;
              final bLon = b['location']?['longitude'] as double?;
              
              if (aLat == null || aLon == null) return 1;
              if (bLat == null || bLon == null) return -1;
              
              final aDistance = _calculateDistance(latitude, longitude, aLat, aLon);
              final bDistance = _calculateDistance(latitude, longitude, bLat, bLon);
              
              return aDistance.compareTo(bDistance);
            } catch (e) {
              if (kDebugMode) {
                print('SearchService: Error comparing game distances: $e');
              }
              return 0;
            }
          });
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error sorting games by distance: $e');
          }
        }
      }

      if (kDebugMode) {
        print('SearchService: Game search completed successfully. Returning ${games.length} games');
      }
      
      return games;
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error searching games: $e');
      }
      throw Exception('Unable to search games. Please check your connection and try again.');
    }
  }

  /// Advanced search for teams with multiple filters
  Future<List<Map<String, dynamic>>> searchTeams({
    String? query,
    String? sport,
    String? location,
    String? skillLevel,
    int? minMembers,
    int? maxMembers,
    bool? isRecruiting,
    double? latitude,
    double? longitude,
    double? radiusKm = 10.0,
    int limit = 50,
  }) async {
    try {
      if (kDebugMode) {
        print('SearchService: Starting team search with filters - sport: $sport, location: $location, limit: $limit');
      }
      
      Query queryRef = _firestore.collection('teams');

      // Apply filters
      if (sport != null && sport.isNotEmpty) {
        queryRef = queryRef.where('sport', isEqualTo: sport);
      }

      if (isRecruiting != null) {
        queryRef = queryRef.where('isRecruiting', isEqualTo: isRecruiting);
      }

      if (minMembers != null) {
        queryRef = queryRef.where('memberCount', isGreaterThanOrEqualTo: minMembers);
      }

      if (maxMembers != null) {
        queryRef = queryRef.where('memberCount', isLessThanOrEqualTo: maxMembers);
      }

      // Location-based filtering
      if (latitude != null && longitude != null && radiusKm != null) {
        final latDelta = radiusKm / 111.0;
        queryRef = queryRef
            .where('location.latitude', isGreaterThanOrEqualTo: latitude - latDelta)
            .where('location.latitude', isLessThanOrEqualTo: latitude + latDelta);
      }

      // Apply limit and ordering
      queryRef = queryRef
          .orderBy('createdAt', descending: true)
          .limit(limit);

      final snapshot = await queryRef.get();
      
      if (kDebugMode) {
        print('SearchService: Found ${snapshot.docs.length} teams from Firestore query');
      }
      
      var teams = snapshot.docs.map((doc) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          return <String, dynamic>{'id': doc.id, ...data};
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error processing team document ${doc.id}: $e');
          }
          return <String, dynamic>{'id': doc.id};
        }
      }).toList();

      // Apply additional filters
      if (query != null && query.isNotEmpty) {
        final queryLower = query.toLowerCase();
        teams = teams.where((team) {
          try {
            final name = (team['name']?.toString() ?? '').toLowerCase();
            final description = (team['description']?.toString() ?? '').toLowerCase();
            final teamLocation = (team['location']?.toString() ?? '').toLowerCase();
            
            return name.contains(queryLower) || 
                   description.contains(queryLower) || 
                   teamLocation.contains(queryLower);
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering team by query: $e');
            }
            return false;
          }
        }).toList();
      }

      if (location != null && location.isNotEmpty) {
        final locationLower = location.toLowerCase();
        teams = teams.where((team) {
          try {
            final teamLocation = (team['location']?.toString() ?? '').toLowerCase();
            return teamLocation.contains(locationLower);
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering team by location: $e');
            }
            return false;
          }
        }).toList();
      }

      if (skillLevel != null && skillLevel.isNotEmpty) {
        teams = teams.where((team) {
          try {
            final teamSkillLevel = team['skillLevel']?.toString() ?? '';
            return teamSkillLevel == skillLevel;
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering team by skill level: $e');
            }
            return false;
          }
        }).toList();
      }

      // Apply precise location filtering
      if (latitude != null && longitude != null && radiusKm != null) {
        teams = teams.where((team) {
          try {
            final teamLat = team['location']?['latitude'] as double?;
            final teamLon = team['location']?['longitude'] as double?;
            
            if (teamLat == null || teamLon == null) return false;
            
            final distance = _calculateDistance(latitude, longitude, teamLat, teamLon);
            return distance <= radiusKm;
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering team by distance: $e');
            }
            return false;
          }
        }).toList();
      }

      // Sort by relevance
      if (latitude != null && longitude != null) {
        try {
          teams.sort((a, b) {
            try {
              final aLat = a['location']?['latitude'] as double?;
              final aLon = a['location']?['longitude'] as double?;
              final bLat = b['location']?['latitude'] as double?;
              final bLon = b['location']?['longitude'] as double?;
              
              if (aLat == null || aLon == null) return 1;
              if (bLat == null || bLon == null) return -1;
              
              final aDistance = _calculateDistance(latitude, longitude, aLat, aLon);
              final bDistance = _calculateDistance(latitude, longitude, bLat, bLon);
              
              return aDistance.compareTo(bDistance);
            } catch (e) {
              if (kDebugMode) {
                print('SearchService: Error comparing team distances: $e');
              }
              return 0;
            }
          });
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error sorting teams by distance: $e');
          }
        }
      }

      if (kDebugMode) {
        print('SearchService: Team search completed successfully. Returning ${teams.length} teams');
      }
      
      return teams;
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error searching teams: $e');
      }
      throw Exception('Unable to search teams. Please check your connection and try again.');
    }
  }

  /// Search for users with specific criteria
  Future<List<Map<String, dynamic>>> searchUsers({
    String? query,
    List<String>? sports,
    String? skillLevel,
    String? location,
    double? latitude,
    double? longitude,
    double? radiusKm = 10.0,
    int limit = 50,
  }) async {
    try {
      if (kDebugMode) {
        print('SearchService: Starting user search with filters - skillLevel: $skillLevel, location: $location, limit: $limit');
      }
      
      Query queryRef = _firestore.collection('users');

      // Apply filters
      if (skillLevel != null && skillLevel.isNotEmpty) {
        queryRef = queryRef.where('level', isEqualTo: skillLevel);
      }

      // Location-based filtering
      if (latitude != null && longitude != null && radiusKm != null) {
        final latDelta = radiusKm / 111.0;
        queryRef = queryRef
            .where('location.latitude', isGreaterThanOrEqualTo: latitude - latDelta)
            .where('location.latitude', isLessThanOrEqualTo: latitude + latDelta);
      }

      // Apply limit and ordering
      queryRef = queryRef
          .orderBy('createdAt', descending: true)
          .limit(limit);

      final snapshot = await queryRef.get();
      
      if (kDebugMode) {
        print('SearchService: Found ${snapshot.docs.length} users from Firestore query');
      }
      
      var users = snapshot.docs.map((doc) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          return <String, dynamic>{'id': doc.id, ...data};
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error processing user document ${doc.id}: $e');
          }
          return <String, dynamic>{'id': doc.id};
        }
      }).toList();

      // Apply additional filters
      if (query != null && query.isNotEmpty) {
        final queryLower = query.toLowerCase();
        users = users.where((user) {
          try {
            final username = (user['username']?.toString() ?? '').toLowerCase();
            final bio = (user['bio']?.toString() ?? '').toLowerCase();
            final userLocation = (user['city']?.toString() ?? '').toLowerCase();
            
            return username.contains(queryLower) || 
                   bio.contains(queryLower) || 
                   userLocation.contains(queryLower);
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering user by query: $e');
            }
            return false;
          }
        }).toList();
      }

      if (sports != null && sports.isNotEmpty) {
        users = users.where((user) {
          try {
            final userSports = user['sports'];
            if (userSports == null) return false;
            
            if (userSports is Map) {
              return sports.any((sport) => userSports.containsKey(sport));
            } else if (userSports is List) {
              return sports.any((sport) => userSports.contains(sport));
            }
            
            return false;
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering user by sports: $e');
            }
            return false;
          }
        }).toList();
      }

      if (location != null && location.isNotEmpty) {
        final locationLower = location.toLowerCase();
        users = users.where((user) {
          try {
            final userLocation = (user['city']?.toString() ?? '').toLowerCase();
            return userLocation.contains(locationLower);
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering user by location: $e');
            }
            return false;
          }
        }).toList();
      }

      // Apply precise location filtering
      if (latitude != null && longitude != null && radiusKm != null) {
        users = users.where((user) {
          try {
            final userLat = user['location']?['latitude'] as double?;
            final userLon = user['location']?['longitude'] as double?;
            
            if (userLat == null || userLon == null) return false;
            
            final distance = _calculateDistance(latitude, longitude, userLat, userLon);
            return distance <= radiusKm;
          } catch (e) {
            if (kDebugMode) {
              print('SearchService: Error filtering user by distance: $e');
            }
            return false;
          }
        }).toList();
      }

      // Sort by relevance
      if (latitude != null && longitude != null) {
        try {
          users.sort((a, b) {
            try {
              final aLat = a['location']?['latitude'] as double?;
              final aLon = a['location']?['longitude'] as double?;
              final bLat = b['location']?['latitude'] as double?;
              final bLon = b['location']?['longitude'] as double?;
              
              if (aLat == null || aLon == null) return 1;
              if (bLat == null || bLon == null) return -1;
              
              final aDistance = _calculateDistance(latitude, longitude, aLat, aLon);
              final bDistance = _calculateDistance(latitude, longitude, bLat, bLon);
              
              return aDistance.compareTo(bDistance);
            } catch (e) {
              if (kDebugMode) {
                print('SearchService: Error comparing user distances: $e');
              }
              return 0;
            }
          });
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error sorting users by distance: $e');
          }
        }
      }

      if (kDebugMode) {
        print('SearchService: User search completed successfully. Returning ${users.length} users');
      }
      
      return users;
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error searching users: $e');
      }
      throw Exception('Unable to search users. Please check your connection and try again.');
    }
  }

  /// Get trending sports based on recent activity
  Future<List<Map<String, dynamic>>> getTrendingSports({int limit = 10}) async {
    try {
      if (kDebugMode) {
        print('SearchService: Getting trending sports with limit: $limit');
      }
      
      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));
      
      final gamesSnapshot = await _firestore
          .collection('games')
          .where('createdAt', isGreaterThanOrEqualTo: weekAgo)
          .get();

      final sportCounts = <String, int>{};
      
      for (final doc in gamesSnapshot.docs) {
        try {
          final sport = doc.data()['sport'] as String?;
          if (sport != null) {
            sportCounts[sport] = (sportCounts[sport] ?? 0) + 1;
          }
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error processing sport from game ${doc.id}: $e');
          }
          // Continue processing other games
        }
      }

      final sortedSports = sportCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final result = sortedSports.take(limit).map((entry) => {
        'sport': entry.key,
        'count': entry.value,
        'trend': 'up', // Could be calculated based on previous period
      }).toList();
      
      if (kDebugMode) {
        print('SearchService: Retrieved ${result.length} trending sports');
      }
      
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error getting trending sports: $e');
      }
      return [];
    }
  }

  /// Get popular locations based on game activity
  Future<List<Map<String, dynamic>>> getPopularLocations({int limit = 10}) async {
    try {
      if (kDebugMode) {
        print('SearchService: Getting popular locations with limit: $limit');
      }
      
      final now = DateTime.now();
      final monthAgo = now.subtract(const Duration(days: 30));
      
      final gamesSnapshot = await _firestore
          .collection('games')
          .where('createdAt', isGreaterThanOrEqualTo: monthAgo)
          .get();

      final locationCounts = <String, int>{};
      
      for (final doc in gamesSnapshot.docs) {
        try {
          final location = doc.data()['location'] as String?;
          if (location != null) {
            locationCounts[location] = (locationCounts[location] ?? 0) + 1;
          }
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error processing location from game ${doc.id}: $e');
          }
          // Continue processing other games
        }
      }

      final sortedLocations = locationCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final result = sortedLocations.take(limit).map((entry) => {
        'location': entry.key,
        'count': entry.value,
        'popularity': 'high', // Could be calculated based on activity level
      }).toList();
      
      if (kDebugMode) {
        print('SearchService: Retrieved ${result.length} popular locations');
      }
      
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error getting popular locations: $e');
      }
      return [];
    }
  }

  /// Calculate distance between two points using Haversine formula
  double _calculateDistance(double? lat1, double? lon1, double? lat2, double? lon2) {
    try {
      if (lat1 == null || lon1 == null || lat2 == null || lon2 == null) {
        if (kDebugMode) {
          print('SearchService: Invalid coordinates for distance calculation');
        }
        return double.infinity; // Return infinity for invalid coordinates
      }
      
      const double earthRadius = 6371; // Earth's radius in kilometers
      
      final dLat = _degreesToRadians(lat2 - lat1);
      final dLon = _degreesToRadians(lon2 - lon1);
      
      final a = sin(dLat / 2) * sin(dLat / 2) +
                cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
                sin(dLon / 2) * sin(dLon / 2);
      
      final c = 2 * atan2(sqrt(a), sqrt(1 - a));
      
      return earthRadius * c;
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error calculating distance: $e');
      }
      return double.infinity;
    }
  }

  /// Convert degrees to radians
  double _degreesToRadians(double degrees) {
    try {
      return degrees * (pi / 180);
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error converting degrees to radians: $e');
      }
      return 0.0;
    }
  }

  /// Get search suggestions based on user's history and preferences
  Future<List<String>> getSearchSuggestions({
    String? query,
    String? type, // 'games', 'teams', 'users'
    int limit = 5,
  }) async {
    try {
      if (kDebugMode) {
        print('SearchService: Getting search suggestions for type: $type, query: $query, limit: $limit');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('SearchService: No authenticated user found for search suggestions');
        }
        return [];
      }

      final suggestions = <String>{};

      // Get suggestions based on type
      if (type == 'games') {
        try {
          final games = await searchGames(limit: 20);
          for (final game in games) {
            try {
              final name = game['name']?.toString();
              final sport = game['sport']?.toString();
              final location = game['location']?.toString();
              
              if (name != null && name.isNotEmpty) suggestions.add(name);
              if (sport != null && sport.isNotEmpty) suggestions.add(sport);
              if (location != null && location.isNotEmpty) suggestions.add(location);
            } catch (e) {
              if (kDebugMode) {
                print('SearchService: Error processing game suggestion: $e');
              }
              // Continue with other games
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error getting game suggestions: $e');
          }
        }
      } else if (type == 'teams') {
        try {
          final teams = await searchTeams(limit: 20);
          for (final team in teams) {
            try {
              final name = team['name']?.toString();
              final sport = team['sport']?.toString();
              final location = team['location']?.toString();
              
              if (name != null && name.isNotEmpty) suggestions.add(name);
              if (sport != null && sport.isNotEmpty) suggestions.add(sport);
              if (location != null && location.isNotEmpty) suggestions.add(location);
            } catch (e) {
              if (kDebugMode) {
                print('SearchService: Error processing team suggestion: $e');
              }
              // Continue with other teams
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error getting team suggestions: $e');
          }
        }
      }

      // Filter suggestions based on query
      if (query != null && query.isNotEmpty) {
        try {
          final queryLower = query.toLowerCase();
          suggestions.removeWhere((suggestion) => 
            !suggestion.toLowerCase().contains(queryLower)
          );
        } catch (e) {
          if (kDebugMode) {
            print('SearchService: Error filtering suggestions by query: $e');
          }
        }
      }

      final result = suggestions.take(limit).toList();
      
      if (kDebugMode) {
        print('SearchService: Retrieved ${result.length} search suggestions');
      }
      
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('SearchService: Error getting search suggestions: $e');
      }
      return [];
    }
  }
}
