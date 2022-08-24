import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/presentation/widgets/glass_layer.dart';
import 'package:under_control_v2/features/core/presentation/widgets/overlay_menu/overlay_menu_item.dart';
import 'package:under_control_v2/features/core/utils/choice.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/tasks_overlay_menu_items.dart';

import '../../../../assets/presentation/widgets/assets_overlay_menu_items.dart';
import '../../../../dashboard/presentation/widgets/dashboard_overlay_menu_items.dart';
import '../../../../inventory/presentation/widgets/inventory_overlay_menu_items.dart';
import '../../../../knowledge_base/presentation/widgets/knowledge_base_overlay_menu_items.dart';

class OverlayMenu extends StatelessWidget {
  const OverlayMenu({
    Key? key,
    required this.onDismiss,
    required this.isVisible,
    required this.pageIndex,
  }) : super(key: key);

  final Function onDismiss;
  final bool isVisible;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    List<Choice> menuItems;
    switch (pageIndex) {
      case 0:
        menuItems = tasksOverlayMenuItems(context);
        break;
      case 1:
        menuItems = inventoryOverlayMenuItems(context);
        break;
      case 2:
        menuItems = dashboardOverlayMenuItems(context);
        break;
      case 3:
        menuItems = assetsOverlayMenuItems(context);
        break;
      case 4:
        menuItems = knowledgeBaseOverlayMenuItems(context);
        break;
      default:
        menuItems = dashboardOverlayMenuItems(context);
        break;
    }
    if (!isVisible) {
      return const SizedBox();
    } else {
      return GlassLayer(
        onDismiss: onDismiss,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...menuItems
                  .map(
                    (chice) => OverlayMenuItem(
                      choice: chice,
                      onDissmis: onDismiss,
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      );
    }
  }
}
