import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../interfaces/team_service_interface.dart';
import '../../models/team.dart';
import '../../utils/data_service.dart';

class TeamService implements TeamServiceInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DataService _dataService = DataService.instance;

  @override
  Stream<List<Team>> getTeamsStream() {
    return _firestore
        .collection('teams')
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs
            .map((doc) => Team.fromFirestore(doc))
            .toList());
  }

  @override
  Future<int> getPendingInvitationsCount() async {
    try {
      if (kDebugMode) {
        print('TeamService: Getting pending invitations count');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for invitations count');
        }
        return 0;
      }

      try {
        final teamsQuery = await _firestore
            .collection('teams')
            .where('pendingRequests', arrayContains: uid)
            .get();

        final count = teamsQuery.docs.length;
        
        if (kDebugMode) {
          print('TeamService: Found $count pending invitations');
        }
        
        return count;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error getting pending invitations count: $e');
        }
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error getting pending invitations count: $e');
      }
      return 0;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUserTeams() async {
    try {
      if (kDebugMode) {
        print('TeamService: Getting user teams');
      }
      
      final userData = await _dataService.getUserData();
      if (userData == null) {
        if (kDebugMode) {
          print('TeamService: No user data found for teams');
        }
        return [];
      }

      try {
        final teamIds = List<String>.from(userData['teams'] ?? []);
        if (teamIds.isEmpty) {
          if (kDebugMode) {
            print('TeamService: User has no teams');
          }
          return [];
        }

        final teams = await _dataService.getTeamsData();
        final userTeams = teams.where((team) => teamIds.contains(team['id'])).toList();
        
        if (kDebugMode) {
          print('TeamService: Retrieved ${userTeams.length} user teams');
        }
        
        return userTeams;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error processing user teams: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error getting user teams: $e');
      }
      return [];
    }
  }

  @override
  Future<bool> createTeam(Map<String, dynamic> teamData) async {
    try {
      if (kDebugMode) {
        print('TeamService: Creating team with data: ${teamData.keys.toList()}');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for team creation');
        }
        throw Exception('You must be signed in to create a team.');
      }

      // Add creator as first member
      final teamWithCreator = {
        ...teamData,
        'createdBy': uid,
        'members': [uid],
        'createdAt': FieldValue.serverTimestamp(),
        'pendingRequests': [],
      };

      try {
        final docRef = await _firestore.collection('teams').add(teamWithCreator);
        
        if (kDebugMode) {
          print('TeamService: Team created successfully with ID: ${docRef.id}');
        }

        // Add team reference to user's teams
        try {
          await _firestore.collection('users').doc(uid).update({
            'teams': FieldValue.arrayUnion([docRef.id]),
          });
          
          if (kDebugMode) {
            print('TeamService: Team reference added to user document');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error adding team reference to user: $e');
          }
          // Don't fail the entire operation if user update fails
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error creating team in Firebase: $e');
        }
        throw Exception('Unable to create team. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error creating team: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> joinTeam(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Joining team: $teamId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for joining team');
        }
        throw Exception('You must be signed in to join a team.');
      }

      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      try {
        // Add user to team members
        await _firestore.collection('teams').doc(teamId).update({
          'members': FieldValue.arrayUnion([uid]),
          'pendingRequests': FieldValue.arrayRemove([uid]),
        });
        
        if (kDebugMode) {
          print('TeamService: User added to team members successfully');
        }

        // Add team to user's teams
        try {
          await _firestore.collection('users').doc(uid).update({
            'teams': FieldValue.arrayUnion([teamId]),
          });
          
          if (kDebugMode) {
            print('TeamService: Team added to user document successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error adding team to user document: $e');
          }
          // Don't fail the entire operation if user update fails
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error joining team: $e');
        }
        throw Exception('Unable to join team. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error joining team: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> leaveTeam(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Leaving team: $teamId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for leaving team');
        }
        throw Exception('You must be signed in to leave a team.');
      }

      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      try {
        // Remove user from team members
        await _firestore.collection('teams').doc(teamId).update({
          'members': FieldValue.arrayRemove([uid]),
        });
        
        if (kDebugMode) {
          print('TeamService: User removed from team members successfully');
        }

        // Remove team from user's teams
        try {
          await _firestore.collection('users').doc(uid).update({
            'teams': FieldValue.arrayRemove([teamId]),
          });
          
          if (kDebugMode) {
            print('TeamService: Team removed from user document successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error removing team from user document: $e');
          }
          // Don't fail the entire operation if user update fails
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error leaving team: $e');
        }
        throw Exception('Unable to leave team. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error leaving team: $e');
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getTeamDetails(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Getting team details for: $teamId');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        return null;
      }

      try {
        final teams = await _dataService.getTeamsData();
        final team = teams.firstWhere((team) => team['id'] == teamId);
        
        if (kDebugMode) {
          print('TeamService: Team details retrieved successfully');
        }
        
        return team;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error getting team details: $e');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error getting team details: $e');
      }
      return null;
    }
  }

  @override
  Future<int> countPendingInvitationsFor(String uid) async {
    try {
      if (kDebugMode) {
        print('TeamService: Counting pending invitations for user: $uid');
      }
      
      if (uid.isEmpty) {
        if (kDebugMode) {
          print('TeamService: User ID cannot be empty');
        }
        return 0;
      }

      try {
        final teamsQuery = await _firestore
            .collection('teams')
            .where('pendingRequests', arrayContains: uid)
            .get();

        final count = teamsQuery.docs.length;
        
        if (kDebugMode) {
          print('TeamService: Found $count pending invitations for user $uid');
        }
        
        return count;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error counting pending invitations for user $uid: $e');
        }
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error counting pending invitations for user $uid: $e');
      }
      return 0;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingInvitations() async {
    try {
      if (kDebugMode) {
        print('TeamService: Getting pending invitations');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for pending invitations');
        }
        return [];
      }

      try {
        final teamsQuery = await _firestore
            .collection('teams')
            .where('pendingRequests', arrayContains: uid)
            .get();

        final invitations = teamsQuery.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {
                'id': doc.id,
                'name': data['name'] ?? 'Unknown Team',
                'sport': data['sport'] ?? 'Unknown Sport',
                'location': data['location'] ?? 'Unknown Location',
                'level': data['level'] ?? 'Mixed',
                'description': data['description'] ?? '',
                'memberCount': data['memberCount'] ?? 0,
                'maxMembers': data['maxMembers'] ?? 0,
                'createdBy': data['createdBy'],
                'createdAt': data['createdAt'],
              };
            }
            return {
              'id': doc.id,
              'name': 'Unknown Team',
              'sport': 'Unknown Sport',
              'location': 'Unknown Location',
              'level': 'Mixed',
              'description': '',
              'memberCount': 0,
              'maxMembers': 0,
              'createdBy': 'Unknown',
              'createdAt': null,
            };
          } catch (e) {
            if (kDebugMode) {
              print('TeamService: Error processing team invitation ${doc.id}: $e');
            }
            return {
              'id': doc.id,
              'name': 'Unknown Team',
              'sport': 'Unknown Sport',
              'location': 'Unknown Location',
              'level': 'Mixed',
              'description': '',
              'memberCount': 0,
              'maxMembers': 0,
              'createdBy': 'Unknown',
              'createdAt': null,
            };
          }
        }).toList();
        
        if (kDebugMode) {
          print('TeamService: Retrieved ${invitations.length} pending invitations');
        }
        
        return invitations;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error getting pending invitations: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error getting pending invitations: $e');
      }
      return [];
    }
  }

  @override
  Future<bool> acceptInvitation(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Accepting invitation for team: $teamId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for accepting invitation');
        }
        throw Exception('You must be signed in to accept an invitation.');
      }

      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      try {
        // Remove from pending requests and add to members
        await _firestore.collection('teams').doc(teamId).update({
          'pendingRequests': FieldValue.arrayRemove([uid]),
          'members': FieldValue.arrayUnion([uid]),
          'memberCount': FieldValue.increment(1),
        });
        
        if (kDebugMode) {
          print('TeamService: Invitation accepted successfully');
        }

        // Add team to user's teams
        try {
          await _firestore.collection('users').doc(uid).update({
            'teams': FieldValue.arrayUnion([teamId]),
          });
          
          if (kDebugMode) {
            print('TeamService: Team added to user document successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error adding team to user document: $e');
          }
          // Don't fail the entire operation if user update fails
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error accepting invitation: $e');
        }
        throw Exception('Unable to accept invitation. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error accepting invitation: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> declineInvitation(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Declining invitation for team: $teamId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for declining invitation');
        }
        throw Exception('You must be signed in to decline an invitation.');
      }

      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      try {
        // Remove from pending requests
        await _firestore.collection('teams').doc(teamId).update({
          'pendingRequests': FieldValue.arrayRemove([uid]),
        });
        
        if (kDebugMode) {
          print('TeamService: Invitation declined successfully');
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error declining invitation: $e');
        }
        throw Exception('Unable to decline invitation. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error declining invitation: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTeamMembers(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Getting team members for: $teamId');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        return [];
      }

      try {
        final team = await getTeamDetails(teamId);
        if (team == null) {
          if (kDebugMode) {
            print('TeamService: Team not found for getting members');
          }
          return [];
        }

        final memberIds = List<String>.from(team['members'] ?? []);
        if (memberIds.isEmpty) {
          if (kDebugMode) {
            print('TeamService: Team has no members');
          }
          return [];
        }

        final membersQuery = await _firestore
            .collection('users')
            .where(FieldPath.documentId, whereIn: memberIds)
            .get();

        final members = membersQuery.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {
                'id': doc.id,
                'email': data['email'] ?? 'Unknown',
                'displayName': data['displayName'] ?? 'Unknown User',
                'photoURL': data['photoURL'],
                'sport': data['sport'],
                'isOwner': doc.id == team['createdBy'],
              };
            }
            return {
              'id': doc.id,
              'email': 'Unknown',
              'displayName': 'Unknown User',
              'photoURL': null,
              'sport': null,
              'isOwner': doc.id == team['createdBy'],
            };
          } catch (e) {
            if (kDebugMode) {
              print('TeamService: Error processing team member ${doc.id}: $e');
            }
            return {
              'id': doc.id,
              'email': 'Unknown',
              'displayName': 'Unknown User',
              'photoURL': null,
              'sport': null,
              'isOwner': doc.id == team['createdBy'],
            };
          }
        }).toList();
        
        if (kDebugMode) {
          print('TeamService: Retrieved ${members.length} team members');
        }
        
        return members;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error getting team members: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error getting team members: $e');
      }
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTeamPendingRequests(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Getting pending requests for team: $teamId');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        return [];
      }

      try {
        final team = await getTeamDetails(teamId);
        if (team == null) {
          if (kDebugMode) {
            print('TeamService: Team not found for getting pending requests');
          }
          return [];
        }

        final requestIds = List<String>.from(team['pendingRequests'] ?? []);
        if (requestIds.isEmpty) {
          if (kDebugMode) {
            print('TeamService: Team has no pending requests');
          }
          return [];
        }

        final requestsQuery = await _firestore
            .collection('users')
            .where(FieldPath.documentId, whereIn: requestIds)
            .get();

        final requests = requestsQuery.docs.map((doc) {
          try {
            final data = doc.data();
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return {
                'id': doc.id,
                'email': data['email'] ?? 'Unknown',
                'displayName': data['displayName'] ?? 'Unknown User',
                'photoURL': data['photoURL'],
                'sport': data['sport'],
              };
            }
            return {
              'id': doc.id,
              'email': 'Unknown',
              'displayName': 'Unknown User',
              'photoURL': null,
              'sport': null,
            };
          } catch (e) {
            if (kDebugMode) {
              print('TeamService: Error processing pending request ${doc.id}: $e');
            }
            return {
              'id': doc.id,
              'email': 'Unknown',
              'displayName': 'Unknown User',
              'photoURL': null,
              'sport': null,
            };
          }
        }).toList();
        
        if (kDebugMode) {
          print('TeamService: Retrieved ${requests.length} pending requests');
        }
        
        return requests;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error getting team pending requests: $e');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error getting team pending requests: $e');
      }
      return [];
    }
  }

  @override
  Future<bool> inviteMember(String teamId, String email) async {
    try {
      if (kDebugMode) {
        print('TeamService: Inviting member to team: $teamId with email: $email');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      if (email.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Email cannot be empty');
        }
        throw Exception('Email cannot be empty.');
      }

      try {
        // Find user by email
        final userQuery = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (userQuery.docs.isEmpty) {
          if (kDebugMode) {
            print('TeamService: No user found with email: $email');
          }
          throw Exception('No user found with that email address.');
        }

        final userId = userQuery.docs.first.id;
        final team = await getTeamDetails(teamId);
        if (team == null) {
          if (kDebugMode) {
            print('TeamService: Team not found for inviting member');
          }
          throw Exception('Team not found.');
        }

        // Check if user is already a member or has a pending request
        final members = List<String>.from(team['members'] ?? []);
        final pendingRequests = List<String>.from(team['pendingRequests'] ?? []);
        
        if (members.contains(userId) || pendingRequests.contains(userId)) {
          if (kDebugMode) {
            print('TeamService: User is already a member or has a pending request');
          }
          throw Exception('User is already a member or has a pending request.');
        }

        // Add to pending requests
        await _firestore.collection('teams').doc(teamId).update({
          'pendingRequests': FieldValue.arrayUnion([userId]),
        });
        
        if (kDebugMode) {
          print('TeamService: Member invitation sent successfully');
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error inviting member: $e');
        }
        rethrow;
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error inviting member: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> acceptRequest(String teamId, String userId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Accepting request for team: $teamId from user: $userId');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      if (userId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: User ID cannot be empty');
        }
        throw Exception('Invalid user ID.');
      }

      try {
        // Add user to team members
        await _firestore.collection('teams').doc(teamId).update({
          'members': FieldValue.arrayUnion([userId]),
          'pendingRequests': FieldValue.arrayRemove([userId]),
          'memberCount': FieldValue.increment(1),
        });
        
        if (kDebugMode) {
          print('TeamService: Request accepted successfully');
        }

        // Add team to user's teams
        try {
          await _firestore.collection('users').doc(userId).update({
            'teams': FieldValue.arrayUnion([teamId]),
          });
          
          if (kDebugMode) {
            print('TeamService: Team added to user document successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error adding team to user document: $e');
          }
          // Don't fail the entire operation if user update fails
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error accepting request: $e');
        }
        throw Exception('Unable to accept request. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error accepting request: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> rejectRequest(String teamId, String userId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Rejecting request for team: $teamId from user: $userId');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      if (userId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: User ID cannot be empty');
        }
        throw Exception('Invalid user ID.');
      }

      try {
        // Remove from pending requests
        await _firestore.collection('teams').doc(teamId).update({
          'pendingRequests': FieldValue.arrayRemove([userId]),
        });
        
        if (kDebugMode) {
          print('TeamService: Request rejected successfully');
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error rejecting request: $e');
        }
        throw Exception('Unable to reject request. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error rejecting request: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> removeMember(String teamId, String userId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Removing member from team: $teamId, user: $userId');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      if (userId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: User ID cannot be empty');
        }
        throw Exception('Invalid user ID.');
      }

      try {
        // Remove user from team members
        await _firestore.collection('teams').doc(teamId).update({
          'members': FieldValue.arrayRemove([userId]),
          'memberCount': FieldValue.increment(-1),
        });
        
        if (kDebugMode) {
          print('TeamService: Member removed from team successfully');
        }

        // Remove team from user's teams
        try {
          await _firestore.collection('users').doc(userId).update({
            'teams': FieldValue.arrayRemove([teamId]),
          });
          
          if (kDebugMode) {
            print('TeamService: Team removed from user document successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error removing team from user document: $e');
          }
          // Don't fail the entire operation if user update fails
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error removing member: $e');
        }
        throw Exception('Unable to remove member. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error removing member: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> deleteTeam(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Deleting team: $teamId');
      }
      
      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      try {
        final team = await getTeamDetails(teamId);
        if (team == null) {
          if (kDebugMode) {
            print('TeamService: Team not found for deletion');
          }
          throw Exception('Team not found.');
        }

        // Remove team from all members' teams
        final memberIds = List<String>.from(team['members'] ?? []);
        for (final memberId in memberIds) {
          try {
            await _firestore.collection('users').doc(memberId).update({
              'teams': FieldValue.arrayRemove([teamId]),
            });
          } catch (e) {
            if (kDebugMode) {
              print('TeamService: Error removing team from member $memberId: $e');
            }
            // Continue with other members even if one fails
          }
        }

        // Delete the team document
        await _firestore.collection('teams').doc(teamId).delete();
        
        if (kDebugMode) {
          print('TeamService: Team deleted successfully');
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error deleting team: $e');
        }
        throw Exception('Unable to delete team. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error deleting team: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> sendJoinRequest(String teamId) async {
    try {
      if (kDebugMode) {
        print('TeamService: Sending join request for team: $teamId');
      }
      
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        if (kDebugMode) {
          print('TeamService: No authenticated user found for join request');
        }
        throw Exception('You must be signed in to send a join request.');
      }

      if (teamId.isEmpty) {
        if (kDebugMode) {
          print('TeamService: Team ID cannot be empty');
        }
        throw Exception('Invalid team ID.');
      }

      try {
        // Add join request to team
        await _firestore.collection('teams').doc(teamId).update({
          'pendingRequests': FieldValue.arrayUnion([uid]),
        });
        
        if (kDebugMode) {
          print('TeamService: Join request sent to team successfully');
        }

        // Add team to user's pending requests
        try {
          await _firestore.collection('users').doc(uid).update({
            'pendingTeamRequests': FieldValue.arrayUnion([teamId]),
          });
          
          if (kDebugMode) {
            print('TeamService: Team added to user pending requests successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error adding team to user pending requests: $e');
          }
          // Don't fail the entire operation if user update fails
        }

        // Refresh cache
        try {
          await _dataService.getTeamsData(forceRefresh: true);
          
          if (kDebugMode) {
            print('TeamService: Cache refreshed successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('TeamService: Error refreshing cache: $e');
          }
          // Don't fail the entire operation if cache refresh fails
        }

        return true;
      } catch (e) {
        if (kDebugMode) {
          print('TeamService: Error sending join request: $e');
        }
        throw Exception('Unable to send join request. Please check your connection and try again.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TeamService: Error sending join request: $e');
      }
      rethrow;
    }
  }
}
