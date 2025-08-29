import 'package:shared_preferences/shared_preferences.dart';
import '../core/logging/app_logger.dart';
import 'dart:convert';

/// Cache Manager for SquadUp app
class CacheManager {
  static CacheManager? _instance;
  static SharedPreferences? _prefs;

  CacheManager._();

  static Future<CacheManager> getInstance() async {
    _instance ??= CacheManager._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  /// Cache Keys
  static const String userDataKey = 'user_data';
  static const String userPreferencesKey = 'user_preferences';
  static const String teamsDataKey = 'teams_data';
  static const String gamesDataKey = 'games_data';
  static const String lastSyncKey = 'last_sync';
  static const String offlineDataKey = 'offline_data';
  static const String cacheVersionKey = 'cache_version';

  /// Save data to cache
  Future<bool> saveData(String key, dynamic data) async {
    try {
      if (data is String) {
        return await _prefs!.setString(key, data);
      } else if (data is int) {
        return await _prefs!.setInt(key, data);
      } else if (data is double) {
        return await _prefs!.setDouble(key, data);
      } else if (data is bool) {
        return await _prefs!.setBool(key, data);
      } else if (data is List<String>) {
        return await _prefs!.setStringList(key, data);
      } else {
        // For complex objects, convert to JSON
        return await _prefs!.setString(key, jsonEncode(data));
      }
    } catch (e) {
      AppLogger.error('Error saving data to cache', error: e, tag: 'CacheManager');
      return false;
    }
  }

  /// Get data from cache
  Future<T?> getData<T>(String key) async {
    try {
      if (T == String) {
        return _prefs!.getString(key) as T?;
      } else if (T == int) {
        return _prefs!.getInt(key) as T?;
      } else if (T == double) {
        return _prefs!.getDouble(key) as T?;
      } else if (T == bool) {
        return _prefs!.getBool(key) as T?;
      } else if (T == List<String>) {
        return _prefs!.getStringList(key) as T?;
      } else {
        // For complex objects, decode from JSON
        final jsonString = _prefs!.getString(key);
        if (jsonString != null) {
          return jsonDecode(jsonString) as T?;
        }
        return null;
      }
    } catch (e) {
      AppLogger.error('Error getting data from cache', error: e, tag: 'CacheManager');
      return null;
    }
  }

  /// Remove data from cache
  Future<bool> removeData(String key) async {
    try {
      return await _prefs!.remove(key);
    } catch (e) {
      AppLogger.error('Error removing data from cache', error: e, tag: 'CacheManager');
      return false;
    }
  }

  /// Clear all cache
  Future<bool> clearCache() async {
    try {
      return await _prefs!.clear();
    } catch (e) {
      AppLogger.error('Error clearing cache', error: e, tag: 'CacheManager');
      return false;
    }
  }

  /// Check if key exists in cache
  Future<bool> containsKey(String key) async {
    try {
      return _prefs!.containsKey(key);
    } catch (e) {
      AppLogger.error('Error checking cache key', error: e, tag: 'CacheManager');
      return false;
    }
  }

  /// Get all keys in cache
  Future<Set<String>> getAllKeys() async {
    try {
      return _prefs!.getKeys();
    } catch (e) {
      AppLogger.error('Error getting all cache keys', error: e, tag: 'CacheManager');
      return <String>{};
    }
  }

  /// Save user data
  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    return await saveData(userDataKey, userData);
  }

  /// Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    return await getData<Map<String, dynamic>>(userDataKey);
  }

  /// Save teams data
  Future<bool> saveTeamsData(List<Map<String, dynamic>> teamsData) async {
    return await saveData(teamsDataKey, teamsData);
  }

  /// Get teams data
  Future<List<Map<String, dynamic>>?> getTeamsData() async {
    return await getData<List<Map<String, dynamic>>>(teamsDataKey);
  }

  /// Save games data
  Future<bool> saveGamesData(List<Map<String, dynamic>> gamesData) async {
    return await saveData(gamesDataKey, gamesData);
  }

  /// Get games data
  Future<List<Map<String, dynamic>>?> getGamesData() async {
    return await getData<List<Map<String, dynamic>>>(gamesDataKey);
  }

  /// Save last sync timestamp
  Future<bool> saveLastSync(DateTime timestamp) async {
    return await saveData(lastSyncKey, timestamp.millisecondsSinceEpoch);
  }

  /// Get last sync timestamp
  Future<DateTime?> getLastSync() async {
    final timestamp = await getData<int>(lastSyncKey);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
  }

  /// Save offline data
  Future<bool> saveOfflineData(Map<String, dynamic> offlineData) async {
    return await saveData(offlineDataKey, offlineData);
  }

  /// Get offline data
  Future<Map<String, dynamic>?> getOfflineData() async {
    return await getData<Map<String, dynamic>>(offlineDataKey);
  }

  /// Save cache version
  Future<bool> saveCacheVersion(String version) async {
    return await saveData(cacheVersionKey, version);
  }

  /// Get cache version
  Future<String?> getCacheVersion() async {
    return await getData<String>(cacheVersionKey);
  }

  /// Check if cache is valid
  Future<bool> isCacheValid(String currentVersion) async {
    final cachedVersion = await getCacheVersion();
    return cachedVersion == currentVersion;
  }

  /// Get cache size (approximate)
  Future<int> getCacheSize() async {
    try {
      final keys = await getAllKeys();
      int size = 0;
      for (final key in keys) {
        final value = _prefs!.getString(key);
        if (value != null) {
          size += value.length;
        }
      }
      return size;
    } catch (e) {
      AppLogger.error('Error getting cache size', error: e, tag: 'CacheManager');
      return 0;
    }
  }

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    try {
      final keys = _prefs?.getKeys() ?? <String>{};
      int totalSize = 0;
      int entryCount = keys.length;
      
      for (final key in keys) {
        final value = _prefs!.getString(key);
        if (value != null) {
          totalSize += value.length;
        }
      }
      
      return {
        'entryCount': entryCount,
        'totalSize': totalSize,
        'lastSync': getLastSync(),
        'cacheVersion': getCacheVersion(),
      };
    } catch (e) {
      AppLogger.error('Error getting cache stats', error: e, tag: 'CacheManager');
      return {
        'entryCount': 0,
        'totalSize': 0,
        'lastSync': null,
        'cacheVersion': null,
      };
    }
  }

  /// Cleanup cache (remove old entries)
  Future<void> cleanup() async {
    try {
      final keys = await getAllKeys();
      
      for (final key in keys) {
        // For now, just clear all cache entries
        // In a real implementation, you might want to check timestamps
        await _prefs!.remove(key);
      }
      
      AppLogger.info('Cache cleanup completed', tag: 'CacheManager');
    } catch (e) {
      AppLogger.error('Error during cache cleanup', error: e, tag: 'CacheManager');
    }
  }
}

/// Cache Keys constants
class CacheKeys {
  static const String userData = 'user_data';
  static const String userPreferences = 'user_preferences';
  static const String teamsData = 'teams_data';
  static const String gamesData = 'games_data';
  static const String lastSync = 'last_sync';
  static const String offlineData = 'offline_data';
  static const String cacheVersion = 'cache_version';
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userSettings = 'user_settings';
  static const String appSettings = 'app_settings';
  static const String notifications = 'notifications';
  static const String language = 'language';
  static const String theme = 'theme';
}
