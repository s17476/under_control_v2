import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/core/utils/location_selection_helpers.dart';

import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/item.dart';
import 'selectable_locations_list_tile.dart';

class SelectableLocationsList extends StatelessWidget {
  const SelectableLocationsList({
    Key? key,
    required this.item,
    required this.selectedLocation,
    this.selectedFromLocation = '',
    this.isSubtract = false,
    required this.setLocation,
  }) : super(key: key);

  final Item item;

  final String selectedLocation;
  final String selectedFromLocation;

  final bool isSubtract;

  final Function(String) setLocation;

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
              return SelectableLocationslistTile(
                key: ValueKey(topLevelItems[index].id),
                location: topLevelItems[index],
                selectedLocation: selectedLocation,
                selectedFromLocation: selectedFromLocation,
                childrenLocations: getSelectedLocationsChildren(
                    topLevelItems[index], state.allLocations.allLocations),
                setLocation: setLocation,
                item: item,
                isSubtract: isSubtract,
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
