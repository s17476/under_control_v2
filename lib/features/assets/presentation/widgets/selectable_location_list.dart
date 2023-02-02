import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/location_selection_helpers.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import 'selectable_location_list_tile.dart';

class SelectableLocationsList extends StatelessWidget {
  const SelectableLocationsList({
    Key? key,
    required this.selectedLocation,
    required this.setLocation,
    required this.featureType,
  }) : super(key: key);

  final String selectedLocation;
  final Function(String) setLocation;
  final FeatureType featureType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoadedState) {
          final topLevelItems = state.allLocations.allLocations
              .where((location) => location.parentId.isEmpty)
              .toList();
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topLevelItems.length,
            itemBuilder: (context, index) {
              return SelectableLocationsListTile(
                featureType: featureType,
                key: ValueKey(topLevelItems[index].id),
                location: topLevelItems[index],
                selectedLocation: selectedLocation,
                childrenLocations: getSelectedLocationsChildren(
                    topLevelItems[index], state.allLocations.allLocations),
                setLocation: setLocation,
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
