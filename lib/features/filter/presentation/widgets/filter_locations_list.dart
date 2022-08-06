import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import 'home_page_filter_location_tile.dart';

class FilterLocationsList extends StatelessWidget {
  const FilterLocationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
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
                    return HomePageFilterLocationTile(
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
    );
  }
}
