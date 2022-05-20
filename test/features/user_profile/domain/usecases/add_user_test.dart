import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late AddUser usecase;
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
      usecase = AddUser(repository: repository);
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
    'should return [String] from repository when AddUser is called',
    () async {
      // arrange
      when(() => repository.addUser(any()))
          .thenAnswer((_) async => const Right(''));
      // act
      final result = await usecase(tUserProfile);
      // assert
      expect(result, const Right<Failure, String>(''));
    },
  );
}
