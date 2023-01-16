import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../assets/domain/entities/asset.dart';
import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';
import '../../../../assets/utils/asset_status.dart';
import '../../../../assets/utils/get_asset_status_icon.dart';
import '../../../../assets/utils/get_localizae_asset_status_name.dart';
import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/utils/get_localized_unit_name.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../../../data/models/task_action/user_action_model.dart';
import '../participants_list.dart';

class AddTaskActionSummaryCard extends StatelessWidget with ResponsiveSize {
  const AddTaskActionSummaryCard({
    Key? key,
    required this.pageController,
    required this.descriptionTextEditingController,
    required this.startTime,
    required this.stopTime,
    required this.participants,
    required this.images,
    required this.sparePartsItems,
    required this.removedPartsAssets,
    required this.addedPartsAssets,
    required this.checklist,
    required this.replacedAsset,
    required this.replacementAsset,
    required this.assetStatus,
    required this.isConnectedToAnAsset,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController descriptionTextEditingController;

  final DateTime startTime;
  final DateTime stopTime;

  final List<UserActionModel> participants;
  final List<File> images;

  final List<SparePartItemModel> sparePartsItems;
  final List<AssetModel> removedPartsAssets;
  final List<String> addedPartsAssets;
  final List<CheckpointModel> checklist;

  final AssetModel? replacedAsset;
  final AssetModel? replacementAsset;

  final AssetStatus? assetStatus;

  final bool isConnectedToAnAsset;

  @override
  Widget build(BuildContext context) {
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

                    // description
                    DescriptionSummaryCard(
                      descriptionTextEditingController:
                          descriptionTextEditingController,
                      pageController: pageController,
                    ),

                    // participants
                    ParticipantsSummaryCard(
                      participants: participants,
                      pageController: pageController,
                    ),

                    // checklist
                    if (checklist.isNotEmpty)
                      ChecklistSummaryCard(
                        checklist: checklist,
                        pageController: pageController,
                      ),

                    // asset's new status
                    if (isConnectedToAnAsset && replacedAsset == null)
                      AssetStatusSummaryCard(
                        assetStatus: assetStatus,
                        replacedAsset: replacedAsset,
                        pageController: pageController,
                      ),

                    // images
                    if (images.isNotEmpty)
                      ImagesSummaryCard(
                        images: images,
                        pageController: pageController,
                      ),

                    // used items
                    if (sparePartsItems.isNotEmpty)
                      UsedItemsSummaryCard(
                        sparePartsItems: sparePartsItems,
                        pageController: pageController,
                      ),

                    // spare parts
                    if (removedPartsAssets.isNotEmpty ||
                        addedPartsAssets.isNotEmpty)
                      SparePartsSummaryCard(
                        removedPartsAssets: removedPartsAssets,
                        addedPartsAssets: addedPartsAssets,
                        pageController: pageController,
                      ),

                    // connected asset
                    if (replacedAsset != null)
                      ConnectedAssetSummaryCard(
                        replacedAsset: replacedAsset,
                        replacementAsset: replacementAsset,
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
          title: AppLocalizations.of(context)!.description,
          validator: () =>
              descriptionTextEditingController.text.trim().length < 2
                  ? AppLocalizations.of(context)!.validation_min_two_characters
                  : null,
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

class ParticipantsSummaryCard extends StatelessWidget {
  const ParticipantsSummaryCard({
    Key? key,
    required this.participants,
    required this.pageController,
  }) : super(key: key);

  final List<UserActionModel> participants;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.task_action_participants,
          validator: () {
            if (participants.isEmpty) {
              return AppLocalizations.of(context)!
                  .task_action_add_participants_no_selected;
            } else {
              //validate duration - min. 5 minutes
              Duration totalDuration = const Duration();
              for (var participant in participants) {
                if (participant.totalTime.inMinutes < 5) {
                  return AppLocalizations.of(context)!
                      .task_action_user_duration_to_short;
                }
                totalDuration +=
                    participant.stopTime.difference(participant.startTime);
              }
              if (totalDuration.inMinutes < 5) {
                return AppLocalizations.of(context)!
                    .task_action_duration_to_short;
              }
              return null;
            }
          },
          pageController: pageController,
          onTapAnimateToPage: 1,
          child: IgnorePointer(
            child: ParticipantsList(
              participants: participants,
              toggleParticipantSelection: (_) {},
              updateParticipant: (_) {},
              isEnabled: false,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class UsedItemsSummaryCard extends StatelessWidget {
  const UsedItemsSummaryCard({
    Key? key,
    required this.sparePartsItems,
    required this.pageController,
  }) : super(key: key);

  final List<SparePartItemModel> sparePartsItems;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title:
              '${AppLocalizations.of(context)!.item_spare_parts} - ${AppLocalizations.of(context)!.bottom_bar_title_inventory}',
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
          onTapAnimateToPage: 3,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sparePartsItems.length,
            itemBuilder: (context, index) => BlocBuilder<ItemsBloc, ItemsState>(
              builder: (context, state) {
                if (state is ItemsLoadedState) {
                  final item = state.getItemById(sparePartsItems[index].itemId);
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
          onTapAnimateToPage: 2,
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

class AssetStatusSummaryCard extends StatelessWidget {
  const AssetStatusSummaryCard({
    Key? key,
    required this.assetStatus,
    required this.replacedAsset,
    required this.pageController,
  }) : super(key: key);

  final AssetStatus? assetStatus;
  final AssetModel? replacedAsset;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.asset_status,
          validator: () {
            if (replacedAsset == null) {
              if (assetStatus == null ||
                  assetStatus == AssetStatus.unknown ||
                  assetStatus == AssetStatus.disposed ||
                  assetStatus == AssetStatus.noInspection) {
                return AppLocalizations.of(context)!.asset_status_not_selected;
              }
            }
            return null;
          },
          pageController: pageController,
          onTapAnimateToPage: 6,
          child: Builder(builder: (context) {
            if (assetStatus == null) {
              return const SizedBox();
            }
            return Row(
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: getAssetStatusIcon(
                    context,
                    assetStatus!,
                    30,
                    true,
                  ),
                ),
                Expanded(
                  child: Text(
                    getLocalizedAssetStatusName(
                      context,
                      assetStatus!,
                    ),
                  ),
                ),
              ],
            );
          }),
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
    required this.removedPartsAssets,
    required this.addedPartsAssets,
    required this.pageController,
  }) : super(key: key);

  final List<AssetModel> removedPartsAssets;
  final List<String> addedPartsAssets;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.item_spare_parts,
          validator: () => null,
          pageController: pageController,
          onTapAnimateToPage: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (removedPartsAssets.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.asset_removed}:',
                      style: const TextStyle(fontSize: 16),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: removedPartsAssets.length,
                      itemBuilder: (context, index) => Text(
                        '- ${removedPartsAssets[index].producer} ${removedPartsAssets[index].model}',
                      ),
                    ),
                  ],
                ),
              if (addedPartsAssets.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.asset_used}:',
                      style: const TextStyle(fontSize: 16),
                    ),
                    BlocBuilder<AssetBloc, AssetState>(
                      builder: (context, state) {
                        if (state is AssetLoadedState) {
                          final List<Asset> assets = [];
                          for (var assetId in addedPartsAssets) {
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
                              '+ ${assets[index].producer} ${assets[index].model}',
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    )
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

class ConnectedAssetSummaryCard extends StatelessWidget {
  const ConnectedAssetSummaryCard({
    Key? key,
    required this.replacedAsset,
    required this.replacementAsset,
    required this.pageController,
  }) : super(key: key);

  final AssetModel? replacedAsset;
  final AssetModel? replacementAsset;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.task_connected_asset,
          validator: () {
            if (replacementAsset == null) {
              return AppLocalizations.of(context)!
                  .task_action_replaced_asset_err;
            }
            return null;
          },
          pageController: pageController,
          onTapAnimateToPage: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (replacedAsset != null)
                IgnorePointer(
                  child: AssetTile(
                    margin: EdgeInsets.zero,
                    asset: replacedAsset!,
                    searchQuery: '',
                  ),
                ),
              if (replacementAsset != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${AppLocalizations.of(context)!.asset_replaced_with}:',
                  ),
                ),
                IgnorePointer(
                  child: AssetTile(
                    margin: EdgeInsets.zero,
                    asset: replacementAsset!,
                    searchQuery: '',
                  ),
                )
              ],
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

class ChecklistSummaryCard extends StatelessWidget {
  const ChecklistSummaryCard({
    Key? key,
    required this.checklist,
    required this.pageController,
  }) : super(key: key);

  final List<CheckpointModel> checklist;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          title: AppLocalizations.of(context)!.checklist,
          validator: () => null,
          pageController: pageController,
          onTapAnimateToPage: 7,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: checklist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline_outlined),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(checklist[index].title),
                        ],
                      ),
                    ),
                    Icon(
                      checklist[index].isChecked
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
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
