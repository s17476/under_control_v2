import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/shimmer_user_list_tile.dart';
import 'package:under_control_v2/features/core/presentation/widgets/user_list_tile.dart';
import 'package:under_control_v2/features/user_profile/presentation/pages/users_list_page.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/presentation/widgets/asset_tile.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../company_profile/presentation/blocs/new_users/new_users_bloc.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../tasks/presentation/blocs/task/task_bloc.dart';
import '../../../tasks/presentation/blocs/work_request/work_request_bloc.dart';
import '../../../tasks/presentation/widgets/task_details/shimmer_task_action_tile.dart';
import '../../../tasks/presentation/widgets/task_tile.dart';
import '../../../tasks/presentation/widgets/work_request_tile.dart';
import '../../domain/entities/notification_type.dart';
import '../../domain/entities/uc_notification.dart';

class NotificationTile extends StatelessWidget {
  final UcNotification notification;

  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (notification.type) {
      case NotificationType.workRequests:
        return BlocBuilder<WorkRequestBloc, WorkRequestState>(
          builder: (context, state) {
            if (state is WorkRequestLoadedState) {
              final workRequest =
                  state.getWorkRequestById(notification.connectedId);
              if (workRequest != null) {
                return WorkRequestTile(
                  workRequest: workRequest,
                  notification: notification,
                );
              }
              return const InfoTile();
            }
            return const ShimmerTaskActionTile();
          },
        );
      case NotificationType.tasks:
        return BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadedState) {
              final task = state.getTaskById(notification.connectedId);
              if (task != null) {
                return TaskTile(
                  task: task,
                  notification: notification,
                );
              }
              return const InfoTile();
            }
            return const ShimmerTaskActionTile();
          },
        );
      case NotificationType.assets:
        return BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            if (state is AssetLoadedState) {
              final asset = state.getAssetById(notification.connectedId);
              if (asset != null) {
                return AssetTile(
                  asset: asset,
                  searchQuery: '',
                  notification: notification,
                );
              }
              return const InfoTile();
            }
            return const ShimmerTaskActionTile();
          },
        );
      case NotificationType.items:
        return BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsLoadedState) {
              final item = state.getItemById(notification.connectedId);
              if (item != null) {
                return ItemTile(
                  item: item,
                  searchQuery: '',
                  notification: notification,
                );
              }
              return const InfoTile();
            }
            return const ShimmerTaskActionTile();
          },
        );
      case NotificationType.newUser:
        return BlocBuilder<NewUsersBloc, NewUsersState>(
          builder: (context, state) {
            if (state is NewUsersLoadedState) {
              final user = state.getUserById(notification.connectedId);
              if (user != null) {
                return UserListTile(
                  user: user,
                  onTap: (_) =>
                      Navigator.pushNamed(context, UsersListPage.routeName),
                );
              }
              return const InfoTile();
            }
            return const ShimmerUserListTile();
          },
        );
      default:
        return const ShimmerTaskActionTile();
    }
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          const Icon(Icons.location_off),
          const SizedBox(
            width: 4,
          ),
          Text(
            AppLocalizations.of(context)!.notification_not_selected_location,
          ),
        ],
      ),
    );
  }
}
