import '../interfaces/team_service_interface.dart';
import '../repositories/team_repository.dart';
import '../../models/team_model.dart';

/// Team service implementation following Clean Architecture principles
class TeamService implements TeamServiceInterface {
  final TeamRepository _teamRepository;

  TeamService({TeamRepository? teamRepository}) 
      : _teamRepository = teamRepository ?? (throw ArgumentError('TeamRepository is required'));

  @override
  Future<List<TeamModel>> getAllTeams() async {
    return await _teamRepository.getAll();
  }

  @override
  Future<TeamModel?> getTeamById(String teamId) async {
    return await _teamRepository.getById(teamId);
  }

  @override
  Future<List<TeamModel>> getTeamsBySport(String sport) async {
    return await _teamRepository.getTeamsBySport(sport);
  }

  @override
  Future<List<TeamModel>> getTeamsByLocation(String location) async {
    return await _teamRepository.getTeamsByLocation(location);
  }

  @override
  Future<List<TeamModel>> getTeamsByCreator(String creatorId) async {
    return await _teamRepository.getTeamsByCreator(creatorId);
  }

  @override
  Future<List<TeamModel>> searchTeams(String query) async {
    return await _teamRepository.searchTeams(query);
  }

  @override
  Future<String> createTeam(TeamModel team) async {
    return await _teamRepository.create(team);
  }

  @override
  Future<void> updateTeam(String teamId, TeamModel team) async {
    await _teamRepository.update(teamId, team);
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    await _teamRepository.delete(teamId);
  }

  @override
  Future<void> addMember(String teamId, String userId) async {
    await _teamRepository.addMember(teamId, userId);
  }

  @override
  Future<void> removeMember(String teamId, String userId) async {
    await _teamRepository.removeMember(teamId, userId);
  }

  @override
  Future<List<String>> getTeamMembers(String teamId) async {
    return await _teamRepository.getTeamMembers(teamId);
  }

  @override
  Future<void> addPendingRequest(String teamId, String userId) async {
    await _teamRepository.addPendingRequest(teamId, userId);
  }

  @override
  Future<void> removePendingRequest(String teamId, String userId) async {
    await _teamRepository.removePendingRequest(teamId, userId);
  }

  @override
  Future<List<String>> getPendingRequests(String teamId) async {
    return await _teamRepository.getPendingRequests(teamId);
  }

  @override
  Future<void> updateTeamStats(String teamId, Map<String, dynamic> stats) async {
    await _teamRepository.updateTeamStats(teamId, stats);
  }

  @override
  Future<bool> isTeamMember(String teamId, String userId) async {
    final members = await getTeamMembers(teamId);
    return members.contains(userId);
  }

  @override
  Future<bool> isTeamOwner(String teamId, String userId) async {
    final team = await getTeamById(teamId);
    return team?.createdBy == userId;
  }

  @override
  Future<int> getPendingInvitationsCount(String userId) async {
    // Implementation would count pending invitations for user
    // This is a placeholder implementation
    return 0;
  }

  @override
  Future<bool> joinTeam(String teamId) async {
    // Implementation would join team
    throw UnimplementedError('joinTeam not implemented');
  }

  @override
  Stream<List<TeamModel>> getTeamsStream() async* {
    // Implementation would return teams stream
    throw UnimplementedError('getTeamsStream not implemented');
  }

  @override
  Future<bool> leaveTeam(String teamId) async {
    // Implementation would leave team
    throw UnimplementedError('leaveTeam not implemented');
  }

  @override
  Future<List<TeamModel>> getUserTeams(String userId) async {
    // Implementation would get user teams
    throw UnimplementedError('getUserTeams not implemented');
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingInvitations() async {
    // Implementation would get pending invitations
    throw UnimplementedError('getPendingInvitations not implemented');
  }

  @override
  Future<bool> acceptInvitation(String teamId) async {
    // Implementation would accept invitation
    throw UnimplementedError('acceptInvitation not implemented');
  }

  @override
  Future<bool> declineInvitation(String teamId) async {
    // Implementation would decline invitation
    throw UnimplementedError('declineInvitation not implemented');
  }
}