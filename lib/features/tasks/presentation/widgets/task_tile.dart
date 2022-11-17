import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart';
import 'package:under_control_v2/features/tasks/utils/get_task_priority_and_type_icon.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/task/task.dart';

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
  List<UserProfile> _assignedUsers = [];
  List<Group> _assignedGroups = [];

  @override
  void didChangeDependencies() {
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      _author = companyState.getUserById(widget.task.userId);
      if (widget.task.assignedUsers.isNotEmpty) {
        for (var userId in widget.task.assignedUsers) {
          final usr = companyState.getUserById(userId);
          if (usr != null) {
            _assignedUsers.add(usr);
          }
        }
      }
    }
    if (widget.task.assignedGroups.isNotEmpty) {
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
                      BlocBuilder<AssetBloc, AssetState>(
                        builder: (context, state) {
                          if (state is AssetLoadedState) {
                            final asset =
                                state.getAssetById(widget.task.assetId);
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
                      ),
                    // shows info if work order is not connected to an asset
                    if (widget.task.assetId.isEmpty)
                      Padding(
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
                              AppLocalizations.of(context)!
                                  .task_connected_asset_no,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                    // title
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .caption!
                        //     .copyWith(fontSize: 16),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                    // description
                    if (widget.task.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 12),
                        ),
                      ),

                    Row(
                      children: [
                        if (_author == null) const Expanded(child: SizedBox()),
                        if (_author != null)
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
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
                          ),
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
