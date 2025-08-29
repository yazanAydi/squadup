/// Chat service interface following Clean Architecture principles
abstract class ChatServiceInterface {
  /// Send message to team
  Future<void> sendTeamMessage(String teamId, String message);
  
  /// Send message to game
  Future<void> sendGameMessage(String gameId, String message);
  
  /// Send direct message to user
  Future<void> sendDirectMessage(String userId, String message);
  
  /// Get team messages
  Future<List<Map<String, dynamic>>> getTeamMessages(String teamId, {int? limit});
  
  /// Get game messages
  Future<List<Map<String, dynamic>>> getGameMessages(String gameId, {int? limit});
  
  /// Get direct messages
  Future<List<Map<String, dynamic>>> getDirectMessages(String userId, {int? limit});
  
  /// Mark message as read
  Future<void> markMessageAsRead(String messageId);
  
  /// Get unread message count
  Future<int> getUnreadMessageCount(String userId);
  
  /// Delete message
  Future<void> deleteMessage(String messageId);
  
  /// Report message
  Future<void> reportMessage(String messageId, String reason);
  
  /// Block user from messaging
  Future<void> blockUserFromMessaging(String userId, String blockedUserId);
  
  /// Unblock user from messaging
  Future<void> unblockUserFromMessaging(String userId, String unblockedUserId);
}
