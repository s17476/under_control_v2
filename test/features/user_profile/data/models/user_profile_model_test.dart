import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';

void main() {
  const tUserProfileModel = UserProfileModel(
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
  const tUserProfileModelMap = {
    'firstName': 'firstName',
    'lastName': 'lastName',
    'email': 'email',
    'phoneNumber': 'phoneNumber',
    'avatarUrl': 'avatarUrl',
    'userGroups': ['userGroups'],
    'locations': ['locations'],
    'companyId': 'companyId',
    'approved': false,
    'rejected': false,
    'suspended': false,
    'administrator': false,
  };

  group('UserPorfile', () {
    test(
      'should be a subclass of [UserProfile] entity',
      () async {
        // assert
        expect(tUserProfileModel, isA<UserProfile>());
      },
    );

    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = UserProfileModel.fromMap(
            tUserProfileModelMap, tUserProfileModel.id);
        // assert
        expect(result, tUserProfileModel);
      },
    );

    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tUserProfileModel.toMap();
        // assert
        expect(result, tUserProfileModelMap);
      },
    );
  });
}
