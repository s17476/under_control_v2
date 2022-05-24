part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [];
}

class AddUserEvent extends UserProfileEvent {
  final UserProfile userProfile;
  final File? avatar;

  AddUserEvent({
    required this.userProfile,
    required this.avatar,
  }) : super([
          userProfile,
          avatar,
        ]);
}

// class ApproveUserEvent extends UserProfileEvent {
//   final String userId;

//   ApproveUserEvent({
//     required this.userId,
//   }) : super([userId]);
// }

class AssignToCompanyEvent extends UserProfileEvent {
  final UserProfile userProfile;
  final String companyId;

  AssignToCompanyEvent({
    required this.userProfile,
    required this.companyId,
  }) : super([userProfile, companyId]);
}

class GetUserByIdEvent extends UserProfileEvent {
  final String userId;

  GetUserByIdEvent({
    required this.userId,
  }) : super([userId]);
}

// class RejectUserEvent extends UserProfileEvent {
//   final String userId;
//   RejectUserEvent({
//     required this.userId,
//   }) : super([userId]);
// }

// class SuspendEvent extends UserProfileEvent {
//   final String userId;
//   SuspendEvent({
//     required this.userId,
//   }) : super([userId]);
// }

class UpdateUserDataEvent extends UserProfileEvent {
  final UserProfile userProfile;

  UpdateUserDataEvent({required this.userProfile})
      : super([
          userProfile,
        ]);
}
