import '../../models/team_model.dart';

/// Team service interface following Clean Architecture principles
abstract class TeamServiceInterface {
  /// Get all teams
  Future<List<TeamModel>> getAllTeams();
  
  /// Get team by ID
  Future<TeamModel?> getTeamById(String teamId);
  
  /// Get teams by sport
  Future<List<TeamModel>> getTeamsBySport(String sport);
  
  /// Get teams by location
  Future<List<TeamModel>> getTeamsByLocation(String location);
  
  /// Get teams by creator
  Future<List<TeamModel>> getTeamsByCreator(String creatorId);
  
  /// Search teams by query
  Future<List<TeamModel>> searchTeams(String query);
  
  /// Create new team
  Future<String> createTeam(TeamModel team);
  
  /// Update team
  Future<void> updateTeam(String teamId, TeamModel team);
  
  /// Delete team
  Future<void> deleteTeam(String teamId);
  
  /// Add member to team
  Future<void> addMember(String teamId, String userId);
  
  /// Remove member from team
  Future<void> removeMember(String teamId, String userId);
  
  /// Get team members
  Future<List<String>> getTeamMembers(String teamId);
  
  /// Add pending request
  Future<void> addPendingRequest(String teamId, String userId);
  
  /// Remove pending request
  Future<void> removePendingRequest(String teamId, String userId);
  
  /// Get pending requests
  Future<List<String>> getPendingRequests(String teamId);
  
  /// Update team statistics
  Future<void> updateTeamStats(String teamId, Map<String, dynamic> stats);
  
  /// Check if user is team member
  Future<bool> isTeamMember(String teamId, String userId);
  
  /// Check if user is team owner
  Future<bool> isTeamOwner(String teamId, String userId);
  
  /// Get pending invitations count for user
  Future<int> getPendingInvitationsCount(String userId);
  
  /// Join team (for compatibility)
  Future<bool> joinTeam(String teamId);
  
  /// Get teams stream
  Stream<List<TeamModel>> getTeamsStream();
  
  /// Leave team
  Future<bool> leaveTeam(String teamId);
  
  /// Get user teams
  Future<List<TeamModel>> getUserTeams(String userId);
  
  /// Get pending invitations
  Future<List<Map<String, dynamic>>> getPendingInvitations();
  
  /// Accept invitation
  Future<bool> acceptInvitation(String teamId);
  
  /// Decline invitation
  Future<bool> declineInvitation(String teamId);
}