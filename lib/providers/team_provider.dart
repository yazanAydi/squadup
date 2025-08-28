// Team Provider - Simplified version
// This file provides basic state management for team operations
// Run 'flutter pub get' to install flutter_riverpod dependencies later

import '../models/team.dart';

// Simple state management without external dependencies
class TeamProvider {
  static final TeamProvider _instance = TeamProvider._internal();
  factory TeamProvider() => _instance;
  TeamProvider._internal();

  // State variables
  List<Team> _teams = [];
  List<Team> _filteredTeams = [];
  String _searchQuery = '';
  String _selectedSport = 'All';
  bool _isLoading = false;
  String? _lastError;

  // Getters
  List<Team> get teams => _teams;
  List<Team> get filteredTeams => _filteredTeams;
  String get searchQuery => _searchQuery;
  String get selectedSport => _selectedSport;
  bool get isLoading => _isLoading;
  String? get lastError => _lastError;

  // Update search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    _notifyListeners();
  }

  // Update selected sport
  void updateSelectedSport(String sport) {
    _selectedSport = sport;
    _applyFilters();
    _notifyListeners();
  }

  // Set teams
  void setTeams(List<Team> teams) {
    _teams = teams;
    _applyFilters();
    _notifyListeners();
  }

  // Apply filters
  void _applyFilters() {
    var filtered = _teams;
    
    if (_selectedSport != 'All') {
      filtered = filtered.where((team) => 
        team.sport.toLowerCase() == _selectedSport.toLowerCase()
      ).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((team) =>
        team.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        team.city.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    _filteredTeams = filtered;
  }

  // Clear filters
  void clearFilters() {
    _searchQuery = '';
    _selectedSport = 'All';
    _filteredTeams = _teams;
    _notifyListeners();
  }

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    _notifyListeners();
  }

  // Set error
  void setError(String? error) {
    _lastError = error;
    _notifyListeners();
  }

  // Clear error
  void clearError() {
    _lastError = null;
    _notifyListeners();
  }

  // Reset state
  void reset() {
    _teams = [];
    _filteredTeams = [];
    _searchQuery = '';
    _selectedSport = 'All';
    _isLoading = false;
    _lastError = null;
    _notifyListeners();
  }

  // Simple listener system
  final List<Function()> _listeners = [];

  void addListener(Function() listener) {
    _listeners.add(listener);
  }

  void removeListener(Function() listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}

// Team filters class
class TeamFilters {
  final String searchQuery;
  final String selectedSport;
  
  const TeamFilters({
    required this.searchQuery,
    required this.selectedSport,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamFilters &&
          runtimeType == other.runtimeType &&
          searchQuery == other.searchQuery &&
          selectedSport == other.selectedSport;
  
  @override
  int get hashCode => searchQuery.hashCode ^ selectedSport.hashCode;
}

// Global instance
final teamProvider = TeamProvider();
