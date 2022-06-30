import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/bloc/location_bloc.dart';
import '../widgets/add_location_card.dart';
import '../widgets/location_card.dart';
import '../widgets/show_location_snack_bar.dart';

class LocationManagementPage extends StatefulWidget {
  const LocationManagementPage({Key? key}) : super(key: key);

  static const routeName = '.locations';

  @override
  State<LocationManagementPage> createState() => _LocationManagementPageState();
}

class _LocationManagementPageState extends State<LocationManagementPage> {
  int colorIndex = 0;

  final colors = [
    const Color.fromARGB(156, 79, 79, 79),
    const Color.fromARGB(255, 0, 0, 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.location_management_title,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          showLocationSnackBar(context: context, state: state);
        },
        builder: (context, state) {
          if (state is LocationLoadedState) {
            final topLevelItems = state.allLocations.allLocations
                .where((location) => location.parentId.isEmpty)
                .toList();
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: ListView.builder(
                itemCount: topLevelItems.length + 1,
                itemBuilder: (context, index) {
                  if (topLevelItems.isEmpty || index == topLevelItems.length) {
                    return const AddLocationCard(
                      key: Key('top-level'),
                    );
                  } else {
                    return LocationCard(
                      key: Key(topLevelItems[index].id),
                      allLocations: state.allLocations.allLocations,
                      location: topLevelItems[index],
                      color: colors[index % (colors.length)],
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
    );
  }
}