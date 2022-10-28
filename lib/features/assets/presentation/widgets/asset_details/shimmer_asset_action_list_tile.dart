import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/asset_status.dart';
import '../../../utils/get_asset_status_icon.dart';

class ShimmerAssetActionListTile extends StatelessWidget {
  const ShimmerAssetActionListTile({
    Key? key,
    this.isDashboardTile = false,
  }) : super(key: key);

  final bool isDashboardTile;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // shimmer layer
            Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: Theme.of(context).cardColor.withAlpha(60),
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: 24,
                  right: 8,
                ),
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // content box
            Container(
              margin: const EdgeInsets.only(left: 15),
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
                left: 24,
                right: 8,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // date time
                  Container(
                    width: 110,
                    height: 12,
                    color: Colors.black26,
                  ),

                  // item
                  Container(
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    width: 200,
                    height: 16,
                    color: Colors.black26,
                  ),
                  // location
                  Container(
                    width: 100,
                    height: isDashboardTile ? 14 : 18,
                    color: Colors.black26,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 4,
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black26,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 14,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // status icon
            Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: Theme.of(context).cardColor.withAlpha(60),
              child: SizedBox(
                height: 40,
                width: 40,
                child: getAssetStatusIcon(context, AssetStatus.ok),
              ),
            )
          ],
        ));
  }
}
