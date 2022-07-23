import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_stream.dart';
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart';
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

void main() {
  late GetGroupsStream usecase;
  late MockGroupRepository repository;

  setUp(() {
    repository = MockGroupRepository();
    usecase = GetGroupsStream(groupRepository: repository);
  });

  group('Groups', () {
    test(
      'should return [GroupsStream] from repository when GetGroupsStream is called',
      () async {
        // arrange
        when(() => repository.getGroupsStream(any())).thenAnswer(
          (_) async => Right(
            GroupsStream(
              allGroups: Stream.fromIterable([]),
            ),
          ),
        );
        // act
        final result = await usecase('');
        // assert
        expect(result, isA<Right<Failure, GroupsStream>>());
      },
    );
  });
}
