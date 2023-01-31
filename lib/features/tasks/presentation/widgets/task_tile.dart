import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/notifications/domain/entities/uc_notification.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../notifications/presentation/blocs/uc_notification_management/uc_notification_management_bloc.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/task/task.dart';
import '../../utils/get_task_priority_and_type_icon.dart';
import '../pages/task_details_page.dart';
import '../pages/task_template_details_page.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
    this.isTemplate = false,
    this.notification,
  }) : super(key: key);

  final Task task;
  final bool isTemplate;
  final UcNotification? notification;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 25),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: isTemplate
                  ? () => Navigator.pushNamed(
                        context,
                        TaskTemplateDetailsPage.routeName,
                        arguments: task.id,
                      )
                  : () {
                      if (notification != null) {
                        context.read<UcNotificationManagementBloc>().add(
                              MarkAsReadEvent(
                                notificationId: notification!.id,
                              ),
                            );
                      }
                      Navigator.pushNamed(
                        context,
                        TaskDetailsPage.routeName,
                        arguments: task.id,
                      );
                    },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 8,
                  top: 8,
                  bottom: 8,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // notification info
                    if (notification != null) ...[
                      Text(
                        AppLocalizations.of(context)!.notifications_tasks_tile,
                        style: notification!.read
                            ? null
                            : TextStyle(
                                color: Theme.of(context).highlightColor,
                              ),
                      ),
                      const Divider(),
                    ],
                    // date
                    if (!isTemplate)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                          children: [
                            ProgressIcon(task: task),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.build,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .color,
                                        size: 10,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: Text(
                                          dateFormat.format(task.executionDate),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      if (task.isCyclictask)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.refresh,
                                            size: 14,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .color,
                                          ),
                                        ),
                                      Text(
                                        '#${task.count}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  ProgressText(task: task),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    // shows asset data if work order is connected to an asset
                    if (task.assetId.isNotEmpty)
                      ConnectedAsset(assetId: task.assetId),
                    // shows info if work order is not connected to an asset
                    if (task.assetId.isEmpty) const NoAssetInfo(),

                    // title
                    TaskTitle(taskTitle: task.title),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        // task author
                        BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
                          builder: (context, state) {
                            final UserProfile? author;
                            if (state is CompanyProfileLoaded) {
                              author = state.getUserById(task.userId);
                              if (author != null) {
                                return TaskAuthor(author: author);
                              }
                            }
                            return const Expanded(child: SizedBox());
                          },
                        ),
                        // image icon
                        if (task.images.isNotEmpty)
                          Row(
                            children: [
                              if (task.images.length > 1)
                                Text(
                                  '${task.images.length}x',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 14),
                                ),
                              FaIcon(
                                FontAwesomeIcons.image,
                                size: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        // video icon
                        if (task.video.isNotEmpty)
                          FaIcon(
                            FontAwesomeIcons.play,
                            size: 18,
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // assigned users
                    if (task.assignedUsers.isNotEmpty)
                      BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
                        builder: (context, state) {
                          List<UserProfile> assignedUsers = [];
                          if (state is CompanyProfileLoaded) {
                            for (var userId in task.assignedUsers) {
                              final usr = state.getUserById(userId);
                              if (usr != null) {
                                assignedUsers.add(usr);
                              }
                            }
                          }
                          return AssignedUsers(assignedUsers: assignedUsers);
                        },
                      ),

                    // assigned groups
                    if (task.assignedGroups.isNotEmpty)
                      BlocBuilder<GroupBloc, GroupState>(
                        builder: (context, state) {
                          List<Group> assignedGroups = [];
                          if (state is GroupLoadedState) {
                            for (var groupId in task.assignedGroups) {
                              final grp = state.getGroupById(groupId);
                              if (grp != null) {
                                assignedGroups.add(grp);
                              }
                            }
                          }
                          return AssignedGroups(
                            assignedGroups: assignedGroups,
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        getTaskPriorityAndTypeIcon(
          context: context,
          priority: task.priority,
          type: task.type,
          backgroundSize: 50,
          iconSize: 20,
        ),
        if (task.isCancelled)
          Positioned(
            right: 16,
            child: Transform.rotate(
              angle: -math.pi / 8,
              child: Text(
                AppLocalizations.of(context)!.cancelled,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  backgroundColor: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          )
      ],
    );
  }
}

class ProgressIcon extends StatelessWidget {
  const ProgressIcon({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    // task cancelled
    if (task.isCancelled) {
      return Icon(
        Icons.cancel_outlined,
        size: 40,
        color: Theme.of(context).highlightColor.withAlpha(200),
      );
    } else if (task.isFinished) {
      // done sucessfully
      if (task.isSuccessful) {
        return Icon(
          Icons.check_circle_outline_rounded,
          size: 40,
          color: Theme.of(context).primaryColor.withAlpha(120),
        );

        // done unsuccessfully
      } else {
        return Icon(
          Icons.cancel_outlined,
          size: 40,
          color: Theme.of(context).errorColor.withAlpha(160),
        );
      }
    } else {
      // task in progress
      if (task.isInProgress) {
        return Icon(
          Icons.run_circle_outlined,
          size: 40,
          color: task.executionDate.isBefore(DateTime.now())
              ? Theme.of(context).highlightColor.withAlpha(200)
              : Theme.of(context).textTheme.bodySmall!.color!.withAlpha(120),
        );
      } else {
        // scheduled task, but not started yet
        return Icon(
          Icons.schedule_rounded,
          size: 40,
          color: task.executionDate.isBefore(DateTime.now())
              ? Theme.of(context).highlightColor.withAlpha(200)
              : Theme.of(context).textTheme.bodySmall!.color!.withAlpha(120),
        );
      }
    }
  }
}

class ProgressText extends StatelessWidget {
  const ProgressText({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    // task cancelled
    if (task.isCancelled) {
      return Text(
        AppLocalizations.of(context)!.task_progress_cancelled,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
      );
    } else if (task.isFinished) {
      // done sucessfully
      if (task.isSuccessful) {
        return Text(
          AppLocalizations.of(context)!.task_progress_finished_successfully,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
        );

        // done unsuccessfully
      } else {
        return Text(
          AppLocalizations.of(context)!.task_progress_finished_unsuccessfully,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
        );
      }
    } else {
      // task in progress
      if (task.isInProgress) {
        return Text(
          AppLocalizations.of(context)!.task_progress_in_progress,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
        );
      } else {
        // scheduled task, but not started yet
        return Text(
          AppLocalizations.of(context)!.task_progress_scheduled,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
        );
      }
    }
  }
}

class AssignedGroups extends StatelessWidget {
  const AssignedGroups({
    Key? key,
    required List<Group> assignedGroups,
  })  : _assignedGroups = assignedGroups,
        super(key: key);

  final List<Group> _assignedGroups;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.group,
                color: Theme.of(context).textTheme.bodySmall!.color,
                size: 14,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                AppLocalizations.of(context)!.task_assigned_groups,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10),
              ),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  indent: 8,
                  endIndent: 4,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (var group in _assignedGroups)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 4,
                      ),
                      child: Icon(
                        Icons.group,
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                    Text(
                      group.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}

class AssignedUsers extends StatelessWidget {
  const AssignedUsers({
    Key? key,
    required List<UserProfile> assignedUsers,
  })  : _assignedUsers = assignedUsers,
        super(key: key);

  final List<UserProfile> _assignedUsers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).textTheme.bodySmall!.color,
                size: 14,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                AppLocalizations.of(context)!.task_assigned_users,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10),
              ),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  indent: 8,
                  endIndent: 4,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (var user in _assignedUsers)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 4,
                      ),
                      child: CachedUserAvatar(
                        size: 20,
                        imageUrl: user.avatarUrl,
                      ),
                    ),
                    Text(
                      user.firstName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}

class TaskAuthor extends StatelessWidget {
  const TaskAuthor({
    Key? key,
    required UserProfile? author,
  })  : _author = author,
        super(key: key);

  final UserProfile? _author;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 4,
              left: 8,
            ),
            child: CachedUserAvatar(
              size: 20,
              imageUrl: _author!.avatarUrl,
            ),
          ),
          Text(
            '${_author!.firstName} ${_author!.lastName}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class TaskTitle extends StatelessWidget {
  const TaskTitle({
    Key? key,
    required this.taskTitle,
  }) : super(key: key);

  final String taskTitle;

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (taskTitle.contains('AUTO#')) {
      title = AppLocalizations.of(context)!.auto_generated;
    } else {
      title = taskTitle;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class NoAssetInfo extends StatelessWidget {
  const NoAssetInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.handyman,
            size: 16,
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            AppLocalizations.of(context)!.task_connected_asset_no,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ConnectedAsset extends StatelessWidget {
  const ConnectedAsset({
    Key? key,
    required this.assetId,
  }) : super(key: key);

  final String assetId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetBloc, AssetState>(
      builder: (context, state) {
        if (state is AssetLoadedState) {
          final asset = state.getAssetById(assetId);
          if (asset != null) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.precision_manufacturing,
                    size: 16,
                    color: Theme.of(context).highlightColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      '${asset.producer} - ${asset.model}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        return const Text('');
      },
    );
  }
}
