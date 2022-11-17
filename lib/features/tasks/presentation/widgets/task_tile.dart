import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/task/task.dart';
import '../../utils/get_task_priority_and_type_icon.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  UserProfile? _author;
  final List<UserProfile> _assignedUsers = [];
  final List<Group> _assignedGroups = [];

  @override
  void didChangeDependencies() {
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      _author = companyState.getUserById(widget.task.userId);
      if (widget.task.assignedUsers.isNotEmpty) {
        _assignedUsers.clear();
        for (var userId in widget.task.assignedUsers) {
          final usr = companyState.getUserById(userId);
          if (usr != null) {
            _assignedUsers.add(usr);
          }
        }
      }
    }
    if (widget.task.assignedGroups.isNotEmpty) {
      _assignedGroups.clear();
      final groupState = context.watch<GroupBloc>().state;
      if (groupState is GroupLoadedState) {
        for (var groupId in widget.task.assignedGroups) {
          final grp = groupState.getGroupById(groupId);
          if (grp != null) {
            _assignedGroups.add(grp);
          }
        }
      }
    }
    super.didChangeDependencies();
  }

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
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(
                //   context,
                //   WorkRequestDetailsPage.routeName,
                //   arguments: task.id,
                // );
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
                    // date
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              dateFormat.format(widget.task.date),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Text(
                            '#${widget.task.count}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    // shows asset data if work order is connected to an asset
                    if (widget.task.assetId.isNotEmpty)
                      ConnectedAsset(assetId: widget.task.assetId),
                    // shows info if work order is not connected to an asset
                    if (widget.task.assetId.isEmpty) const NoAssetInfo(),

                    // title
                    TaskTitle(title: widget.task.title),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        if (_author == null) const Expanded(child: SizedBox()),
                        if (_author != null)
                          // task author
                          TaskAuthor(author: _author),
                        // image icon
                        if (widget.task.images.isNotEmpty)
                          Row(
                            children: [
                              if (widget.task.images.length > 1)
                                Text(
                                  '${widget.task.images.length}x',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontSize: 14),
                                ),
                              FaIcon(
                                FontAwesomeIcons.image,
                                size: 18,
                                color:
                                    Theme.of(context).textTheme.caption!.color,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        // video icon
                        if (widget.task.video.isNotEmpty)
                          FaIcon(
                            FontAwesomeIcons.play,
                            size: 18,
                            color: Theme.of(context).textTheme.caption!.color,
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // assigned users
                    if (_assignedUsers.isNotEmpty)
                      AssignedUsers(assignedUsers: _assignedUsers),

                    // assigned groups
                    if (_assignedGroups.isNotEmpty)
                      AssignedGroups(assignedGroups: _assignedGroups),
                  ],
                ),
              ),
            ),
          ),
        ),
        getTaskPriorityAndTypeIcon(
          context: context,
          priority: widget.task.priority,
          type: widget.task.type,
          backgroundSize: 50,
          iconSize: 20,
        ),
        if (widget.task.isCancelled)
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
                color: Theme.of(context).textTheme.caption!.color,
                size: 14,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                AppLocalizations.of(context)!.task_assigned_groups,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
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
                        color: Theme.of(context).textTheme.caption!.color,
                      ),
                    ),
                    Text(
                      group.name,
                      style: Theme.of(context).textTheme.caption,
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
                color: Theme.of(context).textTheme.caption!.color,
                size: 14,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                AppLocalizations.of(context)!.task_assigned_users,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
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
                      style: Theme.of(context).textTheme.caption,
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
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

class TaskTitle extends StatelessWidget {
  const TaskTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16),
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
            color: Theme.of(context).textTheme.caption!.color,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            AppLocalizations.of(context)!.task_connected_asset_no,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
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
                  Text(
                    '${asset.internalCode} - ${asset.producer} - ${asset.model}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).highlightColor,
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
