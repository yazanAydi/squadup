import 'package:flutter/foundation.dart';
import 'interfaces/user_service_interface.dart';
import 'interfaces/team_service_interface.dart';
import 'interfaces/game_service_interface.dart';
import 'interfaces/chat_service_interface.dart';
import 'implementations/user_service.dart';
import 'implementations/team_service.dart';
import 'implementations/game_service.dart';
import 'implementations/chat_service.dart';
import '../utils/data_service.dart';
import 'admin_service.dart';
import 'data_cleanup_service.dart';

class ServiceLocator {
  static ServiceLocator? _instance;
  static ServiceLocator get instance => _instance ??= ServiceLocator._();
  
  ServiceLocator._();
  
  // Services
  UserServiceInterface? _userService;
  TeamServiceInterface? _teamService;
  GameServiceInterface? _gameService;
  ChatServiceInterface? _chatService;
  DataService? _dataService;
  AdminService? _adminService;
  DataCleanupService? _dataCleanupService;
  
  // Service getters
  UserServiceInterface get userService => _userService ??= UserService();
  TeamServiceInterface get teamService => _teamService ??= TeamService();
  GameServiceInterface get gameService => _gameService ??= GameService();
  ChatServiceInterface get chatService => _chatService ??= ChatService();
  DataService get dataService => _dataService ??= DataService.instance;
  AdminService get adminService => _adminService ??= AdminService();
  DataCleanupService get dataCleanupService => _dataCleanupService ??= DataCleanupService();
  
  /// Initialize all services
  Future<void> initialize() async {
    try {
      if (kDebugMode) {
        print('Initializing ServiceLocator...');
      }
      
      // Initialize data service first (which initializes cache)
      await dataService.initialize();
      
      if (kDebugMode) {
        print('ServiceLocator initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing ServiceLocator: $e');
      }
      rethrow;
    }
  }
  
  /// Reset all services (useful for testing or logout)
  void reset() {
    _userService = null;
    _teamService = null;
    _gameService = null;
    _chatService = null;
    _dataService = null;
    _adminService = null;
    _dataCleanupService = null;
    
    if (kDebugMode) {
      print('ServiceLocator reset');
    }
  }
  
  /// Get service by type
  T getService<T>() {
    if (T == UserServiceInterface) {
      return userService as T;
    } else if (T == TeamServiceInterface) {
      return teamService as T;
    } else if (T == GameServiceInterface) {
      return gameService as T;
    } else if (T == ChatServiceInterface) {
      return chatService as T;
    } else if (T == DataService) {
      return dataService as T;
    } else if (T == AdminService) {
      return adminService as T;
    } else if (T == DataCleanupService) {
      return dataCleanupService as T;
    }
    
    throw Exception('Service of type $T not found');
  }
  
  /// Check if service is initialized
  bool get isInitialized => _dataService != null;
}
