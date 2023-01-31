import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../tasks/presentation/blocs/task_filter/task_filter_bloc.dart';

class TaskFilterButton extends HookWidget {
  const TaskFilterButton({
    Key? key,
    required this.isTaskFilterVisible,
  }) : super(key: key);

  final bool isTaskFilterVisible;

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    toggleState.value = isTaskFilterVisible;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: InkResponse(
        onTap: () {
          if (toggleState.value) {
            context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
          } else {
            context.read<TaskFilterBloc>().add(TaskFilterShowEvent());
          }
          toggleState.value = !toggleState.value;
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? Stack(
                  key: const ValueKey('expanded'),
                  children: [
                    Icon(
                      Icons.filter_list_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    BlocBuilder<TaskFilterBloc, TaskFilterState>(
                      builder: (context, state) {
                        if (state is TaskFilterSelectedState) {
                          return const Positioned(
                            top: 0,
                            left: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: 5,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                )
              : Stack(
                  key: const ValueKey('colapsed'),
                  children: [
                    Icon(
                      Icons.filter_list_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    BlocBuilder<TaskFilterBloc, TaskFilterState>(
                      builder: (context, state) {
                        if (state is TaskFilterSelectedState) {
                          return const Positioned(
                            top: 0,
                            left: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: 5,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
