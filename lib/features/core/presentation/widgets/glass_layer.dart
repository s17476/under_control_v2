import 'dart:ui';

import 'package:flutter/material.dart';

class GlassLayer extends StatelessWidget {
  const GlassLayer({Key? key, required this.onDismiss, required this.child})
      : super(key: key);

  final Widget child;
  final Function onDismiss;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0.0, end: 0.5),
      child: child,
      builder: (context, double value, child) {
        return Stack(
          children: [
            InkWell(
              onTap: () => onDismiss(),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(value),
                ),
              ),
            ),
            child!,
          ],
        );
      },
    );
  }
}
