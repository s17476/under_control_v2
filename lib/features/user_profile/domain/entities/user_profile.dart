import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String avatarUrl;
  final List<String> userGroups;
  final List<String> locations;
  final String companyId;
  final bool approved;
  final bool rejected;
  final bool suspended;
  final bool administrator;
  final DateTime joinDate;

  const UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.userGroups,
    required this.locations,
    required this.companyId,
    required this.approved,
    required this.rejected,
    required this.suspended,
    required this.administrator,
    required this.joinDate,
  });

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      avatarUrl,
      userGroups,
      locations,
      companyId,
      approved,
      rejected,
      suspended,
      administrator,
      joinDate,
    ];
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, userGroups: $userGroups, locations: $locations, companyId: $companyId, approved: $approved, rejected: $rejected, suspended: $suspended, administrator: $administrator, joinDate: $joinDate)';
  }
}
