import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../locations/domain/entities/location.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import 'location_selection_tile.dart';

class AddGroupLocationsCard extends StatelessWidget {
  const AddGroupLocationsCard({
    Key? key,
    required this.selectedLocations,
    required this.locationsChildren,
    required this.locationsContext,
    required this.toggleLocationSelection,
  }) : super(key: key);

  final List<Location> selectedLocations;
  final List<String> locationsChildren;
  final List<String> locationsContext;

  final Function(
    BuildContext context,
    Location location,
    bool isSelected,
  ) toggleLocationSelection;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // title
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!
                            .home_screen_filter_select_locations,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, state) {
                      if (state is LocationLoadedState) {
                        final topLevelItems = state.allLocations.allLocations
                            .where((location) => location.parentId.isEmpty)
                            .toList();
                        return Padding(
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
                                return LocationSelectionTile(
                                  key: Key(topLevelItems[index].id),
                                  allLocations: state.allLocations.allLocations,
                                  location: topLevelItems[index],
                                  locationsChildren: locationsChildren,
                                  locationsContext: locationsContext,
                                  selectedLocations: selectedLocations,
                                  toggleLocationSelection:
                                      toggleLocationSelection,
                                );
                              }
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
