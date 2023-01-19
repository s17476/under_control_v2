import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/locations_list_model.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/entities/locations_list.dart';
import '../../../domain/usecases/add_location.dart';
import '../../../domain/usecases/cache_location.dart';
import '../../../domain/usecases/delete_location.dart';
import '../../../domain/usecases/fetch_all_locations.dart';
import '../../../domain/usecases/try_to_get_cached_location.dart';
import '../../../domain/usecases/update_location.dart';

part 'location_event.dart';
part 'location_state.dart';

const String locationAddedMessage = 'added';
const String deleteFailed = 'deleteFailed';
const String deleteSuccess = 'deleteSuccess';
const String updateSuccess = 'updateSuccess';
const String locationSelected = 'locationSelected';
const String locationRemoved = 'locationRemoved';

@singleton
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final UserProfileBloc userProfileBloc;
  final AddLocation addLocation;
  final CacheLocation cacheLocation;
  final DeleteLocation deleteLocation;
  final FetchAllLocations fetchAllLocations;
  final TryToGetCachedLocation tryToGetCachedLocation;
  final UpdateLocation updateLocation;

  late StreamSubscription _userProfileStreamSubscription;
  StreamSubscription? _locationsStreamSubscription;
  String _companyId = '';

  LocationBloc({
    required this.userProfileBloc,
    required this.addLocation,
    required this.cacheLocation,
    required this.deleteLocation,
    required this.fetchAllLocations,
    required this.tryToGetCachedLocation,
    required this.updateLocation,
  }) : super(const LocationEmptyState()) {
    _userProfileStreamSubscription = userProfileBloc.stream.listen(
      (state) {
        if (_companyId.isEmpty && state is Approved) {
          _companyId = state.userProfile.companyId;
          add(FetchAllLocationsEvent());
        }
      },
    );

    on<AddLocationEvent>((event, emit) async {
      final failureOrString = await addLocation(
        LocationParams(location: event.location, comapnyId: _companyId),
      );
      await failureOrString.fold(
        (failure) async => emit(LocationErrorState(message: failure.message)),
        (locationId) async {
          emit(
            (state as LocationLoadedState).copyWith(
              message: locationAddedMessage,
            ),
          );
        },
      );
    });

    on<UpdateLocationEvent>((event, emit) async {
      final failureOrVoidresult = await updateLocation(
          LocationParams(location: event.location, comapnyId: _companyId));
      await failureOrVoidresult.fold(
        (failure) async => emit(LocationErrorState(message: failure.message)),
        (_) async {
          emit(
            (state as LocationLoadedState).copyWith(
              message: updateSuccess,
            ),
          );
        },
      );
    });

    on<DeleteLocationEvent>((event, emit) async {
      final currentState = (state as LocationLoadedState);
      final childrenList = currentState.allLocations.allLocations
          .where((element) => element.parentId == event.location.id);
      if (childrenList.isNotEmpty) {
        emit(
          currentState.copyWith(
            message: deleteFailed,
            error: true,
          ),
        );
      } else {
        final failureOrVoidresult = await deleteLocation(
          LocationParams(
            location: event.location,
            comapnyId: _companyId,
          ),
        );
        await failureOrVoidresult.fold(
          (failure) async => emit(LocationErrorState(message: failure.message)),
          (_) async {
            emit(currentState.copyWith(message: deleteSuccess));
          },
        );
      }
    });

    on<FetchAllLocationsEvent>((event, emit) async {
      emit(LocationLoadingState());
      final failureOrLocations = await fetchAllLocations(_companyId);
      await failureOrLocations.fold(
        (failure) async => emit(LocationErrorState(message: failure.message)),
        (locations) async {
          _locationsStreamSubscription =
              locations.allLocations.listen((snapshot) {
            add(UpdateLocationsListEvent(snapshot: snapshot));
          });
        },
      );
    });

    on<UpdateLocationsListEvent>(
      (event, emit) async {
        final locationsList = LocationsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        final failureOrSelectedLocationsParams =
            await tryToGetCachedLocation(NoParams());
        await failureOrSelectedLocationsParams.fold(
          // no cached location id
          (failure) async => emit(
            LocationLoadedState(
              selectedLocations: const [],
              allLocations: locationsList,
              context: const [],
              children: const [],
            ),
          ),
          // cached location if found
          (selectedLocationsParams) async {
            final List<Location> cachedLocations = [];
            for (var locationId in selectedLocationsParams.locations) {
              final index = locationsList.allLocations
                  .indexWhere((element) => element.id == locationId);
              if (index >= 0) {
                cachedLocations.add(locationsList.allLocations[index]);
              }
            }
            final locationsContext = getselectedLocationsContext(
              cachedLocations,
              selectedLocationsParams.children,
              locationsList.allLocations,
            );
            print('LocationBloc - Loaded');
            emit(
              LocationLoadedState(
                selectedLocations: cachedLocations,
                allLocations: locationsList,
                context: locationsContext,
                children: selectedLocationsParams.children,
              ),
            );
          },
        );
      },
    );

    on<SelectLocationEvent>(
      (event, emit) async {
        final currentState = state as LocationLoadedState;

        List<String> tmpChildren = getSelectedLocationsChildrenId(
          event.location,
          currentState.allLocations.allLocations,
        );
        List<Location> tmpLocations = [...currentState.selectedLocations];

        // finds parent location
        if (event.location.parentId.isNotEmpty) {
          if (currentState.children.contains(event.location.parentId) ||
              currentState.selectedLocations
                  .where((element) => element.id == event.location.parentId)
                  .toList()
                  .isNotEmpty) {
            tmpChildren.add(event.location.id);
            tmpChildren.addAll(currentState.children);
          } else {
            tmpLocations.add(event.location);
            tmpChildren.addAll(currentState.children);
          }
          // top level location
        } else {
          // remove all children from selected locations
          for (var loc in tmpChildren) {
            final location = currentState.allLocations.allLocations.firstWhere(
              (element) => element.id == loc,
            );
            tmpLocations.remove(location);
          }
          // add selected location to selected locations list
          tmpLocations.add(event.location);
          // add selected location children to state children list
          tmpChildren.addAll(currentState.children);
        }
        // remove duplicates
        tmpChildren = tmpChildren.toSet().toList();
        tmpLocations = tmpLocations.toSet().toList();
        // update selected locations
        List<Location> updatedLocations = [];
        for (var location in tmpLocations) {
          if (!tmpChildren.contains(location.id)) {
            updatedLocations.add(location);
          }
        }
        // update locations context
        final updatedContext = getselectedLocationsContext(updatedLocations,
            tmpChildren, currentState.allLocations.allLocations);
        // try to cache locations and children
        final failureOrVoidresult = await cacheLocation(
          SelectedLocationsParams(
            locations: updatedLocations.map((location) => location.id).toList(),
            children: tmpChildren,
          ),
        );
        await failureOrVoidresult.fold(
          (failure) async => emit(
            LocationLoadedState(
              allLocations: currentState.allLocations,
              context: updatedContext,
              children: tmpChildren,
              selectedLocations: updatedLocations,
              message: locationSelected,
            ),
          ),
          (_) async {
            print('LocationBloc - Selected');
            emit(
              LocationLoadedState(
                allLocations: currentState.allLocations,
                context: updatedContext,
                children: tmpChildren,
                selectedLocations: updatedLocations,
                message: locationSelected,
              ),
            );
          },
        );
      },
    );

    on<UnselectLocationEvent>(
      (event, emit) async {
        final currentState = state as LocationLoadedState;
        emit(LocationLoadingState());
        // updates children
        List<String> tmpChildren = getSelectedLocationsChildrenId(
          event.location,
          currentState.allLocations.allLocations,
        );
        tmpChildren.add(event.location.id);
        final List<String> updatedChildren = [];
        for (var child in currentState.children) {
          if (!tmpChildren.contains(child)) {
            updatedChildren.add(child);
          }
        }

        // updates selected locations
        List<Location> tmpLocations = currentState.selectedLocations;

        tmpLocations.remove(event.location);

        final updatedContext = getselectedLocationsContext(
          tmpLocations,
          updatedChildren,
          currentState.allLocations.allLocations,
        );

        final failureOrVoidresult = await cacheLocation(
          SelectedLocationsParams(
            locations: tmpLocations.map((location) => location.id).toList(),
            children: updatedChildren,
          ),
        );
        await failureOrVoidresult.fold(
          (failure) async => emit(
            LocationLoadedState(
              allLocations: currentState.allLocations,
              context: updatedContext,
              children: updatedChildren,
              selectedLocations: tmpLocations,
              message: locationRemoved,
            ),
          ),
          (_) async {
            print('LocationBloc - Unselected');
            emit(
              LocationLoadedState(
                allLocations: currentState.allLocations,
                context: updatedContext,
                children: updatedChildren,
                selectedLocations: tmpLocations,
                message: locationRemoved,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _userProfileStreamSubscription.cancel();
    _locationsStreamSubscription?.cancel();
    return super.close();
  }
}
