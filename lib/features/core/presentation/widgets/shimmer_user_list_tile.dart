import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserListTile extends StatelessWidget {
  const ShimmerUserListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Theme.of(context).cardColor.withAlpha(60),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: 200,
                height: 24,
                color: Colors.black,
              ),
              const Expanded(child: SizedBox()),
              Container(
                height: 36,
                width: 36,
                color: Colors.black,
              ),
              const SizedBox(
                width: 2,
              )
            ],
          ),
        ),
      ],
    );
  }
}
