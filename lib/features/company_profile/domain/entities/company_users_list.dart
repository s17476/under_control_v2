import 'package:equatable/equatable.dart';

import '../../../user_profile/domain/entities/user_profile.dart';

class CompanyUsersList extends Equatable {
  final List<UserProfile> activeUsers;
  final List<UserProfile> passiveUsers;

  const CompanyUsersList({
    required this.activeUsers,
    required this.passiveUsers,
  });

  @override
  List<Object> get props => [activeUsers, passiveUsers];

  @override
  String toString() =>
      'CompanyUsersList(allUsers: $activeUsers, passiveUsers: $passiveUsers)';
}
