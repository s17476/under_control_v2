part of 'uc_notification_management_bloc.dart';

abstract class UcNotificationManagementEvent extends Equatable {
  final String notificationId;
  const UcNotificationManagementEvent({
    required this.notificationId,
  });

  @override
  List<Object> get props => [notificationId];
}

class MarkAsUnreadEvent extends UcNotificationManagementEvent {
  const MarkAsUnreadEvent({required super.notificationId});
}

class MarkAsReadEvent extends UcNotificationManagementEvent {
  const MarkAsReadEvent({required super.notificationId});
}

class DeleteNotificationEvent extends UcNotificationManagementEvent {
  const DeleteNotificationEvent({required super.notificationId});
}
