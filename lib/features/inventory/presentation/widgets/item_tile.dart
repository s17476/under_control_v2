import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/presentation/widgets/highlighted_text.dart';
import '../../../core/presentation/widgets/icon_title_mini_row.dart';
import '../../../core/utils/double_apis.dart';
import '../../domain/entities/item.dart';
import '../../utils/get_item_quantity_in_locations.dart';
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
    this.onSelected,
    this.isSelected,
  }) : super(key: key);

  final Item item;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry margin;
  final String searchQuery;
  final Function(String)? onSelected;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    final highlightColor = Theme.of(context).highlightColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Theme.of(context).cardColor,
      ),
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onSelected != null
              ? () => onSelected!(item.id)
              : () => Navigator.pushNamed(
                    context,
                    ItemDetailsPage.routeName,
                    arguments: item,
                  ),
          onLongPress: () => Navigator.pushNamed(
            context,
            ItemDetailsPage.routeName,
            arguments: item,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ? CachedNetworkImage(
                                          imageUrl: item.itemPhoto,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            highlightColor:
                                                Theme.of(context).cardColor,
                                            child: Container(
                                              color: Colors.black,
                                              width: double.infinity,
                                              height: 70,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.api,
                                            size: 50,
                                          ),
                                          fit: BoxFit.cover,
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
                            // item model
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  HighlightedText(
                                    text: item.producer,
                                    query: searchQuery,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  HighlightedText(
                                    text: item.name,
                                    query: searchQuery,
                                    highlightColor: highlightColor,
                                    style: const TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
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
                  Builder(builder: (context) {
                    final quantity = getItemQuantityInLocations(context, item);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (onSelected != null && isSelected != null)
                          Container(
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.only(
                              top: 4,
                              right: 4,
                              left: 4,
                            ),
                            width: 70,
                            // height: 80,
                            child: Checkbox(
                              value: isSelected,
                              onChanged: (_) => onSelected!(item.id),
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        // if (onSelected == null || isSelected == null)
                        Stack(
                          children: [
                            // warning icon
                            if (item.alertQuantity != null &&
                                quantity <= item.alertQuantity!)
                              Container(
                                alignment: Alignment.topRight,
                                padding:
                                    (onSelected != null || isSelected != null)
                                        ? const EdgeInsets.only(right: 4)
                                        : const EdgeInsets.all(4),
                                width: 70,
                                height:
                                    (onSelected != null || isSelected != null)
                                        ? 50
                                        : 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(borderRadius),
                                  ),
                                ),
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  size:
                                      (onSelected != null || isSelected != null)
                                          ? 14
                                          : 26,
                                  color: Colors.amber,
                                ),
                              ),
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: (onSelected != null || isSelected != null)
                                  ? 50
                                  : 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(borderRadius),
                                ),
                              ),
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    quantity.toStringWithFixedDecimal(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: (item.alertQuantity != null &&
                                              quantity <= item.alertQuantity!)
                                          ? Colors.amber
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
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
      ),
    );
  }
}
