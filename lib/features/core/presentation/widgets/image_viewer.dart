import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    required this.imageProvider,
    this.backgroundDecoration,
    required this.heroTag,
    this.title,
    this.controller,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final String heroTag;
  final String? title;
  final PhotoViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              backgroundColor: Colors.transparent,
            )
          : null,
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          controller: controller,
          imageProvider: imageProvider,
          backgroundDecoration: backgroundDecoration,
          minScale: PhotoViewComputedScale.contained,
          heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
        ),
      ),
    );
  }
}
