import 'package:flutter/material.dart';

import '../domain/entities/item_action/item_action.dart';

List<Color> getGradient(BuildContext context, ItemActionType itemActionType) {
  if (itemActionType == ItemActionType.add) {
    return [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor.withAlpha(60),
    ];
  } else if (itemActionType == ItemActionType.remove) {
    return [
      Colors.red,
      Colors.red.withAlpha(60),
    ];
  }
  return [
    Colors.blue.shade700,
    Colors.blue.shade700.withAlpha(60),
  ];
}
