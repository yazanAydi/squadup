import 'package:flutter/material.dart';

/// SquadUp App Colors following the brand guidelines
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryVariant = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color secondary = Color(0xFFA78BFA);
  
  // Background Colors
  static const Color background = Color(0xFF0F0A1F);
  static const Color surface = Color(0xFF1C1532);
  static const Color surfaceVariant = Color(0xFF2D1B69);
  static const Color card = Color(0xFF1C1532);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textTertiary = Color(0xFF71717A);
  
  // Accent Colors
  static const Color accent = Color(0xFF7C3AED);
  static const Color accentGlow = Color(0xFF7C3AED);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Additional Status Colors (for compatibility)
  static const Color red = Color(0xFFEF4444);
  static const Color green = Color(0xFF10B981);
  static const Color orange = Color(0xFFF59E0B);
  static const Color yellow = Color(0xFFEAB308);
  static const Color blue = Color(0xFF3B82F6);
  
  // Interactive Colors
  static const Color buttonPrimary = Color(0xFF8B5CF6);
  static const Color buttonSecondary = Color(0xFF1C1532);
  static const Color buttonDisabled = Color(0xFF374151);
  
  // Border Colors
  static const Color border = Color(0xFF374151);
  static const Color borderLight = Color(0xFF4B5563);
  static const Color borderDark = Color(0xFF1F2937);
  static const Color outline = Color(0xFF374151);
  
  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient logoGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0F0A1F), Color(0xFF1C1532)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Shadow Colors
  static const Color shadow = Color(0x40000000);
  static const Color shadowLight = Color(0x20000000);
  
  // Input Field Colors
  static const Color inputBackground = Color(0xFF1C1532);
  static const Color inputBorder = Color(0xFF8B5CF6);
  static const Color inputBorderFocused = Color(0xFF7C3AED);
  static const Color inputText = Color(0xFFFFFFFF);
  static const Color inputHint = Color(0xFFA1A1AA);
  
  // Navigation Colors
  static const Color navBackground = Color(0xFF1C1532);
  static const Color navSelected = Color(0xFF8B5CF6);
  static const Color navUnselected = Color(0xFFA1A1AA);
  
  // Game Status Colors
  static const Color gameActive = Color(0xFF10B981);
  static const Color gamePending = Color(0xFFF59E0B);
  static const Color gameCompleted = Color(0xFF6B7280);
  static const Color gameCancelled = Color(0xFFEF4444);
  
  // Team Colors
  static const Color teamPrimary = Color(0xFF8B5CF6);
  static const Color teamSecondary = Color(0xFF7C3AED);
  static const Color teamAccent = Color(0xFFA78BFA);
  
  // Profile Colors
  static const Color profileBackground = Color(0xFF1C1532);
  static const Color profileCard = Color(0xFF2D1B69);
  static const Color profileAccent = Color(0xFF8B5CF6);
  
  // Chat Colors
  static const Color chatBackground = Color(0xFF0F0A1F);
  static const Color chatBubble = Color(0xFF1C1532);
  static const Color chatBubbleOwn = Color(0xFF8B5CF6);
  static const Color chatText = Color(0xFFFFFFFF);
  static const Color chatTextOwn = Color(0xFFFFFFFF);
  
  // Notification Colors
  static const Color notificationSuccess = Color(0xFF10B981);
  static const Color notificationWarning = Color(0xFFF59E0B);
  static const Color notificationError = Color(0xFFEF4444);
  static const Color notificationInfo = Color(0xFF3B82F6);
}
