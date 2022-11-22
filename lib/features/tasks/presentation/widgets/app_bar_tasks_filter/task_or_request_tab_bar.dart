import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/task_filter_enums.dart';
import '../../blocs/task_filter/task_filter_bloc.dart';

class TaskOrRequestTabBar extends StatefulWidget {
  const TaskOrRequestTabBar({
    Key? key,
    this.iconSize,
    this.color,
    this.indicatorColor,
  }) : super(key: key);

  final double? iconSize;
  final Color? color;
  final Color? indicatorColor;

  @override
  State<TaskOrRequestTabBar> createState() => _TaskOrRequestTabBarState();
}

class _TaskOrRequestTabBarState extends State<TaskOrRequestTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _typeTabController;

  void _setIndex(int index) {
    TaskOrRequest taskOrRequest = TaskOrRequest.all;
    switch (index) {
      case 0:
        taskOrRequest = TaskOrRequest.all;
        break;
      case 1:
        taskOrRequest = TaskOrRequest.request;
        break;
      case 2:
        taskOrRequest = TaskOrRequest.task;
        break;
    }
    context.read<TaskFilterBloc>().add(
          TaskFilterSelectEvent(
            taskOrRequest: taskOrRequest,
          ),
        );
  }

  @override
  void initState() {
    _typeTabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final taskFilterState = context.watch<TaskFilterBloc>().state;
    if (taskFilterState is TaskFilterSelectedState) {
      _typeTabController.animateTo(taskFilterState.taskOrRequest.index);
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
            AppLocalizations.of(context)!.task_and_request,
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
                icon: Text(
                  AppLocalizations.of(context)!.work_requests,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.indicatorColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  AppLocalizations.of(context)!.bottom_bar_title_tasks,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.indicatorColor,
                    fontSize: 14,
                  ),
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
