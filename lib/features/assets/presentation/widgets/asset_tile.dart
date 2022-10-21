import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:under_control_v2/features/assets/utils/get_asset_status_icon.dart';

import '../../../core/presentation/widgets/highlighted_text.dart';
import '../../../core/presentation/widgets/icon_title_mini_row.dart';
import '../../domain/entities/asset.dart';
import 'asset_category_mini_row.dart';

class AssetTile extends StatelessWidget {
  const AssetTile({
    Key? key,
    required this.asset,
    this.borderRadius = 15,
    this.color = Colors.black,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    required this.searchQuery,
  }) : super(key: key);

  final Asset asset;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry margin;
  final String searchQuery;
  // final Function(String)? onSelected;
  // final bool? isSelected;

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
          onTap: () {},
          // onSelected != null
          //     ? () => onSelected!(item.id)
          //     :
          // () =>
          // Navigator.pushNamed(
          //       context,
          //       ItemDetailsPage.routeName,
          //       arguments: item,
          //     ),
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
                            // asset photo or icon
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
                                  // shows asset's photo or an icon if no there is no photo url
                                  child: asset.images.isNotEmpty
                                      ? Hero(
                                          tag: asset.id,
                                          child: CachedNetworkImage(
                                            imageUrl: asset.images[0],
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
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.precision_manufacturing,
                                              size: 50,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.precision_manufacturing,
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
                                    text: asset.producer,
                                    query: searchQuery,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  HighlightedText(
                                    text: asset.model,
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
                        // if (asset.description.isNotEmpty)
                        //   Padding(
                        //     padding: const EdgeInsets.only(
                        //       top: 8,
                        //       left: 8,
                        //       right: 8,
                        //     ),
                        //     child: Text(
                        //       asset.description,
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //   ),
                        if (asset.description.isEmpty)
                          const SizedBox(
                            height: 6,
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    height: 50,
                    width: 50,
                    child: getAssetStatusIcon(
                      context,
                      asset.currentStatus,
                    ),
                  ),
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
                    AssetCategoryMiniRow(
                      categoryId: asset.categoryId,
                      searchQuery: searchQuery,
                    ),
                    // qr/bar code
                    if (asset.barCode.isNotEmpty)
                      IconTitleMiniRow(
                        title: asset.barCode,
                        icon: Icons.qr_code,
                        searchQuery: searchQuery,
                      ),
                    // internal code
                    IconTitleMiniRow(
                      title: asset.internalCode,
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
