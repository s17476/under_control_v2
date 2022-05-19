import 'package:equatable/equatable.dart';

import 'company_user.dart';

class CompanyUsers extends Equatable {
  final List<CompanyUser> allUsers;

  const CompanyUsers({
    required this.allUsers,
  });

  @override
  List<Object> get props => [allUsers];

  @override
  String toString() => 'CompanyUsers(allUsers: $allUsers)';
}
