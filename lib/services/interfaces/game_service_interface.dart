abstract class GameServiceInterface {
  /// Get all games with optional force refresh
  Future<List<Map<String, dynamic>>> getGames({bool forceRefresh = false});
  
  /// Get game by ID
  Future<Map<String, dynamic>?> getGameById(String gameId);
  
  /// Create new game
  Future<String?> createGame(Map<String, dynamic> gameData);
  
  /// Update game information
  Future<bool> updateGame(String gameId, Map<String, dynamic> gameData);
  
  /// Delete game
  Future<bool> deleteGame(String gameId);
  
  /// Search games by query and filters
  Future<List<Map<String, dynamic>>> searchGames({
    required String query,
    String? sport,
    String? type,
    String? location,
    DateTime? date,
    bool forceRefresh = false,
  });
  
  /// Join game
  Future<bool> joinGame(String gameId);
  
  /// Leave game
  Future<bool> leaveGame(String gameId);
  
  /// Get game participants
  Future<List<Map<String, dynamic>>> getGameParticipants(String gameId);
  
  /// Get games by sport
  Future<List<Map<String, dynamic>>> getGamesBySport(String sport);
  
  /// Get games by type (pickup, scheduled, tournament)
  Future<List<Map<String, dynamic>>> getGamesByType(String type);
  
  /// Get games by location
  Future<List<Map<String, dynamic>>> getGamesByLocation(String location);
  
  /// Get games by date range
  Future<List<Map<String, dynamic>>> getGamesByDateRange(DateTime start, DateTime end);
  
  /// Get upcoming games
  Future<List<Map<String, dynamic>>> getUpcomingGames();
  
  /// Get past games
  Future<List<Map<String, dynamic>>> getPastGames();
  
  /// Check if user is participating in game
  Future<bool> isUserInGame(String gameId, String userId);
  
  /// Get all games (alias for getGames)
  Future<List<Map<String, dynamic>>> getAllGames();
  
  /// Get games created by a specific user
  Future<List<Map<String, dynamic>>> getGamesByCreator(String userId);
  
  /// Get games that a specific user is participating in
  Future<List<Map<String, dynamic>>> getGamesByPlayer(String userId);
  
  /// Cancel a game (only creator can cancel)
  Future<bool> cancelGame(String gameId);
  
  /// Add a player to a game
  Future<bool> addPlayerToGame(String gameId, String userId);
}
