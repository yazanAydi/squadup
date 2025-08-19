import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ValidationService {
  static final ValidationService _instance = ValidationService._internal();
  factory ValidationService() => _instance;
  ValidationService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Validate user profile update data
  Future<bool> validateUserProfileUpdate(Map<String, dynamic> userData) async {
    try {
      if (kDebugMode) {
        print('ValidationService: Validating user profile update data');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('ValidationService: No authenticated user found for profile validation');
        }
        return false;
      }

      // Check if user exists
      try {
        final currentDoc = await _firestore.collection('users').doc(uid).get();
        if (!currentDoc.exists) {
          if (kDebugMode) {
            print('ValidationService: User document not found for validation');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error checking user existence: $e');
        }
        return false;
      }

      // Prevent manual manipulation of stats
      if (userData.containsKey('games') || userData.containsKey('mvps')) {
        if (kDebugMode) {
          print('ValidationService: Attempted to manually update stats - blocked');
        }
        return false;
      }

      // Validate sports data structure
      if (userData.containsKey('sports')) {
        try {
          final sports = userData['sports'];
          if (sports is! Map<String, dynamic>) {
            if (kDebugMode) {
              print('ValidationService: Invalid sports data structure');
            }
            return false;
          }
        } catch (e) {
          if (kDebugMode) {
            print('ValidationService: Error validating sports data: $e');
          }
          return false;
        }
      }

      // Validate required fields
      if (userData.containsKey('username')) {
        try {
          final username = userData['username']?.toString().trim();
          if (username == null || username.isEmpty || username.length < 2) {
            if (kDebugMode) {
              print('ValidationService: Invalid username: $username');
            }
            return false;
          }
        } catch (e) {
          if (kDebugMode) {
            print('ValidationService: Error validating username: $e');
          }
          return false;
        }
      }

      if (userData.containsKey('city')) {
        try {
          final city = userData['city']?.toString().trim();
          if (city == null || city.isEmpty) {
            if (kDebugMode) {
              print('ValidationService: Invalid city: $city');
            }
            return false;
          }
        } catch (e) {
          if (kDebugMode) {
            print('ValidationService: Error validating city: $e');
          }
          return false;
        }
      }

      if (kDebugMode) {
        print('ValidationService: User profile update validation passed successfully');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('ValidationService: Error validating user profile update: $e');
      }
      return false;
    }
  }

  /// Validate game creation data
  Future<bool> validateGameCreation(Map<String, dynamic> gameData) async {
    try {
      if (kDebugMode) {
        print('ValidationService: Validating game creation data');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('ValidationService: No authenticated user found for game validation');
        }
        return false;
      }

      // Validate required fields
      try {
        final name = gameData['name']?.toString().trim();
        if (name == null || name.isEmpty || name.length < 3) {
          if (kDebugMode) {
            print('ValidationService: Invalid game name: $name');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating game name: $e');
        }
        return false;
      }

      try {
        final sport = gameData['sport']?.toString();
        if (sport == null || sport.isEmpty) {
          if (kDebugMode) {
            print('ValidationService: Invalid sport: $sport');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating sport: $e');
        }
        return false;
      }

      try {
        final location = gameData['location']?.toString().trim();
        if (location == null || location.isEmpty) {
          if (kDebugMode) {
            print('ValidationService: Invalid location: $location');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating location: $e');
        }
        return false;
      }

      try {
        final maxPlayers = gameData['maxPlayers'];
        if (maxPlayers == null || maxPlayers < 2 || maxPlayers > 50) {
          if (kDebugMode) {
            print('ValidationService: Invalid max players: $maxPlayers');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating max players: $e');
        }
        return false;
      }

      try {
        final gameDateTime = gameData['gameDateTime'];
        if (gameDateTime == null || gameDateTime is! Timestamp) {
          if (kDebugMode) {
            print('ValidationService: Invalid game date/time: $gameDateTime');
          }
          return false;
        }

        // Check if game is in the future
        if (gameDateTime.toDate().isBefore(DateTime.now())) {
          if (kDebugMode) {
            print('ValidationService: Game cannot be in the past: ${gameDateTime.toDate()}');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating game date/time: $e');
        }
        return false;
      }

      if (kDebugMode) {
        print('ValidationService: Game creation validation passed successfully');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('ValidationService: Error validating game creation: $e');
      }
      return false;
    }
  }

  /// Validate team creation data
  Future<bool> validateTeamCreation(Map<String, dynamic> teamData) async {
    try {
      if (kDebugMode) {
        print('ValidationService: Validating team creation data');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('ValidationService: No authenticated user found for team validation');
        }
        return false;
      }

      // Validate required fields
      try {
        final name = teamData['name']?.toString().trim();
        if (name == null || name.isEmpty || name.length < 2) {
          if (kDebugMode) {
            print('ValidationService: Invalid team name: $name');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating team name: $e');
        }
        return false;
      }

      try {
        final sport = teamData['sport']?.toString();
        if (sport == null || sport.isEmpty) {
          if (kDebugMode) {
            print('ValidationService: Invalid sport: $sport');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating sport: $e');
        }
        return false;
      }

      try {
        final location = teamData['location']?.toString().trim();
        if (location == null || location.isEmpty) {
          if (kDebugMode) {
            print('ValidationService: Invalid location: $location');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating location: $e');
        }
        return false;
      }

      try {
        final maxMembers = teamData['maxMembers'];
        if (maxMembers == null || maxMembers < 2 || maxMembers > 20) {
          if (kDebugMode) {
            print('ValidationService: Invalid max members: $maxMembers');
          }
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error validating max members: $e');
        }
        return false;
      }

      if (kDebugMode) {
        print('ValidationService: Team creation validation passed successfully');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('ValidationService: Error validating team creation: $e');
      }
      return false;
    }
  }

  /// Check if user can modify a resource
  Future<bool> canModifyResource(String collection, String documentId) async {
    try {
      if (kDebugMode) {
        print('ValidationService: Checking if user can modify resource in $collection/$documentId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('ValidationService: No authenticated user found for resource modification check');
        }
        return false;
      }

      try {
        final doc = await _firestore.collection(collection).doc(documentId).get();
        if (!doc.exists) {
          if (kDebugMode) {
            print('ValidationService: Document not found for modification check');
          }
          return false;
        }

        final data = doc.data();
        if (data == null) {
          if (kDebugMode) {
            print('ValidationService: Document data is null for modification check');
          }
          return false;
        }

        bool canModify = false;
        
        switch (collection) {
          case 'users':
            canModify = data['uid'] == uid;
            break;
          case 'teams':
            canModify = data['createdBy'] == uid || 
                       (data['members'] as List<dynamic>?)?.contains(uid) == true;
            break;
          case 'games':
            canModify = data['createdBy'] == uid || 
                       (data['players'] as List<dynamic>?)?.contains(uid) == true;
            break;
          default:
            canModify = false;
            break;
        }
        
        if (kDebugMode) {
          print('ValidationService: User $uid can modify $collection/$documentId: $canModify');
        }
        
        return canModify;
      } catch (e) {
        if (kDebugMode) {
          print('ValidationService: Error checking resource modification permission: $e');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('ValidationService: Error checking resource modification permission: $e');
      }
      return false;
    }
  }

  /// Validate email format
  bool isValidEmail(String email) {
    try {
      if (kDebugMode) {
        print('ValidationService: Validating email format: $email');
      }
      
      if (email.isEmpty) {
        if (kDebugMode) {
          print('ValidationService: Email is empty');
        }
        return false;
      }
      
      // Basic email validation regex
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      final isValid = emailRegex.hasMatch(email);
      
      if (kDebugMode) {
        print('ValidationService: Email validation result: $isValid');
      }
      
      return isValid;
    } catch (e) {
      if (kDebugMode) {
        print('ValidationService: Error validating email: $e');
      }
      return false;
    }
  }

  /// Validate phone number format
  bool isValidPhoneNumber(String phone) {
    try {
      if (kDebugMode) {
        print('ValidationService: Validating phone number format: $phone');
      }
      
      if (phone.isEmpty) {
        if (kDebugMode) {
          print('ValidationService: Phone number is empty');
        }
        return false;
      }
      
      // Basic phone validation (allows +, digits, spaces, dashes, parentheses)
      final phoneRegex = RegExp(r'^[\+]?[0-9\s\-\(\)]{10,15}$');
      final isValid = phoneRegex.hasMatch(phone);
      
      if (kDebugMode) {
        print('ValidationService: Phone validation result: $isValid');
      }
      
      return isValid;
    } catch (e) {
      if (kDebugMode) {
        print('ValidationService: Error validating phone number: $e');
      }
      return false;
    }
  }

  /// Validate location coordinates
  bool isValidLocation(double? latitude, double? longitude) {
    try {
      if (kDebugMode) {
        print('ValidationService: Validating location coordinates: lat=$latitude, lon=$longitude');
      }
      
      if (latitude == null || longitude == null) {
        if (kDebugMode) {
          print('ValidationService: Location coordinates are null');
        }
        return false;
      }
      
      // Check if coordinates are within valid ranges
      final isValidLat = latitude >= -90 && latitude <= 90;
      final isValidLon = longitude >= -180 && longitude <= 180;
      
      if (kDebugMode) {
        print('ValidationService: Location validation result: lat=$isValidLat, lon=$isValidLon');
      }
      
      return isValidLat && isValidLon;
    } catch (e) {
      if (kDebugMode) {
        print('ValidationService: Error validating location coordinates: $e');
      }
      return false;
    }
  }
}
