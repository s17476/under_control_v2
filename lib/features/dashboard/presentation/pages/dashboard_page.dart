import 'package:flutter/material.dart';

import 'package:under_control_v2/features/dashboard/presentation/widgets/work_orders_latest.dart';

import '../widgets/assets_latest_actions.dart';
import '../widgets/assets_without_inspection.dart';
import '../widgets/inventory_latest_actions.dart';
import '../widgets/inventory_low_level_items.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          WorkOrdersLatest(),
          AssetsWithoutInspection(),
          AssetsLatestActions(),
          InventoryLowLevelItems(),
          InventoryLatestActions(),
        ],
      ),
    );
  }
}
