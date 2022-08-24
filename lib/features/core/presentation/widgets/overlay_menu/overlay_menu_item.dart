import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/utils/choice.dart';

class OverlayMenuItem extends StatelessWidget {
  const OverlayMenuItem({
    Key? key,
    required this.choice,
    required this.onDissmis,
  }) : super(key: key);
  final Choice choice;
  final Function onDissmis;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onDissmis();
        choice.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              choice.icon,
              size: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              choice.title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
