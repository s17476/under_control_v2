import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../notifications/presentation/blocs/bloc/uc_notification_bloc.dart';

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
          if (state.allNotifications.allNotifications.isEmpty) {
            return Icon(
              Icons.notifications,
              color: Theme.of(context).textTheme.caption!.color!.withAlpha(60),
            );
          } else {
            final count = state.allNotifications.allNotifications.length;
            return Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_sharp,
                  color: !isExpanded
                      ? Theme.of(context).textTheme.headline6!.color
                      : Theme.of(context).primaryColor.withAlpha(130),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isExpanded
                            ? Theme.of(context).textTheme.headline6!.color
                            : Theme.of(context).primaryColor.withAlpha(130),
                      ),
                      child: Text(
                        count > 99 ? '99+' : count.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: !isExpanded
                              ? Theme.of(context).textTheme.headline6!.color
                              : Theme.of(context).primaryColor.withAlpha(130),
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
