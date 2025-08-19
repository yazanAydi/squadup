import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team.dart';
import '../services/interfaces/team_service_interface.dart';
import '../core/di/providers.dart';

class TeamController extends StateNotifier<AsyncValue<List<Team>>> {
  TeamController(this._teamService) : super(const AsyncValue.loading()) {
    _loadTeams();
  }

  final TeamServiceInterface _teamService;

  Future<void> _loadTeams() async {
    try {
      state = const AsyncValue.loading();
      final teamsStream = _teamService.getTeamsStream();
      await for (final teams in teamsStream) {
        state = AsyncValue.data(teams);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createTeam(Map<String, dynamic> teamData) async {
    try {
      final success = await _teamService.createTeam(teamData);
      if (success) {
        _loadTeams(); // Reload teams instead of using ref
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> joinTeam(String teamId) async {
    try {
      final success = await _teamService.joinTeam(teamId);
      if (success) {
        _loadTeams(); // Reload teams instead of using ref
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> leaveTeam(String teamId) async {
    try {
      final success = await _teamService.leaveTeam(teamId);
      if (success) {
        _loadTeams(); // Reload teams instead of using ref
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    _loadTeams(); // Reload teams instead of using ref
  }
}

final teamControllerProvider = StateNotifierProvider<TeamController, AsyncValue<List<Team>>>((ref) {
  final teamService = ref.watch(teamServiceProvider);
  return TeamController(teamService);
});
