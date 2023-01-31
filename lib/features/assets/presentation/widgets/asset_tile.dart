import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../notifications/domain/entities/uc_notification.dart';
import '../../../core/presentation/widgets/highlighted_text.dart';
import '../../../core/presentation/widgets/icon_title_mini_row.dart';
import '../../../notifications/presentation/blocs/uc_notification_management/uc_notification_management_bloc.dart';
import '../../domain/entities/asset.dart';
import '../../utils/get_asset_status_icon.dart';
import '../pages/asset_details_page.dart';
import 'asset_category_mini_row.dart';

class AssetTile extends StatelessWidget {
  const AssetTile({
    Key? key,
    required this.asset,
    this.borderRadius = 15,
    this.color = Colors.black,
    this.backgroundColor,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    required this.searchQuery,
    this.onSelected,
    this.isSelected,
    this.groupValue,
    this.onRadioSelected,
    this.notification,
  }) : super(key: key);

  final Asset asset;
  final double borderRadius;
  final Color color;
  final Color? backgroundColor;
  final EdgeInsetsGeometry margin;
  final String searchQuery;
  final Function(String)? onSelected;
  final bool? isSelected;
  final String? groupValue;
  final Function(String)? onRadioSelected;
  final UcNotification? notification;

  @override
  Widget build(BuildContext context) {
    final highlightColor = Theme.of(context).highlightColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? Theme.of(context).cardColor,
      ),
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.transparent,
        child: InkWell(
          // multi selection
          onTap: onSelected != null
              ? () => onSelected!(asset.id)
              // single asset selection
              : onRadioSelected != null
                  ? () => onRadioSelected!(asset.id)
                  // open details page
                  : () {
                      if (notification != null) {
                        context.read<UcNotificationManagementBloc>().add(
                              MarkAsReadEvent(
                                notificationId: notification!.id,
                              ),
                            );
                      }
                      Navigator.pushNamed(
                        context,
                        AssetDetailsPage.routeName,
                        arguments: asset.id,
                      );
                    },
          onLongPress: () => Navigator.pushNamed(
            context,
            AssetDetailsPage.routeName,
            arguments: asset.id,
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
                                      ? CachedNetworkImage(
                                          imageUrl: asset.images[0],
                                          placeholder: (context, url) => Stack(
                                            children: [
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
                                              const SizedBox(
                                                width: double.infinity,
                                                height: 70,
                                                child: Icon(
                                                  Icons.precision_manufacturing,
                                                  size: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.precision_manufacturing,
                                            size: 50,
                                          ),
                                          fit: BoxFit.cover,
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
                                  // notification info
                                  if (notification != null) ...[
                                    Text(
                                      AppLocalizations.of(context)!
                                          .notifications_assets_tile,
                                      style: notification!.read
                                          ? null
                                          : TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                            ),
                                    ),
                                    const Divider(),
                                  ],
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
                        if (asset.description.isEmpty)
                          const SizedBox(
                            height: 6,
                          ),
                      ],
                    ),
                  ),
                  if (onSelected == null && onRadioSelected != null)
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(4),
                      width: 50,
                      height: 50,
                      child: Radio<String>(
                        value: asset.id,
                        groupValue: groupValue,
                        onChanged: (val) => onRadioSelected!(val!),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  if (onSelected != null && onRadioSelected == null)
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(4),
                      width: 50,
                      height: 50,
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (_) => onSelected!(asset.id),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  if (onSelected == null && onRadioSelected == null)
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
