import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../../../groups/domain/entities/group.dart';
import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../locations/domain/entities/location.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

part 'filter_event.dart';
part 'filter_state.dart';

@singleton
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final LocationBloc locationBloc;
  final GroupBloc groupBloc;
  final UserProfileBloc userProfileBloc;
  final AuthenticationBloc authenticationBloc;

  late StreamSubscription _locationStreamSubscription;
  late StreamSubscription _groupStreamSubscription;
  late StreamSubscription _userProfileStreamSubscription;
  late StreamSubscription _authStreamSubscription;

  String _companyId = '';
  bool _isAdmin = false;
  List<String> _userGroups = const [];

  FilterBloc({
    required this.locationBloc,
    required this.groupBloc,
    required this.userProfileBloc,
    required this.authenticationBloc,
  }) : super(FilterEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    // location stream
    _locationStreamSubscription = locationBloc.stream.listen((state) {
      if (_companyId.isNotEmpty && state is LocationLoadedState) {
        // gets all selected locations
        final selectedLocations = state.allSelectedLocations;
        add(UpdateLocationsEvent(locations: selectedLocations));
      }
    });

    // group stream
    _groupStreamSubscription = groupBloc.stream.listen((state) {
      if (_companyId.isNotEmpty && state is GroupLoadedState) {
        if (!_isAdmin) {
          add(
            UpdateGroupsEvent(
              groups: state.getGroupsById(_userGroups),
            ),
          );
        } else {
          add(UpdateGroupsEvent(groups: state.selectedGroups));
        }
      }
    });

    _userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (state is Approved) {
        _companyId = state.userProfile.companyId;
        _isAdmin = state.userProfile.administrator;
        _userGroups = state.userProfile.userGroups;
      }
    });

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _isAdmin = false;
        _userGroups = [];
        emit(FilterEmptyState());
      },
    );

    on<UpdateLocationsEvent>(
      (event, emit) async {
        if (groupBloc.state is GroupLoadedState) {
          emit(FilterLoadingState());
          List<Group> updatedGroups = [];
          List<Group> selectedGroups = [];
          if (!_isAdmin) {
            selectedGroups = (groupBloc.state as GroupLoadedState)
                .getGroupsById(_userGroups);
          } else {
            selectedGroups =
                (groupBloc.state as GroupLoadedState).selectedGroups;
          }
          for (var location in event.locations) {
            for (var group in selectedGroups) {
              if (group.locations.contains(location.id) &&
                  !updatedGroups.contains(group)) {
                updatedGroups.add(group);
              }
            }
          }
          emit(
            FilterLoadedState(
              isAdmin: _isAdmin,
              companyId: _companyId,
              locations: event.locations,
              groups: updatedGroups,
              allPossibleGroups: getAllPossibleGroups(),
            ),
          );
        }
      },
    );

    on<UpdateGroupsEvent>((event, emit) async {
      if (locationBloc.state is LocationLoadedState) {
        emit(FilterLoadingState());
        List<Group> updatedGroups = [];
        final locations =
            (locationBloc.state as LocationLoadedState).allSelectedLocations;
        for (var location in locations) {
          for (var group in event.groups) {
            if (group.locations.contains(location.id) &&
                !updatedGroups.contains(group)) {
              updatedGroups.add(group);
            }
          }
        }
        emit(
          FilterLoadedState(
            isAdmin: _isAdmin,
            companyId: _companyId,
            locations: locations,
            groups: updatedGroups,
            allPossibleGroups: getAllPossibleGroups(),
          ),
        );
      }
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
          }
        }
      }

      // gets groups where current user is a member
      List<Group> groupsForUser = [];
      if (_isAdmin) {
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
    _locationStreamSubscription.cancel();
    _groupStreamSubscription.cancel();
    _userProfileStreamSubscription.cancel();
    _authStreamSubscription.cancel();
    return super.close();
  }
}
