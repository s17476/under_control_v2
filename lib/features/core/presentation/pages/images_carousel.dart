import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/image_viewer.dart';

class ImagesCarousel extends StatefulWidget {
  const ImagesCarousel({
    Key? key,
    required this.images,
    this.initialPage = 0,
  }) : super(key: key);

  static const routeName = 'imagesCarousel';

  final List<String> images;
  final int initialPage;

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  late PageController _pageController;
  late int _pageIndex;
  late List<PhotoViewController> _photoViewControllers;
  late List<ImageViewer> _pages;
  bool _canScroll = true;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPage);
    _pageIndex = widget.initialPage;
    _photoViewControllers = [];
    for (int i = 0; i < widget.images.length; i++) {
      _photoViewControllers.add(PhotoViewController());
    }

    _pageController.addListener(() {
      setState(() {
        _pageIndex = (_pageController.page! + 0.5).toInt();
      });
    });

    // init controllers
    for (var ctrl in _photoViewControllers) {
      ctrl.addIgnorableListener(() {
        if (ctrl.scale! > 0.30) {
          setState(() {
            _canScroll = false;
          });
        } else {
          setState(() {
            _canScroll = true;
          });
        }
      });
    }

    _pages = [];
    for (int i = 0; i < widget.images.length; i++) {
      _pages.add(
        ImageViewer(
          controller: _photoViewControllers[i],
          imageProvider: CachedNetworkImageProvider(widget.images[i]),
          heroTag: widget.images[i],
        ),
      );
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    for (var ctrl in _photoViewControllers) {
      ctrl.dispose();
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView(
          physics: !_canScroll ? const NeverScrollableScrollPhysics() : null,
          controller: _pageController,
          pageSnapping: true,
          children: _pages,
        ),
        Positioned(
          bottom: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: _pageIndex,
                count: _pages.length,
                effect: WormEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                  dotHeight: 10,
                  dotWidth: 10,
                  type: WormType.thin,
                  paintStyle: PaintingStyle.stroke,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
