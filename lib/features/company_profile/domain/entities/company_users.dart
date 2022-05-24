import 'package:equatable/equatable.dart';

class CompanyUsers extends Equatable {
  final Stream allUsers;

  const CompanyUsers({
    required this.allUsers,
  });

  @override
  List<Object> get props => [allUsers];

  @override
  String toString() => 'CompanyUsers(allUsers: $allUsers)';
}
