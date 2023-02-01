import 'package:flutter/material.dart';

import 'highlighted_text.dart';

class IconTitleMiniRow extends StatelessWidget {
  const IconTitleMiniRow({
    Key? key,
    required this.title,
    this.searchQuery = '',
    required this.icon,
  }) : super(key: key);

  final String title;
  final String searchQuery;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).textTheme.bodySmall!.color,
        ),
        const SizedBox(
          width: 4,
        ),
        HighlightedText(
          text: title,
          query: searchQuery,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
