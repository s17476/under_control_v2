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
  final List<String> deviceTokens;
  final String companyId;
  final bool approved;
  final bool rejected;
  final bool suspended;
  final bool isActive;
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
    required this.deviceTokens,
    required this.companyId,
    required this.approved,
    required this.rejected,
    required this.suspended,
    required this.isActive,
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
      deviceTokens,
      companyId,
      approved,
      rejected,
      suspended,
      isActive,
      administrator,
      joinDate,
    ];
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, userGroups: $userGroups, locations: $locations, deviceTokens: $deviceTokens, companyId: $companyId, approved: $approved, rejected: $rejected, suspended: $suspended, isActive: $isActive, administrator: $administrator, joinDate: $joinDate)';
  }
}
