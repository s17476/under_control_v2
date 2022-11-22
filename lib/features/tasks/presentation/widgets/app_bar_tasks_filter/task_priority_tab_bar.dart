import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/task_priority.dart';
import '../../../utils/get_task_priority_icon.dart';
import '../../blocs/task_filter/task_filter_bloc.dart';

class TaskPriorityTabBar extends StatefulWidget {
  const TaskPriorityTabBar({
    Key? key,
    this.iconSize,
    this.color,
    this.indicatorColor,
  }) : super(key: key);

  final double? iconSize;
  final Color? color;
  final Color? indicatorColor;

  @override
  State<TaskPriorityTabBar> createState() => _TaskPriorityTabBarState();
}

class _TaskPriorityTabBarState extends State<TaskPriorityTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _typeTabController;

  void _setIndex(int index) {
    TaskPriority taskPriority = TaskPriority.unknown;
    switch (index) {
      case 0:
        taskPriority = TaskPriority.unknown;
        break;
      case 1:
        taskPriority = TaskPriority.low;
        break;
      case 2:
        taskPriority = TaskPriority.medium;
        break;
      case 3:
        taskPriority = TaskPriority.high;
        break;
    }
    context.read<TaskFilterBloc>().add(
          TaskFilterSelectEvent(
            taskPriority: taskPriority,
          ),
        );
  }

  @override
  void initState() {
    _typeTabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final taskFilterState = context.watch<TaskFilterBloc>().state;
    if (taskFilterState is TaskFilterSelectedState) {
      _typeTabController.animateTo(taskFilterState.taskPriority.index);
    } else if (taskFilterState is TaskFilterNothingSelectedState) {
      _typeTabController.animateTo(0);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _typeTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.task_priority,
            style: Theme.of(context).textTheme.caption,
          ),
          TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.all_inclusive,
                  size: widget.iconSize,
                  color: widget.color,
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
            controller: _typeTabController,
            onTap: _setIndex,
            indicatorColor: widget.indicatorColor,
          ),
        ],
      ),
    );
  }
}
