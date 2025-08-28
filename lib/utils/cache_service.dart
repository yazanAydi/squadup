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
      return connectivityResult.isNotEmpty && connectivityResult.contains(ConnectivityResult.none) == false;
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
      if (connectivityResult.isEmpty) return 'Offline';
      
      // Check for the most common connection types first
      if (connectivityResult.contains(ConnectivityResult.wifi)) return 'WiFi';
      if (connectivityResult.contains(ConnectivityResult.mobile)) return 'Mobile';
      if (connectivityResult.contains(ConnectivityResult.ethernet)) return 'Ethernet';
      if (connectivityResult.contains(ConnectivityResult.vpn)) return 'VPN';
      if (connectivityResult.contains(ConnectivityResult.bluetooth)) return 'Bluetooth';
      if (connectivityResult.contains(ConnectivityResult.other)) return 'Other';
      
      return 'Offline';
    } catch (e) {
      if (kDebugMode) {
        print('Error getting connectivity status: $e');
      }
      return 'Unknown';
    }
  }

  /// Monitor connectivity changes
  Stream<List<ConnectivityResult>> get connectivityStream {
    return Connectivity().onConnectivityChanged;
  }
}
