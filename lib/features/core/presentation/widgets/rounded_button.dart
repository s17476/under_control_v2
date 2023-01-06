import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.title,
    this.iconSize,
    this.titleSize,
    this.padding,
    this.foregroundColor,
    this.isLoading = false,
    this.axis = Axis.vertical,
    required this.gradient,
  }) : super(key: key);

  final Function() onPressed;
  final IconData icon;
  final String? title;
  final double? iconSize;
  final double? titleSize;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Gradient gradient;
  final bool isLoading;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(15),
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
        child: Center(
          child: Wrap(
            spacing: axis == Axis.horizontal ? 8 : 0,
            direction: axis,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  height: iconSize ?? 30,
                  width: iconSize ?? 30,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              if (!isLoading)
                FaIcon(
                  icon,
                  color: foregroundColor,
                  size: iconSize,
                ),
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: titleSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
