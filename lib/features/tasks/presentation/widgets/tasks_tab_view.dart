import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/utils/responsive_size.dart';
import '../../domain/entities/task/task.dart';
import '../../domain/entities/task_priority.dart';
import '../../utils/get_task_priority_icon.dart';
import '../blocs/task/task_bloc.dart';
import 'tasks_nested_tab_view.dart';

class TasksTabView extends StatefulWidget {
  const TasksTabView({Key? key}) : super(key: key);

  @override
  State<TasksTabView> createState() => _TasksTabViewState();
}

class _TasksTabViewState extends State<TasksTabView>
    with SingleTickerProviderStateMixin, ResponsiveSize {
  late TabController _tabController;
  List<Task>? _tasks;
  List<Task> _filteredTasks = [];
  Color _nestedIndicatorColor = Colors.white;
  int _index = 0;

  void _setIndex(int value) {
    setState(() {
      _index = value;
      _nestedIndicatorColor = _getNestedIndicatorColor(value);
    });
  }

  Color _getNestedIndicatorColor(int index) {
    switch (index) {
      case 0:
        return Colors.white;
      case 1:
        return const Color.fromARGB(255, 28, 154, 97);
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  void _filterWorkRequests() {
    switch (_index) {
      case 0:
        _filteredTasks = _tasks!;
        break;
      case 1:
        _filteredTasks = _tasks
                ?.where((task) => task.priority == TaskPriority.low)
                .toList() ??
            [];
        break;
      case 2:
        _filteredTasks = _tasks
                ?.where((task) => task.priority == TaskPriority.medium)
                .toList() ??
            [];
        break;
      case 3:
        _filteredTasks = _tasks
                ?.where((task) => task.priority == TaskPriority.high)
                .toList() ??
            [];
        break;
      default:
        _filteredTasks = _tasks ?? [];
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
          child: Row(
            children: [
              Container(
                height: 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 12,
                    top: 4,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.bottom_bar_title_tasks,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.all_inclusive,
                  size: tabBarIconSize,
                  color: tabBarIconColor,
                ),
              ),
              Tab(
                icon: getTaskPriorityIcon(
                  context,
                  TaskPriority.low,
                  30,
                  const EdgeInsets.all(0),
                  false,
                ),
              ),
              Tab(
                icon: getTaskPriorityIcon(
                  context,
                  TaskPriority.medium,
                  30,
                  const EdgeInsets.all(0),
                  false,
                ),
              ),
              Tab(
                icon: getTaskPriorityIcon(
                  context,
                  TaskPriority.high,
                  30,
                  const EdgeInsets.all(0),
                  false,
                ),
              ),
            ],
            controller: _tabController,
            onTap: _setIndex,
            indicatorColor: tabBarIconColor,
          ),
        ),
        BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadedState) {
              _tasks = state.allTasks.allTasks;
              _filterWorkRequests();
              return TasksNestedTabView(
                nestedIndicatorColor: _nestedIndicatorColor,
                tasks: _filteredTasks,
              );
            } else {
              // shows shimmer when loading
              return ListView.separated(
                padding: const EdgeInsets.only(top: 4),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) =>
                    // shimmer work order
                    const ShimmerAssetActionListTile(),
              );
            }
          },
        ),
      ],
    );
  }
}
