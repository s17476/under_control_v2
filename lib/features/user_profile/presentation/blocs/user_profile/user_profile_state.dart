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
class UserProfileEmpty extends UserProfileState {}

class NoUserProfileError extends UserProfileState {
  const NoUserProfileError({
    super.message,
    super.error = true,
  });
}

class DatabaseErrorUserProfile extends UserProfileState {
  const DatabaseErrorUserProfile({
    super.message,
    super.error = true,
  });
}

class ValidationErrorUserProfile extends UserProfileState {
  const ValidationErrorUserProfile({
    super.message,
    super.error = true,
  });
}

// loading
class Loading extends UserProfileState {}

// user without company assigned
class NoCompanyState extends UserProfileState {
  final UserProfile userProfile;

  NoCompanyState({
    String message = '',
    bool error = false,
    required this.userProfile,
  }) : super(
          message: message,
          error: error,
          properties: [userProfile],
        );
}

// user with company and awaiting approvement
class NotApproved extends UserProfileState {
  final UserProfile userProfile;

  NotApproved({
    String message = '',
    bool error = false,
    required this.userProfile,
  }) : super(
          message: message,
          error: error,
          properties: [userProfile],
        );
}

// user rejected
class Rejected extends UserProfileState {
  final UserProfile userProfile;

  Rejected({
    String message = '',
    bool error = false,
    required this.userProfile,
  }) : super(
          message: message,
          error: error,
          properties: [userProfile],
        );
}

// user suspended
class Suspended extends UserProfileState {
  final UserProfile userProfile;

  Suspended({
    String message = '',
    bool error = false,
    required this.userProfile,
  }) : super(
          message: message,
          error: error,
          properties: [userProfile],
        );
}
