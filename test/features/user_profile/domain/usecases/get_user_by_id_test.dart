import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';
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

  final tUserProfile = UserProfileModel(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    phoneNumber: 'phoneNumber',
    avatarUrl: 'avatarUrl',
    userGroups: const ['userGroups'],
    locations: const ['locations'],
    deviceTokens: const ['deviceTokens'],
    companyId: 'companyId',
    approved: false,
    rejected: false,
    suspended: false,
    isActive: false,
    administrator: false,
    joinDate: DateTime.now(),
  );

  test(
    'UserPorfile should return [UserProfile] from repository when getUserById is called',
    () async {
      // arrange
      when(() => repository.getUserById(any()))
          .thenAnswer((_) async => Right(tUserProfile));
      // act
      final result = await usecase('');

      // assert
      expect(result, Right<Failure, UserProfile>(tUserProfile));
    },
  );
}
