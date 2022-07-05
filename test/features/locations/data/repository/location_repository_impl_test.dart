import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/exceptions.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations.dart';
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockLocationLocalDataSource extends Mock
    implements LocationLocalDataSource {}

class MockLocationRemoteDataSource extends Mock
    implements LocationRemoteDataSource {}

void main() {
  late MockLocationLocalDataSource mockLocationLocalDataSource;
  late MockLocationRemoteDataSource mockLocationRemoteDataSource;
  late LocationRepositoryImpl mockLocationRepository;

  setUp(() {
    mockLocationLocalDataSource = MockLocationLocalDataSource();
    mockLocationRemoteDataSource = MockLocationRemoteDataSource();
    mockLocationRepository = LocationRepositoryImpl(
      locationLocalDataSource: mockLocationLocalDataSource,
      locationRemoteDataSource: mockLocationRemoteDataSource,
    );
  });

  setUpAll(() {
    registerFallbackValue(
      LocationParams(
        location: LocationModel.initial(),
        comapnyId: 'comapnyId',
      ),
    );
  });

  const tLocation = LocationModel(
    id: 'id',
    name: 'name',
    parentId: 'parentId',
  );

  const tLocationParams = LocationParams(
    location: tLocation,
    comapnyId: 'comapnyId',
  );

  group('LocationRepositoryImpl', () {
    // group('CacheLocation usecase', () {
    //   test(
    //     'should cache data locally',
    //     () async {
    //       // arrange
    //       when(() => mockLocationLocalDataSource.cacheLocation(any()))
    //           .thenAnswer((_) => Future.value());
    //       // act
    //       await mockLocationRepository.cacheSelectedLocations(tLocationParams);
    //       // assert
    //       verify(() => mockLocationLocalDataSource
    //           .cacheLocation(tLocationParams.location.id));
    //     },
    //   );
    //   test(
    //     'should return [CacheFailure]',
    //     () async {
    //       // arrange
    //       when(() => mockLocationLocalDataSource.cacheLocation(any()))
    //           .thenThrow(CacheException());
    //       // act
    //       final result = await mockLocationRepository
    //           .cacheSelectedLocations(tLocationParams);
    //       // assert
    //       expect(result, isA<Left<Failure, VoidResult>>());
    //     },
    //   );
    //   test(
    //     'should return [unsuspectedFailure]',
    //     () async {
    //       // arrange
    //       when(() => mockLocationLocalDataSource.cacheLocation(any()))
    //           .thenThrow(Exception());
    //       // act
    //       final result = await mockLocationRepository
    //           .cacheSelectedLocations(tLocationParams);
    //       // assert
    //       expect(result, isA<Left<Failure, VoidResult>>());
    //     },
    //   );
    // });

    // group('TryToGetCachedlocation usecase', () {
    //   test(
    //     'should return cached locations id',
    //     () async {
    //       // arrange
    //       when(() => mockLocationLocalDataSource.getCachedLocation())
    //           .thenAnswer((_) async => tLocation.id);
    //       // act
    //       final result = await mockLocationRepository.tryToGetCachedLocation();
    //       // assert
    //       expect(result, isA<Right<Failure, String>>());
    //     },
    //   );
    //   test(
    //     'should return [CacheFailure]',
    //     () async {
    //       // arrange
    //       when(() => mockLocationLocalDataSource.getCachedLocation())
    //           .thenThrow(CacheException());
    //       // act
    //       final result = await mockLocationRepository.tryToGetCachedLocation();
    //       // assert
    //       expect(result, isA<Left<Failure, String>>());
    //     },
    //   );
    //   test(
    //     'should return [unsuspectedFailure]',
    //     () async {
    //       // arrange
    //       when(() => mockLocationLocalDataSource.getCachedLocation())
    //           .thenThrow(Exception());
    //       // act
    //       final result = await mockLocationRepository.tryToGetCachedLocation();
    //       // assert
    //       expect(result, isA<Left<Failure, String>>());
    //     },
    //   );
    // });

    group('AddLocation usecase', () {
      test(
        'should add location to db and return generated locations id',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.addLocation(any()))
              .thenAnswer((_) async => Right(tLocation.id));
          // act
          final result =
              await mockLocationRepository.addLocation(tLocationParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [DatabaseFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.addLocation(any()))
              .thenAnswer((_) async => const Left(CacheFailure()));
          // act
          final result =
              await mockLocationRepository.addLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.addLocation(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
          // act
          final result =
              await mockLocationRepository.addLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
    });

    group('DeleteLocation usecase', () {
      test(
        'should return [VoidResult]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.deleteLocation(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          // act
          final result =
              await mockLocationRepository.deleteLocation(tLocationParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.deleteLocation(any()))
              .thenAnswer((_) async => const Left(CacheFailure()));
          // act
          final result =
              await mockLocationRepository.deleteLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.deleteLocation(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
          // act
          final result =
              await mockLocationRepository.deleteLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    });

    group('UpdateLocation usecase', () {
      test(
        'should return [VoidResult]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.updateLocation(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          // act
          final result =
              await mockLocationRepository.updateLocation(tLocationParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.updateLocation(any()))
              .thenAnswer((_) async => const Left(CacheFailure()));
          // act
          final result =
              await mockLocationRepository.updateLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.updateLocation(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
          // act
          final result =
              await mockLocationRepository.updateLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    });

    group('FetchAllLocation usecase', () {
      test(
        'should return [Locations]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.fetchAllLocations(any()))
              .thenAnswer(
            (_) async => Right(
              Locations(
                allLocations: Stream.fromIterable([tLocation]),
              ),
            ),
          );
          // act
          final result =
              await mockLocationRepository.fetchAllLocations('companyId');
          // assert
          expect(result, isA<Right<Failure, Locations>>());
        },
      );
      test(
        'should return [DatabaseFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.fetchAllLocations(any()))
              .thenAnswer((_) async => const Left(CacheFailure()));
          // act
          final result =
              await mockLocationRepository.fetchAllLocations(tLocation.id);
          // assert
          expect(result, isA<Left<Failure, Locations>>());
        },
      );
      test(
        'should return [UnsuspectedFailure]',
        () async {
          // arrange
          when(() => mockLocationRemoteDataSource.fetchAllLocations(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
          // act
          final result =
              await mockLocationRepository.fetchAllLocations(tLocation.id);
          // assert
          expect(result, isA<Left<Failure, Locations>>());
        },
      );
    });
  });
}
