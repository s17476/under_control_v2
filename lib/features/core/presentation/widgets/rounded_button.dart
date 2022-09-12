import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.title,
    this.iconSize,
    this.titleSize,
    this.padding,
    this.foregroundColor,
    this.gradient,
  }) : super(key: key);

  final Function() onPressed;
  final IconData icon;
  final String title;
  final double? iconSize;
  final double? titleSize;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: foregroundColor,
              size: iconSize,
            ),
            Text(
              title,
              style: TextStyle(
                color: foregroundColor,
                fontSize: titleSize,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
