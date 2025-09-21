import 'package:flutter/material.dart';

/// Retourne une route avec une animation de transition Scale.
/// Utilisable pour n'importe quelle page via un `WidgetBuilder`.
Route<T> screenViewAnimation<T>({
  required WidgetBuilder builder,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
  Alignment alignment = Alignment.center,
}) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: curve);
      return ScaleTransition(
        alignment: alignment,
        scale: curved,
        child: child,
      );
    },
  );
}

/// Variante pratique si vous avez déjà une instance de `Widget`.
Route<T> screenViewAnimationForPage<T>({
  required Widget page,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
  Alignment alignment = Alignment.center,
}) {
  return screenViewAnimation<T>(
    builder: (_) => page,
    duration: duration,
    curve: curve,
    alignment: alignment,
  );
}
