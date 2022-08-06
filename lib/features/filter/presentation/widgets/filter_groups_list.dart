import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/filter/filter_bloc.dart';
import 'home_page_filter_group_tile.dart';

class FilterGroupsList extends StatelessWidget {
  const FilterGroupsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoadedState) {
          if (state.allPossibleGroups.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.home_screen_filter_no_groups,
              ),
            );
          } else {
            return Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.allPossibleGroups.length,
                  itemBuilder: (context, index) {
                    return HomePageFilterGroupTile(
                      key: Key(state.allPossibleGroups[index].id),
                      group: state.allPossibleGroups[index],
                      color: Theme.of(context).cardColor,
                    );
                  },
                ),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
