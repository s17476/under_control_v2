import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/notifications/data/models/uc_notification_model.dart';
import 'package:under_control_v2/features/notifications/domain/entities/notification_type.dart';

final tNotificationDate = DateTime(2023);

final tUcNotificationModel = UcNotificationModel(
  id: 'id',
  type: NotificationType.tasks,
  code: 'code',
  connectedId: 'connectedId',
  read: false,
  date: tNotificationDate,
);

final tUcNotificationToMap = {
  'type': NotificationType.tasks.name,
  'code': 'code',
  'connectedId': 'connectedId',
  'read': false,
  'date': tNotificationDate,
};

final tUcNotificationFromMap = {
  'type': NotificationType.tasks.name,
  'code': 'code',
  'connectedId': 'connectedId',
  'read': false,
  'date': Timestamp.fromDate(tNotificationDate),
};
