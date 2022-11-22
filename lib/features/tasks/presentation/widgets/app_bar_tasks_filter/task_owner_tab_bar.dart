import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/task_filter_enums.dart';
import '../../blocs/task_filter/task_filter_bloc.dart';

class TaskOwnerTabBar extends StatefulWidget {
  const TaskOwnerTabBar({
    Key? key,
    this.iconSize,
    this.color,
    this.indicatorColor,
  }) : super(key: key);

  final double? iconSize;
  final Color? color;
  final Color? indicatorColor;

  @override
  State<TaskOwnerTabBar> createState() => _TaskOwnerTabBarState();
}

class _TaskOwnerTabBarState extends State<TaskOwnerTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _typeTabController;

  void _setIndex(int index) {
    TaskOwner taskOwner = TaskOwner.all;
    switch (index) {
      case 0:
        taskOwner = TaskOwner.all;
        break;
      case 1:
        taskOwner = TaskOwner.user;
        break;
      case 2:
        taskOwner = TaskOwner.group;
        break;
      case 3:
        taskOwner = TaskOwner.userAndGroup;
        break;
    }
    context.read<TaskFilterBloc>().add(
          TaskFilterSelectEvent(
            taskOwner: taskOwner,
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
      _typeTabController.animateTo(taskFilterState.taskOwner.index);
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
            AppLocalizations.of(context)!.task_owner,
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
                icon: Icon(
                  Icons.person,
                  size: widget.iconSize,
                  color: widget.color,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.group,
                  size: widget.iconSize,
                  color: widget.color,
                ),
              ),
              Tab(
                icon: SizedBox(
                  width: widget.iconSize != null ? widget.iconSize! * 2 : 64,
                  height: widget.iconSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        child: Icon(
                          Icons.person,
                          size: widget.iconSize != null
                              ? widget.iconSize! * 0.8
                              : 28,
                          color: widget.color,
                        ),
                      ),
                      Positioned(
                        left: widget.iconSize != null
                            ? widget.iconSize! * 0.55
                            : 18,
                        child: Icon(
                          Icons.add,
                          size: widget.iconSize != null
                              ? widget.iconSize! * 0.7
                              : 28,
                          color: widget.color,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Icon(
                          Icons.group,
                          size: widget.iconSize != null
                              ? widget.iconSize! * 0.9
                              : 28,
                          color: widget.color,
                        ),
                      ),
                    ],
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
