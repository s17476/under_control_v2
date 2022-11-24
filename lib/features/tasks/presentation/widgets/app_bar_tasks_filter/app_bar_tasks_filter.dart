import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/task_filter_enums.dart';
import '../../blocs/task_filter/task_filter_bloc.dart';
import 'task_or_request_tab_bar.dart';
import 'task_owner_tab_bar.dart';
import 'task_priority_tab_bar.dart';
import 'task_type_tab_bar.dart';

class AppBarTasksFilter extends StatefulWidget {
  const AppBarTasksFilter({
    Key? key,
    required this.isTaskFilterVisible,
  }) : super(key: key);

  final bool isTaskFilterVisible;

  @override
  State<AppBarTasksFilter> createState() => _AppBarTasksFilterState();
}

class _AppBarTasksFilterState extends State<AppBarTasksFilter> {
  bool _isMini = false;
  bool _isOnlyRequestsFilter = false;
  double _filterHeight = 350;

  @override
  void didChangeDependencies() {
    final filterState = context.watch<TaskFilterBloc>().state;
    if (filterState is TaskFilterSelectedState ||
        filterState is TaskFilterNothingSelectedState) {
      _isMini = filterState.isMiniSize;
      _isOnlyRequestsFilter =
          filterState.taskOrRequest == TaskOrRequest.request;
      _filterHeight = filterState.filterHeight;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
    if (!widget.isTaskFilterVisible) {
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _filterHeight,
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
                    top: _isMini ? 0 : 12,
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
                        isMini: _isMini,
                      ),
                      TaskOwnerTabBar(
                        iconSize: tabBarIconSize,
                        color: tabBarIconColor,
                        indicatorColor: tabBarIconColor,
                        isMini: _isMini,
                        isVisible: !_isOnlyRequestsFilter,
                      ),
                      TaskPriorityTabBar(
                        iconSize: tabBarIconSize,
                        color: tabBarIconColor,
                        indicatorColor: tabBarIconColor,
                        isMini: _isMini,
                      ),
                      TaskTypeTabBar(
                        iconSize: tabBarIconSize,
                        color: tabBarIconColor,
                        indicatorColor: tabBarIconColor,
                        isMini: _isMini,
                        isVisible: !_isOnlyRequestsFilter,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(
                            double.infinity,
                            0,
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
                              .copyWith(fontSize: _isMini ? 10 : 14),
                        ),
                        icon: Icon(
                          Icons.refresh,
                          size: _isMini ? 12 : 20,
                          color: Theme.of(context).textTheme.headline4!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
