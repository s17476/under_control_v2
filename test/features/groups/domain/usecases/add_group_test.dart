import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart';
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

void main() {
  late AddGroup usecase;
  late MockGroupRepository repository;

  setUpAll(() {
    registerFallbackValue(const Group(
      id: 'id',
      description: 'description',
      name: 'name',
      groupAdministrators: [],
      locations: [],
      features: [],
    ));
    registerFallbackValue(
      const GroupParams(
          group: Group(
            id: 'id',
            description: 'description',
            name: 'name',
            groupAdministrators: [],
            locations: [],
            features: [],
          ),
          companyId: 'comapnyId'),
    );
  });

  setUp(() {
    repository = MockGroupRepository();
    usecase = AddGroup(groupRepository: repository);
  });

  group('Groups', () {
    test(
      'should return [String] from repository when AddGroup is called',
      () async {
        // arrange
        when(() => repository.addGroup(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(
          const GroupParams(
              group: Group(
                id: 'id',
                name: 'name',
                description: 'description',
                groupAdministrators: [],
                locations: [],
                features: [],
              ),
              companyId: 'comapnyId'),
        );
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
