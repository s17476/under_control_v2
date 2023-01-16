import 'package:flutter/material.dart';

class IconTitleRow extends StatelessWidget {
  const IconTitleRow({
    Key? key,
    required this.icon,
    required this.iconColor,
    this.titleColor,
    required this.iconBackground,
    this.iconSize = 20,
    this.iconPadding = 4,
    required this.title,
    this.titleFontSize = 14,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color? titleColor;
  final Color iconBackground;
  final double iconSize;
  final double iconPadding;
  final String title;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    Color topLeftColor;
    Color bottomRightColor;
    if (iconBackground == Colors.black) {
      bottomRightColor = iconBackground;
      topLeftColor = Colors.grey.shade800;
    } else {
      bottomRightColor = iconBackground.withAlpha(80);
      topLeftColor = iconBackground;
    }
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(iconPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 1,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                topLeftColor,
                bottomRightColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // color: iconBackground,
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
              color: titleColor,
            ),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
