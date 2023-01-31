part of 'uc_notification_bloc.dart';

abstract class UcNotificationEvent extends Equatable {
  final List properties;
  const UcNotificationEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetNotificationsStreamEvent extends UcNotificationEvent {
  final UserProfile userProfile;
  GetNotificationsStreamEvent({
    required this.userProfile,
  }) : super(properties: [userProfile]);
}

class ResetEvent extends UcNotificationEvent {}

class UpdateNotificationsListEvent extends UcNotificationEvent {
  final QuerySnapshot<Object?> snapshot;

  UpdateNotificationsListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
