import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemTile extends StatelessWidget {
  const ShimmerItemTile({
    Key? key,
    this.borderRadius = 15,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  }) : super(key: key);

  final double borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Theme.of(context).cardColor.withAlpha(60),
          child: Container(
            width: double.infinity,
            height: 130,
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.black,
            ),
          ),
        ),
        // foreground
        Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
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
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(borderRadius),
                                bottomRight: Radius.circular(borderRadius),
                              ),
                              child: Container(
                                width: 70,
                                height: 70,
                                color: Colors.black26,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            // item name
                            Expanded(
                              child: Container(
                                height: 24,
                                color: Colors.black26,
                              ),
                            )
                          ],
                        ),
                        // description
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 8,
                            right: 8,
                          ),
                          child: Container(
                            height: 16,
                            color: Colors.black26,
                          ),
                        ),
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
                        Container(
                          height: 12,
                          width: 120,
                          color: Colors.black26,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 24,
                          width: 24,
                          color: Colors.black26,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 12,
                          width: 120,
                          color: Colors.black26,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 28,
                          width: 30,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
