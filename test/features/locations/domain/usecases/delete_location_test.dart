import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/location.dart';
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart';
import 'package:under_control_v2/features/locations/domain/usecases/delete_location.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late DeleteLocation usecase;
  late LocationRepository repository;

  setUp(
    () {
      repository = MockLocationRepository();
      usecase = DeleteLocation(locationRepository: repository);
    },
  );

  setUpAll(() {
    registerFallbackValue(
      const Location(
        id: 'id',
        name: 'name',
        parentId: 'parentId',
      ),
    );

    registerFallbackValue(
      LocationParams(
        location: LocationModel.initial(),
        comapnyId: 'comapnyId',
      ),
    );
  });
  test(
    'Locations should return [Voidresult] from repisitory when DeleteLocation is called',
    () async {
      // arrange
      when(() => repository.deleteLocation(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(
        LocationParams(
          location: LocationModel.initial(),
          comapnyId: 'comapnyId',
        ),
      );
      // assert
      expect(result, isA<Right<Failure, VoidResult>>());
    },
  );
}
