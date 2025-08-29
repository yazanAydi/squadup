import '../interfaces/game_service_interface.dart';
import '../repositories/game_repository.dart';
import '../../models/game_model.dart';

/// Game service implementation following Clean Architecture principles
class GameService implements GameServiceInterface {
  final GameRepository _gameRepository;

  GameService({GameRepository? gameRepository}) 
      : _gameRepository = gameRepository ?? (throw ArgumentError('GameRepository is required'));

  @override
  Future<List<GameModel>> getAllGames() async {
    return await _gameRepository.getAll();
  }

  @override
  Future<GameModel?> getGameById(String gameId) async {
    return await _gameRepository.getById(gameId);
  }

  @override
  Future<List<GameModel>> getGamesBySport(String sport) async {
    return await _gameRepository.getGamesBySport(sport);
  }

  @override
  Future<List<GameModel>> getGamesByLocation(String location) async {
    return await _gameRepository.getGamesByLocation(location);
  }

  @override
  Future<List<GameModel>> getGamesByCreator(String creatorId) async {
    return await _gameRepository.getGamesByCreator(creatorId);
  }

  @override
  Future<List<GameModel>> getGamesByDateRange(DateTime start, DateTime end) async {
    return await _gameRepository.getGamesByDateRange(start, end);
  }

  @override
  Future<List<GameModel>> getUpcomingGames() async {
    return await _gameRepository.getUpcomingGames();
  }

  @override
  Future<List<GameModel>> getGamesByStatus(GameStatus status) async {
    return await _gameRepository.getGamesByStatus(status);
  }

  @override
  Future<List<GameModel>> searchGames(String query) async {
    return await _gameRepository.searchGames(query);
  }

  @override
  Future<String> createGame(GameModel game) async {
    return await _gameRepository.create(game);
  }

  @override
  Future<void> updateGame(String gameId, GameModel game) async {
    await _gameRepository.update(gameId, game);
  }

  @override
  Future<void> deleteGame(String gameId) async {
    await _gameRepository.delete(gameId);
  }

  @override
  Future<void> addPlayer(String gameId, String userId) async {
    await _gameRepository.addPlayer(gameId, userId);
  }

  @override
  Future<void> removePlayer(String gameId, String userId) async {
    await _gameRepository.removePlayer(gameId, userId);
  }

  @override
  Future<List<String>> getGamePlayers(String gameId) async {
    return await _gameRepository.getGamePlayers(gameId);
  }

  @override
  Future<void> addPendingRequest(String gameId, String userId) async {
    await _gameRepository.addPendingRequest(gameId, userId);
  }

  @override
  Future<void> removePendingRequest(String gameId, String userId) async {
    await _gameRepository.removePendingRequest(gameId, userId);
  }

  @override
  Future<List<String>> getPendingRequests(String gameId) async {
    return await _gameRepository.getPendingRequests(gameId);
  }

  @override
  Future<void> updateGameStatus(String gameId, GameStatus status) async {
    await _gameRepository.updateGameStatus(gameId, status);
  }

  @override
  Future<void> updateGameScore(String gameId, Map<String, dynamic> score) async {
    await _gameRepository.updateGameScore(gameId, score);
  }

  @override
  Future<bool> isGameParticipant(String gameId, String userId) async {
    final players = await getGamePlayers(gameId);
    return players.contains(userId);
  }

  @override
  Future<bool> isGameCreator(String gameId, String userId) async {
    final game = await getGameById(gameId);
    return game?.createdBy == userId;
  }

  @override
  Future<List<GameModel>> getGames() async {
    // Implementation would get all games
    throw UnimplementedError('getGames not implemented');
  }

  @override
  Future<bool> joinGame(String gameId) async {
    // Implementation would join game
    throw UnimplementedError('joinGame not implemented');
  }

  @override
  Future<bool> leaveGame(String gameId) async {
    // Implementation would leave game
    throw UnimplementedError('leaveGame not implemented');
  }

  @override
  Future<List<GameModel>> searchGamesWithFilters({
    String? query,
    String? sport,
    String? type,
    String? location,
    DateTime? date,
  }) async {
    // Implementation would search games with filters
    throw UnimplementedError('searchGamesWithFilters not implemented');
  }

  @override
  Future<List<GameModel>> getGamesByPlayer(String playerId) async {
    // Implementation would get games by player
    throw UnimplementedError('getGamesByPlayer not implemented');
  }

  @override
  Future<void> cancelGame(String gameId) async {
    // Implementation would cancel game
    throw UnimplementedError('cancelGame not implemented');
  }

  @override
  Future<void> addPlayerToGame(String gameId, String userId) async {
    // Implementation would add player to game
    return addPlayer(gameId, userId);
  }
}