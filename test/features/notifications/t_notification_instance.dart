import 'package:under_control_v2/features/notifications/data/models/uc_notification_model.dart';
import 'package:under_control_v2/features/notifications/domain/entities/notification_type.dart';

const tUcNotificationModel = UcNotificationModel(
  id: 'id',
  type: NotificationType.tasks,
  code: 'code',
  connectedId: 'connectedId',
  read: false,
);

final tUcNotificationToMap = {
  'type': NotificationType.tasks.name,
  'code': 'code',
  'connectedId': 'connectedId',
  'read': false,
};

final tUcNotificationFromMap = {
  'type': NotificationType.tasks.name,
  'code': 'code',
  'connectedId': 'connectedId',
  'read': false,
};
