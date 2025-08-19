import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataCleanupService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Clean up expired data automatically
  Future<void> cleanupExpiredData() async {
    try {
      if (kDebugMode) {
        print('DataCleanupService: Starting data cleanup process...');
      }
      
      final now = DateTime.now();
      
      // Clean up old team invitations (expired after 30 days)
      await _cleanupExpiredInvitations(now);
      
      // Clean up declined invitations (after 7 days)
      await _cleanupDeclinedInvitations(now);
      
      // Clean up old game history (after 1 year)
      await _cleanupOldGameHistory(now);
      
      // Clean up expired rate limit data (after 24 hours)
      await _cleanupExpiredRateLimits(now);
      
      if (kDebugMode) {
        print('DataCleanupService: Data cleanup completed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DataCleanupService: Error during data cleanup: $e');
      }
      throw Exception('Unable to complete data cleanup. Please try again later.');
    }
  }

  /// Clean up expired team invitations (older than 30 days)
  Future<void> _cleanupExpiredInvitations(DateTime now) async {
    try {
      final thirtyDaysAgo = now.subtract(const Duration(days: 30));
      
      if (kDebugMode) {
        print('DataCleanupService: Cleaning up invitations older than ${thirtyDaysAgo.toIso8601String()}');
      }
      
      final query = _firestore
          .collection('team_invitations')
          .where('createdAt', isLessThan: Timestamp.fromDate(thirtyDaysAgo))
          .where('status', isEqualTo: 'pending');
      
      final snapshot = await query.get();
      
      if (kDebugMode) {
        print('DataCleanupService: Found ${snapshot.docs.length} expired invitations to clean up');
      }
      
      int deletedCount = 0;
      for (final doc in snapshot.docs) {
        try {
          await doc.reference.delete();
          deletedCount++;
        } catch (e) {
          if (kDebugMode) {
            print('DataCleanupService: Error deleting expired invitation ${doc.id}: $e');
          }
          // Continue with other deletions even if one fails
        }
      }
      
      if (kDebugMode) {
        print('DataCleanupService: Successfully cleaned up $deletedCount expired invitations');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DataCleanupService: Error cleaning up expired invitations: $e');
      }
      // Don't rethrow - continue with other cleanup operations
    }
  }

  /// Clean up declined invitations (older than 7 days)
  Future<void> _cleanupDeclinedInvitations(DateTime now) async {
    try {
      final sevenDaysAgo = now.subtract(const Duration(days: 7));
      
      if (kDebugMode) {
        print('DataCleanupService: Cleaning up declined invitations older than ${sevenDaysAgo.toIso8601String()}');
      }
      
      final query = _firestore
          .collection('team_invitations')
          .where('respondedAt', isLessThan: Timestamp.fromDate(sevenDaysAgo))
          .where('status', isEqualTo: 'declined');
      
      final snapshot = await query.get();
      
      if (kDebugMode) {
        print('DataCleanupService: Found ${snapshot.docs.length} declined invitations to clean up');
      }
      
      int deletedCount = 0;
      for (final doc in snapshot.docs) {
        try {
          await doc.reference.delete();
          deletedCount++;
        } catch (e) {
          if (kDebugMode) {
            print('DataCleanupService: Error deleting declined invitation ${doc.id}: $e');
          }
          // Continue with other deletions even if one fails
        }
      }
      
      if (kDebugMode) {
        print('DataCleanupService: Successfully cleaned up $deletedCount declined invitations');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DataCleanupService: Error cleaning up declined invitations: $e');
      }
      // Don't rethrow - continue with other cleanup operations
    }
  }

  /// Clean up old game history (older than 1 year)
  Future<void> _cleanupOldGameHistory(DateTime now) async {
    try {
      final oneYearAgo = now.subtract(const Duration(days: 365));
      
      if (kDebugMode) {
        print('DataCleanupService: Archiving games older than ${oneYearAgo.toIso8601String()}');
      }
      
      final query = _firestore
          .collection('games')
          .where('gameDateTime', isLessThan: Timestamp.fromDate(oneYearAgo))
          .where('status', whereIn: ['completed', 'cancelled']);
      
      final snapshot = await query.get();
      
      if (kDebugMode) {
        print('DataCleanupService: Found ${snapshot.docs.length} old games to archive');
      }
      
      int archivedCount = 0;
      for (final doc in snapshot.docs) {
        try {
          // Archive instead of delete for data integrity
          await doc.reference.update({
            'archived': true,
            'archivedAt': Timestamp.fromDate(now),
          });
          archivedCount++;
        } catch (e) {
          if (kDebugMode) {
            print('DataCleanupService: Error archiving old game ${doc.id}: $e');
          }
          // Continue with other archives even if one fails
        }
      }
      
      if (kDebugMode) {
        print('DataCleanupService: Successfully archived $archivedCount old games');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DataCleanupService: Error archiving old game history: $e');
      }
      // Don't rethrow - continue with other cleanup operations
    }
  }

  /// Clean up expired rate limit data (older than 24 hours)
  Future<void> _cleanupExpiredRateLimits(DateTime now) async {
    try {
      final twentyFourHoursAgo = now.subtract(const Duration(hours: 24));
      
      if (kDebugMode) {
        print('DataCleanupService: Cleaning up rate limits older than ${twentyFourHoursAgo.toIso8601String()}');
      }
      
      final query = _firestore
          .collection('rate_limits')
          .where('lastActivity', isLessThan: Timestamp.fromDate(twentyFourHoursAgo));
      
      final snapshot = await query.get();
      
      if (kDebugMode) {
        print('DataCleanupService: Found ${snapshot.docs.length} expired rate limits to clean up');
      }
      
      int deletedCount = 0;
      for (final doc in snapshot.docs) {
        try {
          await doc.reference.delete();
          deletedCount++;
        } catch (e) {
          if (kDebugMode) {
            print('DataCleanupService: Error deleting expired rate limit ${doc.id}: $e');
          }
          // Continue with other deletions even if one fails
        }
      }
      
      if (kDebugMode) {
        print('DataCleanupService: Successfully cleaned up $deletedCount expired rate limits');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DataCleanupService: Error cleaning up expired rate limits: $e');
      }
      // Don't rethrow - continue with other cleanup operations
    }
  }

  /// Schedule automatic cleanup (call this periodically)
  Future<void> scheduleCleanup() async {
    try {
      if (kDebugMode) {
        print('DataCleanupService: Scheduling automatic cleanup...');
      }
      
      // This would typically be called by a timer or scheduled task
      await cleanupExpiredData();
      
      if (kDebugMode) {
        print('DataCleanupService: Automatic cleanup completed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DataCleanupService: Error scheduling cleanup: $e');
      }
      throw Exception('Unable to schedule data cleanup. Please try again later.');
    }
  }

  /// Get cleanup statistics
  Future<Map<String, dynamic>> getCleanupStats() async {
    try {
      final now = DateTime.now();
      final stats = <String, dynamic>{};
      
      // Count expired invitations
      try {
        final thirtyDaysAgo = now.subtract(const Duration(days: 30));
        final expiredQuery = _firestore
            .collection('team_invitations')
            .where('createdAt', isLessThan: Timestamp.fromDate(thirtyDaysAgo))
            .where('status', isEqualTo: 'pending');
        
        final expiredSnapshot = await expiredQuery.get();
        stats['expiredInvitations'] = expiredSnapshot.docs.length;
      } catch (e) {
        if (kDebugMode) {
          print('DataCleanupService: Error counting expired invitations: $e');
        }
        stats['expiredInvitations'] = 0;
      }
      
      // Count old games
      try {
        final oneYearAgo = now.subtract(const Duration(days: 365));
        final oldGamesQuery = _firestore
            .collection('games')
            .where('gameDateTime', isLessThan: Timestamp.fromDate(oneYearAgo))
            .where('status', whereIn: ['completed', 'cancelled']);
        
        final oldGamesSnapshot = await oldGamesQuery.get();
        stats['oldGames'] = oldGamesSnapshot.docs.length;
      } catch (e) {
        if (kDebugMode) {
          print('DataCleanupService: Error counting old games: $e');
        }
        stats['oldGames'] = 0;
      }
      
      if (kDebugMode) {
        print('DataCleanupService: Cleanup stats retrieved: $stats');
      }
      
      return stats;
    } catch (e) {
      if (kDebugMode) {
        print('DataCleanupService: Error getting cleanup stats: $e');
      }
      return {'expiredInvitations': 0, 'oldGames': 0};
    }
  }
}
