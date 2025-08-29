import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_model.dart';
import '../services/interfaces/game_service_interface.dart';
import '../core/di/providers.dart';

class GameFeedController extends StateNotifier<AsyncValue<List<GameModel>>> {
  GameFeedController(this._gameService) : super(const AsyncValue.loading()) {
    _loadGames();
  }

  final GameServiceInterface _gameService;

  Future<void> _loadGames() async {
    try {
      state = const AsyncValue.loading();
      final games = await _gameService.getGames();
      state = AsyncValue.data(games);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createGame(GameModel game) async {
    try {
      final gameId = await _gameService.createGame(game);
      if (gameId.isNotEmpty) {
        _loadGames(); // Reload games
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> joinGame(String gameId) async {
    try {
      final success = await _gameService.joinGame(gameId);
      if (success) {
        _loadGames(); // Reload games
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> leaveGame(String gameId) async {
    try {
      final success = await _gameService.leaveGame(gameId);
      if (success) {
        _loadGames(); // Reload games
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> searchGames({
    required String query,
    String? sport,
    String? type,
    String? location,
    DateTime? date,
  }) async {
    try {
      state = const AsyncValue.loading();
      final games = await _gameService.searchGamesWithFilters(
        query: query,
        sport: sport,
        type: type,
        location: location,
        date: date,
      );
      state = AsyncValue.data(games);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    _loadGames(); // Reload games
  }
}

final gameFeedControllerProvider = StateNotifierProvider<GameFeedController, AsyncValue<List<GameModel>>>((ref) {
  final gameService = ref.watch(gameServiceProvider);
  return GameFeedController(gameService);
});
