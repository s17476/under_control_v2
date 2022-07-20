import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_users_list_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users_list.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';

void main() {
  final tUserProfile = UserProfileModel.newUser(
    firstName: 'firstName',
    lastName: 'lastName',
    phoneNumber: 'phoneNumber',
  );
  final tCompanyUsers = CompanyUsersListModel(allUsers: [tUserProfile]);

  test(
    'Company Profile should be a subclass of [CompanyUserList] entity',
    () async {
      // assert
      expect(tCompanyUsers, isA<CompanyUsersList>());
    },
  );
}
