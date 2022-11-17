import 'package:flutter/material.dart';

import '../../../core/utils/responsive_size.dart';
import '../../domain/entities/task/task.dart';
import '../../domain/entities/task_type.dart';
import '../../utils/get_task_type_icon.dart';
import 'task_tile.dart';

class TasksNestedTabView extends StatefulWidget {
  const TasksNestedTabView({
    Key? key,
    required this.nestedIndicatorColor,
    required this.tasks,
  }) : super(key: key);

  final Color nestedIndicatorColor;
  final List<Task> tasks;

  @override
  State<TasksNestedTabView> createState() => _TasksNestedTabViewState();
}

class _TasksNestedTabViewState extends State<TasksNestedTabView>
    with SingleTickerProviderStateMixin, ResponsiveSize {
  late TabController _tabController;
  List<Task> _filteredTasks = [];
  int _index = 0;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  void _filterWorkRequests() {
    switch (_index) {
      case 0:
        _filteredTasks = widget.tasks;
        break;
      case 1:
        _filteredTasks = widget.tasks
            .where((task) => task.type == TaskType.maintenance)
            .toList();
        break;
      case 2:
        _filteredTasks = widget.tasks
            .where((task) => task.type == TaskType.reparation)
            .toList();
        break;
      case 3:
        _filteredTasks = widget.tasks
            .where((task) => task.type == TaskType.inspection)
            .toList();
        break;
      case 4:
        _filteredTasks =
            widget.tasks.where((task) => task.type == TaskType.event).toList();
        break;
      default:
        _filteredTasks = widget.tasks;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color tabBarIconColor = Theme.of(context).textTheme.headline5!.color!;
    const double tabBarIconSize = 32;
    _filterWorkRequests();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
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
                icon: getTaskTypeIcon(
                  context,
                  TaskType.maintenance,
                  28,
                  true,
                  tabBarIconColor,
                ),
              ),
              Tab(
                icon: getTaskTypeIcon(
                  context,
                  TaskType.reparation,
                  28,
                  true,
                  tabBarIconColor,
                ),
              ),
              Tab(
                icon: getTaskTypeIcon(
                  context,
                  TaskType.inspection,
                  28,
                  true,
                  tabBarIconColor,
                ),
              ),
              Tab(
                icon: getTaskTypeIcon(
                  context,
                  TaskType.event,
                  28,
                  true,
                  tabBarIconColor,
                ),
              ),
            ],
            controller: _tabController,
            onTap: _setIndex,
            indicatorColor: widget.nestedIndicatorColor,
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 4),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _filteredTasks.length,
            itemBuilder: (context, index) => Padding(
              key: ValueKey(_filteredTasks[index].id),
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
                right: 8,
                left: 2,
              ),
              child: TaskTile(task: _filteredTasks[index]),
            ),
          ),
        ),
      ],
    );
  }
}
