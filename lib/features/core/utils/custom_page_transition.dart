import 'package:flutter/material.dart';

mixin CustomPageTransition {
  Route<Object?> fromTheTop(Widget Function() widgetConstructor) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          widgetConstructor(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;

        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeIn));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route<Object?> fadeIn(
      Widget Function() widgetConstructor, Duration duration) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          widgetConstructor(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}
