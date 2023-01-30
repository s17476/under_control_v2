import 'package:equatable/equatable.dart';

import 'uc_notification.dart';

class UcNotificationsList extends Equatable {
  final List<UcNotification> allNotifications;

  const UcNotificationsList({
    required this.allNotifications,
  });

  @override
  List<Object> get props => [allNotifications];

  @override
  String toString() =>
      'UcNotificationsList(allNotifications: $allNotifications)';
}
