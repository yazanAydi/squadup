import '../../models/game_model.dart';

/// Game service interface following Clean Architecture principles
abstract class GameServiceInterface {
  /// Get all games
  Future<List<GameModel>> getAllGames();
  
  /// Get game by ID
  Future<GameModel?> getGameById(String gameId);
  
  /// Get games by sport
  Future<List<GameModel>> getGamesBySport(String sport);
  
  /// Get games by location
  Future<List<GameModel>> getGamesByLocation(String location);
  
  /// Get games by creator
  Future<List<GameModel>> getGamesByCreator(String creatorId);
  
  /// Get games by date range
  Future<List<GameModel>> getGamesByDateRange(DateTime start, DateTime end);
  
  /// Get upcoming games
  Future<List<GameModel>> getUpcomingGames();
  
  /// Get games by status
  Future<List<GameModel>> getGamesByStatus(GameStatus status);
  
  /// Search games by query
  Future<List<GameModel>> searchGames(String query);
  
  /// Create new game
  Future<String> createGame(GameModel game);
  
  /// Update game
  Future<void> updateGame(String gameId, GameModel game);
  
  /// Delete game
  Future<void> deleteGame(String gameId);
  
  /// Add player to game
  Future<void> addPlayer(String gameId, String userId);
  
  /// Remove player from game
  Future<void> removePlayer(String gameId, String userId);
  
  /// Get game players
  Future<List<String>> getGamePlayers(String gameId);
  
  /// Add pending request
  Future<void> addPendingRequest(String gameId, String userId);
  
  /// Remove pending request
  Future<void> removePendingRequest(String gameId, String userId);
  
  /// Get pending requests
  Future<List<String>> getPendingRequests(String gameId);
  
  /// Update game status
  Future<void> updateGameStatus(String gameId, GameStatus status);
  
  /// Update game score
  Future<void> updateGameScore(String gameId, Map<String, dynamic> score);
  
  /// Check if user is game participant
  Future<bool> isGameParticipant(String gameId, String userId);
  
  /// Check if user is game creator
  Future<bool> isGameCreator(String gameId, String userId);
  
  /// Get all games (for compatibility)
  Future<List<GameModel>> getGames();
  
  /// Join a game
  Future<bool> joinGame(String gameId);
  
  /// Leave a game
  Future<bool> leaveGame(String gameId);
  
  /// Search games with filters
  Future<List<GameModel>> searchGamesWithFilters({
    String? query,
    String? sport,
    String? type,
    String? location,
    DateTime? date,
  });
  
  /// Get games by player
  Future<List<GameModel>> getGamesByPlayer(String playerId);
  
  /// Cancel game
  Future<void> cancelGame(String gameId);
  
  /// Add player to game (alias for addPlayer)
  Future<void> addPlayerToGame(String gameId, String userId);
}