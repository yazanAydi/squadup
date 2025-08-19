import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final RouteTransitionType transitionType;

  CustomPageRoute({
    required this.child,
    this.transitionType = RouteTransitionType.slideUp,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case RouteTransitionType.slideUp:
                return _buildSlideUpTransition(animation, child);
              case RouteTransitionType.slideRight:
                return _buildSlideRightTransition(animation, child);
              case RouteTransitionType.fade:
                return _buildFadeTransition(animation, child);
              case RouteTransitionType.scale:
                return _buildScaleTransition(animation, child);
              case RouteTransitionType.rotate:
                return _buildRotateTransition(animation, child);
            }
          },
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );

  static Widget _buildSlideUpTransition(Animation<double> animation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Widget _buildSlideRightTransition(Animation<double> animation, Widget child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Widget _buildFadeTransition(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget _buildScaleTransition(Animation<double> animation, Widget child) {
    const begin = 0.8;
    const end = 1.0;
    const curve = Curves.easeInOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var scaleAnimation = animation.drive(tween);

    return ScaleTransition(
      scale: scaleAnimation,
      child: child,
    );
  }

  static Widget _buildRotateTransition(Animation<double> animation, Widget child) {
    const begin = 0.0;
    const end = 1.0;
    const curve = Curves.easeInOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var rotationAnimation = animation.drive(tween);

    return RotationTransition(
      turns: rotationAnimation,
      child: child,
    );
  }
}

enum RouteTransitionType {
  slideUp,
  slideRight,
  fade,
  scale,
  rotate,
}

// Convenience methods for common transitions
class PageTransitions {
  static Route<T> slideUp<T>(Widget child) {
    return CustomPageRoute<T>(
      child: child,
      transitionType: RouteTransitionType.slideUp,
    );
  }

  static Route<T> slideRight<T>(Widget child) {
    return CustomPageRoute<T>(
      child: child,
      transitionType: RouteTransitionType.slideRight,
    );
  }

  static Route<T> fade<T>(Widget child) {
    return CustomPageRoute<T>(
      child: child,
      transitionType: RouteTransitionType.fade,
    );
  }

  static Route<T> scale<T>(Widget child) {
    return CustomPageRoute<T>(
      child: child,
      transitionType: RouteTransitionType.scale,
    );
  }

  static Route<T> rotate<T>(Widget child) {
    return CustomPageRoute<T>(
      child: child,
      transitionType: RouteTransitionType.rotate,
    );
  }
}
