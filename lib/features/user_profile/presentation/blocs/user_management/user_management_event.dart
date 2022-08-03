part of 'user_management_bloc.dart';

abstract class UserManagementEvent extends Equatable {
  const UserManagementEvent({
    required this.userId,
    this.properties = const [],
  });

  final String userId;
  final List properties;

  @override
  List<Object> get props => [userId, properties];
}

class ApproveUserEvent extends UserManagementEvent {
  const ApproveUserEvent({required super.userId});
}

class ApproveUserAndMakeAdminEvent extends UserManagementEvent {
  const ApproveUserAndMakeAdminEvent({required super.userId});
}

class RejectUserEvent extends UserManagementEvent {
  const RejectUserEvent({required super.userId});
}

class SuspendUserEvent extends UserManagementEvent {
  const SuspendUserEvent({required super.userId});
}

class UnsuspendUserEvent extends UserManagementEvent {
  const UnsuspendUserEvent({required super.userId});
}

class AssignUserToGroupEvent extends UserManagementEvent {
  final String groupId;
  const AssignUserToGroupEvent({
    required this.groupId,
    required super.userId,
  });
}

class UnassignUserFromGroupEvent extends UserManagementEvent {
  final String groupId;
  const UnassignUserFromGroupEvent({
    required this.groupId,
    required super.userId,
  });
}

class AssignGroupAdminEvent extends UserManagementEvent {
  final String groupId;
  final String companyId;
  const AssignGroupAdminEvent({
    required this.groupId,
    required this.companyId,
    required super.userId,
  });
}

class UnassignGroupAdminEvent extends UserManagementEvent {
  final String groupId;
  final String companyId;
  const UnassignGroupAdminEvent({
    required this.groupId,
    required this.companyId,
    required super.userId,
  });
}
