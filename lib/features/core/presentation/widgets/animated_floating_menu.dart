import 'package:flutter/material.dart';

class AnimatedFloatingMenu extends StatefulWidget {
  const AnimatedFloatingMenu({
    Key? key,
    required this.backgroundColor,
    required this.padding,
    required this.onPressed,
  }) : super(key: key);
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final Function onPressed;

  @override
  State<AnimatedFloatingMenu> createState() => _AnimatedFloatingMenuState();
}

class _AnimatedFloatingMenuState extends State<AnimatedFloatingMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: SizedBox(
        width: 48,
        height: 48,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: widget.backgroundColor,
          child: Icon(
            Icons.menu,
            color: Colors.grey.shade200,
            // size: 30,
          ),
          onPressed: () => widget.onPressed(),
        ),
      ),
    );
  }
}
