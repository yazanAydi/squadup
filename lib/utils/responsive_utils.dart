import 'package:flutter/material.dart';

/// Utility class for responsive design across different screen sizes
class ResponsiveUtils {
  static const double _smallScreenBreakpoint = 400;
  static const double _mediumScreenBreakpoint = 600;
  static const double _largeScreenBreakpoint = 900;

  /// Get screen size information
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Check if screen is small (mobile portrait)
  static bool isSmallScreen(BuildContext context) {
    return getScreenSize(context).width < _smallScreenBreakpoint;
  }

  /// Check if screen is medium (tablet portrait)
  static bool isMediumScreen(BuildContext context) {
    final width = getScreenSize(context).width;
    return width >= _smallScreenBreakpoint && width < _mediumScreenBreakpoint;
  }

  /// Check if screen is large (tablet landscape)
  static bool isLargeScreen(BuildContext context) {
    final width = getScreenSize(context).width;
    return width >= _mediumScreenBreakpoint && width < _largeScreenBreakpoint;
  }

  /// Check if screen is extra large (desktop)
  static bool isExtraLargeScreen(BuildContext context) {
    return getScreenSize(context).width >= _largeScreenBreakpoint;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.all(12);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(16);
    } else {
      return const EdgeInsets.all(20);
    }
  }

  /// Get responsive horizontal padding
  static EdgeInsets getResponsiveHorizontalPadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.symmetric(horizontal: 12);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.symmetric(horizontal: 16);
    } else {
      return const EdgeInsets.symmetric(horizontal: 20);
    }
  }

  /// Get responsive spacing between elements
  static double getResponsiveSpacing(BuildContext context) {
    if (isSmallScreen(context)) {
      return 8.0;
    } else if (isMediumScreen(context)) {
      return 12.0;
    } else {
      return 16.0;
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, {
    double small = 12.0,
    double medium = 14.0,
    double large = 16.0,
    double extraLarge = 18.0,
  }) {
    if (isSmallScreen(context)) {
      return small;
    } else if (isMediumScreen(context)) {
      return medium;
    } else if (isLargeScreen(context)) {
      return large;
    } else {
      return extraLarge;
    }
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(BuildContext context, {
    double small = 16.0,
    double medium = 20.0,
    double large = 24.0,
    double extraLarge = 28.0,
  }) {
    if (isSmallScreen(context)) {
      return small;
    } else if (isMediumScreen(context)) {
      return medium;
    } else if (isLargeScreen(context)) {
      return large;
    } else {
      return extraLarge;
    }
  }

  /// Get responsive card width
  static double getResponsiveCardWidth(BuildContext context, {
    double small = 100.0,
    double medium = 120.0,
    double large = 140.0,
    double extraLarge = 160.0,
  }) {
    if (isSmallScreen(context)) {
      return small;
    } else if (isMediumScreen(context)) {
      return medium;
    } else if (isLargeScreen(context)) {
      return large;
    } else {
      return extraLarge;
    }
  }

  /// Get responsive card height
  static double getResponsiveCardHeight(BuildContext context, {
    double small = 120.0,
    double medium = 140.0,
    double large = 160.0,
    double extraLarge = 180.0,
  }) {
    if (isSmallScreen(context)) {
      return small;
    } else if (isMediumScreen(context)) {
      return medium;
    } else if (isLargeScreen(context)) {
      return large;
    } else {
      return extraLarge;
    }
  }

  /// Get responsive avatar radius
  static double getResponsiveAvatarRadius(BuildContext context) {
    final width = getScreenSize(context).width;
    if (width < _smallScreenBreakpoint) {
      return width * 0.10; // 10% of screen width
    } else if (width < _mediumScreenBreakpoint) {
      return width * 0.08; // 8% of screen width
    } else {
      return width * 0.06; // 6% of screen width
    }
  }

  /// Get responsive button height
  static double getResponsiveButtonHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return 44.0;
    } else if (isMediumScreen(context)) {
      return 48.0;
    } else {
      return 56.0;
    }
  }

  /// Get responsive input field height
  static double getResponsiveInputHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return 44.0;
    } else if (isMediumScreen(context)) {
      return 48.0;
    } else {
      return 52.0;
    }
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(BuildContext context) {
    if (isSmallScreen(context)) {
      return 8.0;
    } else if (isMediumScreen(context)) {
      return 12.0;
    } else {
      return 16.0;
    }
  }

  /// Get responsive grid cross axis count
  static int getResponsiveGridCrossAxisCount(BuildContext context) {
    if (isSmallScreen(context)) {
      return 1;
    } else if (isMediumScreen(context)) {
      return 2;
    } else if (isLargeScreen(context)) {
      return 3;
    } else {
      return 4;
    }
  }

  /// Get responsive list item spacing
  static double getResponsiveListItemSpacing(BuildContext context) {
    if (isSmallScreen(context)) {
      return 8.0;
    } else if (isMediumScreen(context)) {
      return 12.0;
    } else {
      return 16.0;
    }
  }

  /// Get responsive bottom sheet padding
  static EdgeInsets getResponsiveBottomSheetPadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.all(16);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(20);
    } else {
      return const EdgeInsets.all(24);
    }
  }

  /// Get responsive dialog padding
  static EdgeInsets getResponsiveDialogPadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.all(16);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(20);
    } else {
      return const EdgeInsets.all(24);
    }
  }

  /// Get responsive snackbar margin
  static EdgeInsets getResponsiveSnackBarMargin(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.all(8);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(12);
    } else {
      return const EdgeInsets.all(16);
    }
  }

  /// Get responsive app bar height
  static double getResponsiveAppBarHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return kToolbarHeight;
    } else if (isMediumScreen(context)) {
      return kToolbarHeight + 8;
    } else {
      return kToolbarHeight + 16;
    }
  }

  /// Get responsive drawer width
  static double getResponsiveDrawerWidth(BuildContext context) {
    if (isSmallScreen(context)) {
      return 280.0;
    } else if (isMediumScreen(context)) {
      return 320.0;
    } else {
      return 360.0;
    }
  }

  /// Get responsive navigation bar height
  static double getResponsiveNavigationBarHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return 60.0;
    } else if (isMediumScreen(context)) {
      return 70.0;
    } else {
      return 80.0;
    }
  }

  /// Get responsive floating action button size
  static double getResponsiveFABSize(BuildContext context) {
    if (isSmallScreen(context)) {
      return 56.0;
    } else if (isMediumScreen(context)) {
      return 64.0;
    } else {
      return 72.0;
    }
  }

  /// Get responsive chip height
  static double getResponsiveChipHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return 28.0;
    } else if (isMediumScreen(context)) {
      return 32.0;
    } else {
      return 36.0;
    }
  }

  /// Get responsive divider thickness
  static double getResponsiveDividerThickness(BuildContext context) {
    if (isSmallScreen(context)) {
      return 0.5;
    } else if (isMediumScreen(context)) {
      return 1.0;
    } else {
      return 1.5;
    }
  }

  /// Get responsive elevation
  static double getResponsiveElevation(BuildContext context) {
    if (isSmallScreen(context)) {
      return 2.0;
    } else if (isMediumScreen(context)) {
      return 4.0;
    } else {
      return 8.0;
    }
  }

  /// Get responsive shadow blur radius
  static double getResponsiveShadowBlurRadius(BuildContext context) {
    if (isSmallScreen(context)) {
      return 4.0;
    } else if (isMediumScreen(context)) {
      return 8.0;
    } else {
      return 12.0;
    }
  }

  /// Get responsive shadow offset
  static Offset getResponsiveShadowOffset(BuildContext context) {
    if (isSmallScreen(context)) {
      return const Offset(0, 2);
    } else if (isMediumScreen(context)) {
      return const Offset(0, 4);
    } else {
      return const Offset(0, 6);
    }
  }

  /// Get responsive animation duration
  static Duration getResponsiveAnimationDuration(BuildContext context) {
    if (isSmallScreen(context)) {
      return const Duration(milliseconds: 200);
    } else if (isMediumScreen(context)) {
      return const Duration(milliseconds: 300);
    } else {
      return const Duration(milliseconds: 400);
    }
  }

  /// Get responsive curve for animations
  static Curve getResponsiveCurve(BuildContext context) {
    if (isSmallScreen(context)) {
      return Curves.easeInOut;
    } else if (isMediumScreen(context)) {
      return Curves.easeOutCubic;
    } else {
      return Curves.easeOutQuart;
    }
  }
}
