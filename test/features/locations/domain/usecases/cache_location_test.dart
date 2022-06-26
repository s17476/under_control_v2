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
        children: ['children'],
      ),
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
    children: ['children'],
  );

  test(
    'should return [Voidresult] from repository when CacheLocation is called',
    () async {
      // arrange
      when(() => repository.cacheLocation(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(
          const LocationParams(location: tLocation, comapnyId: 'comapnyId'));
      // assert
      expect(result, isA<Right<Failure, VoidResult>>());
    },
  );
}
