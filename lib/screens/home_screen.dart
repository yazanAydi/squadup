import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/theme.dart';
import 'game_creation_screen.dart';
import 'game_discovery_screen.dart';
import 'team_creation_screen.dart';
import 'team_management_screen.dart';
import 'team_discovery_screen.dart';
import 'settings_screen.dart';
import 'user_profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: SquadUpTheme.scaffold,
      appBar: AppBar(
        backgroundColor: SquadUpTheme.scaffold,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(SquadUpTheme.spacingS),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                SquadUpTheme.primary,
                SquadUpTheme.accentGlow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(SquadUpTheme.radiusM),
            boxShadow: [
              BoxShadow(
                color: SquadUpTheme.primary.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: SquadUpTheme.accentGlow.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 3,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SquadUpTheme.radiusM),
            child: Image.asset(
              'assets/logoo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: SquadUpTheme.textSecondary,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            tooltip: 'Settings',
          ),
          Container(
            margin: const EdgeInsets.only(right: SquadUpTheme.spacingM),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
              child: Tooltip(
                message: 'View Profile',
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        SquadUpTheme.primary,
                        SquadUpTheme.accentGlow,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: SquadUpTheme.primary.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    color: SquadUpTheme.textPrimary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: SquadUpTheme.getDirectionalPadding(
            start: SquadUpTheme.spacingL,
            end: SquadUpTheme.spacingL,
            top: SquadUpTheme.spacingL,
            bottom: SquadUpTheme.spacingL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message with enhanced styling and glowing effects
              Container(
                padding: const EdgeInsets.all(SquadUpTheme.spacingL),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      SquadUpTheme.card,
                      SquadUpTheme.surfaceContainer,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(SquadUpTheme.radiusL),
                  boxShadow: [
                    BoxShadow(
                      color: SquadUpTheme.primary.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: SquadUpTheme.accentGlow.withValues(alpha: 0.2),
                      blurRadius: 50,
                      spreadRadius: 5,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(SquadUpTheme.spacingS),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                SquadUpTheme.primary,
                                SquadUpTheme.accentGlow,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(SquadUpTheme.radiusM),
                            boxShadow: [
                              BoxShadow(
                                color: SquadUpTheme.primary.withValues(alpha: 0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                              BoxShadow(
                                color: SquadUpTheme.accentGlow.withValues(alpha: 0.3),
                                blurRadius: 30,
                                spreadRadius: 3,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.bar_chart,
                            color: SquadUpTheme.textPrimary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: SquadUpTheme.spacingM),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: SquadUpTheme.textSecondary,
                                ),
                              ),
                              Text(
                                'yazan',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: SquadUpTheme.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SquadUpTheme.spacingL),
                    // Stats row
                    Row(
                      children: [
                        _buildStatItem('Games', '0', Icons.sports_basketball, SquadUpTheme.primary),
                        const SizedBox(width: SquadUpTheme.spacingM),
                        _buildStatItem('MVPs', '0', Icons.star, Colors.amber),
                        const SizedBox(width: SquadUpTheme.spacingM),
                        _buildStatItem('Sports', '3', Icons.sports, SquadUpTheme.success),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: SquadUpTheme.spacingXL),
              
              // Section title
              Row(
                children: [
                  Icon(
                    Icons.flash_on,
                    color: SquadUpTheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: SquadUpTheme.spacingS),
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: SquadUpTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: SquadUpTheme.spacingL),
              
              // Feature cards with enhanced design
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: SquadUpTheme.spacingL,
                mainAxisSpacing: SquadUpTheme.spacingL,
                childAspectRatio: 1.0, // Further increased to prevent overflow
                children: [
                  _buildFeatureCard(
                    icon: Icons.search,
                    title: 'Find Teams',
                    subtitle: 'Discover teams in your area',
                    color: SquadUpTheme.primary,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TeamDiscoveryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.add,
                    title: 'Create Team',
                    subtitle: 'Start your own team',
                    color: SquadUpTheme.success,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TeamCreationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.calendar_today,
                    title: 'Join Game',
                    subtitle: 'Find pickup games',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GameDiscoveryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.group,
                    title: 'My Teams',
                    subtitle: 'Manage your teams',
                    color: SquadUpTheme.primary,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TeamManagementScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: SquadUpTheme.spacingXL),
              
              // Your Sports section
              Row(
                children: [
                  Icon(
                    Icons.sports,
                    color: SquadUpTheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: SquadUpTheme.spacingS),
                  Text(
                    'Your Sports',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: SquadUpTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: SquadUpTheme.spacingL),
              
              // Sports cards
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSportCard('Volleyball', Icons.sports_volleyball, SquadUpTheme.primary),
                    const SizedBox(width: SquadUpTheme.spacingM),
                    _buildSportCard('Soccer', Icons.sports_soccer, Colors.black),
                    const SizedBox(width: SquadUpTheme.spacingM),
                    _buildSportCard('Basketball', Icons.sports_basketball, Colors.orange),
                  ],
                ),
              ),
              
              const SizedBox(height: SquadUpTheme.spacingXL),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              SquadUpTheme.primary,
              SquadUpTheme.accentGlow,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(SquadUpTheme.radiusL),
          boxShadow: [
            BoxShadow(
              color: SquadUpTheme.primary.withValues(alpha: 0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: SquadUpTheme.accentGlow.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 3,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GameCreationScreen(),
              ),
            );
          },
          icon: const Icon(Icons.add, size: 20),
          label: const Text(
            'Create Game',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: SquadUpTheme.textPrimary,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: SquadUpTheme.spacingM,
          horizontal: SquadUpTheme.spacingS,
        ),
        decoration: BoxDecoration(
          color: SquadUpTheme.card,
          borderRadius: BorderRadius.circular(SquadUpTheme.radiusM),
          border: Border.all(
            color: SquadUpTheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(height: SquadUpTheme.spacingXS),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: SquadUpTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SquadUpTheme.card,
            SquadUpTheme.surfaceContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(SquadUpTheme.radiusL),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: SquadUpTheme.primary.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: SquadUpTheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SquadUpTheme.radiusL),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(SquadUpTheme.spacingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon container with glowing effects
                Container(
                  padding: const EdgeInsets.all(SquadUpTheme.spacingL),
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        color.withValues(alpha: 0.2),
                        color.withValues(alpha: 0.1),
                        color.withValues(alpha: 0.05),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: color.withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 3,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: color,
                  ),
                ),
                
                const SizedBox(height: SquadUpTheme.spacingL),
                
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: SquadUpTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: SquadUpTheme.spacingXS),
                
                // Subtitle
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: SquadUpTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSportCard(String sport, IconData icon, Color color) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SquadUpTheme.card,
            SquadUpTheme.surfaceContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(SquadUpTheme.radiusL),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: SquadUpTheme.primary.withValues(alpha: 0.1),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: SquadUpTheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(SquadUpTheme.spacingM),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.1),
                  color.withValues(alpha: 0.05),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(height: SquadUpTheme.spacingS),
          Text(
            sport,
            style: TextStyle(
              color: SquadUpTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}