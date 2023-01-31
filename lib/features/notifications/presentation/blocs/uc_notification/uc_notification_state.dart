part of 'uc_notification_bloc.dart';

abstract class UcNotificationState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const UcNotificationState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class UcNotificationEmpty extends UcNotificationState {}

class UcNotificationLoading extends UcNotificationState {}

class UcNotificationError extends UcNotificationState {
  const UcNotificationError({
    super.message,
    super.error = true,
  });
}

class UcNotificationLoaded extends UcNotificationState {
  final UcNotificationsListModel allNotifications;
  UcNotificationLoaded({
    required this.allNotifications,
  }) : super(properties: [allNotifications]);
}
