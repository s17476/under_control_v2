import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../notifications/presentation/blocs/uc_notification/uc_notification_bloc.dart';

class NotificationsIcon extends StatelessWidget {
  final bool isExpanded;
  const NotificationsIcon({
    Key? key,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UcNotificationBloc, UcNotificationState>(
      builder: (context, state) {
        if (state is UcNotificationLoaded) {
          final count = state.allNotifications.allNotifications
              .where((notification) => !notification.read)
              .length;
          if (count == 0) {
            return Icon(
              Icons.notifications,
              color:
                  Theme.of(context).textTheme.bodySmall!.color!.withAlpha(60),
            );
          } else {
            return Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_sharp,
                  color: !isExpanded
                      ? Theme.of(context).iconTheme.color
                      : Theme.of(context).primaryColor.withAlpha(130),
                ),
                Positioned(
                  top: 2,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isExpanded
                            ? Theme.of(context).textTheme.titleLarge!.color
                            : Theme.of(context).primaryColor.withAlpha(130),
                      ),
                      child: Text(
                        count > 99 ? '99+' : count.toString(),
                        style: TextStyle(
                          fontSize: 8,
                          color: !isExpanded
                              ? Theme.of(context).textTheme.titleLarge!.color
                              : Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
