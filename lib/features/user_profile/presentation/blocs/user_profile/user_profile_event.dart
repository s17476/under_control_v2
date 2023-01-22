part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [properties];
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

class AssignToCompanyEvent extends UserProfileEvent {
  final UserProfile userProfile;
  final String companyId;

  AssignToCompanyEvent({
    required this.userProfile,
    required this.companyId,
  }) : super([userProfile, companyId]);
}

class ResetCompanyEvent extends UserProfileEvent {
  final UserProfile userProfile;

  ResetCompanyEvent({
    required this.userProfile,
  }) : super([userProfile]);
}

class GetUserByIdEvent extends UserProfileEvent {
  final String userId;

  GetUserByIdEvent({
    required this.userId,
  }) : super([userId]);
}

class UpdateUserProfileEvent extends UserProfileEvent {
  final DocumentSnapshot<Object?> snapshot;
  UpdateUserProfileEvent({required this.snapshot}) : super([snapshot]);
}

class ResetEvent extends UserProfileEvent {}
