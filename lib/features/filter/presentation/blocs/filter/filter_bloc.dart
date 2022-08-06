import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../groups/domain/entities/group.dart';
import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../locations/domain/entities/location.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

part 'filter_event.dart';
part 'filter_state.dart';

@injectable
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final LocationBloc locationBloc;
  final GroupBloc groupBloc;
  final UserProfileBloc userProfileBloc;

  late StreamSubscription locationStreamSubscription;
  late StreamSubscription groupStreamSubscription;
  FilterBloc({
    required this.locationBloc,
    required this.groupBloc,
    required this.userProfileBloc,
  }) : super(FilterEmptyState()) {
    // location stream
    locationStreamSubscription = locationBloc.stream.listen((state) {
      if (state is LocationLoadedState) {
        // gets all selected locations
        final selectedLocations = state.allSelectedLocations;
        add(UpdateLocationsEvent(locations: selectedLocations));
      }
    });

    // group stream
    groupStreamSubscription = groupBloc.stream.listen((state) {
      if (state is GroupLoadedState) {
        add(UpdateGroupsEvent(groups: state.selectedGroups));
      }
    });

    on<UpdateLocationsEvent>(
      (event, emit) async {
        emit(FilterLoadingState());
        List<Group> updatedGroups = [];
        if (groupBloc.state is GroupLoadedState) {
          for (var location in event.locations) {
            for (var group
                in (groupBloc.state as GroupLoadedState).selectedGroups) {
              if (group.locations.contains(location.id) &&
                  !updatedGroups.contains(group)) {
                updatedGroups.add(group);
                break;
              }
            }
          }
        }

        if (groupBloc.state is GroupLoadedState) {
          emit(
            FilterLoadedState(
              locations: event.locations,
              groups: updatedGroups,
              allPossibleGroups: getAllPossibleGroups(),
            ),
          );
        } else {
          emit(
            FilterLoadedState(
              locations: event.locations,
              groups: updatedGroups,
            ),
          );
        }
      },
    );

    on<UpdateGroupsEvent>((event, emit) async {
      emit(FilterLoadingState());
      List<Group> updatedGroups = [];
      if (locationBloc.state is LocationLoadedState) {
        for (var location in state.locations) {
          for (var group in event.groups) {
            if (group.locations.contains(location.id) &&
                !updatedGroups.contains(group)) {
              updatedGroups.add(group);
              break;
            }
          }
        }
      }
      emit(
        FilterLoadedState(
          locations: state.locations,
          groups: updatedGroups,
          allPossibleGroups: getAllPossibleGroups(),
        ),
      );
    });
  }

  List<Group> getAllPossibleGroups() {
    if (locationBloc.state is LocationLoadedState &&
        groupBloc.state is GroupLoadedState &&
        userProfileBloc.state is Approved) {
      final locationState = locationBloc.state as LocationLoadedState;
      final groupState = groupBloc.state as GroupLoadedState;
      final userProfileState = userProfileBloc.state as Approved;
      // gets groups for selected locations
      List<Group> groupsInSelectedLocations = [];
      for (var location in locationState.allSelectedLocations) {
        for (var group in groupState.allGroups.allGroups) {
          if (group.locations.contains(location.id) &&
              !groupsInSelectedLocations.contains(group)) {
            groupsInSelectedLocations.add(group);
            break;
          }
        }
      }
      // gets groups where current user is a member
      List<Group> groupsForUser = [];
      if (userProfileState.userProfile.administrator) {
        groupsForUser = groupsInSelectedLocations;
      } else {
        for (var group in groupsInSelectedLocations) {
          if (userProfileState.userProfile.userGroups.contains(group.id) &&
              !groupsForUser.contains(group)) {
            groupsForUser.add(group);
          }
        }
      }
      groupsForUser.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      return groupsForUser;
    } else {
      return [];
    }
  }

  @override
  Future<void> close() {
    locationStreamSubscription.cancel();
    return super.close();
  }
}
