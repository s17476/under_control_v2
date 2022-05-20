import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late AssignUserToCompany usecase;
  late MockUserProfileRepository repository;

  setUpAll(() {
    registerFallbackValue(
        const AssignParams(userId: 'userId', companyId: 'companyId'));
  });

  setUp(
    () {
      repository = MockUserProfileRepository();
      usecase = AssignUserToCompany(repository: repository);
    },
  );

  test(
    'should return [VoidResult] from repository when assignUserToCompany is called',
    () async {
      // arrange
      when(() => repository.assignUserToCompany(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(
          const AssignParams(userId: 'userId', companyId: 'companyId'));
      // assert
      expect(result, Right<Failure, VoidResult>(VoidResult()));
    },
  );
}
