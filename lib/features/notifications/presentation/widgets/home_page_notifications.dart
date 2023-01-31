import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/presentation/widgets/glass_layer.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../blocs/uc_notification/uc_notification_bloc.dart';
import '../pages/notifications_page.dart';
import 'dismissible_notification_tile.dart';

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
                      BlocBuilder<UcNotificationBloc, UcNotificationState>(
                        builder: (context, state) {
                          if (state is UcNotificationLoaded) {
                            final unreadNotifications = state
                                .allNotifications.allNotifications
                                .where((notification) => !notification.read)
                                .toList();
                            if (unreadNotifications.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .notifications_no_unread,
                                  ),
                                ),
                              );
                            }
                            return ListView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                // notifications title
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 12,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: IconTitleRow(
                                          icon: Icons
                                              .notification_important_sharp,
                                          iconColor: Colors.grey.shade200,
                                          iconBackground:
                                              Theme.of(context).primaryColor,
                                          title: AppLocalizations.of(context)!
                                              .notifications_unread,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            NotificationsPage.routeName,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .show_all,
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ...unreadNotifications.map(
                                  (notification) => DismissibleNotificationTile(
                                    key: ValueKey(notification.id),
                                    notification: notification,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            );
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            itemCount: 3,
                            itemBuilder: (context, index) =>
                                const ShimmerAssetActionListTile(),
                          );
                        },
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
