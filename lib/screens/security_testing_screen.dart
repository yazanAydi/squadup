import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Security testing screen for SquadUp app
class SecurityTestingScreen extends StatefulWidget {
  const SecurityTestingScreen({super.key});

  @override
  State<SecurityTestingScreen> createState() => _SecurityTestingScreenState();
}

class _SecurityTestingScreenState extends State<SecurityTestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Security Testing',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Security Testing Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
