import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/data/models/locations_list_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations.dart';
import 'package:under_control_v2/features/locations/domain/usecases/add_location.dart';
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart';
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart';
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart';
import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart';
import 'package:under_control_v2/features/locations/domain/usecases/update_location.dart';
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockFetchAllLocations extends Mock implements FetchAllLocations {}

class MockAddLocation extends Mock implements AddLocation {}

class MockDeleteLocation extends Mock implements DeleteLocation {}

class MockUpdateLocation extends Mock implements UpdateLocation {}

class MockCacheLocation extends Mock implements CacheLocation {}

class MockTryToGetCachedLocation extends Mock
    implements TryToGetCachedLocation {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockUserProfileBloc mockUserProfileBloc;
  late MockFetchAllLocations mockFetchAllLocations;
  late MockAddLocation mockAddLocation;
  late MockDeleteLocation mockDeleteLocation;
  late MockUpdateLocation mockUpdateLocation;
  late MockCacheLocation mockCacheLocation;
  late MockTryToGetCachedLocation mockTryToGetCachedLocation;
  late LocationBloc locationBloc;

  setUp(
    () {
      mockAuthenticationBloc = MockAuthenticationBloc();
      when(() => mockAuthenticationBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(EmptyAuthenticationState()),
        ),
      );
      mockUserProfileBloc = MockUserProfileBloc();
      when(() => mockUserProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(UserProfileEmpty()),
        ),
      );
      mockFetchAllLocations = MockFetchAllLocations();
      mockAddLocation = MockAddLocation();
      mockDeleteLocation = MockDeleteLocation();
      mockUpdateLocation = MockUpdateLocation();
      mockCacheLocation = MockCacheLocation();
      mockTryToGetCachedLocation = MockTryToGetCachedLocation();

      locationBloc = LocationBloc(
        userProfileBloc: mockUserProfileBloc,
        authenticationBloc: mockAuthenticationBloc,
        addLocation: mockAddLocation,
        cacheLocation: mockCacheLocation,
        deleteLocation: mockDeleteLocation,
        fetchAllLocations: mockFetchAllLocations,
        tryToGetCachedLocation: mockTryToGetCachedLocation,
        updateLocation: mockUpdateLocation,
      );
    },
  );

  setUpAll(() {
    registerFallbackValue(
      LocationParams(
        location: LocationModel.initial(),
        comapnyId: 'comapnyId',
      ),
    );
    registerFallbackValue(
      const SelectedLocationsParams(
        locations: ['any'],
        children: [],
      ),
    );
  });

  final tLocation = LocationModel.initial();

  group('Locations BLoC', () {
    test(
      'should emit [LocationEmptyState] as an initial state',
      () async {
        // assert
        expect(locationBloc.state, const LocationEmptyState());
      },
    );

    group('[AddLocation] usecase', () {
      blocTest(
        'should emit [LocationErrorState] when Addlocation usecase returns failure',
        build: () => locationBloc,
        act: (LocationBloc bloc) async {
          bloc.add(AddLocationEvent(location: tLocation));
          when(() => mockAddLocation(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [isA<LocationErrorState>()],
      );
      blocTest(
        'should emit [LocationLoadedState] when AddLocation usecase returns data',
        build: () => locationBloc,
        // ignore: unnecessary_cast
        seed: () => LocationLoadedState(
          allLocations: const LocationsListModel(allLocations: []),
          context: const [],
          children: const [],
        ) as LocationState,
        act: (LocationBloc bloc) async {
          bloc.add(AddLocationEvent(location: tLocation));
          when(() => mockAddLocation(any()))
              .thenAnswer((_) async => const Right('locationid'));
        },
        expect: () => [isA<LocationLoadedState>()],
      );
    });

    group('[UpdateLocation] usecase', () {
      blocTest(
        'should emit [LocationErrorState] when Updatelocation usecase returns failure',
        build: () => locationBloc,
        // ignore: unnecessary_cast
        seed: () => LocationLoadedState(
          allLocations: const LocationsListModel(allLocations: []),
          context: const [],
          children: const [],
        ) as LocationState,
        act: (LocationBloc bloc) async {
          bloc.add(UpdateLocationEvent(location: tLocation));
          when(() => mockUpdateLocation(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [isA<LocationErrorState>()],
      );
      blocTest(
        'should emit [LocationLoadedState] when UpdateLocation usecase returns data',
        build: () => locationBloc,
        // ignore: unnecessary_cast
        seed: () => LocationLoadedState(
          allLocations: const LocationsListModel(allLocations: []),
          context: const [],
          children: const [],
        ) as LocationState,
        act: (LocationBloc bloc) async {
          bloc.add(UpdateLocationEvent(location: tLocation));
          when(() => mockUpdateLocation(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        expect: () => [isA<LocationLoadedState>()],
      );
    });

    group('[DeleteLocation] usecase', () {
      blocTest(
        'should emit [LocationErrorState] when Deletelocation usecase returns failure',
        build: () => locationBloc,
        // ignore: unnecessary_cast
        seed: () => LocationLoadedState(
          allLocations: const LocationsListModel(allLocations: []),
          context: const [],
          children: const [],
        ) as LocationState,
        act: (LocationBloc bloc) async {
          bloc.add(DeleteLocationEvent(location: tLocation));
          when(() => mockDeleteLocation(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [isA<LocationErrorState>()],
      );
      blocTest(
        'should emit [LocationLoadedState] when DeleteLocation usecase returns data',
        build: () => locationBloc,
        // ignore: unnecessary_cast
        seed: () => LocationLoadedState(
          allLocations: const LocationsListModel(allLocations: []),
          context: const [],
          children: const [],
        ) as LocationState,
        act: (LocationBloc bloc) async {
          bloc.add(DeleteLocationEvent(location: tLocation));
          when(() => mockDeleteLocation(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        expect: () => [isA<LocationLoadedState>()],
      );
    });

    group('[FetchAllLocations] usecase', () {
      blocTest(
        'should emit [LocationErrorState] when fetchAllLocations usecase returns failure',
        build: () => locationBloc,
        act: (LocationBloc bloc) async {
          bloc.add(FetchAllLocationsEvent());
          when(() => mockFetchAllLocations(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [LocationLoadingState(), isA<LocationErrorState>()],
      );
      blocTest(
        'should emit [LocationLoadedState] when FetchAllLocations usecase returns data',
        build: () => locationBloc,
        act: (LocationBloc bloc) async {
          bloc.add(FetchAllLocationsEvent());
          when(() => mockFetchAllLocations(any())).thenAnswer((_) async =>
              Right(Locations(allLocations: Stream.fromIterable([]))));
        },
        expect: () => [LocationLoadingState()],
      );
    });
    // group('[SelectLocation] event', () {
    //   blocTest(
    //     'should emit [LocationLoadedState] when SelectLocation event returns data',
    //     build: () => locationBloc,
    //     act: (LocationBloc bloc) async {
    //       bloc.add(SelectLocationEvent(location: tLocation));
    //       when(() => mockCacheLocation(any()))
    //           .thenAnswer((_) async => Right(VoidResult()));
    //     },
    //     expect: () => [LocationLoadingState(), isA<LocationLoadedState>()],
    //   );
    //   blocTest(
    //     'should emit [LocationLoadedState] when SelectLocation event returns failure',
    //     build: () => locationBloc,
    //     act: (LocationBloc bloc) async {
    //       bloc.add(SelectLocationEvent(location: tLocation));
    //       when(() => mockCacheLocation(any()))
    //           .thenAnswer((_) async => const Left(CacheFailure()));
    //     },
    //     expect: () => [LocationLoadingState(), isA<LocationLoadedState>()],
    //   );
    // });
  });
}
