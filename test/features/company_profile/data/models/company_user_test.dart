import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_user_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_user.dart';

void main() {
  const tCompanyUser = CompanyUserModel(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    avatarUrl: 'avatarUrl',
  );

  test(
    'should be a subclass of [CompanyUser] entity',
    () async {
      // assert
      expect(tCompanyUser, isA<CompanyUser>());
    },
  );

  test(
    'should return a valid model from a map',
    () async {
      // act
      final result = CompanyUserModel.fromMap(tCompanyUser.toMap());
      // assert
      expect(result, tCompanyUser);
    },
  );
}
