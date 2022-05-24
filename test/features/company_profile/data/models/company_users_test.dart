import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_users_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';

void main() {
  final tUserProfile = UserProfileModel.newUser(
    firstName: 'firstName',
    lastName: 'lastName',
    phoneNumber: 'phoneNumber',
  );
  final tCompanyUsers =
      CompanyUsersModel(allUsers: Stream.fromIterable([tUserProfile]));

  test(
    'should be a subclass of [CompanyUser] entity',
    () async {
      // assert
      expect(tCompanyUsers, isA<CompanyUsers>());
    },
  );
}
