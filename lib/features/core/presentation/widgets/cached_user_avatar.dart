import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedUserAvatar extends StatelessWidget {
  const CachedUserAvatar({
    Key? key,
    required this.size,
    required this.imageUrl,
  }) : super(key: key);

  final double size;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        height: size,
        width: size,
        fit: BoxFit.fitWidth,
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            const Icon(Icons.image_not_supported_rounded),
      ),
    );
  }
}
