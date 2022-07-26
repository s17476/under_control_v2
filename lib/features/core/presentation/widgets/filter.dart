import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../locations/presentation/widgets/location_filter/location_filter_tile.dart';

class Filter extends StatelessWidget {
  const Filter({
    Key? key,
    required this.isFilterExpanded,
  }) : super(key: key);

  final bool isFilterExpanded;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: double.infinity,
            height: isFilterExpanded ? null : 0,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    AppLocalizations.of(context)!
                        .home_screen_filter_select_locations,
                  ),
                ),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoadedState) {
                      final topLevelItems = state.allLocations.allLocations
                          .where((location) => location.parentId.isEmpty)
                          .toList();
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: topLevelItems.length,
                            itemBuilder: (context, index) {
                              if (topLevelItems.isEmpty) {
                                return const SizedBox(
                                  child: Center(
                                    child: Text('No data'),
                                  ),
                                );
                              } else {
                                return LocationFilterTile(
                                  key: Key(topLevelItems[index].id),
                                  allLocations: state.allLocations.allLocations,
                                  location: topLevelItems[index],
                                );
                              }
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    AppLocalizations.of(context)!
                        .home_screen_filter_select_group,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
