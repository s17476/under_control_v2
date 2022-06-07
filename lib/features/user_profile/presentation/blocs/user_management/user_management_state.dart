part of 'user_management_bloc.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();
  
  @override
  List<Object> get props => [];
}

class UserManagementInitial extends UserManagementState {}
