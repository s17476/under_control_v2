import '../../domain/entities/company_users.dart';

class CompanyUsersModel extends CompanyUsers {
  const CompanyUsersModel({
    required Stream allUsers,
  }) : super(allUsers: allUsers);

  Future<int> get allUsersCount async => allUsers.length;
}
