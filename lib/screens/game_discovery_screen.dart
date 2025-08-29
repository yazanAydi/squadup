import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Game discovery screen for SquadUp app
class GameDiscoveryScreen extends StatefulWidget {
  const GameDiscoveryScreen({super.key});

  @override
  State<GameDiscoveryScreen> createState() => _GameDiscoveryScreenState();
}

class _GameDiscoveryScreenState extends State<GameDiscoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Discover Games',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Game Discovery Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
