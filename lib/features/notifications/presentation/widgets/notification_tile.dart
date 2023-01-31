import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/notifications/domain/entities/notification_type.dart';

import 'package:under_control_v2/features/notifications/domain/entities/uc_notification.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/task_details/shimmer_task_action_tile.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/work_request_tile.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/presentation/widgets/asset_tile.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../tasks/presentation/blocs/task/task_bloc.dart';
import '../../../tasks/presentation/blocs/work_request/work_request_bloc.dart';
import '../../../tasks/presentation/widgets/task_tile.dart';

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
              return const SizedBox();
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
              return const SizedBox();
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
              return const SizedBox();
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
                );
              }
              return const SizedBox();
            }
            return const ShimmerTaskActionTile();
          },
        );
      default:
        return const ShimmerTaskActionTile();
    }
  }
}
