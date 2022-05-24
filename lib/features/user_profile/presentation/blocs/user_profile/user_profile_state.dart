part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState(
      {this.message = '', this.error = false, this.properties = const []});
  final String message;
  final bool error;
  final List properties;

  @override
  List<Object> get props => [message, error, properties];
}

// approved user
class Approved extends UserProfileState {
  final UserProfile userProfile;

  Approved({
    required this.userProfile,
  }) : super(properties: [userProfile]);
}

// initial state
class EmptyUserProfileState extends UserProfileState {}

class NoUserProfileError extends UserProfileState {
  final String msg;
  final bool err;
  const NoUserProfileError({
    this.msg = '',
    this.err = true,
  }) : super(
          message: msg,
          error: err,
        );
}

class DatabaseErrorUserProfile extends UserProfileState {
  final String msg;
  final bool err;
  const DatabaseErrorUserProfile({
    required this.msg,
    this.err = true,
  }) : super(
          message: msg,
          error: err,
        );
}

class ValidationErrorUserProfile extends UserProfileState {
  final String msg;
  final bool err;
  const ValidationErrorUserProfile({
    required this.msg,
    this.err = true,
  }) : super(
          message: msg,
          error: err,
        );
}

// loading
class Loading extends UserProfileState {}

// user without company assigned
class NoCompany extends UserProfileState {
  final String msg;
  final bool err;
  final UserProfile userProfile;

  NoCompany({
    this.msg = '',
    this.err = false,
    required this.userProfile,
  }) : super(
          message: msg,
          error: err,
          properties: [userProfile],
        );
}

// user with company and awaiting approvement
class NotApproved extends UserProfileState {
  final String msg;
  final bool err;
  final UserProfile userProfile;

  NotApproved({
    this.msg = '',
    this.err = false,
    required this.userProfile,
  }) : super(
          message: msg,
          error: err,
          properties: [userProfile],
        );
}

// user rejected
class Rejected extends UserProfileState {
  final String msg;
  final bool err;
  final UserProfile userProfile;

  Rejected({
    this.msg = '',
    this.err = false,
    required this.userProfile,
  }) : super(
          message: msg,
          error: err,
          properties: [userProfile],
        );
}

// user suspended
class Suspended extends UserProfileState {
  final String msg;
  final bool err;
  final UserProfile userProfile;

  Suspended({
    this.msg = '',
    this.err = false,
    required this.userProfile,
  }) : super(
          message: msg,
          error: err,
          properties: [userProfile],
        );
}
