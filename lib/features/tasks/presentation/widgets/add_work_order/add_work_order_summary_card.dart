import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/task_priority.dart';
import '../../../domain/entities/work_order/work_order.dart';
import '../../../utils/get_localized_task_priority_name.dart';
import '../../../utils/get_task_priority_icon.dart';

class AddWorkOrderSummaryCard extends StatelessWidget with ResponsiveSize {
  const AddWorkOrderSummaryCard({
    Key? key,
    this.workOrder,
    required this.pageController,
    required this.titleTextEditingController,
    required this.descriptionTextEditingController,
    required this.date,
    required this.locationId,
    required this.assetId,
    required this.priority,
    required this.isConnectedToAsset,
    required this.images,
    this.video,
  }) : super(key: key);

  final WorkOrder? workOrder;

  final PageController pageController;

  final TextEditingController titleTextEditingController;
  final TextEditingController descriptionTextEditingController;

  final DateTime date;

  final String locationId;
  final String assetId;
  final String priority;

  final bool isConnectedToAsset;

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

                    //priority
                    SummaryCard(
                      title: AppLocalizations.of(context)!.task_priority,
                      validator: () => priority.isEmpty
                          ? AppLocalizations.of(context)!.task_priority
                          : null,
                      child: Row(
                        children: [
                          getTaskPriorityIcon(
                            context,
                            TaskPriority.fromString(priority),
                            70,
                            const EdgeInsets.only(
                              right: 8,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              getLocalizedTaskPriorityName(
                                context,
                                TaskPriority.fromString(priority),
                              ),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: isConnectedToAsset ? 4 : 5,
                    ),
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
                      onTapAnimateToPage: isConnectedToAsset ? 1 : 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // images
                    SummaryCard(
                      title:
                          AppLocalizations.of(context)!.asset_add_images_title,
                      validator: () => null,
                      child: Text(
                        images.isNotEmpty
                            ? '${AppLocalizations.of(context)!.asset_add_images_added}: ${images.length}'
                            : AppLocalizations.of(context)!
                                .asset_add_images_not_added,
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: isConnectedToAsset ? 2 : 3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // documents
                    if (video != null)
                      SummaryCard(
                        title: AppLocalizations.of(context)!.content_video,
                        validator: () => null,
                        child: const SizedBox(),
                        pageController: pageController,
                        onTapAnimateToPage: isConnectedToAsset ? 3 : 4,
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