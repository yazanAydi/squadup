import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/interfaces/game_service_interface.dart';
import '../services/service_locator.dart';
import '../utils/safe_text.dart';
import '../core/theme/app_colors.dart';

class GameFinderScreen extends StatefulWidget {
  const GameFinderScreen({super.key});

  @override
  State<GameFinderScreen> createState() => _GameFinderScreenState();
}

class _GameFinderScreenState extends State<GameFinderScreen>
    with TickerProviderStateMixin {
  late AnimationController _searchController;
  late AnimationController _listController;
  late Animation<double> _searchFade;
  late Animation<Offset> _listSlide;
  late final GameServiceInterface _gameService;

  final TextEditingController _searchControllerText = TextEditingController();
  String _searchQuery = '';
  String _selectedSport = 'All';
  String _selectedType = 'All Types';
  bool _isLoading = true;
  List<Map<String, dynamic>> _games = [];

  // Colors will be accessed directly via Theme.of(context)

  List<String> sports = ['All', 'Basketball', 'Soccer', 'Volleyball'];
  List<String> gameTypes = ['All Types', 'Pickup', 'Scheduled', 'Tournament'];

  @override
  void initState() {
    super.initState();
    _gameService = ServiceLocator.instance.gameService;
    
    _searchController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _listController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _searchFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _searchController,
      curve: Curves.easeIn,
    ));

    _listSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _listController,
      curve: Curves.easeOutCubic,
    ));

    _startAnimations();
    _loadGames();
  }

  void _startAnimations() async {
    await _searchController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    await _listController.forward();
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    _searchControllerText.dispose();
    super.dispose();
  }

  String _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball':
        return 'assets/basketball.png';
      case 'soccer':
        return 'assets/ball.png';
      case 'volleyball':
        return 'assets/volleyball.png';
      default:
        return 'assets/basketball.png';
    }
  }

  Color _getGameTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'pickup':
        return AppColors.green;
      case 'scheduled':
        return AppColors.primary;
      case 'tournament':
        return AppColors.orange;
      default:
        return AppColors.outline;
    }
  }

  void _showGameDetails(Map<String, dynamic> game) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outline.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Game Header
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      _getSportIcon(game['sport'] ?? 'Basketball'),
                      width: 30,
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game['title'] ?? 'Game Title',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              game['sport'] ?? 'Sport',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getGameTypeColor(game['type'] ?? 'Pickup').withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _getGameTypeColor(game['type'] ?? 'Pickup'),
                                ),
                              ),
                              child: Text(
                                game['type'] ?? 'Pickup',
                                style: TextStyle(
                                  color: _getGameTypeColor(game['type'] ?? 'Pickup'),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Game Info
              _buildInfoRow('Location', game['location'] ?? 'Unknown'),
              _buildInfoRow('Date', _formatDate(game['date'])),
              _buildInfoRow('Time', game['time'] ?? 'TBD'),
              _buildInfoRow('Players', '${game['currentPlayers'] ?? 0}/${game['maxPlayers'] ?? 0}'),
              _buildInfoRow('Level', game['level'] ?? 'Mixed'),
              _buildInfoRow('Organizer', game['organizerName'] ?? 'Unknown'),
              
              const SizedBox(height: 24),
              
              // Description
              if (game['description'] != null && game['description'].isNotEmpty) ...[
                Text(
                  'About',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  game['description'],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
              ],
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _joinGame(game),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Join Game',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'TBD';
    if (timestamp is Timestamp) {
      final date = timestamp.toDate();
      return '${date.day}/${date.month}/${date.year}';
    }
    return 'TBD';
  }

  Future<void> _loadGames() async {
    setState(() => _isLoading = true);
    try {
      final games = await _gameService.getAllGames();
      setState(() => _games = games.map((game) => game.toJson()).toList());
      _applyFilters();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading games: ${e.toString()}'),
            backgroundColor: AppColors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _applyFilters() {
    setState(() {
      var filteredGames = List<Map<String, dynamic>>.from(_games);

      // Apply sport filter
      if (_selectedSport != 'All') {
        filteredGames = filteredGames.where((game) => 
          (game['sport']?.toString().toLowerCase() ?? '') == _selectedSport.toLowerCase()
        ).toList();
      }

      // Apply type filter
      if (_selectedType != 'All Types') {
        filteredGames = filteredGames.where((game) => 
          (game['gameType']?.toString().toLowerCase() ?? '') == _selectedType.toLowerCase()
        ).toList();
      }

      // Apply search query
      if (_searchQuery.isNotEmpty) {
        filteredGames = filteredGames.where((game) =>
          (game['name']?.toString().toLowerCase() ?? '').contains(_searchQuery.toLowerCase()) ||
          (game['location']?.toString().toLowerCase() ?? '').contains(_searchQuery.toLowerCase())
        ).toList();
      }

      _games = filteredGames;
    });
  }

  void _onSportChanged(String? value) {
    if (value != null) {
      setState(() => _selectedSport = value);
      _applyFilters();
    }
  }

  void _onTypeChanged(String? value) {
    if (value != null) {
      setState(() => _selectedType = value);
      _applyFilters();
    }
  }

  void _onSearchChanged(String value) {
    setState(() => _searchQuery = value);
    _applyFilters();
  }

  Future<void> _joinGame(Map<String, dynamic> game) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to join games'),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      // Check if user is already in the game
      if (game['players']?.contains(uid) == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are already in this game'),
            backgroundColor: AppColors.orange,
          ),
        );
        return;
      }

      // Check if game is full
      final currentPlayers = game['currentPlayers'] ?? 0;
      final maxPlayers = game['maxPlayers'] ?? 0;
      if (currentPlayers >= maxPlayers) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Game is full'),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      // Add user to game
      await _gameService.addPlayerToGame(game['id'], uid);

      // Add game to user's joined games
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({
        'joinedGames': FieldValue.arrayUnion([game['id']]),
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully joined ${game['name']}!'),
            backgroundColor: AppColors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        
        // Refresh the games list
        _loadGames();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error joining game: ${e.toString()}'),
            backgroundColor: AppColors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Apply text scaling limits to prevent overflow
    final textScaler = MediaQuery.of(context).textScaler.clamp(
      minScaleFactor: 1.0,
      maxScaleFactor: 1.2,
    );
    
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: textScaler),
      child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Expanded(
                      child: SafeTitleText(
                        'Find Games',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),

              // Search and Filter Section
              FadeTransition(
                opacity: _searchFade,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).colorScheme.surface,
                              Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.outline.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchControllerText,
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          onChanged: (value) => _onSearchChanged(value),
                          decoration: InputDecoration(
                            hintText: 'Search games...',
                            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                            prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Filters Row
                      Row(
                        children: [
                          // Sport Filter
                          Expanded(
                            child: SizedBox(
                              height: 50, // Increased from 40 to prevent overflow
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sports.length,
                                itemBuilder: (context, index) {
                                  final sport = sports[index];
                                  final isSelected = _selectedSport == sport;
                                  
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: index < sports.length - 1 ? 8 : 0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => _onSportChanged(sport),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: isSelected
                                                ? [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withValues(alpha: 0.8)]
                                                : [
                                                    Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
                                                    Theme.of(context).colorScheme.surface.withValues(alpha: 0.4),
                                                  ],
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected
                                                ? Theme.of(context).colorScheme.primary
                                                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                                          ),
                                        ),
                                        child: Center(
                                          child: SafeLabelText(
                                            sport,
                                            style: TextStyle(
                                              color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Type Filter
                          Expanded(
                            child: SizedBox(
                              height: 50, // Increased from 40 to prevent overflow
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: gameTypes.length,
                                itemBuilder: (context, index) {
                                  final type = gameTypes[index];
                                  final isSelected = _selectedType == type;
                                  
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: index < gameTypes.length - 1 ? 8 : 0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => _onTypeChanged(type),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: isSelected
                                                ? [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withValues(alpha: 0.8)]
                                                : [
                                                    Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
                                                    Theme.of(context).colorScheme.surface.withValues(alpha: 0.4),
                                                  ],
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected
                                                ? Theme.of(context).colorScheme.primary
                                                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                                          ),
                                        ),
                                        child: Center(
                                          child: SafeLabelText(
                                            type,
                                            style: TextStyle(
                                              color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Games List
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
                    : SlideTransition(
                        position: _listSlide,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _games.length,
                          itemBuilder: (context, index) {
                            final game = _games[index];
                            return _buildGameCard(game);
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.outline.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showGameDetails(game),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    // Sport Icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        _getSportIcon(game['sport'] ?? 'Basketball'),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // Game Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SafeTitleText(
                            game['title'] ?? 'Game Title',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SafeLabelText(
                                game['sport'] ?? 'Sport',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getGameTypeColor(game['type'] ?? 'Pickup').withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _getGameTypeColor(game['type'] ?? 'Pickup'),
                                  ),
                                ),
                                child: SafeLabelText(
                                  game['type'] ?? 'Pickup',
                                  style: TextStyle(
                                    color: _getGameTypeColor(game['type'] ?? 'Pickup'),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Arrow
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      size: 16,
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Details Row
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: SafeLabelText(
                        game['location'] ?? 'Unknown Location',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.people,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    SafeLabelText(
                      '${game['currentPlayers'] ?? 0}/${game['maxPlayers'] ?? 0}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Date and Time
                Row(
                  children: [
                    Icon(
                      Icons.event,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    SafeLabelText(
                      _formatDate(game['date']),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    SafeLabelText(
                      game['time'] ?? 'TBD',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
