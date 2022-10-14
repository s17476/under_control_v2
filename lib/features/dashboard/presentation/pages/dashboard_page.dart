import 'package:flutter/material.dart';
import 'package:under_control_v2/features/dashboard/presentation/widgets/inventory_low_level_items.dart';

import '../widgets/inventory_latest_actions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          InventoryLowLevelItems(),
          InventoryLatestActions(),
        ],
      ),
    );
  }
}
