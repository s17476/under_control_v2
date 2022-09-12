import 'package:flutter/material.dart';

import '../../domain/entities/item.dart';

class OverlayAmountInfoBox extends StatelessWidget {
  const OverlayAmountInfoBox({
    Key? key,
    required this.item,
    required this.title,
    this.titleStyle = const TextStyle(
      fontSize: 16,
    ),
    required this.amount,
    this.amountStyle = const TextStyle(
      fontSize: 24,
      color: Colors.amber,
    ),
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  final Item? item;
  final String title;
  final TextStyle titleStyle;
  final double amount;
  final TextStyle amountStyle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
      tween: Tween<double>(begin: 0.0, end: 0.8),
      builder: (context, double value, child) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(value),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            Text(
              amount.toString(),
              style: amountStyle,
            ),
          ],
        ),
      ),
    );
  }
}
