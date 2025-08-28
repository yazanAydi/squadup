import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/theme/app_colors.dart';
import 'responsive_utils.dart';

/// Responsive sport card widget that automatically adjusts to screen size
class ResponsiveSportCard extends StatelessWidget {
  final String sport;
  final String position;
  final String? sportIconPath;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;
  final Color? backgroundColor;
  final double? customWidth;
  final double? customHeight;

  const ResponsiveSportCard({
    super.key,
    required this.sport,
    required this.position,
    this.sportIconPath,
    this.onEdit,
    this.onDelete,
    this.showActions = true,
    this.backgroundColor,
    this.customWidth,
    this.customHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: customWidth ?? ResponsiveUtils.getResponsiveCardWidth(
        context, 
        small: 100, 
        medium: 120, 
        large: 140, 
        extraLarge: 160
      ),
      height: customHeight ?? ResponsiveUtils.getResponsiveCardHeight(
        context, 
        small: 120, 
        medium: 140, 
        large: 160, 
        extraLarge: 180
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.outline.withValues(alpha: 0.1),
            blurRadius: ResponsiveUtils.getResponsiveShadowBlurRadius(context),
            offset: ResponsiveUtils.getResponsiveShadowOffset(context),
          ),
        ],
      ),
      padding: ResponsiveUtils.getResponsivePadding(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sport icon
          if (sportIconPath != null)
            Image.asset(
              sportIconPath!,
              width: ResponsiveUtils.getResponsiveIconSize(context, small: 28, medium: 32),
              height: ResponsiveUtils.getResponsiveIconSize(context, small: 28, medium: 32),
              fit: BoxFit.contain,
            ),
          
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 0.5),
          
          // Sport name
          Text(
            sport,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          
          // Position
          Text(
            position,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          
          if (showActions) ...[
            const Spacer(),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onEdit != null)
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).iconTheme.color,
                      size: ResponsiveUtils.getResponsiveIconSize(context, small: 14, medium: 16),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 24),
                      minHeight: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 24),
                    ),
                    onPressed: onEdit,
                  ),
                
                if (onEdit != null && onDelete != null)
                  SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context) * 0.25),
                
                if (onDelete != null)
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.red,
                      size: ResponsiveUtils.getResponsiveIconSize(context, small: 14, medium: 16),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 24),
                      minHeight: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 24),
                    ),
                    onPressed: onDelete,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Responsive team card widget
class ResponsiveTeamCard extends StatelessWidget {
  final Map<String, dynamic> team;
  final String? sportIconPath;
  final VoidCallback? onTap;
  final VoidCallback? onJoin;
  final VoidCallback? onManage;
  final bool isOwner;

  const ResponsiveTeamCard({
    super.key,
    required this.team,
    this.sportIconPath,
    this.onTap,
    this.onJoin,
    this.onManage,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ResponsiveUtils.getResponsiveSpacing(context)),
      elevation: ResponsiveUtils.getResponsiveElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
        child: Padding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with sport icon and team name
              Row(
                children: [
                  if (sportIconPath != null)
                    Container(
                      width: ResponsiveUtils.getResponsiveIconSize(context, small: 30, medium: 40),
                      height: ResponsiveUtils.getResponsiveIconSize(context, small: 30, medium: 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor.withValues(alpha: 0.2),
                            Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
                      ),
                      child: Image.asset(
                        sportIconPath!,
                        width: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 28),
                        height: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 28),
                      ),
                    ),
                  
                  SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          team['name'] ?? 'Team Name',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          team['sport'] ?? 'Sport',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
              
              // Team info
              _buildInfoRow(context, 'Location', team['location'] ?? 'Unknown'),
              _buildInfoRow(context, 'Members', '${team['memberCount'] ?? 0}/${team['maxMembers'] ?? 0}'),
              _buildInfoRow(context, 'Level', team['level'] ?? 'Mixed'),
              _buildInfoRow(context, 'Created', _formatDate(team['createdAt'])),
              
              // Description
              if (team['description'] != null && team['description'].isNotEmpty) ...[
                SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                Text(
                  team['description'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isOwner ? onManage : onJoin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.getResponsiveButtonHeight(context) * 0.3,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
                        ),
                      ),
                      child: Text(
                        isOwner ? 'Manage Team' : 'Request to Join',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.getResponsiveSpacing(context) * 0.25),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'Unknown';
    try {
      if (date is Timestamp) {
        final dateTime = date.toDate();
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
      return date.toString();
    } catch (e) {
      return 'Unknown';
    }
  }
}

/// Responsive game card widget
class ResponsiveGameCard extends StatelessWidget {
  final Map<String, dynamic> game;
  final String? sportIconPath;
  final VoidCallback? onTap;
  final VoidCallback? onJoin;

  const ResponsiveGameCard({
    super.key,
    required this.game,
    this.sportIconPath,
    this.onTap,
    this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ResponsiveUtils.getResponsiveSpacing(context)),
      elevation: ResponsiveUtils.getResponsiveElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
        child: Padding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  if (sportIconPath != null)
                    Container(
                      width: ResponsiveUtils.getResponsiveIconSize(context, small: 30, medium: 40),
                      height: ResponsiveUtils.getResponsiveIconSize(context, small: 30, medium: 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor.withValues(alpha: 0.2),
                            Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
                      ),
                      child: Image.asset(
                        sportIconPath!,
                        width: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 28),
                        height: ResponsiveUtils.getResponsiveIconSize(context, small: 20, medium: 28),
                      ),
                    ),
                  
                  SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game['title'] ?? 'Game Title',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          game['sport'] ?? 'Sport',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
              
              // Game info
              _buildInfoRow(context, 'Location', game['location'] ?? 'Unknown'),
              _buildInfoRow(context, 'Date', _formatDate(game['date'])),
              _buildInfoRow(context, 'Time', game['time'] ?? 'Unknown'),
              _buildInfoRow(context, 'Players', '${game['currentPlayers'] ?? 0}/${game['maxPlayers'] ?? 0}'),
              _buildInfoRow(context, 'Level', game['level'] ?? 'Mixed'),
              
              // Description
              if (game['description'] != null && game['description'].isNotEmpty) ...[
                SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                Text(
                  game['description'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context) * 1.5),
              
              // Action button
              if (onJoin != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onJoin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.getResponsiveButtonHeight(context) * 0.3,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ResponsiveUtils.getResponsiveBorderRadius(context)),
                      ),
                    ),
                    child: Text(
                      'Join Game',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.getResponsiveSpacing(context) * 0.25),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'Unknown';
    try {
      if (date is Timestamp) {
        final dateTime = date.toDate();
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
      return date.toString();
    } catch (e) {
      return 'Unknown';
    }
  }
}
