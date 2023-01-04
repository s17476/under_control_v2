import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTaskActionTile extends StatelessWidget {
  const ShimmerTaskActionTile({
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
            width: double.infinity,
            height: 120,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black26,
                height: 14,
                width: 200,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.black26,
                height: 24,
                width: double.infinity,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.black26,
                height: 14,
                width: 150,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black26,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black26,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black26,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black26,
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
