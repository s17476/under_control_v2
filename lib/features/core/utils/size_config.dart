import 'package:flutter/material.dart';

//this class helps to adjust elements size to different screen sizes
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static bool _isSmallScreen = false;
  static bool _isMediumScreen = false;
  static bool _isLargeScreen = false;

  static bool get isSmallScreen => _isSmallScreen;

  static bool get isMediumScreen => _isMediumScreen;

  static bool get isLagreScreen => _isLargeScreen;

  static double get blockSizeHorizontal {
    return _screenWidth! / 100;
  }

  static double get blockSizeVertical {
    return _screenHeight! / 100;
  }

  static double get safeBlockHorizontal {
    return (_screenWidth! - _safeAreaHorizontal!) / 100;
  }

  static double get safeBlockVertical {
    return (_screenHeight! - _safeAreaVertical!) / 100;
  }

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    if (_mediaQueryData != null) {
      _screenWidth = _mediaQueryData!.size.width;
      _screenHeight = _mediaQueryData!.size.height;
      _safeAreaHorizontal =
          _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
      _safeAreaVertical =
          _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
      // init screen size
      _isSmallScreen = _screenWidth! <= 500 ? true : false;
      _isMediumScreen =
          _screenWidth! > 500 && _screenWidth! <= 800 ? true : false;
      _isLargeScreen = _screenWidth! > 800 ? true : false;
    }
  }
}
