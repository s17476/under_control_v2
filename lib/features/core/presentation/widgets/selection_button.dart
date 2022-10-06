import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectionButton<T> extends StatelessWidget {
  const SelectionButton({
    Key? key,
    required this.onSelected,
    required this.icon,
    required this.title,
    this.iconSize,
    this.titleSize,
    this.padding,
    this.foregroundColor,
    required this.gradient,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  final void Function(T) onSelected;
  final IconData icon;
  final String title;
  final double? iconSize;
  final double? titleSize;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Gradient gradient;
  final T value;
  final T groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(value),
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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: FaIcon(
                icon,
                size: iconSize,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: titleSize),
              ),
            ),
            Radio<T>(
              activeColor: Colors.white,
              value: value,
              groupValue: groupValue,
              onChanged: (val) => onSelected(val!),
            ),
          ],
        ),
      ),
    );
  }
}
