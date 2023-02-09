import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../assets/domain/entities/asset.dart';
import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/utils/asset_status.dart';
import '../../../../assets/utils/get_asset_status_icon.dart';
import '../../../../assets/utils/get_localizad_duration_unit_name.dart';
import '../../../../assets/utils/get_localizae_asset_status_name.dart';
import '../../../../assets/utils/get_next_date.dart';
import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/shimmer_custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/shimmer_user_list_tile.dart';
import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/presentation/widgets/user_list_tile.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/duration_unit.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../groups/domain/entities/group.dart';
import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../groups/presentation/widgets/group_management/group_tile.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/utils/get_localized_unit_name.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../../../domain/entities/task_priority.dart';
import '../../../domain/entities/task_type.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../../../utils/get_localized_task_priority_name.dart';
import '../../../utils/get_localized_task_type_name.dart';
import '../../../utils/get_task_priority_and_type_icon.dart';

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
    required this.sparePartsAssets,
    required this.sparePartsItems,
    required this.checklist,
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

  final List<String> sparePartsAssets;
  final List<SparePartItemModel> sparePartsItems;
  final List<CheckpointModel> checklist;

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
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),

                    //priority and type
                    PriorityAndTypeSummaryCard(
                      type: type,
                      priority: priority,
                      pageController: pageController,
                    ),

                    // asset status
                    if (isConnectedToAsset)
                      AssetStatusSummaryCard(
                        assetStatus: assetStatus,
                        pageController: pageController,
                      ),

                    // title
                    TitleSummaryCard(
                      titleTextEditingController: titleTextEditingController,
                      pageController: pageController,
                    ),

                    // description
                    if (descriptionTextEditingController.text.isNotEmpty)
                      DescriptionSummaryCard(
                          descriptionTextEditingController:
                              descriptionTextEditingController,
                          pageController: pageController),

                    // add date
                    AddDateSummaryCard(
                      dateFormat: dateFormat,
                      date: date,
                      pageController: pageController,
                    ),

                    // connected asset
                    if (isConnectedToAsset)
                      ConnectedAssetSummaryCard(
                        assetId: assetId,
                        assetString: assetString,
                        pageController: pageController,
                      ),

                    // location
                    LocationSummaryCard(
                      locationString: locationString,
                      pageController: pageController,
                    ),

                    // cyclic / single task
                    SingleOrCyclicTaskSummaryCard(
                      isCyclicTask: isCyclicTask,
                      durationUnit: durationUnit,
                      duration: duration,
                      dateFormat: dateFormat,
                      executionDate: executionDate,
                      pageController: pageController,
                    ),

                    // assigned users
                    if (assignedUsers.isNotEmpty)
                      AssignedUsersSummaryCard(
                        assignedUsers: assignedUsers,
                        pageController: pageController,
                      ),

                    // assigned groups
                    if (assignedGroups.isNotEmpty)
                      AssignedGroupsSummaryCard(
                        assignedGroups: assignedGroups,
                        pageController: pageController,
                      ),

                    // no groups or users assigned
                    if (assignedGroups.isEmpty && assignedUsers.isEmpty)
                      NotAssignedSummaryCard(
                        pageController: pageController,
                      ),

                    // spare parts
                    if (sparePartsAssets.isNotEmpty ||
                        sparePartsItems.isNotEmpty)
                      SparePartsSummaryCard(
                        sparePartsAssets: sparePartsAssets,
                        sparePartsItems: sparePartsItems,
                        pageController: pageController,
                      ),

                    // images
                    if (images.isNotEmpty)
                      ImagesSummaryCard(
                        images: images,
                        pageController: pageController,
                      ),
                    // video
                    if (video != null)
                      VideoSummaryCard(pageController: pageController),

                    if (checklist.isNotEmpty)
                      ChecklistSummaryCard(
                        checkpoints: checklist,
                        pageController: pageController,
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

class PriorityAndTypeSummaryCard extends StatelessWidget {
  const PriorityAndTypeSummaryCard({
    Key? key,
    required this.type,
    required this.priority,
    required this.pageController,
  }) : super(key: key);

  final String type;
  final String priority;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.task_priority_and_type,
          validator: () => type.isEmpty
              ? AppLocalizations.of(context)!.task_type_select
              : null,
          pageController: pageController,
          onTapAnimateToPage: 10,
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
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class AssetStatusSummaryCard extends StatelessWidget {
  const AssetStatusSummaryCard({
    Key? key,
    required this.assetStatus,
    required this.pageController,
  }) : super(key: key);

  final String assetStatus;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.asset_status,
          validator: () => assetStatus.isEmpty
              ? AppLocalizations.of(context)!.asset_status_not_selected
              : null,
          pageController: pageController,
          onTapAnimateToPage: 2,
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
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class TitleSummaryCard extends StatelessWidget {
  const TitleSummaryCard({
    Key? key,
    required this.titleTextEditingController,
    required this.pageController,
  }) : super(key: key);

  final TextEditingController titleTextEditingController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.title,
          validator: () => titleTextEditingController.text.trim().length < 2
              ? AppLocalizations.of(context)!.validation_min_two_characters
              : null,
          pageController: pageController,
          onTapAnimateToPage: 0,
          child: Text(titleTextEditingController.text.trim()),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class ChecklistSummaryCard extends StatelessWidget {
  const ChecklistSummaryCard({
    Key? key,
    required this.checkpoints,
    required this.pageController,
  }) : super(key: key);

  final List<CheckpointModel> checkpoints;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title:
              '${AppLocalizations.of(context)!.checklist_add_checkpoints_title}: ${checkpoints.length}',
          validator: () => checkpoints.isEmpty
              ? AppLocalizations.of(context)!.checklist_add_checkpoints_empty
              : null,
          pageController: pageController,
          onTapAnimateToPage: 9,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: checkpoints.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        checkpoints[index].title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class DescriptionSummaryCard extends StatelessWidget {
  const DescriptionSummaryCard({
    Key? key,
    required this.descriptionTextEditingController,
    required this.pageController,
  }) : super(key: key);

  final TextEditingController descriptionTextEditingController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.description_optional,
          validator: () => null,
          pageController: pageController,
          onTapAnimateToPage: 0,
          child: Text(descriptionTextEditingController.text.trim()),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class AddDateSummaryCard extends StatelessWidget {
  const AddDateSummaryCard({
    Key? key,
    required this.dateFormat,
    required this.date,
    required this.pageController,
  }) : super(key: key);

  final DateFormat dateFormat;
  final DateTime date;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.add_date,
          validator: () => null,
          pageController: pageController,
          onTapAnimateToPage: 0,
          child: Text(dateFormat.format(date)),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class ConnectedAssetSummaryCard extends StatelessWidget {
  const ConnectedAssetSummaryCard({
    Key? key,
    required this.assetId,
    required this.assetString,
    required this.pageController,
  }) : super(key: key);

  final String assetId;
  final String assetString;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.task_connected_asset,
          validator: () {
            if (assetId.isEmpty) {
              return AppLocalizations.of(context)!.task_connected_asset_select;
            }
            return null;
          },
          pageController: pageController,
          onTapAnimateToPage: 1,
          child: Text(assetString),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class LocationSummaryCard extends StatelessWidget {
  const LocationSummaryCard({
    Key? key,
    required this.locationString,
    required this.pageController,
  }) : super(key: key);

  final String locationString;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.location,
          validator: () => locationString.isEmpty
              ? AppLocalizations.of(context)!.validation_location_not_selected
              : null,
          pageController: pageController,
          onTapAnimateToPage: 2,
          child: Text(locationString),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class SingleOrCyclicTaskSummaryCard extends StatelessWidget {
  const SingleOrCyclicTaskSummaryCard({
    Key? key,
    required this.isCyclicTask,
    required this.durationUnit,
    required this.duration,
    required this.dateFormat,
    required this.executionDate,
    required this.pageController,
  }) : super(key: key);

  final bool isCyclicTask;
  final String durationUnit;
  final int duration;
  final DateFormat dateFormat;
  final DateTime executionDate;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: isCyclicTask
              ? AppLocalizations.of(context)!.task_is_cyclic
              : AppLocalizations.of(context)!.task_not_is_cyclic,
          validator: () {
            if (isCyclicTask) {
              if (durationUnit.isEmpty) {
                return AppLocalizations.of(context)!.duration_unit_not_selected;
              } else if (duration < 1) {
                return AppLocalizations.of(context)!.duration_not_selected;
              }
            }
            return null;
          },
          pageController: pageController,
          onTapAnimateToPage: 6,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class AssignedUsersSummaryCard extends StatelessWidget {
  const AssignedUsersSummaryCard({
    Key? key,
    required this.assignedUsers,
    required this.pageController,
  }) : super(key: key);

  final List<String> assignedUsers;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.task_assigned_users,
          validator: () => null,
          pageController: pageController,
          onTapAnimateToPage: 8,
          child: BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
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
                      8,
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
                itemBuilder: (context, index) => const ShimmerUserListTile(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class AssignedGroupsSummaryCard extends StatelessWidget {
  const AssignedGroupsSummaryCard({
    Key? key,
    required this.assignedGroups,
    required this.pageController,
  }) : super(key: key);

  final List<String> assignedGroups;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.task_assigned_groups,
          validator: () => null,
          pageController: pageController,
          onTapAnimateToPage: 8,
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
                      8,
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
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class NotAssignedSummaryCard extends StatelessWidget {
  const NotAssignedSummaryCard({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.task_assign_groups_or_users,
          validator: () =>
              AppLocalizations.of(context)!.task_assign_groups_or_users_error,
          pageController: pageController,
          onTapAnimateToPage: 8,
          child: const SizedBox(),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class SparePartsSummaryCard extends StatelessWidget {
  const SparePartsSummaryCard({
    Key? key,
    required this.sparePartsAssets,
    required this.sparePartsItems,
    required this.pageController,
  }) : super(key: key);

  final List<String> sparePartsAssets;
  final List<SparePartItemModel> sparePartsItems;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.item_spare_parts,
          validator: () {
            for (var item in sparePartsItems) {
              if (item.quantity <= 0) {
                return AppLocalizations.of(context)!
                    .item_spare_part_quantity_error;
              }
            }
            return null;
          },
          pageController: pageController,
          onTapAnimateToPage: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (sparePartsAssets.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.bottom_bar_title_assets}:',
                      style: const TextStyle(fontSize: 16),
                    ),
                    BlocBuilder<AssetBloc, AssetState>(
                      builder: (context, state) {
                        if (state is AssetLoadedState) {
                          final List<Asset> assets = [];
                          for (var assetId in sparePartsAssets) {
                            final asset = state.getAssetById(assetId);
                            if (asset != null) {
                              assets.add(asset);
                            }
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: assets.length,
                            itemBuilder: (context, index) => Text(
                              '- ${assets[index].producer} ${assets[index].model}',
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              if (sparePartsItems.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.bottom_bar_title_inventory}:',
                      style: const TextStyle(fontSize: 16),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sparePartsItems.length,
                      itemBuilder: (context, index) =>
                          BlocBuilder<ItemsBloc, ItemsState>(
                        builder: (context, state) {
                          if (state is ItemsLoadedState) {
                            final item = state
                                .getItemById(sparePartsItems[index].itemId);
                            if (item != null) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '- ${item.producer} ${item.name}',
                                    ),
                                  ),
                                  Text(
                                      '${sparePartsItems[index].quantity.toStringWithFixedDecimal()}  [${getLocalizedUnitName(context, item.itemUnit)}]')
                                ],
                              );
                            }
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class ImagesSummaryCard extends StatelessWidget {
  const ImagesSummaryCard({
    Key? key,
    required this.images,
    required this.pageController,
  }) : super(key: key);

  final List<File> images;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.asset_add_images_title,
          validator: () => null,
          pageController: pageController,
          onTapAnimateToPage: 3,
          child: Text(
            images.isNotEmpty
                ? '${AppLocalizations.of(context)!.asset_add_images_added}: ${images.length}'
                : AppLocalizations.of(context)!.asset_add_images_not_added,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class VideoSummaryCard extends StatelessWidget {
  const VideoSummaryCard({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SummaryCard(
      title: AppLocalizations.of(context)!.content_video,
      validator: () => null,
      pageController: pageController,
      onTapAnimateToPage: 4,
      child: const SizedBox(),
    );
  }
}
