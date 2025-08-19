import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/safe_text.dart';
import '../utils/page_transitions.dart';
// Removed Freepik demo imports

class TeamDiscoveryScreen extends StatefulWidget {
  const TeamDiscoveryScreen({super.key});

  @override
  TeamDiscoveryScreenState createState() => TeamDiscoveryScreenState();
}

class TeamDiscoveryScreenState extends State<TeamDiscoveryScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchControllerText = TextEditingController();
  String _searchQuery = '';
  String _selectedSport = 'All';
  final bool _isLoading = false;
  late AnimationController _searchFadeController;
  late Animation<double> _searchFade;

  // Sports list
  final List<String> _sports = ['All', 'Basketball', 'Football', 'Soccer', 'Tennis'];

  // Colors - will be replaced with theme tokens

  @override
  void initState() {
    super.initState();
    _searchFadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _searchFadeController, curve: Curves.easeInOut),
    );
    _searchFadeController.forward();
  }

  @override
  void dispose() {
    _searchControllerText.dispose();
    _searchFadeController.dispose();
    super.dispose();
  }

  void _showTeamDetails(Map<String, dynamic> team) {
    // Navigate to team details screen
    Navigator.of(context).push(
      PageTransitions.slideRight(
        Scaffold(
          appBar: AppBar(
            title: Text(team['name'] ?? 'Team Details'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Team Header
                Container(
                  padding: const EdgeInsets.all(20),
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
                  ),
                  child: Row(
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: team['imageUrl'] != null && team['imageUrl'].toString().isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: team['imageUrl'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    _getSportIcon(team['sport'] ?? 'Basketball'),
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              )
                            : Image.asset(
                                _getSportIcon(team['sport'] ?? 'Basketball'),
                                width: 30,
                                height: 30,
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SafeTitleText(
                              team['name'] ?? 'Team Name',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SafeLabelText(
                              team['sport'] ?? 'Sport',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Team Info
                Container(
                  padding: const EdgeInsets.all(20),
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
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeTitleText(
                        'Team Information',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Location', team['location'] ?? 'Unknown'),
                      _buildInfoRow('Sport', team['sport'] ?? 'Unknown'),
                      _buildInfoRow('Members', '${team['memberCount'] ?? 0} players'),
                      _buildInfoRow('Created', team['createdAt'] ?? 'Unknown'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Join Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle join team logic
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const SafeTitleText(
                      'Join Team',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeLabelText(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          SafeTitleText(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball':
        return 'assets/basketball.png';
      case 'football':
        return 'assets/ball.png';
      case 'soccer':
        return 'assets/ball.png';
      case 'tennis':
        return 'assets/ball.png';
      default:
        return 'assets/ball.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: MediaQuery.of(context).textScaler.clamp(
          minScaleFactor: 1.0,
          maxScaleFactor: 1.2,
        ),
      ),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // App Bar
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        // Avoid Expanded + Flexible conflict from SafeTitleText
                        Flexible(
                          child: SafeTitleText(
                            'Find Teams',
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
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                              ),
                            ),
                            child: TextField(
                              controller: _searchControllerText,
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                              decoration: InputDecoration(
                                hintText: 'Search teams...',
                                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Sport Filter
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _sports.length,
                              itemBuilder: (context, index) {
                                final sport = _sports[index];
                                final isSelected = _selectedSport == sport;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedSport = sport;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: isSelected
                                            ? [
                                                Theme.of(context).colorScheme.primary,
                                                Theme.of(context).colorScheme.primary.withValues(alpha: 0.8)
                                              ]
                                            : [
                                                Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
                                                Theme.of(context).colorScheme.surface.withValues(alpha: 0.4)
                                              ],
                                      ),
                                      borderRadius: BorderRadius.circular(25),
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
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // AI demo removed

                  const SizedBox(height: 20),

                  // Teams List
                  _isLoading
                      ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('teams').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: SafeLabelText(
                                  'Error loading teams',
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                                ),
                              );
                            }

                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
                              );
                            }

                            var teams = snapshot.data!.docs.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              return {'id': doc.id, ...data};
                            }).toList();

                            // Apply filters
                            if (_selectedSport != 'All') {
                              teams = teams.where((team) => 
                                (team['sport']?.toString().toLowerCase() ?? '') == _selectedSport.toLowerCase()
                              ).toList();
                            }

                            if (_searchQuery.isNotEmpty) {
                              teams = teams.where((team) =>
                                (team['name']?.toString().toLowerCase() ?? '').contains(_searchQuery.toLowerCase()) ||
                                (team['location']?.toString().toLowerCase() ?? '').contains(_searchQuery.toLowerCase())
                              ).toList();
                            }

                            if (teams.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 64,
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                                    ),
                                    const SizedBox(height: 16),
                                    SafeTitleText(
                                      'No teams found',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SafeBodyText(
                                      'Try adjusting your search or filters',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: teams.length,
                              itemBuilder: (context, index) {
                                final team = teams[index];
                                return _buildTeamCard(team);
                              },
                            );
                          },
                        ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamCard(Map<String, dynamic> team) {
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
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showTeamDetails(team),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Team Icon/Logo
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: team['imageUrl'] != null && team['imageUrl'].toString().isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: team['imageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              _getSportIcon(team['sport'] ?? 'Basketball'),
                              width: 25,
                              height: 25,
                            ),
                          ),
                        )
                      : Image.asset(
                          _getSportIcon(team['sport'] ?? 'Basketball'),
                          width: 25,
                          height: 25,
                        ),
                ),
                
                const SizedBox(width: 16),
                
                // Team Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeTitleText(
                        team['name'] ?? 'Team Name',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SafeLabelText(
                        team['sport'] ?? 'Sport',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          SafeLabelText(
                            team['location'] ?? 'Unknown Location',
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
                
                // Arrow indicator
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
