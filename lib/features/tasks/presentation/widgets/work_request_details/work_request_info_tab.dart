import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/user_info_card.dart';
import '../../../../core/presentation/widgets/user_list_tile.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../../../utils/get_localized_task_priority_name.dart';
import '../../../utils/get_task_priority_icon.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task_archive/task_archive_bloc.dart';
import '../task_tile.dart';

class WorkRequestInfoTab extends StatefulWidget {
  const WorkRequestInfoTab({
    Key? key,
    required this.workRequest,
  }) : super(key: key);

  final WorkRequest workRequest;

  @override
  State<WorkRequestInfoTab> createState() => _WorkRequestInfoTabState();
}

class _WorkRequestInfoTabState extends State<WorkRequestInfoTab> {
  UserProfile? _userProfile;
  bool _isUserInfoCardVisible = false;

  void _showUserInfoCard() {
    setState(() {
      _isUserInfoCardVisible = true;
    });
  }

  void _hideUserInfoCard() {
    setState(() {
      _isUserInfoCardVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_userProfile == null) {
      final companyState = context.read<CompanyProfileBloc>().state;
      if (companyState is CompanyProfileLoaded) {
        _userProfile = companyState.getUserById(widget.workRequest.userId);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final detailedDateFormat = DateFormat('dd-MM-yyyy HH:mm');
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (_isUserInfoCardVisible) {
          _hideUserInfoCard();
          return false;
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    getTaskPriorityIcon(
                      context,
                      widget.workRequest.priority,
                      100,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.task_priority,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 10),
                          ),
                          Text(
                            getLocalizedTaskPriorityName(
                              context,
                              widget.workRequest.priority,
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
                        '#${widget.workRequest.count}',
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
                      if (widget.workRequest.cancelled)
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
                        widget.workRequest.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),

                      if (widget.workRequest.description.isNotEmpty)
                        const SizedBox(
                          height: 4,
                        ),
                      // description
                      if (widget.workRequest.description.isNotEmpty)
                        Text(
                          widget.workRequest.description,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),

                // work order data
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if work request is converted to a task
                      if (widget.workRequest.taskId.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
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
                                iconBackground: Theme.of(context).primaryColor,
                                title: AppLocalizations.of(context)!
                                    .work_request_converted,
                              ),
                              BlocBuilder<TaskBloc, TaskState>(
                                builder: (context, state) {
                                  if (state is TaskLoadedState) {
                                    final task = state
                                        .getTaskById(widget.workRequest.taskId);
                                    if (task != null) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 12,
                                        ),
                                        child: TaskTile(task: task),
                                      );
                                    }
                                    return const SizedBox();
                                  }
                                  return const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 8.0,
                                      top: 16,
                                    ),
                                    child: ShimmerAssetActionListTile(),
                                  );
                                },
                              ),
                              // archive task
                              BlocBuilder<TaskArchiveBloc, TaskArchiveState>(
                                builder: (context, state) {
                                  if (state is TaskArchiveLoadedState) {
                                    final task = state
                                        .getTaskById(widget.workRequest.taskId);
                                    if (task != null) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 12,
                                        ),
                                        child: TaskTile(task: task),
                                      );
                                    }
                                    return const SizedBox();
                                  }
                                  return const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 8.0,
                                      top: 16,
                                    ),
                                    child: ShimmerAssetActionListTile(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                      const Divider(
                        thickness: 1.5,
                        indent: 8,
                        endIndent: 8,
                      ),

                      // type
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconTitleRow(
                              icon: Icons.security,
                              iconColor: Colors.white,
                              iconBackground: Colors.black,
                              title: AppLocalizations.of(context)!
                                  .work_request_data,
                              titleFontSize: 16,
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
                                  detailedDateFormat
                                      .format(widget.workRequest.date),
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
                                      widget.workRequest.locationId,
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
                              icon: widget.workRequest.assetId.isNotEmpty
                                  ? Icons.precision_manufacturing
                                  : Icons.handyman,
                              iconColor: Colors.white,
                              iconBackground:
                                  widget.workRequest.assetId.isNotEmpty
                                      ? Colors.blue
                                      : Theme.of(context).primaryColor,
                              title: widget.workRequest.assetId.isNotEmpty
                                  ? AppLocalizations.of(context)!
                                      .task_connected_asset_yes
                                  : AppLocalizations.of(context)!
                                      .task_connected_asset_no,
                              titleFontSize: 16,
                            ),
                            if (widget.workRequest.assetId.isNotEmpty)
                              const SizedBox(
                                height: 8,
                              ),

                            // asset tile
                            if (widget.workRequest.assetId.isNotEmpty)
                              BlocBuilder<AssetBloc, AssetState>(
                                builder: (context, state) {
                                  if (state is AssetLoadedState) {
                                    final asset = state.getAssetById(
                                        widget.workRequest.assetId);
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

                            const Divider(
                              thickness: 1.5,
                            ),

                            // user
                            if (_userProfile != null)
                              UserListTile(
                                user: _userProfile!,
                                onTap: (_) => _showUserInfoCard(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // user info card
            if (_isUserInfoCardVisible)
              UserInfoCard(
                onDismiss: _hideUserInfoCard,
                user: _userProfile!,
              ),
          ],
        ),
      ),
    );
  }
}
