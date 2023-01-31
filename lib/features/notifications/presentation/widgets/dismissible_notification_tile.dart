import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/uc_notification.dart';
import '../blocs/uc_notification_management/uc_notification_management_bloc.dart';
import 'notification_tile.dart';

class DismissibleNotificationTile extends StatelessWidget {
  const DismissibleNotificationTile({
    super.key,
    required this.notification,
    this.onlyDelete = false,
  });

  final UcNotification notification;
  final bool onlyDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(notification.id),
      background: Container(
        alignment: Alignment.centerLeft,
        child: Icon(
          onlyDelete ? Icons.delete : Icons.done,
          size: 48,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 48,
        ),
      ),
      onDismissed: (direction) {
        if (onlyDelete || direction == DismissDirection.endToStart) {
          context.read<UcNotificationManagementBloc>().add(
                DeleteNotificationEvent(
                  notificationId: notification.id,
                ),
              );
        } else {
          context.read<UcNotificationManagementBloc>().add(
                MarkAsReadEvent(
                  notificationId: notification.id,
                ),
              );
        }
      },
      child: NotificationTile(
        notification: notification,
      ),
    );
  }
}
