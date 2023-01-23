import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/activity_bloc/activity_bloc_bloc.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityBlocState>(
      builder: (context, state) {
        print(state);
        if (!state.isLoading && state.maxValue > 0) {
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
                      Icons.precision_manufacturing,
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      AppLocalizations.of(context)!.assets_status,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          );
        }
        if (state.isLoading) {
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
        }
        return const SizedBox();
      },
    );
  }
}
