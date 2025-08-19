import 'package:flutter/material.dart';

/// Comprehensive responsive layout utilities to prevent overflow issues.
class ResponsiveLayout {
  static const double _smallScreenBreakpoint = 400.0;
  static const double _mediumScreenBreakpoint = 600.0;

  /// Check if the screen is small (phone in portrait)
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < _smallScreenBreakpoint;
  }

  /// Check if the screen is medium (phone in landscape or small tablet)
  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _smallScreenBreakpoint && width < _mediumScreenBreakpoint;
  }

  /// Check if the screen is large (tablet or desktop)
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= _mediumScreenBreakpoint;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(20.0);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  /// Get responsive horizontal padding
  static EdgeInsets getResponsiveHorizontalPadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.symmetric(horizontal: 16.0);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.symmetric(horizontal: 20.0);
    } else {
      return const EdgeInsets.symmetric(horizontal: 24.0);
    }
  }

  /// Get responsive vertical padding
  static EdgeInsets getResponsiveVerticalPadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.symmetric(vertical: 16.0);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.symmetric(vertical: 20.0);
    } else {
      return const EdgeInsets.symmetric(vertical: 24.0);
    }
  }

  /// Get responsive spacing between elements
  static double getResponsiveSpacing(BuildContext context) {
    if (isSmallScreen(context)) {
      return 16.0;
    } else if (isMediumScreen(context)) {
      return 20.0;
    } else {
      return 24.0;
    }
  }

  /// Get responsive font size based on screen size
  static double getResponsiveFontSize(BuildContext context, {
    double small = 14.0,
    double medium = 16.0,
    double large = 18.0,
  }) {
    if (isSmallScreen(context)) {
      return small;
    } else if (isMediumScreen(context)) {
      return medium;
    } else {
      return large;
    }
  }

  /// Get responsive title font size
  static double getResponsiveTitleFontSize(BuildContext context) {
    if (isSmallScreen(context)) {
      return 20.0;
    } else if (isMediumScreen(context)) {
      return 24.0;
    } else {
      return 28.0;
    }
  }

  /// Get responsive subtitle font size
  static double getResponsiveSubtitleFontSize(BuildContext context) {
    if (isSmallScreen(context)) {
      return 14.0;
    } else if (isMediumScreen(context)) {
      return 16.0;
    } else {
      return 18.0;
    }
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(BuildContext context) {
    if (isSmallScreen(context)) {
      return 20.0;
    } else if (isMediumScreen(context)) {
      return 24.0;
    } else {
      return 28.0;
    }
  }

  /// Get responsive button height
  static double getResponsiveButtonHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return 48.0;
    } else if (isMediumScreen(context)) {
      return 52.0;
    } else {
      return 56.0;
    }
  }

  /// Get responsive card height
  static double getResponsiveCardHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return 120.0;
    } else if (isMediumScreen(context)) {
      return 140.0;
    } else {
      return 160.0;
    }
  }

  /// Get responsive card width
  static double getResponsiveCardWidth(BuildContext context) {
    if (isSmallScreen(context)) {
      return 140.0;
    } else if (isMediumScreen(context)) {
      return 160.0;
    } else {
      return 180.0;
    }
  }

  /// Get responsive avatar radius
  static double getResponsiveAvatarRadius(BuildContext context) {
    if (isSmallScreen(context)) {
      return 24.0;
    } else if (isMediumScreen(context)) {
      return 28.0;
    } else {
      return 32.0;
    }
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(BuildContext context) {
    if (isSmallScreen(context)) {
      return 12.0;
    } else if (isMediumScreen(context)) {
      return 16.0;
    } else {
      return 20.0;
    }
  }

  /// Get responsive grid cross axis count
  static int getResponsiveGridCrossAxisCount(BuildContext context) {
    if (isSmallScreen(context)) {
      return 2;
    } else if (isMediumScreen(context)) {
      return 3;
    } else {
      return 4;
    }
  }

  /// Get responsive child aspect ratio for grids
  static double getResponsiveChildAspectRatio(BuildContext context) {
    if (isSmallScreen(context)) {
      return 1.2;
    } else if (isMediumScreen(context)) {
      return 1.4;
    } else {
      return 1.6;
    }
  }

  /// Get responsive spacing between grid items
  static double getResponsiveGridSpacing(BuildContext context) {
    if (isSmallScreen(context)) {
      return 8.0;
    } else if (isMediumScreen(context)) {
      return 12.0;
    } else {
      return 16.0;
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
      return const EdgeInsets.all(16.0);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(20.0);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  /// Get responsive dialog padding
  static EdgeInsets getResponsiveDialogPadding(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(20.0);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  /// Get responsive snackbar margin
  static EdgeInsets getResponsiveSnackbarMargin(BuildContext context) {
    if (isSmallScreen(context)) {
      return const EdgeInsets.all(8.0);
    } else if (isMediumScreen(context)) {
      return const EdgeInsets.all(12.0);
    } else {
      return const EdgeInsets.all(16.0);
    }
  }

  /// Get responsive app bar height
  static double getResponsiveAppBarHeight(BuildContext context) {
    if (isSmallScreen(context)) {
      return 56.0;
    } else if (isMediumScreen(context)) {
      return 64.0;
    } else {
      return 72.0;
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
      return 56.0;
    } else if (isMediumScreen(context)) {
      return 64.0;
    } else {
      return 72.0;
    }
  }

  /// Get responsive FAB size
  static double getResponsiveFabSize(BuildContext context) {
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
      return 32.0;
    } else if (isMediumScreen(context)) {
      return 36.0;
    } else {
      return 40.0;
    }
  }

  /// Get responsive divider thickness
  static double getResponsiveDividerThickness(BuildContext context) {
    if (isSmallScreen(context)) {
      return 1.0;
    } else if (isMediumScreen(context)) {
      return 1.5;
    } else {
      return 2.0;
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

  /// Get responsive shadow spread radius
  static double getResponsiveShadowSpreadRadius(BuildContext context) {
    if (isSmallScreen(context)) {
      return 1.0;
    } else if (isMediumScreen(context)) {
      return 2.0;
    } else {
      return 4.0;
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

  /// Get responsive animation curve
  static Curve getResponsiveAnimationCurve(BuildContext context) {
    if (isSmallScreen(context)) {
      return Curves.easeInOut;
    } else if (isMediumScreen(context)) {
      return Curves.easeOutCubic;
    } else {
      return Curves.easeOutBack;
    }
  }

  /// Create a responsive SizedBox with height
  static Widget responsiveHeight(BuildContext context, double height) {
    return SizedBox(height: height);
  }

  /// Create a responsive SizedBox with width
  static Widget responsiveWidth(BuildContext context, double width) {
    return SizedBox(width: width);
  }

  /// Create a responsive SizedBox with both dimensions
  static Widget responsiveSize(BuildContext context, double width, double height) {
    return SizedBox(width: width, height: height);
  }

  /// Create a responsive Container with padding
  static Widget responsiveContainer(BuildContext context, {
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BoxDecoration? decoration,
    double? width,
    double? height,
  }) {
    return Container(
      padding: padding ?? getResponsivePadding(context),
      margin: margin,
      decoration: decoration,
      width: width,
      height: height,
      child: child,
    );
  }

  /// Create a responsive Card
  static Widget responsiveCard(BuildContext context, {
    Widget? child,
    EdgeInsets? margin,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return Card(
      color: color,
      elevation: elevation ?? getResponsiveElevation(context),
      margin: margin ?? EdgeInsets.all(getResponsiveSpacing(context) * 0.5),
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getResponsiveBorderRadius(context)),
      ),
      child: child,
    );
  }

  /// Create a responsive ListTile
  static Widget responsiveListTile(BuildContext context, {
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    EdgeInsets? contentPadding,
  }) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      contentPadding: contentPadding ?? EdgeInsets.symmetric(
        horizontal: getResponsiveSpacing(context),
        vertical: getResponsiveSpacing(context) * 0.5,
      ),
    );
  }

  /// Create a responsive Button
  static Widget responsiveButton(BuildContext context, {
    required VoidCallback? onPressed,
    required Widget child,
    ButtonStyle? style,
    EdgeInsets? padding,
    double? height,
  }) {
    return SizedBox(
      height: height ?? getResponsiveButtonHeight(context),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }

  /// Create a responsive TextField
  static Widget responsiveTextField(BuildContext context, {
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    EdgeInsets? contentPadding,
    int? maxLines,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(
          horizontal: getResponsiveSpacing(context),
          vertical: getResponsiveSpacing(context) * 0.75,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getResponsiveBorderRadius(context)),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
    );
  }

  /// Create a responsive DropdownButtonFormField
  static Widget responsiveDropdown<T>(BuildContext context, {
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?>? onChanged,
    String? labelText,
    Widget? prefixIcon,
    EdgeInsets? contentPadding,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(
          horizontal: getResponsiveSpacing(context),
          vertical: getResponsiveSpacing(context) * 0.75,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getResponsiveBorderRadius(context)),
        ),
      ),
    );
  }

  /// Create a responsive GridView
  static Widget responsiveGridView<T>(BuildContext context, {
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    int? crossAxisCount,
    double? childAspectRatio,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    EdgeInsets? padding,
    ScrollPhysics? physics,
  }) {
    return GridView.builder(
      padding: padding ?? getResponsivePadding(context),
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? getResponsiveGridCrossAxisCount(context),
        childAspectRatio: childAspectRatio ?? getResponsiveChildAspectRatio(context),
        crossAxisSpacing: crossAxisSpacing ?? getResponsiveGridSpacing(context),
        mainAxisSpacing: mainAxisSpacing ?? getResponsiveGridSpacing(context),
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (index < items.length) {
          return itemBuilder(context, items[index]);
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Create a responsive ListView
  static Widget responsiveListView<T>(BuildContext context, {
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    EdgeInsets? padding,
    double? itemExtent,
    ScrollPhysics? physics,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) {
    return ListView.builder(
      padding: padding ?? getResponsivePadding(context),
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      itemExtent: itemExtent,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      itemBuilder: (context, index) {
        if (index < items.length) {
          return itemBuilder(context, items[index]);
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Create a responsive SingleChildScrollView
  static Widget responsiveScrollView(BuildContext context, {
    required Widget child,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    bool primary = true,
    bool reverse = false,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SingleChildScrollView(
      padding: padding ?? getResponsivePadding(context),
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      primary: primary,
      reverse: reverse,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  /// Create a responsive Column
  static Widget responsiveColumn(BuildContext context, {
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Widget? separator,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );
  }

  /// Create a responsive Row
  static Widget responsiveRow(BuildContext context, {
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Widget? separator,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );
  }
}
