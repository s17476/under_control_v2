import 'package:flutter/material.dart';

class AnimatedFloatingMenu extends StatelessWidget {
  const AnimatedFloatingMenu({
    Key? key,
    required this.backgroundColor,
    this.padding,
    required this.onPressed,
  }) : super(key: key);
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: SizedBox(
        width: 48,
        height: 48,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: backgroundColor,
          child: Icon(
            Icons.menu,
            color: Colors.grey.shade200,
            // size: 30,
          ),
          onPressed: () => onPressed(),
        ),
      ),
    );
  }
}
