import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../locations/domain/entities/location.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import 'location_selection_tile.dart';

class AddGroupLocationsCard extends StatelessWidget {
  const AddGroupLocationsCard({
    Key? key,
    required this.pageController,
    required this.selectedLocations,
    required this.locationsChildren,
    required this.locationsContext,
    required this.toggleLocationSelection,
  }) : super(key: key);

  final PageController pageController;

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
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
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
                ],
              ),
            ),
          ),
          // bottom navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardTextButton(
                  icon: Icons.arrow_back_ios_new,
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  function: () => pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                  function: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
