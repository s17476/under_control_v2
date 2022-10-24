import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/assets/utils/get_asset_status_icon.dart';
import 'package:under_control_v2/features/assets/utils/get_localizae_asset_status_name.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../inventory/presentation/widgets/internal_code_row.dart';
import '../../../../inventory/presentation/widgets/price_row.dart';
import '../../../../inventory/presentation/widgets/qr_code_row.dart';
import '../../../domain/entities/asset.dart';
import '../asset_category_row.dart';
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
                      const SizedBox(
                        height: 4,
                      ),
                      // description
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
                            ),
                          ),
                          Text(
                            dateFormat.format(asset.addDate),
                          ),
                        ],
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
