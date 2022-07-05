import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/location.dart';
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart';
import 'package:under_control_v2/features/locations/domain/usecases/cache_location.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late CacheLocation usecase;
  late MockLocationRepository repository;

  setUpAll(() {
    registerFallbackValue(
      const Location(
        id: 'id',
        name: 'name',
        parentId: 'parentId',
      ),
    );
    registerFallbackValue(
      const SelectedLocationsParams(locations: ['any'], children: []),
    );

    registerFallbackValue(
      LocationParams(
        location: LocationModel.initial(),
        comapnyId: 'comapnyId',
      ),
    );
  });

  setUp(
    () {
      repository = MockLocationRepository();
      usecase = CacheLocation(locationRepository: repository);
    },
  );

  const tLocation = Location(
    id: 'id',
    name: 'name',
    parentId: 'parentId',
  );

  test(
    'should return [Voidresult] from repository when CacheLocation is called',
    () async {
      // arrange
      when(() => repository.cacheSelectedLocations(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(SelectedLocationsParams(
          children: [tLocation.id], locations: const ['any']));
      // assert
      expect(result, isA<Right<Failure, VoidResult>>());
    },
  );
}
