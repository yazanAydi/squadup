import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_colors.dart';
import '../widgets/common/squadup_logo.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const SquadUpLogo(
          size: 40.0,
          showGlow: false,
          isIconOnly: true,
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            tooltip: 'Settings',
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
              child: Tooltip(
                message: 'View Profile',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          colors: [
              AppColors.background,
              AppColors.background,
              AppColors.surface.withValues(alpha: 0.3),
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                // Welcome message with enhanced styling
                Container(
                  padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                        AppColors.surface,
                        AppColors.surface.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
        children: [
          Container(
                            padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
                                colors: AppColors.logoGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                            child: const Icon(
                              Icons.bar_chart,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                                  'Welcome back,',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                    Text(
                                  'yazan',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
                      // Stats row
          Row(
            children: [
                          _buildStatItem('Games', '0', Icons.sports_basketball, AppColors.primary),
              const SizedBox(width: 16),
                          _buildStatItem('MVPs', '0', Icons.star, AppColors.yellow),
              const SizedBox(width: 16),
                          _buildStatItem('Sports', '3', Icons.sports, AppColors.green),
            ],
          ),
        ],
      ),
                ),
                
                const SizedBox(height: 32),
                
                // Section title
        Row(
          children: [
            Icon(
              Icons.flash_on,
              color: AppColors.primary,
                      size: 24,
            ),
                    const SizedBox(width: 12),
            Text(
              'Quick Actions',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
              ),
            ),
          ],
        ),
                
                const SizedBox(height: 20),
                
                // Feature cards with enhanced design
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.85,
          children: [
                    _buildEnhancedFeatureCard(
              icon: Icons.search,
                      title: 'Find Teams',
                      subtitle: 'Discover teams in your area',
              color: AppColors.primary,
                      gradient: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TeamDiscoveryScreen(),
                          ),
                        );
                      },
                    ),
                    _buildEnhancedFeatureCard(
                      icon: Icons.add,
              title: 'Create Team',
                      subtitle: 'Start your own team',
                      color: AppColors.green,
                      gradient: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TeamCreationScreen(),
                          ),
                        );
                      },
                    ),
                    _buildEnhancedFeatureCard(
                      icon: Icons.calendar_today,
                      title: 'Join Game',
                      subtitle: 'Find pickup games',
                      color: AppColors.orange,
                      gradient: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GameDiscoveryScreen(),
                          ),
                        );
                      },
                    ),
                    _buildEnhancedFeatureCard(
                      icon: Icons.group,
                      title: 'My Teams',
                      subtitle: 'Manage your teams',
                      color: AppColors.primary,
                      gradient: true,
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
                
                const SizedBox(height: 32),
                
                // Your Sports section
                    Row(
                      children: [
                    Icon(
                      Icons.sports,
                      color: AppColors.primary,
                            size: 24,
                          ),
                    const SizedBox(width: 12),
                    Text(
                      'Your Sports',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                                ),
                              ],
                            ),
                
                    const SizedBox(height: 16),
                
                // Sports cards
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildSportCard('Volleyball', Icons.sports_volleyball, AppColors.primary),
                      const SizedBox(width: 16),
                      _buildSportCard('Soccer', Icons.sports_soccer, Colors.black),
                      const SizedBox(width: 16),
                      _buildSportCard('Basketball', Icons.sports_basketball, AppColors.orange),
                  ],
                ),
              ),
                
                const SizedBox(height: 40),
              ],
            ),
                    ),
                  ),
                ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.logoGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 20,
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
          icon: const Icon(Icons.add, size: 24),
          label: const Text(
            'Create Game',
                  style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
                  border: Border.all(
            color: color.withValues(alpha: 0.2),
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
            const SizedBox(height: 8),
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
                color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
      ),
    );
  }

  Widget _buildEnhancedFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    bool gradient = false,
    VoidCallback? onTap,
  }) {
    return Container(
              decoration: BoxDecoration(
        gradient: gradient
            ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                  AppColors.surface,
                  AppColors.surface.withValues(alpha: 0.9),
                ],
              )
            : null,
        color: gradient ? null : AppColors.surface,
        borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: color.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
                // Enhanced icon container
          Container(
                  padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.2),
                        color.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
                    size: 36,
              color: color,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Title with enhanced typography
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                // Subtitle with enhanced styling
                Text(
                  subtitle,
              style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: color.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 12),
                  Text(
            sport,
            style: TextStyle(
              color: AppColors.textPrimary,
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