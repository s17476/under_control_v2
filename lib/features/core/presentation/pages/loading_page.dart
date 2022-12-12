import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/logo_widget.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).appBarTheme.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Theme.of(context).appBarTheme.backgroundColor,
        statusBarBrightness: Brightness.dark,
      ));
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FittedBox(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Logo(greenLettersSize: 15, whitheLettersSize: 10),
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
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
    ));
  }
}
