import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/responsive_size.dart';

class ShimmerInstructionTile extends StatelessWidget with ResponsiveSize {
  const ShimmerInstructionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // shimmer
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Theme.of(context).cardColor.withAlpha(60),
          child: Container(
            width: double.infinity,
            height: 104,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Container(
                width: responsiveSizePct(small: 60),
                height: 20,
                color: Colors.black26,
              ),
              const SizedBox(
                height: 8,
              ),
              // description
              Container(
                width: responsiveSizePct(small: 80),
                height: 12,
                color: Colors.black26,
              ),
              const SizedBox(
                height: 4,
              ),
              // steps
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 12,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              // category
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.black26,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
