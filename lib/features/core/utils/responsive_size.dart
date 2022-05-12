import 'package:under_control_v2/features/core/utils/size_config.dart';

mixin ResponsiveSize {
  double responsiveSizePct(
      {required double small, double? medium, double? large}) {
    if (SizeConfig.isSmallScreen) {
      return SizeConfig.blockSizeHorizontal * small;
    } else if (SizeConfig.isMediumScreen) {
      return SizeConfig.blockSizeHorizontal * (medium ?? small);
    } else {
      return SizeConfig.blockSizeHorizontal * (large ?? medium ?? small);
    }
  }

  double responsiveSizeVerticalPct(
      {required double small, double? medium, double? large}) {
    if (SizeConfig.isSmallScreen) {
      return SizeConfig.blockSizeVertical * small;
    } else if (SizeConfig.isMediumScreen) {
      return SizeConfig.blockSizeVertical * (medium ?? small);
    } else {
      return SizeConfig.blockSizeVertical * (large ?? medium ?? small);
    }
  }

  double responsiveSizePx(
      {required double small, double? medium, double? large}) {
    if (SizeConfig.isSmallScreen) {
      return small;
    } else if (SizeConfig.isMediumScreen) {
      return medium ?? small;
    } else {
      return large ?? medium ?? small;
    }
  }

  bool isSmallScreen() {
    return SizeConfig.isSmallScreen;
  }

  bool isMediumScreen() {
    return SizeConfig.isMediumScreen;
  }

  bool isLargeScreen() {
    return SizeConfig.isLagreScreen;
  }
}
