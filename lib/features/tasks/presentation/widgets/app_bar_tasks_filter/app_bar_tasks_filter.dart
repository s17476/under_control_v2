import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/task_filter/task_filter_bloc.dart';
import 'task_or_request_tab_bar.dart';
import 'task_owner_tab_bar.dart';
import 'task_priority_tab_bar.dart';
import 'task_type_tab_bar.dart';

class AppBarTasksFilter extends StatelessWidget {
  const AppBarTasksFilter({
    Key? key,
    required this.isTaskFilterVisible,
    required this.isControlsVisible,
    required this.tasksFilterHeight,
  }) : super(key: key);

  final bool isTaskFilterVisible;
  final bool isControlsVisible;
  final double tasksFilterHeight;

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
    if (!isTaskFilterVisible) {
      return const SizedBox();
    } else {
      return TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ),
          builder: (context, Offset offset, child) {
            return FractionalTranslation(
              translation: offset,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  height: tasksFilterHeight,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0.5),
                        color: Colors.grey.shade700,
                        blurRadius: 3,
                      )
                    ],
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isControlsVisible ? 12 : 0,
                      left: 8,
                      right: 8,
                      // bottom: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TaskOrRequestTabBar(
                          iconSize: tabBarIconSize,
                          color: tabBarIconColor,
                          indicatorColor: tabBarIconColor,
                          isMini: !isControlsVisible,
                        ),
                        TaskOwnerTabBar(
                          iconSize: tabBarIconSize,
                          color: tabBarIconColor,
                          indicatorColor: tabBarIconColor,
                          isMini: !isControlsVisible,
                        ),
                        TaskPriorityTabBar(
                          iconSize: tabBarIconSize,
                          color: tabBarIconColor,
                          indicatorColor: tabBarIconColor,
                          isMini: !isControlsVisible,
                        ),
                        TaskTypeTabBar(
                          iconSize: tabBarIconSize,
                          color: tabBarIconColor,
                          indicatorColor: tabBarIconColor,
                          isMini: !isControlsVisible,
                        ),
                        if (!isControlsVisible)
                          const Divider(
                            thickness: 1.5,
                            indent: 24,
                            endIndent: 24,
                          ),
                        if (isControlsVisible)
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(
                                double.infinity,
                                20,
                              ),
                            ),
                            onPressed: () => context
                                .read<TaskFilterBloc>()
                                .add(const TaskFilterResetEvent()),
                            label: Text(
                              AppLocalizations.of(context)!.task_filter_reset,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontSize: 14),
                            ),
                            icon: Icon(
                              Icons.refresh,
                              size: 20,
                              color:
                                  Theme.of(context).textTheme.headline4!.color,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }
}
