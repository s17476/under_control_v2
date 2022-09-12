import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:under_control_v2/features/inventory/presentation/widgets/actions/selectable_locations_list_tile.dart';

import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/item.dart';

class SelectableLocationsList extends StatelessWidget {
  const SelectableLocationsList({
    Key? key,
    required this.item,
    required this.selectedLocation,
    required this.setLocation,
  }) : super(key: key);

  final Item item;

  final String selectedLocation;

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
                location: topLevelItems[index],
                selectedLocation: selectedLocation,
                allLocations: state.allLocations.allLocations,
                setLocation: setLocation,
                item: item,
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
