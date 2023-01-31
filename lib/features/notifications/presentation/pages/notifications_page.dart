import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/task_details/shimmer_task_action_tile.dart';

import '../blocs/uc_notification/uc_notification_bloc.dart';
import '../widgets/dismissible_notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notifications),
      ),
      body: BlocBuilder<UcNotificationBloc, UcNotificationState>(
        builder: (context, state) {
          if (state is UcNotificationLoaded) {
            final notifications = state.allNotifications.allNotifications;
            if (notifications.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.notifications_no_unread,
                  ),
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) => DismissibleNotificationTile(
                notification: notifications[index],
                onlyDelete: true,
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            itemCount: 3,
            itemBuilder: (context, index) => const ShimmerAssetActionListTile(),
          );
        },
      ),
    );
  }
}
