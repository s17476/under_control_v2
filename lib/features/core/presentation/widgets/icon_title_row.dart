import 'package:flutter/material.dart';

class IconTitleRow extends StatelessWidget {
  const IconTitleRow({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    this.iconSize = 20,
    this.iconPadding = 4,
    required this.title,
    this.titleFontSize = 14,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final double iconSize;
  final double iconPadding;
  final String title;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(iconPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: iconBackground,
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
            ),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
