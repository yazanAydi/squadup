import '../interfaces/base_repository.dart';
import '../../models/game_model.dart';

/// Game repository interface
abstract class GameRepository extends BaseRepository<GameModel> {
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
  
  /// Search games by title
  Future<List<GameModel>> searchGames(String query);
  
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
}
