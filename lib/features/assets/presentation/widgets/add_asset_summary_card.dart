import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart';

import '../../../core/presentation/widgets/summary_card.dart';
import '../../../core/utils/double_apis.dart';
import '../../../core/utils/duration_unit.dart';
import '../../../core/utils/location_selection_helpers.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../utils/asset_status.dart';
import '../../utils/get_localizad_duration_unit_name.dart';
import '../../utils/get_localizae_asset_status_name.dart';
import '../../utils/get_next_date.dart';
import '../blocs/asset/asset_bloc.dart';
import '../blocs/asset_category/asset_category_bloc.dart';

class AddAssetSummaryCard extends StatelessWidget with ResponsiveSize {
  const AddAssetSummaryCard({
    Key? key,
    required this.pageController,
    required this.producerTextEditingController,
    required this.modelTextEditingController,
    required this.descriptionTextEditingController,
    required this.priceTextEditingController,
    required this.internalCodeTextEditingController,
    required this.barCodeTextEditingController,
    required this.addDate,
    required this.lastInspectionDate,
    required this.category,
    required this.selectedLocation,
    required this.assetStatus,
    required this.durationUnit,
    required this.parentId,
    required this.duration,
    required this.isSparePart,
    required this.isInUse,
    required this.spareParts,
    required this.instructions,
    required this.images,
    required this.documents,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController producerTextEditingController;
  final TextEditingController modelTextEditingController;
  final TextEditingController descriptionTextEditingController;
  final TextEditingController priceTextEditingController;
  final TextEditingController internalCodeTextEditingController;
  final TextEditingController barCodeTextEditingController;

  final DateTime addDate;
  final DateTime lastInspectionDate;

  final String category;
  final String selectedLocation;
  final String assetStatus;
  final String durationUnit;
  final String parentId;

  final int duration;

  final bool isSparePart;
  final bool isInUse;

  final List<String> spareParts;
  final List<String> instructions;

  final List<File> images;
  final List<File> documents;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    // category name
    String categoryName = '';
    final assetCategoryState = context.read<AssetCategoryBloc>().state;
    if (category.isNotEmpty && assetCategoryState is AssetCategoryLoadedState) {
      categoryName = assetCategoryState.allAssetsCategories.allAssetsCategories
          .firstWhere((cat) => cat.id == category)
          .name;
    }

    //
    //
    //
    print('context.read<AssetInternalNumberCubit>().state');
    print(context.read<AssetInternalNumberCubit>().state);

    // price format
    String priceString = '';
    try {
      final price = double.parse(priceTextEditingController.text);

      priceString = price.toStringWithFixedDecimal(decimalPlaces: 2);
    } catch (e) {
      priceString = priceTextEditingController.text;
    }
    // location
    String locationString = '';
    try {
      final locationState = context.read<LocationBloc>().state;
      if (selectedLocation.isNotEmpty && locationState is LocationLoadedState) {
        locationString = getBreadcrumbsForLocation(
          selectedLocation,
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

                    // producer
                    SummaryCard(
                      title: AppLocalizations.of(context)!.item_producer,
                      validator: () =>
                          producerTextEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child: Text(producerTextEditingController.text.trim()),
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    // model
                    SummaryCard(
                      title: AppLocalizations.of(context)!.item_name,
                      validator: () =>
                          modelTextEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child: Text(modelTextEditingController.text.trim()),
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

                    // category
                    SummaryCard(
                      title: AppLocalizations.of(context)!.category,
                      validator: () => category.isEmpty
                          ? AppLocalizations.of(context)!.category_no_select
                          : null,
                      child: Text(categoryName),
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // price
                    if (priceString.isNotEmpty && priceString != '0')
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .item_unit_price_optional,
                        validator: () {
                          try {
                            final price =
                                double.parse(priceTextEditingController.text);
                            if (price < 0) {
                              return AppLocalizations.of(context)!
                                  .incorrect_price_to_small;
                            }
                          } catch (e) {
                            return AppLocalizations.of(context)!
                                .incorrect_price_format;
                          }
                          return null;
                        },
                        child: Text(priceString),
                        pageController: pageController,
                        onTapAnimateToPage: 1,
                      ),

                    if (priceString.isNotEmpty && priceString != '0')
                      const SizedBox(
                        height: 8,
                      ),

                    // internal code
                    SummaryCard(
                      title: AppLocalizations.of(context)!.item_internal_code,
                      validator: () =>
                          internalCodeTextEditingController.text.trim().length <
                                  2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child:
                          Text(internalCodeTextEditingController.text.trim()),
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    //item bar/QR code
                    if (barCodeTextEditingController.text.trim().isNotEmpty)
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .item_bar_code_optional,
                        validator: () => null,
                        child: Text(barCodeTextEditingController.text.trim()),
                        pageController: pageController,
                        onTapAnimateToPage: 1,
                      ),

                    if (barCodeTextEditingController.text.trim().isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // add date
                    SummaryCard(
                      title: AppLocalizations.of(context)!.add_date,
                      validator: () => null,
                      child: Text(dateFormat.format(addDate)),
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                    ),
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

                    // last inspection date
                    SummaryCard(
                      title: AppLocalizations.of(context)!
                          .asset_last_inspection_date,
                      validator: () => null,
                      child: Text(dateFormat.format(lastInspectionDate)),
                      pageController: pageController,
                      onTapAnimateToPage: 3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    //asset status
                    SummaryCard(
                      title: AppLocalizations.of(context)!.asset_status,
                      validator: () => assetStatus.isEmpty
                          ? AppLocalizations.of(context)!
                              .asset_status_not_selected
                          : null,
                      child: Text(
                        getLocalizedAssetStatusName(
                          context,
                          AssetStatus.fromString(
                            assetStatus,
                          ),
                        ),
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 3,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //duration unit and duration
                    SummaryCard(
                      title:
                          AppLocalizations.of(context)!.asset_next_inspection,
                      validator: () => (durationUnit.isEmpty || duration == 0)
                          ? AppLocalizations.of(context)!
                              .asset_next_inspection_tip
                          : null,
                      child: (durationUnit.isNotEmpty || duration != 0)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.duration_unit}:\n${getLocalizedDurationUnitName(
                                    context,
                                    DurationUnit.fromString(
                                      durationUnit,
                                    ),
                                  )}',
                                ),
                                Text(
                                  '${AppLocalizations.of(context)!.duration}:\n$duration',
                                ),
                                Text(
                                    '${AppLocalizations.of(context)!.asset_next_inspection}:\n${dateFormat.format(getNextDate(
                                  lastInspectionDate,
                                  DurationUnit.fromString(durationUnit),
                                  duration,
                                ))}'),
                              ],
                            )
                          : const SizedBox(),
                      pageController: pageController,
                      onTapAnimateToPage: 3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // is spare part
                    SummaryCard(
                      title: AppLocalizations.of(context)!.asset_type,
                      validator: () => null,
                      child: Text(
                        isSparePart
                            ? AppLocalizations.of(context)!.asset_spare_part
                            : AppLocalizations.of(context)!
                                .asset_not_spare_part,
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 4,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // is in use
                    SummaryCard(
                      title: AppLocalizations.of(context)!.asset_is_in_use,
                      validator: () => null,
                      child: Text(
                        isInUse
                            ? AppLocalizations.of(context)!.asset_in_use
                            : AppLocalizations.of(context)!.asset_not_in_use,
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 5,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // parent asset
                    if (isSparePart && isInUse)
                      SummaryCard(
                        title: AppLocalizations.of(context)!.asset_parent,
                        validator: () {
                          if (parentId.isEmpty) {
                            return AppLocalizations.of(context)!
                                .asset_parent_select;
                          }
                          return null;
                        },
                        child: BlocBuilder<AssetBloc, AssetState>(
                          builder: (context, state) {
                            if (state is AssetLoadedState) {
                              final parent = state.getAssetById(parentId);
                              if (parent != null) {
                                return Text(
                                  '${parent.producer} ${parent.model} ${parent.internalCode}',
                                );
                              }
                              return const Text('');
                            }
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          },
                        ),
                        pageController: pageController,
                        onTapAnimateToPage: 5,
                      ),
                    const SizedBox(
                      height: 8,
                    ),

                    // spare parts
                    SummaryCard(
                      title: AppLocalizations.of(context)!.asset_spare_parts,
                      validator: () => null,
                      child: Text(
                        spareParts.isNotEmpty
                            ? '${AppLocalizations.of(context)!.asset_spare_parts_added}: ${spareParts.length}'
                            : AppLocalizations.of(context)!
                                .asset_spare_parts_not_added,
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 6,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // instructions
                    SummaryCard(
                      title: AppLocalizations.of(context)!
                          .asset_add_instructions_title,
                      validator: () => null,
                      child: Text(
                        instructions.isNotEmpty
                            ? '${AppLocalizations.of(context)!.asset_add_instructions_added}: ${instructions.length}'
                            : AppLocalizations.of(context)!
                                .asset_add_instructions_not_added,
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 7,
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
                      onTapAnimateToPage: 8,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // documents
                    SummaryCard(
                      title: AppLocalizations.of(context)!
                          .asset_add_documents_title,
                      validator: () => null,
                      child: Text(
                        documents.isNotEmpty
                            ? '${AppLocalizations.of(context)!.asset_add_documents_added}: ${documents.length}'
                            : AppLocalizations.of(context)!
                                .asset_add_documents_not_added,
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 9,
                    ),
                    const SizedBox(
                      height: 8,
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
