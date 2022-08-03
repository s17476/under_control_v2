import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late MakeUserAdministrator usecase;
  late MockUserProfileRepository repository;

  setUp(
    () {
      repository = MockUserProfileRepository();
      usecase = MakeUserAdministrator(repository: repository);
    },
  );

  test(
    'UserPorfile should return [Voidresult] from repository when MakeUserAdministrator is called',
    () async {
      // arrange
      when(() => repository.makeUserAdministrator(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase('');
      // assert
      expect(result, Right<Failure, VoidResult>(VoidResult()));
    },
  );
}
