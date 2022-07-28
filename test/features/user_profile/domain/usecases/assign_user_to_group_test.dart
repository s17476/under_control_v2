import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late AssignUserToGroup usecase;
  late MockUserProfileRepository repository;

  setUpAll(() {
    registerFallbackValue(
        const UserAndGroupParams(userId: 'userId', groupId: 'groupId'));
  });

  setUp(
    () {
      repository = MockUserProfileRepository();
      usecase = AssignUserToGroup(repository: repository);
    },
  );

  test(
    'UserManagement should return [VoidResult] from repository when assignUserTogroup is called',
    () async {
      // arrange
      when(() => repository.assignUserToGroup(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(
          const UserAndGroupParams(userId: 'userId', groupId: 'groupId'));
      // assert
      expect(result, Right<Failure, VoidResult>(VoidResult()));
    },
  );
}
