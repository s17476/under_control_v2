import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../icon_title_row.dart';
import 'home_page_filter_group_tile.dart';
import 'home_page_filter_location_tile.dart';

class HomePageFilter extends StatelessWidget {
  const HomePageFilter({
    Key? key,
    required this.isFilterExpanded,
  }) : super(key: key);

  final bool isFilterExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
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
              // locations title
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: IconTitleRow(
                  icon: Icons.location_on,
                  iconColor: Colors.grey.shade200,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!
                      .home_screen_filter_select_locations,
                ),
              ),
              // locations list
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
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  thickness: 1.5,
                ),
              ),
              // groups title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: IconTitleRow(
                  icon: Icons.group,
                  iconColor: Colors.grey.shade200,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!
                      .home_screen_filter_select_group,
                ),
              ),
              // groups list
              BlocBuilder<GroupBloc, GroupState>(
                builder: (context, state) {
                  if (state is GroupLoadedState) {
                    final groups = state.allGroups.allGroups;
                    final userProfile =
                        (context.read<UserProfileBloc>().state as Approved)
                            .userProfile;
                    final userGroups = [];
                    for (var groupId in userProfile.userGroups) {
                      final tmpIndex = groups.indexWhere(
                        (element) => element.id == groupId,
                      );
                      if (tmpIndex >= 0) {
                        userGroups.add(groups[tmpIndex]);
                      }
                    }
                    return Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userGroups.length,
                          itemBuilder: (context, index) {
                            if (userGroups.isEmpty) {
                              return const SizedBox(
                                child: Center(
                                  child: Text('No data'),
                                ),
                              );
                            } else {
                              return HomePageFilterGroupTile(
                                group: userGroups[index],
                                color: Theme.of(context).cardColor,
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
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
