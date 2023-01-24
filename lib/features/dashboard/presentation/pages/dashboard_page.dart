import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:under_control_v2/features/dashboard/presentation/widgets/my_tasks.dart';
import 'package:under_control_v2/features/dashboard/presentation/widgets/status_card.dart';

import '../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../widgets/assets_latest_actions.dart';
import '../widgets/assets_without_inspection.dart';
import '../widgets/inventory_latest_actions.dart';
import '../widgets/inventory_low_level_items.dart';
import '../widgets/tasks_latest.dart';
import '../widgets/work_requests_latest.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoadedState && state.locations.isNotEmpty) {
          return ListView(
            children: [
              ...getStatusCardWidgets(context),
              const MyTasks(),
              const WorkRequestsLatest(),
              const TasksLatest(),
              const AssetsWithoutInspection(),
              const AssetsLatestActions(),
              const InventoryLowLevelItems(),
              const InventoryLatestActions(),
              const SizedBox(
                height: 50,
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
