import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';
import '../../../../assets/utils/get_localizad_duration_unit_name.dart';
import '../../../../assets/utils/get_next_date.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/user_info_card.dart';
import '../../../../core/presentation/widgets/user_list_tile.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../groups/domain/entities/group.dart';
import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../groups/presentation/pages/group_details.dart';
import '../../../../groups/presentation/widgets/group_management/group_tile.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/task/task.dart';
import '../../../utils/get_localized_task_priority_name.dart';
import '../../../utils/get_localized_task_type_name.dart';
import '../../../utils/get_task_priority_and_type_icon.dart';
import '../../blocs/work_request_archive/work_request_archive_bloc.dart';
import '../work_request_tile.dart';

class TaskInfoTab extends StatefulWidget {
  const TaskInfoTab({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskInfoTab> createState() => _TaskInfoTabState();
}

class _TaskInfoTabState extends State<TaskInfoTab> {
  UserProfile? _selectedUser;
  UserProfile? _authorProfile;
  bool _isUserInfoCardVisible = false;
  final List<UserProfile> _assignedUsers = [];
  final List<Group> _assignedGroups = [];

  void _showUserInfoCard(UserProfile selectedUser) {
    _selectedUser = selectedUser;
    setState(() {
      _isUserInfoCardVisible = true;
    });
  }

  void _hideUserInfoCard() {
    _selectedUser = null;
    setState(() {
      _isUserInfoCardVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      _authorProfile = companyState.getUserById(widget.task.userId);
      _assignedUsers.clear();
      for (var userId in widget.task.assignedUsers) {
        final usr = companyState.getUserById(userId);
        if (usr != null) {
          _assignedUsers.add(usr);
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
    final detailedDateFormat = DateFormat('dd-MM-yyyy HH:mm');
    final dateFormat = DateFormat('dd-MM-yyyy');
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (_isUserInfoCardVisible) {
          _hideUserInfoCard();
          return false;
        }
        return true;
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: getTaskPriorityAndTypeIcon(
                        context: context,
                        priority: widget.task.priority,
                        type: widget.task.type,
                        backgroundSize: 100,
                        iconSize: 38,
                        shadow: true,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .task_priority_and_type,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 10),
                          ),
                          Text(
                            getLocalizedTaskPriorityName(
                              context,
                              widget.task.priority,
                            ),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            getLocalizedTaskTypeName(
                              context,
                              widget.task.type,
                            ),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 16),
                      height: 100,
                      child: Text(
                        '#${widget.task.count}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.task.isCancelled)
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.cancelled,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).highlightColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      // title
                      Text(
                        widget.task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),

                      if (widget.task.description.isNotEmpty)
                        const SizedBox(
                          height: 4,
                        ),
                      // description
                      if (widget.task.description.isNotEmpty)
                        Text(
                          widget.task.description,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),

                // task data
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1.5,
                      ),

                      // task data
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconTitleRow(
                              icon: Icons.security,
                              iconColor: Colors.white,
                              iconBackground: Colors.black,
                              title: AppLocalizations.of(context)!.task_data,
                              titleFontSize: 16,
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // execution date
                            Row(
                              children: [
                                Expanded(
                                  child: IconTitleRow(
                                    icon: Icons.build,
                                    iconColor: Colors.white,
                                    iconBackground:
                                        Theme.of(context).primaryColor,
                                    title: AppLocalizations.of(context)!
                                        .task_execution_date,
                                    titleFontSize: 16,
                                  ),
                                ),
                                Text(
                                  detailedDateFormat.format(
                                    widget.task.executionDate,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            // add date
                            Row(
                              children: [
                                Expanded(
                                  child: IconTitleRow(
                                    icon: Icons.calendar_month,
                                    iconColor: Colors.white,
                                    iconBackground:
                                        Theme.of(context).primaryColor,
                                    title: AppLocalizations.of(context)!
                                        .asset_add_date,
                                    titleFontSize: 16,
                                  ),
                                ),
                                Text(
                                  detailedDateFormat.format(widget.task.date),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // location
                            Row(
                              children: [
                                Expanded(
                                  child: IconTitleRow(
                                    icon: Icons.location_on,
                                    iconColor: Colors.white,
                                    iconBackground:
                                        Theme.of(context).primaryColor,
                                    title:
                                        AppLocalizations.of(context)!.location,
                                    titleFontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<LocationBloc, LocationState>(
                              builder: (context, state) {
                                if (state is LocationLoadedState) {
                                  return Text(
                                    getBreadcrumbsForLocation(
                                      widget.task.locationId,
                                      state.allLocations.allLocations,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // connected asset
                            IconTitleRow(
                              icon: widget.task.assetId.isNotEmpty
                                  ? Icons.precision_manufacturing
                                  : Icons.handyman,
                              iconColor: Colors.white,
                              iconBackground: widget.task.assetId.isNotEmpty
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                              title: widget.task.assetId.isNotEmpty
                                  ? AppLocalizations.of(context)!
                                      .task_connected_asset_yes
                                  : AppLocalizations.of(context)!
                                      .task_connected_asset_no,
                              titleFontSize: 16,
                            ),
                            if (widget.task.assetId.isNotEmpty)
                              const SizedBox(
                                height: 8,
                              ),

                            // asset tile
                            if (widget.task.assetId.isNotEmpty)
                              BlocBuilder<AssetBloc, AssetState>(
                                builder: (context, state) {
                                  if (state is AssetLoadedState) {
                                    final asset =
                                        state.getAssetById(widget.task.assetId);
                                    if (asset != null) {
                                      return AssetTile(
                                        asset: asset,
                                        searchQuery: '',
                                        margin: const EdgeInsets.only(top: 4),
                                      );
                                    }
                                  }
                                  return const ShimmerItemTile();
                                },
                              ),
                            const SizedBox(
                              height: 8,
                            ),

                            // only cyclic task
                            if (widget.task.isCyclictask)
                              TaskCycleInfo(
                                dateFormat: dateFormat,
                                task: widget.task,
                              ),

                            // if task is converted from a work request
                            if (widget.task.workOrderId.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    thickness: 1.5,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  IconTitleRow(
                                    icon: Icons.done,
                                    iconColor: Colors.white,
                                    iconBackground:
                                        Theme.of(context).primaryColor,
                                    title: AppLocalizations.of(context)!
                                        .task_converted,
                                  ),
                                  BlocBuilder<WorkRequestArchiveBloc,
                                      WorkRequestArchiveState>(
                                    builder: (context, state) {
                                      if (state
                                          is WorkRequestArchiveLoadedState) {
                                        final workRequest =
                                            state.getWorkRequestById(
                                                widget.task.workOrderId);
                                        if (workRequest != null) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8.0,
                                              top: 12,
                                            ),
                                            child: WorkRequestTile(
                                              workRequest: workRequest,
                                            ),
                                          );
                                        }
                                      }
                                      return const Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 16,
                                        ),
                                        child: ShimmerAssetActionListTile(),
                                      );
                                    },
                                  )
                                ],
                              ),

                            const Divider(
                              thickness: 1.5,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // author
                            if (_authorProfile != null)
                              Column(
                                children: [
                                  // author
                                  IconTitleRow(
                                    icon: Icons.add_task,
                                    iconColor: Colors.white,
                                    iconBackground: Colors.black,
                                    title:
                                        AppLocalizations.of(context)!.added_by,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: UserListTile(
                                      user: _authorProfile!,
                                      onTap: _showUserInfoCard,
                                    ),
                                  ),
                                ],
                              ),
                            // assigned users
                            if (_assignedUsers.isNotEmpty)
                              Column(
                                children: [
                                  IconTitleRow(
                                    icon: Icons.person,
                                    iconColor: Colors.white,
                                    iconBackground: Colors.black,
                                    title: AppLocalizations.of(context)!
                                        .task_assigned_users,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  for (var user in _assignedUsers)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: UserListTile(
                                        user: user,
                                        onTap: _showUserInfoCard,
                                      ),
                                    ),
                                ],
                              ),

                            // assigned groups
                            if (_assignedGroups.isNotEmpty)
                              AssignedGroups(assignedGroups: _assignedGroups),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
          // user info card
          if (_isUserInfoCardVisible)
            UserInfoCard(
              onDismiss: _hideUserInfoCard,
              user: _selectedUser!,
            ),
        ],
      ),
    );
  }
}

class TaskCycleInfo extends StatelessWidget {
  const TaskCycleInfo({
    Key? key,
    required this.task,
    required this.dateFormat,
  }) : super(key: key);

  final Task task;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 1.5,
        ),
        const SizedBox(
          height: 8,
        ),
        IconTitleRow(
          icon: Icons.refresh,
          iconColor: Colors.white,
          iconBackground: Colors.black,
          title: AppLocalizations.of(context)!.task_is_cyclic,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: IconTitleRow(
                icon: Icons.av_timer,
                iconColor: Colors.white,
                iconBackground: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.duration_unit,
              ),
            ),
            Text(
              getLocalizedDurationUnitName(
                context,
                task.durationUnit,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: IconTitleRow(
                icon: Icons.timer_outlined,
                iconColor: Colors.white,
                iconBackground: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.duration,
              ),
            ),
            Text(
              task.duration.toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: IconTitleRow(
                icon: Icons.today,
                iconColor: Colors.white,
                iconBackground: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.task_next_execution_date,
              ),
            ),
            Text(
              dateFormat.format(
                getNextDate(
                  task.executionDate,
                  task.durationUnit,
                  task.duration,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
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
    return Column(
      children: [
        IconTitleRow(
          icon: Icons.group,
          iconColor: Colors.white,
          iconBackground: Colors.black,
          title: AppLocalizations.of(context)!.task_assigned_groups,
        ),
        const SizedBox(
          height: 6,
        ),
        for (var group in _assignedGroups)
          GroupTile(
            group: group,
            onTap: (grp) => Navigator.pushNamed(
              context,
              GroupDetailsPage.routeName,
              arguments: grp,
            ),
          ),
      ],
    );
  }
}
