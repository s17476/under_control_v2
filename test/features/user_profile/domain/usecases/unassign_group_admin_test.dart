import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late UnassignGroupAdmin usecase;
  late MockUserProfileRepository repository;

  setUpAll(() {
    registerFallbackValue(
      const AssignGroupAdminParams(
        userId: 'userId',
        groupId: 'groupId',
        companyId: 'companyId',
      ),
    );
  });

  setUp(
    () {
      repository = MockUserProfileRepository();
      usecase = UnassignGroupAdmin(repository: repository);
    },
  );

  test(
    'UserManagement should return [VoidResult] from repository when unassignGroupAdmin is called',
    () async {
      // arrange
      when(() => repository.unassignGroupAdmin(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(
        const AssignGroupAdminParams(
          userId: 'userId',
          groupId: 'groupId',
          companyId: 'companyId',
        ),
      );
      // assert
      expect(result, Right<Failure, VoidResult>(VoidResult()));
    },
  );
}
