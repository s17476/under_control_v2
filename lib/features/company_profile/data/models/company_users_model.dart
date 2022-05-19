import 'package:under_control_v2/features/company_profile/domain/entities/company_user.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users.dart';

class CompanyUsersModel extends CompanyUsers {
  const CompanyUsersModel({
    required List<CompanyUser> allUsers,
  }) : super(allUsers: allUsers);

  int get allUsersCount => allUsers.length;
}
