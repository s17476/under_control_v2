import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  late GetUserById usecase;
  late MockUserProfileRepository repository;

  setUp(
    () {
      repository = MockUserProfileRepository();
      usecase = GetUserById(repository: repository);
    },
  );

  const tUserProfile = UserProfile(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    phoneNumber: 'phoneNumber',
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
    'UserPorfile should return [UserProfile] from repository when getUserById is called',
    () async {
      // arrange
      when(() => repository.getUserById(any()))
          .thenAnswer((_) async => const Right(tUserProfile));
      // act
      final result = await usecase('');

      // assert
      expect(result, const Right<Failure, UserProfile>(tUserProfile));
    },
  );
}
