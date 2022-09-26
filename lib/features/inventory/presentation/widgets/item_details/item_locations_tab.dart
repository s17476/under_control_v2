import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/item.dart';
import '../actions/quantity_location_list_tile.dart';

class ItemLocationsTab extends StatelessWidget {
  const ItemLocationsTab({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationLoadedState) {
              final topLevelItems = state.allLocations.allLocations
                  .where((location) => location.parentId.isEmpty)
                  .toList();
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 4),
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
                    return QuantityLocationslistTile(
                      location: topLevelItems[index],
                      childrenLocations: getSelectedLocationsChildren(
                        topLevelItems[index],
                        state.allLocations.allLocations,
                      ),
                      item: item,
                    );
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
