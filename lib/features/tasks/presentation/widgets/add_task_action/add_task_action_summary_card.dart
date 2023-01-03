import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/core/utils/double_apis.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/participants_list.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../assets/domain/entities/asset.dart';
import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/utils/get_localized_unit_name.dart';
import '../../../data/models/task/spare_part_item_model.dart';
import '../../../data/models/task_action/user_action_model.dart';

class AddTaskActionSummaryCard extends StatelessWidget with ResponsiveSize {
  const AddTaskActionSummaryCard({
    Key? key,
    required this.pageController,
    required this.descriptionTextEditingController,
    required this.startTime,
    required this.stopTime,
    required this.participants,
    required this.images,
    required this.removedPartsAssets,
    required this.addedPartsAssets,
    this.replacedAsset,
    this.replacementAsset,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController descriptionTextEditingController;

  final DateTime startTime;
  final DateTime stopTime;

  final List<UserActionModel> participants;
  final List<File> images;

  final List<AssetModel> removedPartsAssets;
  final List<String> addedPartsAssets;

  final AssetModel? replacedAsset;
  final AssetModel? replacementAsset;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    final timeFormat = DateFormat('HH:mm');

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

                    // images
                    if (images.isNotEmpty)
                      ImagesSummaryCard(
                        images: images,
                        pageController: pageController,
                      ),

                    // // spare parts
                    // if (sparePartsAssets.isNotEmpty ||
                    //     sparePartsItems.isNotEmpty)
                    //   SparePartsSummaryCard(
                    //     sparePartsAssets: sparePartsAssets,
                    //     sparePartsItems: sparePartsItems,
                    //     pageController: pageController,
                    //   ),

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
          onTapAnimateToPage: 8,
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
