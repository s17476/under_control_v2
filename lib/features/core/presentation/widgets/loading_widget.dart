import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'logo_widget.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    Key? key,
    this.showLogo = true,
  }) : super(key: key);

  final bool showLogo;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateY;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _rotateY = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.showLogo)
            const SizedBox(
              width: 500,
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Logo(greenLettersSize: 15, whitheLettersSize: 10),
                ),
              ),
            ),
          SizedBox(
            width: widget.showLogo ? 60 : 100,
            height: widget.showLogo ? 60 : 100,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final child = Image.asset('assets/under_control_icon.png');

                return Transform(
                  transform: Matrix4.rotationY(_rotateY.value * 2 * math.pi),
                  alignment: Alignment.center,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
