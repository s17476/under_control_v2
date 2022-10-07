import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemActionListTile extends StatelessWidget {
  const ShimmerItemActionListTile({
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
                margin: const EdgeInsets.only(left: 15),
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: 24,
                  right: 8,
                ),
                width: double.infinity,
                height: 110,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                          height: 22,
                          color: Colors.black26,
                        ),
                        // location
                        Container(
                          width: 100,
                          height: isDashboardTile ? 14 : 18,
                          color: Colors.black26,
                        ),
                        // description
                        Container(
                          margin: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                            right: 4,
                          ),
                          width: double.infinity,
                          height: 12,
                          color: Colors.black26,
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
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            // icon box
            Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 30,
              width: 30,
            ),
          ],
        ));
  }
}
