import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/item_details_page.dart';

import '../../domain/entities/item.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
    this.borderRadius = 15,
    this.color = Colors.orange,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  }) : super(key: key);

  final Item item;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
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
                        color: Theme.of(context).shadowColor.withOpacity(0.5),
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
                                placeholder: (context, url) => const Padding(
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
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            ),
            if (item.description.isNotEmpty)
              Text(
                item.description,
                overflow: TextOverflow.ellipsis,
              )
          ],
        ),
      ),
    );
  }
}
