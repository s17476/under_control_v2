import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart';
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

void main() {
  late DeleteGroup usecase;
  late MockGroupRepository repository;

  setUpAll(() {
    registerFallbackValue(const Group(
      id: 'id',
      name: 'name',
      locations: [],
      features: [],
    ));
    registerFallbackValue(
      const GroupParams(
          group: Group(
            id: 'id',
            name: 'name',
            locations: [],
            features: [],
          ),
          comapnyId: 'comapnyId'),
    );
  });

  setUp(() {
    repository = MockGroupRepository();
    usecase = DeleteGroup(groupRepository: repository);
  });

  group('Groups', () {
    test(
      'should return [VoidResult] from repository when DeleteGroup is called',
      () async {
        // arrange
        when(() => repository.deleteGroup(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(
          const GroupParams(
              group: Group(
                id: 'id',
                name: 'name',
                locations: [],
                features: [],
              ),
              comapnyId: 'comapnyId'),
        );
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
