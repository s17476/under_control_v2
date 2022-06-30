import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
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

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late StreamSubscription companyProfileStreamSubscription;
  StreamSubscription? locationsStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final AddLocation addLocation;
  final CacheLocation cacheLocation;
  final DeleteLocation deleteLocation;
  final FetchAllLocations fetchAllLocations;
  final TryToGetCachedLocation tryToGetCachedLocation;
  final UpdateLocation updateLocation;
  LocationLoadedState? _lastState;
  String companyId = '';

  LocationBloc({
    required this.companyProfileBloc,
    required this.addLocation,
    required this.cacheLocation,
    required this.deleteLocation,
    required this.fetchAllLocations,
    required this.tryToGetCachedLocation,
    required this.updateLocation,
  }) : super(LocationEmptyState()) {
    companyProfileStreamSubscription = companyProfileBloc.stream.listen(
      (state) {
        if (state is CompanyProfileLoaded) {
          companyId = state.company.id;
          add(FetchAllLocationsEvent());
        }
      },
    );

    on<AddLocationEvent>((event, emit) async {
      final failureOrString = await addLocation(
        LocationParams(location: event.location, comapnyId: companyId),
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
          LocationParams(location: event.location, comapnyId: companyId));
      await failureOrVoidresult.fold(
        (failure) async => emit(LocationErrorState(message: failure.message)),
        (_) async {
          emit(
            (state as LocationLoadedState).copyWith(
              message: locationAddedMessage,
            ),
          );
        },
      );
    });

    // TODO
    // update tests
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
            comapnyId: companyId,
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
      final failureOrLocations = await fetchAllLocations(companyId);
      await failureOrLocations.fold(
        (failure) async => emit(LocationErrorState(message: failure.message)),
        (locations) async {
          locationsStreamSubscription =
              locations.allLocations.listen((snapshot) {
            add(UpdateLocationsListEvent(snapshot: snapshot));
          });
          emit(
            LocationLoadedState(
              allLocations: const LocationsList(allLocations: []),
              context: const [],
              children: const [],
            ),
          );
        },
      );
    });

    on<UpdateLocationsListEvent>(
      (event, emit) async {
        final locationsList = LocationsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        final failureOrString = await tryToGetCachedLocation(NoParams());
        await failureOrString.fold(
          // no cached location id
          (failure) async => emit(
            LocationLoadedState(
              allLocations: locationsList,
              context: const [],
              children: locationsList.allLocations
                  .map((location) => location.id)
                  .toList(),
            ),
          ),
          // cached location if found
          (locationId) async {
            final cachedLocation = locationsList.allLocations
                .firstWhere((location) => location.id == locationId);
            emit(
              LocationLoadedState(
                selectedLocation: cachedLocation,
                allLocations: locationsList,
                context: updateContext(
                  cachedLocation,
                  locationsList.allLocations,
                ),
                children: updateChildren(
                  cachedLocation,
                  locationsList.allLocations,
                ),
              ),
            );
          },
        );
      },
    );

    on<SelectLocationEvent>(
      (event, emit) async {
        emit(LocationLoadingState());
        _saveState();
        final failureOrVoidresult = await cacheLocation(
          LocationParams(
            location: event.location,
            comapnyId: companyId,
          ),
        );
        await failureOrVoidresult.fold(
          (failure) async => emit(LocationLoadedState(
            selectedLocation: event.location,
            allLocations: _lastState?.allLocations ??
                const LocationsList(allLocations: []),
            context: updateContext(
              event.location,
              _lastState?.allLocations.allLocations ?? [],
            ),
            children: updateChildren(
              event.location,
              _lastState?.allLocations.allLocations ?? [],
            ),
          )),
          (_) async => emit(LocationLoadedState(
            selectedLocation: event.location,
            allLocations: _lastState?.allLocations ??
                const LocationsList(allLocations: []),
            context: updateContext(
              event.location,
              _lastState?.allLocations.allLocations ?? [],
            ),
            children: updateChildren(
              event.location,
              _lastState?.allLocations.allLocations ?? [],
            ),
          )),
        );
      },
    );
  }

  void _saveState() {
    if (state is LocationLoadedState) {
      _lastState = state as LocationLoadedState;
    }
  }

  List<String> updateContext(
    Location selectedLocation,
    List<Location> allLocations,
  ) {
    List<String> updatedContext = [];
    Location tmpLocation = selectedLocation;
    while (tmpLocation.parentId.isNotEmpty) {
      updatedContext.add(tmpLocation.id);
      tmpLocation = allLocations.firstWhere(
        (location) => location.id == tmpLocation.parentId,
      );
    }
    updatedContext.add(tmpLocation.id);
    print(updatedContext);
    return updatedContext;
  }

  List<String> updateChildren(
    Location selectedLocation,
    List<Location> allLocations,
  ) {
    List<String> updatedChildren = [];
    List<Location> tmpLocations = [selectedLocation];
    while (tmpLocations.isNotEmpty) {
      Location tmpLocation = tmpLocations[0];
      final tmpList =
          allLocations.where((location) => location.parentId == tmpLocation.id);
      tmpLocations.addAll(tmpList);
      updatedChildren.add(tmpLocation.id);
      tmpLocations.remove(tmpLocation);
    }
    updatedChildren.remove(selectedLocation.id);
    return updatedChildren;
  }

  @override
  Future<void> close() {
    companyProfileStreamSubscription.cancel();
    locationsStreamSubscription?.cancel();
    return super.close();
  }
}
