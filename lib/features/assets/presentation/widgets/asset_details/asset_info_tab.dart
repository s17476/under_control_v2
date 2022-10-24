import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../inventory/presentation/widgets/internal_code_row.dart';
import '../../../../inventory/presentation/widgets/price_row.dart';
import '../../../../inventory/presentation/widgets/qr_code_row.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/asset.dart';
import '../../../utils/get_asset_status_icon.dart';
import '../../../utils/get_localizad_duration_unit_name.dart';
import '../../../utils/get_localizae_asset_status_name.dart';
import '../../../utils/get_next_date.dart';
import '../../blocs/asset/asset_bloc.dart';
import '../asset_category_row.dart';
import '../asset_tile.dart';
import 'square_asset_image.dart';

class AssetInfoTab extends StatelessWidget with ResponsiveSize {
  const AssetInfoTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-mm-yyyy');
    final detailedDateFormat = DateFormat('dd-mm-yyyy hh:MM');
    SizeConfig.init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // asset photos
          Stack(
            children: [
              // asset photo
              SquareAssetImage(asset: asset),

              // asset status
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black54,
                  ),
                  child: getAssetStatusIcon(context, asset.currentStatus, 32),
                ),
              ),

              // overlay item data
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.5),
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.9),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  width: responsiveSizePct(small: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // producer
                      Text(
                        asset.producer,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // model
                      Text(
                        asset.model,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (asset.description.isNotEmpty)
                        const SizedBox(
                          height: 4,
                        ),
                      // description
                      if (asset.description.isNotEmpty)
                        Text(
                          asset.description,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // item data
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const Divider(
                  thickness: 1.5,
                ),
                // status
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconTitleRow(
                        icon: Icons.security,
                        iconColor: Colors.white,
                        iconBackground: Colors.black,
                        title: AppLocalizations.of(context)!.asset_status,
                        titleFontSize: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getLocalizedAssetStatusName(
                                context,
                                asset.currentStatus,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: getAssetStatusIcon(
                              context,
                              asset.currentStatus,
                              14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.youtube_searched_for,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title: AppLocalizations.of(context)!
                                  .asset_last_inspection_date,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            detailedDateFormat.format(
                              asset.lastInspection,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // is in use
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: asset.isInUse
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              iconColor: Colors.white,
                              iconBackground: asset.isInUse
                                  ? Theme.of(context).primaryColor
                                  : Colors.orange,
                              title:
                                  AppLocalizations.of(context)!.asset_is_in_use,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            asset.isInUse
                                ? AppLocalizations.of(context)!.yes
                                : AppLocalizations.of(context)!.no,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // is spare part
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon:
                                  asset.isSparePart ? Icons.build : Icons.done,
                              iconColor: Colors.white,
                              iconBackground: !asset.isSparePart
                                  ? Theme.of(context).primaryColor
                                  : Colors.orange,
                              title:
                                  AppLocalizations.of(context)!.item_spare_part,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            asset.isSparePart
                                ? AppLocalizations.of(context)!
                                    .item_spare_part_yes
                                : AppLocalizations.of(context)!
                                    .item_spare_part_not,
                          ),
                        ],
                      ),

                      // current parent
                      if (asset.isSparePart &&
                          asset.isInUse &&
                          asset.currentParentId.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: IconTitleRow(
                                    icon: Icons.precision_manufacturing,
                                    iconColor: Colors.white,
                                    iconBackground:
                                        Theme.of(context).primaryColor,
                                    title: AppLocalizations.of(context)!
                                        .asset_parent,
                                    titleFontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            BlocBuilder<AssetBloc, AssetState>(
                              builder: (context, state) {
                                if (state is AssetLoadedState) {
                                  return AssetTile(
                                    margin: const EdgeInsets.all(0),
                                    asset: state
                                        .getAssetById(asset.currentParentId)!,
                                    searchQuery: '',
                                  );
                                }
                                return const ShimmerItemTile();
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                // next inspection
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconTitleRow(
                        icon: Icons.search,
                        iconColor: Colors.white,
                        iconBackground: Colors.black,
                        title:
                            AppLocalizations.of(context)!.asset_next_inspection,
                        titleFontSize: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // duration unit
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.calendar_today,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title:
                                  AppLocalizations.of(context)!.duration_unit,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            getLocalizedDurationUnitName(
                              context,
                              asset.durationUnit,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // duration
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.numbers,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title: AppLocalizations.of(context)!.duration,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            asset.duration.toString(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // next inspection date
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.calendar_month,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title: AppLocalizations.of(context)!
                                  .asset_next_inspection,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            dateFormat.format(
                              getNextDate(
                                asset.lastInspection,
                                asset.durationUnit,
                                asset.duration,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconTitleRow(
                        icon: Icons.precision_manufacturing,
                        iconColor: Colors.grey.shade300,
                        iconBackground: Colors.black,
                        title: AppLocalizations.of(context)!.asset_data,
                        titleFontSize: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      // category
                      AssetCategoryRow(asset: asset),

                      // add date
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.location_on,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title: AppLocalizations.of(context)!.location,
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
                                asset.locationId,
                                state.allLocations.allLocations,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                          return const SizedBox();
                        },
                      ),

                      // qr code
                      if (asset.barCode.isNotEmpty) const SizedBox(height: 16),
                      if (asset.barCode.isNotEmpty)
                        QrCodeRow(code: asset.barCode),

                      // internal code
                      if (asset.internalCode.isNotEmpty)
                        const SizedBox(height: 16),
                      if (asset.internalCode.isNotEmpty)
                        InternalCodeRow(code: asset.internalCode),

                      // price
                      if (asset.price > 0) const SizedBox(height: 16),
                      if (asset.price > 0) PriceRow(price: asset.price),

                      // add date
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.calendar_month,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title:
                                  AppLocalizations.of(context)!.asset_add_date,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            detailedDateFormat.format(asset.addDate),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }
}
