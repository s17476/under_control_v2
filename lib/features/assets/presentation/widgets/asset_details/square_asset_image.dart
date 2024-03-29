import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/pages/images_carousel.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/size_config.dart';
import '../../../domain/entities/asset.dart';

class SquareAssetImage extends StatelessWidget with ResponsiveSize {
  const SquareAssetImage({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return InkWell(
      onTap: asset.images.isNotEmpty
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagesCarousel(
                    images: asset.images,
                  ),
                ),
              );
            }
          : () {},
      child: SizedBox(
        width: responsiveSizePct(small: 100),
        height: responsiveSizePct(small: asset.images.isNotEmpty ? 100 : 60),
        child: asset.images.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: asset.images[0],
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.precision_manufacturing,
                    size: responsiveSizePct(small: 30),
                  ),
                ),
                fit: BoxFit.cover,
              )
            : Center(
                child: Icon(
                  Icons.precision_manufacturing,
                  size: responsiveSizePct(small: 30),
                ),
              ),
      ),
    );
  }
}
