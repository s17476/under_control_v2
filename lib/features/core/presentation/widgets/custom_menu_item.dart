import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String label;
  final double labelSize;
  const CustomMenuItem({
    Key? key,
    required this.onTap,
    this.backgroundColor,
    this.iconBackgroundColor = Colors.transparent,
    required this.icon,
    this.iconColor = Colors.white,
    required this.label,
    this.labelSize = 18,
    this.iconSize = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconBackgroundColor,
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              label,
              style: TextStyle(fontSize: labelSize),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
