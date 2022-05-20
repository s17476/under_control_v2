import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late RejectUser usecase;
  late MockUserProfileRepository repository;

  setUp(
    () {
      repository = MockUserProfileRepository();
      usecase = RejectUser(repository: repository);
    },
  );

  test(
    'should return [Voidresult] from repository when RejectUser is called',
    () async {
      // arrange
      when(() => repository.rejectUser(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase('');
      // assert
      expect(result, Right<Failure, VoidResult>(VoidResult()));
    },
  );
}
