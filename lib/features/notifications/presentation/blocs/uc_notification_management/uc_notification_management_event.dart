part of 'items_management_bloc.dart';

abstract class UcNotificationManagementEvent extends Equatable {
  final UcNotification notification;
  const UcNotificationManagementEvent({
    required this.notification,
  });

  @override
  List<Object> get props => [notification];
}

class MarkAsUnreadEvent extends UcNotificationManagementEvent {
  const MarkAsUnreadEvent({required super.notification});
}

class MarkAsReadEvent extends UcNotificationManagementEvent {
  const MarkAsReadEvent({required super.notification});
}

class DeleteNotificationEvent extends UcNotificationManagementEvent {
  const DeleteNotificationEvent({required super.notification});
}
