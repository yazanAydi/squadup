import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// SquadUp Logo Widget
class SquadUpLogo extends StatelessWidget {
  final double? size;
  final Color? color;
  final bool showText;
  final String? text;
  final TextStyle? textStyle;

  const SquadUpLogo({
    super.key,
    this.size,
    this.color,
    this.showText = true,
    this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Image
        Container(
          width: size ?? 40,
          height: size ?? 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/logoo.png',
              width: size ?? 40,
              height: size ?? 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        if (showText) ...[
          const SizedBox(width: 12),
          // Logo Text
          Text(
            text ?? 'SquadUp',
            style: textStyle ?? AppTypography.logo.copyWith(
              fontSize: size != null ? size! * 0.6 : 28,
              color: color ?? AppColors.primary,
            ),
          ),
        ],
      ],
    );
  }
}

/// SquadUp Logo with Glow Effect
class SquadUpLogoGlow extends StatelessWidget {
  final double? size;
  final Color? color;
  final bool showText;
  final String? text;
  final TextStyle? textStyle;
  final double glowIntensity;

  const SquadUpLogoGlow({
    super.key,
    this.size,
    this.color,
    this.showText = true,
    this.text,
    this.textStyle,
    this.glowIntensity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (color ?? AppColors.primary).withValues(alpha: glowIntensity),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SquadUpLogo(
        size: size,
        color: color,
        showText: showText,
        text: text,
        textStyle: textStyle,
      ),
    );
  }
}

/// SquadUp Logo for Splash Screen
class SquadUpLogoSplash extends StatelessWidget {
  final double? size;
  final Color? color;
  final bool showText;
  final String? text;
  final TextStyle? textStyle;
  final bool animate;

  const SquadUpLogoSplash({
    super.key,
    this.size,
    this.color,
    this.showText = true,
    this.text,
    this.textStyle,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget logo = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Image with enhanced styling
        Container(
          width: size ?? 80,
          height: size ?? 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/logoo.png',
              width: size ?? 80,
              height: size ?? 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        if (showText) ...[
          const SizedBox(height: 16),
          // Logo Text with splash styling
          Text(
            text ?? 'SquadUp',
            style: textStyle ?? AppTypography.splash.copyWith(
              fontSize: size != null ? size! * 0.4 : 24,
              color: color ?? AppColors.textPrimary,
            ),
          ),
        ],
      ],
    );

    if (animate) {
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1500),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Opacity(
              opacity: value,
              child: logo,
            ),
          );
        },
      );
    }

    return logo;
  }
}
