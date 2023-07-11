import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';

import '../../../tasks/presentation/blocs/task_archive/task_archive_bloc.dart';

class TasksStatus extends StatelessWidget {
  const TasksStatus({super.key});

  List<PieChartSectionData> showingSections(
      BuildContext context, int success, int failure, int cancelled) {
    final totalCount = success + failure + cancelled;
    final successPercentage = success / totalCount;
    final failurePercentage = failure / totalCount;
    final cancelledPercentage = cancelled / totalCount;

    return List.generate(3, (i) {
      const radius = 15.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: Theme.of(context).primaryColor,
            value: successPercentage,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: Colors.amber,
            value: cancelledPercentage,
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            showTitle: false,
            color: Theme.of(context).colorScheme.error,
            value: failurePercentage,
            radius: radius,
          );

        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskArchiveBloc, TaskArchiveState>(
      builder: (context, state) {
        if (state is TaskArchiveLoadedState) {
          if (state.allTasks.allTasks.isEmpty) {
            return const SizedBox();
          }
          final limitDate = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).subtract(const Duration(days: 30));
          final allTasks = state.allTasks.allTasks
              .where((task) => task.executionDate.isAfter(limitDate));
          final successfullCount = allTasks
              .where(
                (task) => task.isSuccessful,
              )
              .length;
          final unsuccessfullCount = allTasks
              .where(
                (task) => !task.isSuccessful && !task.isCancelled,
              )
              .length;
          final cancelledCount = allTasks
              .where(
                (task) => !task.isSuccessful && task.isCancelled,
              )
              .length;
          final totalCount =
              successfullCount + unsuccessfullCount + cancelledCount;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.task_alt,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.task_finished} - ${AppLocalizations.of(context)!.status_recent}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: ResponsiveValue(
                                  context,
                                  defaultValue: 1,
                                  valueWhen: [
                                    const Condition.largerThan(
                                      name: MOBILE,
                                      value: 1.5,
                                    )
                                  ],
                                ).value?.toDouble() ??
                                1,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  enabled: false,
                                  // touchCallback:
                                  //     (FlTouchEvent event, pieTouchResponse) {
                                  // setState(() {
                                  //   if (!event.isInterestedForInteractions ||
                                  //       pieTouchResponse == null ||
                                  //       pieTouchResponse.touchedSection == null) {
                                  //     touchedIndex = -1;
                                  //     return;
                                  //   }
                                  //   touchedIndex = pieTouchResponse
                                  //       .touchedSection!.touchedSectionIndex;
                                  // });
                                  //   },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                startDegreeOffset: 270,
                                sectionsSpace: 4,
                                centerSpaceRadius: 30,
                                sections: showingSections(
                                  context,
                                  successfullCount,
                                  unsuccessfullCount,
                                  cancelledCount,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .color,
                            radius: 24,
                            child: FittedBox(
                              child: Text(
                                '${((successfullCount / totalCount) * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            right: 8,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .task_progress_finished_success,
                                    ),
                                  ),
                                  Text(
                                    successfullCount.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .status_cancelled,
                                    ),
                                  ),
                                  Text(
                                    cancelledCount.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .task_progress_finished_failure,
                                    ),
                                  ),
                                  Text(
                                    unsuccessfullCount.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Theme.of(context).cardColor.withAlpha(60),
            child: Container(
              width: double.infinity,
              height: 145,
              // margin: margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
