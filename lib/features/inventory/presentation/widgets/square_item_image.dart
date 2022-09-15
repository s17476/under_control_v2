import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';

import '../../../core/presentation/widgets/image_viewer.dart';
import '../../domain/entities/item.dart';

class SquareItemImage extends StatelessWidget with ResponsiveSize {
  const SquareItemImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return InkWell(
      onTap: item.itemPhoto.isNotEmpty
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewer(
                    imageProvider: CachedNetworkImageProvider(item.itemPhoto),
                    heroTag: item.id,
                    title: item.name,
                  ),
                ),
              );
            }
          : () {},
      child: SizedBox(
        width: responsiveSizePct(small: 100),
        height: responsiveSizePct(small: item.itemPhoto.isNotEmpty ? 100 : 60),
        child: CachedNetworkImage(
          imageUrl: item.itemPhoto,
          placeholder: (context, url) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(
              Icons.api,
              size: responsiveSizePct(small: 30),
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
