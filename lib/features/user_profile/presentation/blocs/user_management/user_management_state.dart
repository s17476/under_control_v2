part of 'user_management_bloc.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState({
    this.message = '',
    this.error = false,
  });
  final bool error;
  final String message;

  @override
  List<Object> get props => [message];
}

class UserManagementEmpty extends UserManagementState {}

class UserManagementLoading extends UserManagementState {}

class UserManagementSuccessful extends UserManagementState {
  const UserManagementSuccessful({
    super.message,
    super.error,
  });
}

class UserManagementError extends UserManagementState {
  const UserManagementError({super.message});
}
