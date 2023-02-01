import 'package:flutter/material.dart';

import '../../../utils/choice.dart';

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
      onTap: () async {
        choice.onTap();
        await Future.delayed(const Duration(milliseconds: 500));
        onDissmis();
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
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
