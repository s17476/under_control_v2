import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustomDropdownButton extends StatelessWidget {
  const ShimmerCustomDropdownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Theme.of(context).cardColor.withAlpha(60),
          child: Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
