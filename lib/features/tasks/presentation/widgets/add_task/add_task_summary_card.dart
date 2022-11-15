import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:under_control_v2/features/assets/utils/get_localizad_duration_unit_name.dart';
import 'package:under_control_v2/features/assets/utils/get_localizae_asset_status_name.dart';
import 'package:under_control_v2/features/core/presentation/widgets/shimmer_custom_dropdown_button.dart';
import 'package:under_control_v2/features/core/presentation/widgets/user_list_tile.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/tasks/utils/get_task_priority_and_type_icon.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/utils/asset_status.dart';
import '../../../../assets/utils/get_asset_status_icon.dart';
import '../../../../assets/utils/get_next_date.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/shimmer_user_list_tile.dart';
import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/duration_unit.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../groups/presentation/widgets/group_management/group_tile.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/task_priority.dart';
import '../../../domain/entities/task_type.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../../../utils/get_localized_task_priority_name.dart';
import '../../../utils/get_localized_task_type_name.dart';
import '../../../utils/get_task_priority_icon.dart';

class AddTaskSummaryCard extends StatelessWidget with ResponsiveSize {
  const AddTaskSummaryCard({
    Key? key,
    this.workRequest,
    required this.pageController,
    required this.titleTextEditingController,
    required this.descriptionTextEditingController,
    required this.date,
    required this.executionDate,
    required this.locationId,
    required this.assetId,
    required this.priority,
    required this.assetStatus,
    required this.type,
    required this.durationUnit,
    required this.duration,
    required this.isConnectedToAsset,
    required this.isCyclicTask,
    required this.assignedUsers,
    required this.assignedGroups,
    required this.images,
    this.video,
  }) : super(key: key);

  final WorkRequest? workRequest;

  final PageController pageController;

  final TextEditingController titleTextEditingController;
  final TextEditingController descriptionTextEditingController;

  final DateTime date;
  final DateTime executionDate;

  final String locationId;
  final String assetId;
  final String priority;
  final String assetStatus;
  final String type;
  final String durationUnit;

  final int duration;

  final bool isConnectedToAsset;
  final bool isCyclicTask;

  final List<String> assignedUsers;
  final List<String> assignedGroups;

  final List<File> images;
  final File? video;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    // asset
    String assetString = '';
    final assetState = context.read<AssetBloc>().state;
    if (assetId.isNotEmpty && assetState is AssetLoadedState) {
      final tmpAsset = assetState.getAssetById(assetId);
      if (tmpAsset != null) {
        assetString =
            '${tmpAsset.internalCode} ${tmpAsset.producer} ${tmpAsset.model}';
      }
    }

    // location
    String locationString = '';
    try {
      final locationState = context.read<LocationBloc>().state;
      if (locationId.isNotEmpty && locationState is LocationLoadedState) {
        locationString = getBreadcrumbsForLocation(
          locationId,
          locationState.allLocations.allLocations,
        );
      }
    } catch (e) {
      locationString = '';
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          // vertical: 4,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.summary,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),

                    //priority and type
                    SummaryCard(
                      title:
                          AppLocalizations.of(context)!.task_priority_and_type,
                      validator: () => type.isEmpty
                          ? AppLocalizations.of(context)!.task_type_select
                          : null,
                      child: Row(
                        children: [
                          getTaskPriorityAndTypeIcon(
                            context: context,
                            priority: TaskPriority.fromString(priority),
                            type: TaskType.fromString(type),
                            shadow: true,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getLocalizedTaskPriorityName(
                                    context,
                                    TaskPriority.fromString(priority),
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  getLocalizedTaskTypeName(
                                    context,
                                    TaskType.fromString(type),
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 8,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // asset status
                    if (isConnectedToAsset)
                      SummaryCard(
                        title: AppLocalizations.of(context)!.asset_status,
                        validator: () => assetStatus.isEmpty
                            ? AppLocalizations.of(context)!
                                .asset_status_not_selected
                            : null,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: getAssetStatusIcon(
                                context,
                                AssetStatus.fromString(assetStatus),
                                30,
                                true,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                getLocalizedAssetStatusName(
                                  context,
                                  AssetStatus.fromString(assetStatus),
                                ),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        pageController: pageController,
                        onTapAnimateToPage: 2,
                      ),
                    if (isConnectedToAsset)
                      const SizedBox(
                        height: 8,
                      ),

                    // title
                    SummaryCard(
                      title: AppLocalizations.of(context)!.title,
                      validator: () =>
                          titleTextEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child: Text(titleTextEditingController.text.trim()),
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // description
                    if (descriptionTextEditingController.text.isNotEmpty)
                      SummaryCard(
                        title:
                            AppLocalizations.of(context)!.description_optional,
                        validator: () => null,
                        child:
                            Text(descriptionTextEditingController.text.trim()),
                        pageController: pageController,
                        onTapAnimateToPage: 0,
                      ),
                    if (descriptionTextEditingController.text.isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // add date
                    SummaryCard(
                      title: AppLocalizations.of(context)!.add_date,
                      validator: () => null,
                      child: Text(dateFormat.format(date)),
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // connected asset
                    if (isConnectedToAsset)
                      SummaryCard(
                        title:
                            AppLocalizations.of(context)!.task_connected_asset,
                        validator: () {
                          if (assetId.isEmpty) {
                            return AppLocalizations.of(context)!
                                .task_connected_asset_select;
                          }
                          return null;
                        },
                        child: Text(assetString),
                        pageController: pageController,
                        onTapAnimateToPage: 1,
                      ),
                    if (isConnectedToAsset)
                      const SizedBox(
                        height: 8,
                      ),

                    // location
                    SummaryCard(
                      title: AppLocalizations.of(context)!.location,
                      validator: () => locationString.isEmpty
                          ? AppLocalizations.of(context)!
                              .validation_location_not_selected
                          : null,
                      child: Text(locationString),
                      pageController: pageController,
                      onTapAnimateToPage: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // cyclic / single task
                    SummaryCard(
                      title: isCyclicTask
                          ? AppLocalizations.of(context)!.task_is_cyclic
                          : AppLocalizations.of(context)!.task_not_is_cyclic,
                      validator: () {
                        if (isCyclicTask) {
                          if (durationUnit.isEmpty) {
                            return AppLocalizations.of(context)!
                                .duration_unit_not_selected;
                          } else if (duration < 1) {
                            return AppLocalizations.of(context)!
                                .duration_not_selected;
                          }
                        }
                        return null;
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.task_execution_date}:',
                          ),
                          Text(
                            dateFormat.format(executionDate),
                          ),
                          if (isCyclicTask)
                            Column(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.task_interval}:',
                                ),
                                Text(
                                  '${getLocalizedDurationUnitName(context, DurationUnit.fromString(durationUnit))} - $duration',
                                ),
                                Text(
                                  '${AppLocalizations.of(context)!.task_next_execution_date}:',
                                ),
                                Text(
                                  dateFormat.format(
                                    getNextDate(
                                      executionDate,
                                      DurationUnit.fromString(durationUnit),
                                      duration,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 6,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // assigned users
                    if (assignedUsers.isNotEmpty)
                      SummaryCard(
                        title:
                            AppLocalizations.of(context)!.task_assigned_users,
                        validator: () => null,
                        child: BlocBuilder<CompanyProfileBloc,
                            CompanyProfileState>(
                          builder: (context, state) {
                            if (state is CompanyProfileLoaded) {
                              final List<UserProfile> users = [];
                              for (var userId in assignedUsers) {
                                final user = state.getUserById(userId);
                                if (user != null) {
                                  users.add(user);
                                }
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: users.length,
                                itemBuilder: (context, index) => UserListTile(
                                  user: users[index],
                                  onTap: (_) => pageController.animateToPage(
                                    7,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  const ShimmerUserListTile(),
                            );
                          },
                        ),
                        pageController: pageController,
                        onTapAnimateToPage: 7,
                      ),
                    if (assignedUsers.isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // assigned groups
                    if (assignedGroups.isNotEmpty)
                      SummaryCard(
                        title:
                            AppLocalizations.of(context)!.task_assigned_groups,
                        validator: () => null,
                        child: BlocBuilder<GroupBloc, GroupState>(
                          builder: (context, state) {
                            if (state is GroupLoadedState) {
                              final List<Group> groups = [];
                              for (var groupId in assignedGroups) {
                                final group = state.getGroupById(groupId);
                                if (group != null) {
                                  groups.add(group);
                                }
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: groups.length,
                                itemBuilder: (context, index) => GroupTile(
                                  group: groups[index],
                                  onTap: (_) => pageController.animateToPage(
                                    7,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  iconColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  const ShimmerCustomDropdownButton(),
                            );
                          },
                        ),
                        pageController: pageController,
                        onTapAnimateToPage: 7,
                      ),
                    if (assignedGroups.isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // no groups or users assigned
                    if (assignedGroups.isEmpty && assignedUsers.isEmpty)
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .task_assign_groups_or_users,
                        validator: () => AppLocalizations.of(context)!
                            .task_assign_groups_or_users_error,
                        child: const SizedBox(),
                        pageController: pageController,
                        onTapAnimateToPage: 7,
                      ),
                    if (assignedGroups.isEmpty && assignedUsers.isEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // images
                    if (images.isNotEmpty)
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .asset_add_images_title,
                        validator: () => null,
                        child: Text(
                          images.isNotEmpty
                              ? '${AppLocalizations.of(context)!.asset_add_images_added}: ${images.length}'
                              : AppLocalizations.of(context)!
                                  .asset_add_images_not_added,
                        ),
                        pageController: pageController,
                        onTapAnimateToPage: 3,
                      ),
                    if (images.isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // video
                    if (video != null)
                      SummaryCard(
                        title: AppLocalizations.of(context)!.content_video,
                        validator: () => null,
                        child: const SizedBox(),
                        pageController: pageController,
                        onTapAnimateToPage: 4,
                      ),

                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
