import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/activity_bloc/activity_bloc_bloc.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  List<String> _getDiagramList(Map<String, int> activity) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final shortDateFormat = DateFormat('dd-MM');
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime currentDate = today.subtract(
      const Duration(days: 29),
    );
    List<String> activitiesList = List<String>.generate(40, (index) => '');
    for (var i = 0; i < 40; i++) {
      if (i == 0 || i == 8 || i == 16 || i == 24 || i == 32) {
        activitiesList[i] = shortDateFormat.format(currentDate);
      } else if (i == 7 || i == 15 || i == 23 || i == 31 || i == 39) {
        activitiesList[i] = shortDateFormat
            .format(currentDate.subtract(const Duration(days: 1)));
      } else {
        activitiesList[i] =
            activity[dateFormat.format(currentDate)]?.toString() ?? '0';

        currentDate = currentDate.add(const Duration(days: 1));
      }
    }
    return activitiesList;
  }

  double _getOpacity(int value, int maxValue) {
    if (value == 0) {
      return 0;
    }
    final result = value / maxValue;
    if (result < 0.2) {
      return 0.15;
    } else if (result < 0.4) {
      return 0.3;
    } else if (result < 0.6) {
      return 0.45;
    } else if (result < 0.8) {
      return 0.6;
    } else {
      return 0.75;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityBlocState>(
      builder: (context, state) {
        final activityMap = state.getActivities;
        if (!state.isLoading && activityMap.isNotEmpty) {
          final maxValue = activityMap.values.reduce(max);
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
                      Icons.check_box_outlined,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.status_activity} - ${AppLocalizations.of(context)!.status_recent}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 2,
                  crossAxisCount: 8,
                  children: _getDiagramList(activityMap).map((count) {
                    if (count.contains('-')) {
                      return Center(
                        child: Text(
                          count,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 10),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).cardColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                    blurRadius: 3,
                                  )
                                ]),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor.withOpacity(
                                  _getOpacity(int.parse(count), maxValue)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          );
        }
        if (state.isLoading) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Shimmer.fromColors(
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
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
