import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              return Column(
                children: const [
                  WorkRequestsLatest(),
                  TasksLatest(),
                  AssetsWithoutInspection(),
                  AssetsLatestActions(),
                  InventoryLowLevelItems(),
                  InventoryLatestActions(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
