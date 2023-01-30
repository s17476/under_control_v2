import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/notifications/data/models/uc_notification_model.dart';
import 'package:under_control_v2/features/notifications/domain/entities/uc_notification.dart';
import 'package:under_control_v2/features/notifications/domain/entities/uc_notifications_list.dart';

class UcNotificationsListModel extends UcNotificationsList {
  const UcNotificationsListModel({required super.allNotifications});

  factory UcNotificationsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<UcNotification> notificationslist = [];
    notificationslist = snapshot.docs
        .map(
          (DocumentSnapshot doc) => UcNotificationModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();
    return UcNotificationsListModel(allNotifications: notificationslist);
  }
}
