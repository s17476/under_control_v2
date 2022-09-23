import 'package:flutter/material.dart';

import '../domain/entities/item_action/item_action.dart';

Widget getActionIcon(BuildContext context, ItemActionType itemActionType) {
  const iconSize = 30.0;
  switch (itemActionType) {
    case ItemActionType.add:
      return const Icon(
        Icons.add,
        size: iconSize,
      );
    case ItemActionType.remove:
      return const Icon(
        Icons.remove,
        size: iconSize,
      );
    case ItemActionType.moveAdd:
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: Stack(
          children: const [
            Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.compare_arrows,
                size: 22,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Icon(
                Icons.add,
                size: 22,
              ),
            ),
          ],
        ),
      );
    case ItemActionType.moveRemove:
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: Stack(
          children: const [
            Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.compare_arrows,
                size: 22,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Icon(
                Icons.remove,
                size: 22,
              ),
            ),
          ],
        ),
      );
    default:
      return const SizedBox();
  }
}
