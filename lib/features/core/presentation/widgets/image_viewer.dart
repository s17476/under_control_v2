import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageProvider,
    required this.heroTag,
    this.title,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String heroTag;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
        ),
      ),
    );
  }
}
