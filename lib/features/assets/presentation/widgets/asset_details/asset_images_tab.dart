import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/presentation/pages/images_carousel.dart';
import '../../../domain/entities/asset.dart';

class AssetImagesTab extends StatelessWidget {
  const AssetImagesTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    if (asset.images.isNotEmpty) {
      return GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: asset.images
            .map(
              (img) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagesCarousel(
                        images: asset.images,
                        initialPage: asset.images.indexOf(img),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: img,
                  child: SizedBox.expand(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.image,
            size: 70,
            color: Theme.of(context).textTheme.caption!.color!,
          ),
          Text(
            AppLocalizations.of(context)!.details_no_images,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
