import 'cache_manager.dart';

/// Data service for SquadUp app
class DataService {
  static DataService? _instance;
  static DataService get instance => _instance ??= DataService._();
  
  DataService._();
  
  late CacheManager _cacheManager;
  bool _isInitialized = false;

  /// Initialize the data service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _cacheManager = await CacheManager.getInstance();
    _isInitialized = true;
  }

  /// Get cache manager
  CacheManager get cacheManager => _cacheManager;

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Sync data with server
  Future<void> syncData() async {
    if (!_isInitialized) {
      throw StateError('DataService not initialized');
    }
    
    // Implementation would sync data with server
    throw UnimplementedError('syncData not implemented');
  }

  /// Clear all local data
  Future<void> clearAllData() async {
    if (!_isInitialized) {
      throw StateError('DataService not initialized');
    }
    
    await _cacheManager.clearCache();
  }

  /// Get data sync status
  Future<bool> isDataSynced() async {
    if (!_isInitialized) {
      throw StateError('DataService not initialized');
    }
    
    final lastSync = await _cacheManager.getLastSync();
    if (lastSync == null) return false;
    
    final now = DateTime.now();
    final difference = now.difference(lastSync);
    
    // Consider data synced if last sync was within 1 hour
    return difference.inHours < 1;
  }
}