import 'package:flutter/material.dart';

import '../widgets/inventory_latest_actions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          InventoryLatestActions(),
        ],
      ),
    );
  }
}
