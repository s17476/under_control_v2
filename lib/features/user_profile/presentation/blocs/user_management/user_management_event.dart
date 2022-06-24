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
  const ApproveUserEvent({required String userId}) : super(userId: userId);
}

class ApproveUserAndMakeAdminEvent extends UserManagementEvent {
  const ApproveUserAndMakeAdminEvent({required String userId})
      : super(userId: userId);
}

class RejectUserEvent extends UserManagementEvent {
  const RejectUserEvent({required String userId}) : super(userId: userId);
}

class SuspendUserEvent extends UserManagementEvent {
  const SuspendUserEvent({required String userId}) : super(userId: userId);
}
