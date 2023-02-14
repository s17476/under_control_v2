import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/size_config.dart';
import '../../../domain/entities/item.dart';
import '../../../utils/get_item_quantity_in_locations.dart';
import '../../../utils/get_item_total_quantity.dart';
import '../alarm_row.dart';
import '../internal_code_row.dart';
import '../item_category_row.dart';
import '../item_unit_row.dart';
import '../overlay_info_box.dart';
import '../price_row.dart';
import '../qr_code_row.dart';
import '../square_item_image.dart';
import 'item_actions_tab.dart';

class ItemInfoTab extends StatelessWidget with ResponsiveSize {
  const ItemInfoTab({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // item photo and quantity
          Stack(
            children: [
              // item photo
              SquareItemImage(item: item),
              // quantity info boxes
              Row(
                children: [
                  OverlayQuantityInfoBox(
                    item: item,
                    quantity: getItemTotalQuantity(item),
                    title: AppLocalizations.of(context)!.item_total_quantity,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  OverlayQuantityInfoBox(
                    item: item,
                    quantity: getItemQuantityInLocations(context, item, false),
                    title:
                        AppLocalizations.of(context)!.item_in_selected_quantity,
                    quantityStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
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
                        item.producer,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // name
                      Text(
                        item.name,
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
                        item.description,
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

          const Divider(
            thickness: 1.5,
            endIndent: 8,
            indent: 8,
          ),
          ItemActionButtons(
            item: item,
          ),

          // item data
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const Divider(
                  thickness: 1.5,
                ),
                if (item.alertQuantity != null &&
                    item.alertQuantity! >=
                        getItemQuantityInLocations(context, item, false))
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).errorColor.withAlpha(80),
                              Theme.of(context).errorColor,
                              Theme.of(context).errorColor.withAlpha(80)
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context)!.quantity_low_level,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconTitleRow(
                        icon: Icons.api,
                        iconColor: Colors.grey.shade300,
                        iconBackground: Colors.black,
                        title: AppLocalizations.of(context)!.item_details_data,
                        titleFontSize: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // category
                      ItemCategoryRow(item: item),
                      const SizedBox(height: 16),
                      // unit
                      ItemUnitRow(item: item),
                      // qr code
                      if (item.itemBarCode.isNotEmpty)
                        const SizedBox(height: 16),
                      if (item.itemBarCode.isNotEmpty)
                        QrCodeRow(code: item.itemBarCode),
                      // internal code
                      if (item.itemCode.isNotEmpty) const SizedBox(height: 16),
                      if (item.itemCode.isNotEmpty)
                        InternalCodeRow(code: item.itemCode),
                      // price
                      if (item.price > 0) const SizedBox(height: 16),
                      if (item.price > 0) PriceRow(price: item.price),
                      // alarm quantity
                      const SizedBox(height: 16),
                      if (item.alertQuantity != null &&
                          item.alertQuantity! >= 0)
                        AlarmRow(item: item),
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
