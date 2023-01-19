import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/work_requests_status/work_requests_status_bloc.dart';

class WorkrequestsStatus extends StatelessWidget {
  const WorkrequestsStatus({super.key});

  List<PieChartSectionData> showingSections(
      BuildContext context, WorkRequestsStatusLoadedState state) {
    final totalCount = state.awaiting.allWorkRequests.length +
        state.converted.allWorkRequests.length +
        state.cancelled.allWorkRequests.length;
    final awaitingPercentage =
        (state.awaiting.allWorkRequests.length / totalCount) * 100;
    final convertedPercentage =
        (state.converted.allWorkRequests.length / totalCount) * 100;
    final cancelledPercentage =
        (state.cancelled.allWorkRequests.length / totalCount) * 100;

    return List.generate(3, (i) {
      // final isTouched = i == touchedIndex;
      final isTouched = false;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 30.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Theme.of(context).errorColor,
            value: awaitingPercentage,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Theme.of(context).primaryColor,
            value: convertedPercentage,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.amber,
            value: cancelledPercentage,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkRequestsStatusBloc, WorkRequestsStatusState>(
      builder: (context, state) {
        if (state is WorkRequestsStatusLoadedState) {
          if (state.awaiting.allWorkRequests.isEmpty &&
              state.converted.allWorkRequests.isEmpty &&
              state.cancelled.allWorkRequests.isEmpty) {
            return const SizedBox();
          }
          return Container(
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
                      Icons.build,
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      AppLocalizations.of(context)!.work_requests,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1,
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
                            sectionsSpace: 8,
                            centerSpaceRadius: 20,
                            sections: showingSections(context, state),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    color: Theme.of(context).errorColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .status_awaiting,
                                    ),
                                  ),
                                  Text(
                                    state.awaiting.allWorkRequests.length
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .status_converted,
                                    ),
                                  ),
                                  Text(
                                    state.converted.allWorkRequests.length
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
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
                                    state.cancelled.allWorkRequests.length
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .status_total,
                                    ),
                                  ),
                                  Text(
                                    (state.awaiting.allWorkRequests.length +
                                            state.converted.allWorkRequests
                                                .length +
                                            state.cancelled.allWorkRequests
                                                .length)
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        }
        return Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Theme.of(context).cardColor.withAlpha(60),
          child: Container(
            width: double.infinity,
            height: 170,
            // margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
