import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late UpdateUserData usecase;
  late MockUserProfileRepository repository;

  setUpAll(() {
    registerFallbackValue(const UserProfile(
      id: 'id',
      firstName: 'firstName',
      lastName: 'lastName',
      email: 'email',
      avatarUrl: 'avatarUrl',
      userGroups: ['userGroups'],
      locations: ['locations'],
      companyId: 'companyId',
      approved: false,
      rejected: false,
      suspended: false,
      administrator: false,
    ));
  });

  setUp(
    () {
      repository = MockUserProfileRepository();
      usecase = UpdateUserData(repository: repository);
    },
  );

  const tUserProfile = UserProfile(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    avatarUrl: 'avatarUrl',
    userGroups: ['userGroups'],
    locations: ['locations'],
    companyId: 'companyId',
    approved: false,
    rejected: false,
    suspended: false,
    administrator: false,
  );

  test(
    'should return [Voidresult] from repository when UpdateUserData is called',
    () async {
      // arrange
      when(() => repository.updateUserdata(any()))
          .thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(tUserProfile);
      // assert
      expect(result, Right<Failure, VoidResult>(VoidResult()));
    },
  );
}
