import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/locations/domain/entities/location.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations.dart';
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart';
import 'package:under_control_v2/features/locations/domain/usecases/fetch_all_locations.dart';

class MockLocationsRepository extends Mock implements LocationRepository {}

void main() {
  late MockLocationsRepository repository;
  late FetchAllLocations usecase;

  setUp(
    () {
      repository = MockLocationsRepository();
      usecase = FetchAllLocations(locationRepository: repository);
    },
  );

  const tLocation = Location(
    id: 'id',
    name: 'name',
    parentId: 'parentId',
  );

  const tLocations = [tLocation];

  test(
    'should return [Locations] from repository when FetchAllLocations usecase is called',
    () async {
      // arrange
      when(() => repository.fetchAllLocations(any())).thenAnswer((_) async =>
          Right(Locations(allLocations: Stream.fromIterable(tLocations))));
      // act
      final result = await usecase('');
      // assert
      verify(() => repository.fetchAllLocations(''));
      verifyNoMoreInteractions(repository);
      expect(result, isA<Right<Failure, Locations>>());
    },
  );
}
