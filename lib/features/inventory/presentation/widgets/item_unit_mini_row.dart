import 'package:flutter/material.dart';

import '../../domain/entities/item.dart';
import '../../utils/get_localized_unit_name.dart';

class ItemUnitMiniRow extends StatelessWidget {
  const ItemUnitMiniRow({
    Key? key,
    required this.itemUnit,
  }) : super(key: key);

  final ItemUnit itemUnit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.balance,
          size: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          getLocalizedUnitName(context, itemUnit),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
