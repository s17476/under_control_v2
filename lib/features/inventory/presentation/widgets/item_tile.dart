import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/highlighted_text.dart';
import '../../../core/presentation/widgets/icon_title_mini_row.dart';
import '../../../core/utils/double_apis.dart';
import '../../domain/entities/item.dart';
import '../../utils/get_item_total_quantity.dart';
import '../../utils/get_localized_unit_name.dart';
import '../pages/item_details_page.dart';
import 'item_category_mini_row.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
    this.borderRadius = 15,
    this.color = Colors.black,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    required this.searchQuery,
  }) : super(key: key);

  final Item item;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry margin;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final highlightColor = Theme.of(context).highlightColor;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ItemDetailsPage.routeName,
        arguments: item,
      ),
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // item photo or icon
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(borderRadius),
                                bottomRight: Radius.circular(borderRadius),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(borderRadius),
                                bottomRight: Radius.circular(borderRadius),
                              ),
                              child: Container(
                                width: 70,
                                height: 70,
                                color: color,
                                // shows item's photo or an icon if no there is no photo url
                                child: item.itemPhoto.isNotEmpty
                                    ? Hero(
                                        tag: item.id,
                                        child: CachedNetworkImage(
                                          imageUrl: item.itemPhoto,
                                          placeholder: (context, url) =>
                                              const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.api,
                                            size: 50,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.api,
                                        size: 50,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          // item name
                          Expanded(
                            child: HighlightedText(
                              text: item.name,
                              query: searchQuery,
                              highlightColor: highlightColor,
                              style: const TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                      // description
                      if (item.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 8,
                            right: 8,
                          ),
                          child: Text(
                            item.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (item.description.isEmpty)
                        const SizedBox(
                          height: 6,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.item_total_quantity,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        getItemTotalQuantity(item).toStringWithFixedDecimal(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.item_in_selected_quantity,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        getItemTotalQuantity(item).toStringWithFixedDecimal(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 4,
                children: [
                  // category
                  ItemCategoryMiniRow(
                    categoryId: item.category,
                    searchQuery: searchQuery,
                  ),
                  // unit
                  IconTitleMiniRow(
                    title: getLocalizedUnitName(context, item.itemUnit),
                    icon: Icons.balance,
                  ),
                  // qr/bar code
                  if (item.itemBarCode.isNotEmpty)
                    IconTitleMiniRow(
                      title: item.itemBarCode,
                      icon: Icons.qr_code,
                      searchQuery: searchQuery,
                    ),
                  // internal code
                  if (item.itemCode.isNotEmpty)
                    IconTitleMiniRow(
                      title: item.itemCode,
                      icon: Icons.numbers,
                      searchQuery: searchQuery,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
