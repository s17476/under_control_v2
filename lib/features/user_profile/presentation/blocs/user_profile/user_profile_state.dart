part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [properties];
}

// approved user
class Approved extends UserProfileState {
  final UserProfile userProfile;

  Approved({
    required this.userProfile,
  }) : super([userProfile]);
}

// initial state
class EmptyUserProfileState extends UserProfileState {}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError({
    required this.message,
  }) : super([message]);
}

class DatabaseError extends UserProfileState {
  final String message;

  DatabaseError({
    required this.message,
  }) : super([message]);
}

// loading
class Loading extends UserProfileState {}

// user without company assigned
class NoCompany extends UserProfileState {
  final UserProfile userProfile;

  NoCompany({
    required this.userProfile,
  }) : super([userProfile]);
}

// user with company and awaiting approvement
class NotApproved extends UserProfileState {
  final UserProfile userProfile;

  NotApproved({
    required this.userProfile,
  }) : super([userProfile]);
}

// user not approved
class Rejected extends UserProfileState {
  final UserProfile userProfile;

  Rejected({
    required this.userProfile,
  }) : super([userProfile]);
}

// user suspended
class Suspended extends UserProfileState {
  final UserProfile userProfile;

  Suspended({
    required this.userProfile,
  }) : super([userProfile]);
}
