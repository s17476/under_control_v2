import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../tasks/domain/entities/task/task.dart';
import '../../../tasks/presentation/blocs/task/task_bloc.dart';
import '../../../tasks/presentation/widgets/task_tile.dart';

class TasksLatest extends StatefulWidget {
  const TasksLatest({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksLatest> createState() => _TasksLatestState();
}

class _TasksLatestState extends State<TasksLatest> {
  List<Task>? _tasks;

  @override
  void didChangeDependencies() {
    final tasksState = context.watch<TaskBloc>().state;
    if (tasksState is TaskLoadedState) {
      _tasks = tasksState.allTasks.allTasks.toList();
      if (_tasks != null && _tasks!.length > 5) {
        _tasks = _tasks!.sublist(0, 5);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final permission = getUserPermission(
      context: context,
      featureType: FeatureType.tasks,
      permissionType: PermissionType.read,
    );
    return !permission
        ? const SizedBox()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: IconTitleRow(
                        icon: Icons.task_alt_sharp,
                        iconColor: Colors.white,
                        iconBackground: Colors.red,
                        title:
                            '${AppLocalizations.of(context)!.bottom_bar_title_tasks} - ${AppLocalizations.of(context)!.item_details_latest_actions}',
                      ),
                    ),
                    if (_tasks == null)
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade800.withAlpha(150),
                      Theme.of(context).scaffoldBackgroundColor
                    ],
                    stops: const [0, 0.005],
                  ),
                ),
                child: Column(
                  children: [
                    if (_tasks == null)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) =>
                            const ShimmerAssetActionListTile(
                          isDashboardTile: true,
                        ),
                      ),
                    if (_tasks != null && _tasks!.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _tasks!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TaskTile(
                            task: _tasks![index],
                          ),
                        ),
                      ),
                    if (_tasks != null && _tasks!.isEmpty)
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          AppLocalizations.of(context)!
                              .no_actions_in_selected_locations,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
  }
}
