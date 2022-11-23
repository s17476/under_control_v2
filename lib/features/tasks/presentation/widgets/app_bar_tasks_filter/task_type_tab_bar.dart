import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/task_priority.dart';
import '../../../domain/entities/task_type.dart';
import '../../../utils/get_task_type_icon.dart';
import '../../blocs/task_filter/task_filter_bloc.dart';

class TaskTypeTabBar extends StatefulWidget {
  const TaskTypeTabBar({
    Key? key,
    this.iconSize,
    this.color,
    this.indicatorColor,
    required this.isMini,
  }) : super(key: key);

  final double? iconSize;
  final Color? color;
  final Color? indicatorColor;
  final bool isMini;

  @override
  State<TaskTypeTabBar> createState() => _TaskTypeTabBarState();
}

class _TaskTypeTabBarState extends State<TaskTypeTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _typeTabController;
  late Color indicatorColor;

  void _setIndex(int index) {
    TaskType taskType = TaskType.unknown;
    switch (index) {
      case 0:
        taskType = TaskType.unknown;
        break;
      case 1:
        taskType = TaskType.maintenance;
        break;
      case 2:
        taskType = TaskType.reparation;
        break;
      case 3:
        taskType = TaskType.inspection;
        break;
      case 4:
        taskType = TaskType.event;
        break;
    }
    context.read<TaskFilterBloc>().add(
          TaskFilterSelectEvent(
            taskType: taskType,
          ),
        );
  }

  @override
  void initState() {
    _typeTabController = TabController(
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final taskFilterState = context.watch<TaskFilterBloc>().state;
    if (taskFilterState is TaskFilterSelectedState) {
      _typeTabController.animateTo(taskFilterState.taskType.index);
      switch (taskFilterState.taskPriority) {
        case TaskPriority.unknown:
          indicatorColor = Theme.of(context).textTheme.headline5!.color!;
          break;
        case TaskPriority.low:
          indicatorColor = Theme.of(context).primaryColor;
          break;
        case TaskPriority.medium:
          indicatorColor = Colors.yellow;
          break;
        case TaskPriority.high:
          indicatorColor = Colors.red;
          break;
        default:
      }
    } else if (taskFilterState is TaskFilterNothingSelectedState) {
      _typeTabController.animateTo(0);
      indicatorColor = Theme.of(context).textTheme.headline5!.color!;
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
    double? tabHeight = widget.isMini ? 30 : null;
    double? iconSize = widget.isMini ? 20 : widget.iconSize;
    return SizedBox(
      height: widget.isMini ? 32 : 64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.isMini)
            Text(
              AppLocalizations.of(context)!.task_type,
              style: Theme.of(context).textTheme.caption,
            ),
          TabBar(
            tabs: [
              Tab(
                height: tabHeight,
                icon: Icon(
                  Icons.all_inclusive,
                  size: iconSize,
                  color: widget.color,
                ),
              ),
              Tab(
                height: tabHeight,
                icon: getTaskTypeIcon(
                  context,
                  TaskType.maintenance,
                  iconSize ?? 28,
                  true,
                  widget.color,
                ),
              ),
              Tab(
                height: tabHeight,
                icon: getTaskTypeIcon(
                  context,
                  TaskType.reparation,
                  iconSize ?? 28,
                  true,
                  widget.color,
                ),
              ),
              Tab(
                height: tabHeight,
                icon: getTaskTypeIcon(
                  context,
                  TaskType.inspection,
                  iconSize ?? 28,
                  true,
                  widget.color,
                ),
              ),
              Tab(
                height: tabHeight,
                icon: getTaskTypeIcon(
                  context,
                  TaskType.event,
                  iconSize ?? 28,
                  true,
                  widget.color,
                ),
              ),
            ],
            controller: _typeTabController,
            onTap: _setIndex,
            indicatorColor: indicatorColor,
          ),
        ],
      ),
    );
  }
}
