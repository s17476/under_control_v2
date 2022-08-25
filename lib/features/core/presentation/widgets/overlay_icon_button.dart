import 'package:flutter/material.dart';

class OverlayIconButton extends StatelessWidget {
  const OverlayIconButton({
    Key? key,
    required this.onPressed,
    this.width = 100,
    this.height = 100,
    this.backgroundColor,
    this.iconSize = 50,
    required this.icon,
    this.iconColor,
    required this.title,
    this.titleColor = Colors.white,
  }) : super(key: key);

  final Function onPressed;
  final double width;
  final double height;
  final double iconSize;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color titleColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? Theme.of(context).primaryColor,
            ),
            Text(
              title,
              style: TextStyle(color: titleColor),
            ),
          ],
        ),
      ),
    );
  }
}
