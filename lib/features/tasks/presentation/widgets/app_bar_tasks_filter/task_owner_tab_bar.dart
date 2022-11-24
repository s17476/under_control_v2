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
    required this.isMini,
    required this.isVisible,
  }) : super(key: key);

  final double? iconSize;
  final Color? color;
  final Color? indicatorColor;
  final bool isMini;
  final bool isVisible;

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
    double? tabHeight = widget.isMini ? 30 : null;
    double? iconSize = widget.isMini ? 20 : widget.iconSize;
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        height: !widget.isVisible
            ? 0
            : widget.isMini
                ? 32
                : 64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isMini)
              Text(
                AppLocalizations.of(context)!.task_owner,
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
                  icon: Icon(
                    Icons.person,
                    size: iconSize,
                    color: widget.color,
                  ),
                ),
                Tab(
                  height: tabHeight,
                  icon: Icon(
                    Icons.group,
                    size: iconSize,
                    color: widget.color,
                  ),
                ),
                Tab(
                  height: tabHeight,
                  icon: SizedBox(
                    width: iconSize != null ? iconSize * 2 : 64,
                    height: iconSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          child: Icon(
                            Icons.person,
                            size: iconSize != null ? iconSize * 0.8 : 28,
                            color: widget.color,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Icon(
                            Icons.group,
                            size: iconSize != null ? iconSize * 0.9 : 28,
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
      ),
    );
  }
}
