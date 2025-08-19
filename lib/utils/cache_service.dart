import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class CacheService {
  static CacheService? _instance;
  static CacheService get instance => _instance ??= CacheService._();
  
  CacheService._();
  
  /// Check if device has internet connection
  Future<bool> get hasInternetConnection async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking connectivity: $e');
      }
      return false; // Assume no connection if check fails
    }
  }

  /// Check if device is offline
  Future<bool> get isOffline async {
    return !(await hasInternetConnection);
  }

  /// Get connectivity status as string
  Future<String> getConnectivityStatus() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      switch (connectivityResult) {
        case ConnectivityResult.mobile:
          return 'Mobile';
        case ConnectivityResult.wifi:
          return 'WiFi';
        case ConnectivityResult.ethernet:
          return 'Ethernet';
        case ConnectivityResult.vpn:
          return 'VPN';
        case ConnectivityResult.bluetooth:
          return 'Bluetooth';
        case ConnectivityResult.other:
          return 'Other';
        case ConnectivityResult.none:
          return 'Offline';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting connectivity status: $e');
      }
      return 'Unknown';
    }
  }

  /// Monitor connectivity changes
  Stream<ConnectivityResult> get connectivityStream {
    return Connectivity().onConnectivityChanged;
  }
}
