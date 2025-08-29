import '../interfaces/base_repository.dart';
import '../../models/team_model.dart';

/// Team repository interface
abstract class TeamRepository extends BaseRepository<TeamModel> {
  /// Get teams by sport
  Future<List<TeamModel>> getTeamsBySport(String sport);
  
  /// Get teams by location
  Future<List<TeamModel>> getTeamsByLocation(String location);
  
  /// Get teams by creator
  Future<List<TeamModel>> getTeamsByCreator(String creatorId);
  
  /// Search teams by name
  Future<List<TeamModel>> searchTeams(String query);
  
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
}
