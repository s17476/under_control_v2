import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../blocs/task/task_bloc.dart';

class ShowAllTasksButton extends StatelessWidget {
  const ShowAllTasksButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoadedState && state.locations.isNotEmpty) {
          return BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoadedState && !state.isAllTasks) {
                return InkWell(
                  onTap: () => context
                      .read<TaskBloc>()
                      .add(GetTasksStreamEvent(isAllTasks: true)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.show_all,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Expanded(
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
