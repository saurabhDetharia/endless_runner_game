import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  /// To replace the current route with provided route.
  Future<T?> pushReplace<T>(Widget child) async {
    return Navigator.pushReplacement(
      this,
      PageRouteBuilder(
        pageBuilder: (builderCtx, animation, secondaryAnimation) {
          return child;
        },
        transitionsBuilder: (
          transitionBuilderCtx,
          animation,
          secondaryAnimation,
          child,
        ) {
          const begin = 0.0;
          const end = 1.0;
          final tween = Tween<double>(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
