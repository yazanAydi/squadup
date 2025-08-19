import 'dart:async';
import '../../models/team.dart';

abstract class TeamServiceInterface {
  /// Get pending team invitations count for current user
  Future<int> getPendingInvitationsCount();
  
  /// Get pending team invitations count for a specific user
  Future<int> countPendingInvitationsFor(String uid);
  
  /// Get user's teams
  Future<List<Map<String, dynamic>>> getUserTeams();
  
  /// Get all teams stream for real-time updates
  Stream<List<Team>> getTeamsStream();
  
  /// Create a new team
  Future<bool> createTeam(Map<String, dynamic> teamData);
  
  /// Join a team
  Future<bool> joinTeam(String teamId);
  
  /// Leave a team
  Future<bool> leaveTeam(String teamId);
  
  /// Get team details
  Future<Map<String, dynamic>?> getTeamDetails(String teamId);
  
  /// Get pending invitations for current user
  Future<List<Map<String, dynamic>>> getPendingInvitations();
  
  /// Accept a team invitation
  Future<bool> acceptInvitation(String teamId);
  
  /// Decline a team invitation
  Future<bool> declineInvitation(String teamId);
  
  /// Get team members
  Future<List<Map<String, dynamic>>> getTeamMembers(String teamId);
  
  /// Get pending requests for a team
  Future<List<Map<String, dynamic>>> getTeamPendingRequests(String teamId);
  
  /// Invite a member to a team
  Future<bool> inviteMember(String teamId, String email);
  
  /// Accept a join request
  Future<bool> acceptRequest(String teamId, String userId);
  
  /// Reject a join request
  Future<bool> rejectRequest(String teamId, String userId);
  
  /// Remove a member from a team
  Future<bool> removeMember(String teamId, String userId);
  
  /// Delete a team
  Future<bool> deleteTeam(String teamId);
  
  /// Send a join request to a team
  Future<bool> sendJoinRequest(String teamId);
}
