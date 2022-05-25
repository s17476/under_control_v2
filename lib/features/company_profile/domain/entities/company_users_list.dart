import 'package:equatable/equatable.dart';

import '../../../user_profile/domain/entities/user_profile.dart';

class CompanyUsersList extends Equatable {
  final List<UserProfile> allUsers;

  const CompanyUsersList({
    required this.allUsers,
  });

  @override
  List<Object> get props => [allUsers];

  @override
  String toString() => 'CompanyUsers(allUsers: $allUsers)';
}
