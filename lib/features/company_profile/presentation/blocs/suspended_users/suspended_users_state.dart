part of 'suspended_users_bloc.dart';

abstract class SuspendedUsersState extends Equatable {
  const SuspendedUsersState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });
  final List properties;
  final String message;
  final bool error;

  @override
  List<Object> get props => [properties, message, error];
}

class SuspendedUsersEmptyState extends SuspendedUsersState {}

class SuspendedUsersErrorState extends SuspendedUsersState {
  const SuspendedUsersErrorState({
    super.message,
    super.error = true,
  });
}

class SuspendedUsersLoadingState extends SuspendedUsersState {}

class SuspendedUsersLoadedState extends SuspendedUsersState {
  final CompanyUsersList suspendedUsers;
  SuspendedUsersLoadedState({
    required this.suspendedUsers,
  }) : super(properties: [suspendedUsers]);
}
