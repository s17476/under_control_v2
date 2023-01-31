import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/notifications/presentation/widgets/notification_tile.dart';

import '../../../core/presentation/widgets/glass_layer.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../blocs/bloc/uc_notification_bloc.dart';

class HomePageNotifications extends StatelessWidget {
  const HomePageNotifications({
    Key? key,
    required this.isNotificationsExpanded,
    required this.onDismiss,
  }) : super(key: key);

  final bool isNotificationsExpanded;
  final Function onDismiss;

  @override
  Widget build(BuildContext context) {
    if (!isNotificationsExpanded) {
      return const SizedBox();
    } else {
      return GlassLayer(
        onDismiss: onDismiss,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ),
          builder: (context, Offset offset, child) {
            return FractionalTranslation(
              translation: offset,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0.5),
                        color: Colors.grey.shade700,
                        blurRadius: 3,
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // notifications title
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 12,
                          bottom: 8,
                        ),
                        child: IconTitleRow(
                          icon: Icons.notification_important_sharp,
                          iconColor: Colors.grey.shade200,
                          iconBackground: Theme.of(context).primaryColor,
                          title: AppLocalizations.of(context)!
                              .notifications_unread,
                        ),
                      ),
                      BlocBuilder<UcNotificationBloc, UcNotificationState>(
                        builder: (context, state) {
                          if (state is UcNotificationLoaded) {
                            final unreadNotifications = state
                                .allNotifications.allNotifications
                                .where((notification) => !notification.read)
                                .toList();
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 8,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: unreadNotifications.length,
                              itemBuilder: (context, index) => NotificationTile(
                                key: ValueKey(unreadNotifications[index].id),
                                notification: unreadNotifications[index],
                              ),
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
