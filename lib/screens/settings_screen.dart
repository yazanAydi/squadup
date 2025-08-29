import 'package:flutter/material.dart';
import '../app/theme.dart';

/// Settings screen for SquadUp app
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SquadUpTheme.scaffold,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: SquadUpTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: SquadUpTheme.scaffold,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: SquadUpTheme.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              // Profile Section
              _buildSettingsSection(
                title: 'Profile',
                icon: Icons.person,
                children: [
                  _buildSettingsItem(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    subtitle: 'Update your personal information',
                    onTap: () {
                      // TODO: Navigate to edit profile
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.security,
                    title: 'Privacy & Security',
                    subtitle: 'Manage your privacy settings',
                    onTap: () {
                      // TODO: Navigate to privacy settings
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: SquadUpTheme.spacingXL),
              
              // Preferences Section
              _buildSettingsSection(
                title: 'Preferences',
                icon: Icons.tune,
                children: [
                  _buildSettingsItem(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'Manage notification preferences',
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeColor: SquadUpTheme.primary,
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subtitle: 'Toggle dark theme',
                    trailing: Switch(
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      },
                      activeColor: SquadUpTheme.primary,
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: _selectedLanguage,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: SquadUpTheme.textSecondary,
                      size: 16,
                    ),
                    onTap: () {
                      _showLanguageDialog();
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: SquadUpTheme.spacingXL),
              
              // Support Section
              _buildSettingsSection(
                title: 'Support',
                icon: Icons.help,
                children: [
                  _buildSettingsItem(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    subtitle: 'Get help and support',
                    onTap: () {
                      // TODO: Navigate to help center
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.feedback,
                    title: 'Send Feedback',
                    subtitle: 'Share your thoughts with us',
                    onTap: () {
                      // TODO: Navigate to feedback
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.info,
                    title: 'About',
                    subtitle: 'App version and information',
                    onTap: () {
                      // TODO: Navigate to about
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: SquadUpTheme.spacingXL),
              
              // Account Section
              _buildSettingsSection(
                title: 'Account',
                icon: Icons.account_circle,
                children: [
                  _buildSettingsItem(
                    icon: Icons.logout,
                    title: 'Sign Out',
                    subtitle: 'Sign out of your account',
                    textColor: SquadUpTheme.error,
                    onTap: () {
                      _showSignOutDialog();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: SquadUpTheme.primary,
              size: 24,
            ),
            const SizedBox(width: SquadUpTheme.spacingS),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: SquadUpTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: SquadUpTheme.spacingM),
        Container(
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
                color: SquadUpTheme.primary.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: SquadUpTheme.outline.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: SquadUpTheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(SquadUpTheme.spacingS),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                SquadUpTheme.primary.withValues(alpha: 0.2),
                SquadUpTheme.primary.withValues(alpha: 0.1),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: SquadUpTheme.primary.withValues(alpha: 0.2),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: SquadUpTheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? SquadUpTheme.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: SquadUpTheme.textSecondary,
            fontSize: 14,
          ),
        ),
        trailing: trailing ?? Icon(
          Icons.arrow_forward_ios,
          color: SquadUpTheme.textSecondary,
          size: 16,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SquadUpTheme.spacingL,
          vertical: SquadUpTheme.spacingS,
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SquadUpTheme.card,
        title: Text(
          'Select Language',
          style: TextStyle(color: SquadUpTheme.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English'),
            _buildLanguageOption('العربية'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(
        language,
        style: TextStyle(color: SquadUpTheme.textPrimary),
      ),
      trailing: _selectedLanguage == language
          ? Icon(Icons.check, color: SquadUpTheme.primary)
          : null,
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.of(context).pop();
      },
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SquadUpTheme.card,
        title: Text(
          'Sign Out',
          style: TextStyle(color: SquadUpTheme.textPrimary),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: SquadUpTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: SquadUpTheme.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement sign out
              Navigator.of(context).pop();
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: SquadUpTheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
