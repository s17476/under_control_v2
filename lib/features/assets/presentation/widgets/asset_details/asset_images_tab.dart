import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/asset.dart';

class AssetImagesTab extends StatelessWidget {
  const AssetImagesTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: asset.images
          .map(
            (img) => InkWell(
              onTap: () {},
              child: Hero(
                tag: img,
                child: SizedBox.expand(
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (_, __) => SizedBox.expand(
                      child: Shimmer.fromColors(
                        baseColor:
                            Theme.of(context).appBarTheme.backgroundColor!,
                        highlightColor:
                            Theme.of(context).backgroundColor.withAlpha(150),
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
