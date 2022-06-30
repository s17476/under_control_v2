import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/locations/presentation/widgets/add_location_card.dart';

import '../blocs/bloc/location_bloc.dart';
import '../widgets/location_card.dart';

class LocationManagementPage extends StatefulWidget {
  const LocationManagementPage({Key? key}) : super(key: key);

  static const routeName = '.locations';

  @override
  State<LocationManagementPage> createState() => _LocationManagementPageState();
}

class _LocationManagementPageState extends State<LocationManagementPage> {
  int colorIndex = 0;

  final colors = [
    Colors.red,
    Colors.amber,
    const Color.fromRGBO(0, 240, 130, 100),
    Colors.blue,
    Colors.deepPurple,
  ];

  void nextColor() {
    if (colorIndex < colors.length - 1) {
      colorIndex++;
    } else {
      colorIndex = 0;
    }
  }

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
          String message = '';
          bool error = false;
          if (state is LocationLoadedState) {
            switch (state.message) {
              case locationAddedMessage:
                message = AppLocalizations.of(context)!
                    .location_management_add_location_message_added;
                break;
              case deleteFailed:
                message = AppLocalizations.of(context)!
                    .location_management_add_location_message_delete_failed;
                error = true;
                break;
              case deleteSuccess:
                message = AppLocalizations.of(context)!
                    .location_management_add_location_message_delete_success;
                break;
              case updateSuccess:
                message = AppLocalizations.of(context)!
                    .location_management_add_location_message_update_success;
                break;
              default:
                message = '';
            }
          } else if (state is LocationErrorState) {
            message = 'Failed!';
            error = true;
          }
          if (message.isNotEmpty) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: error
                      ? Theme.of(context).errorColor
                      : Theme.of(context).primaryColor,
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is LocationLoadedState) {
            final topLevelItems = state.allLocations.allLocations
                .where((location) => location.parentId.isEmpty)
                .toList();
            return ListView.builder(
              itemCount: topLevelItems.length + 1,
              itemBuilder: (context, index) {
                // nextColor();
                if (topLevelItems.isEmpty || index == topLevelItems.length) {
                  return AddLocationCard(
                    key: const Key('top-level'),
                    color: colors[index % (colors.length - 1)],
                  );
                } else {
                  return LocationCard(
                    key: Key(topLevelItems[index].id),
                    allLocations: state.allLocations.allLocations,
                    location: topLevelItems[index],
                    color: colors[index % (colors.length - 1)],
                  );
                }
              },
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
