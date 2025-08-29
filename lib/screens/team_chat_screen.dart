import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Team chat screen for SquadUp app
class TeamChatScreen extends StatefulWidget {
  final String teamId;
  final String teamName;

  const TeamChatScreen({
    super.key,
    required this.teamId,
    required this.teamName,
  });

  @override
  State<TeamChatScreen> createState() => _TeamChatScreenState();
}

class _TeamChatScreenState extends State<TeamChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.teamName,
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Team Chat Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
