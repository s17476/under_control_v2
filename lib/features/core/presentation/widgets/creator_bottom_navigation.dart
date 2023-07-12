import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import 'backward_text_button.dart';
import 'forward_text_button.dart';

class CreatorBottomNavigation extends StatefulWidget {
  const CreatorBottomNavigation({
    Key? key,
    this.lastPageForwardButtonFunction,
    this.firstPageBackwardButtonFunction,
    this.lastPageForwardButtonIconData,
    this.forwardButtonIconData = Icons.arrow_forward_ios,
    this.backwardButtonIconData = Icons.arrow_back_ios_new,
    this.firstPageBackwardButtonIconData,
    this.forwardButtonLabel,
    this.lastPageForwardButtonLabel,
    this.backwardButtonLabel,
    this.firstPageBackwardButtonLabel,
    this.forwardButtonColor,
    this.lastPageForwardButtonColor,
    this.backwardButtonColor,
    this.firstPageBackwardButtonColor,
    this.backgroundColor,
    required this.pages,
    required this.pageController,
    this.dotIndicatorPadding,
  }) : super(key: key);

  final Function()? firstPageBackwardButtonFunction;
  final Function()? lastPageForwardButtonFunction;
  final IconData? firstPageBackwardButtonIconData;
  final IconData? lastPageForwardButtonIconData;
  final IconData forwardButtonIconData;
  final IconData backwardButtonIconData;
  final String? firstPageBackwardButtonLabel;
  final String? lastPageForwardButtonLabel;
  final String? forwardButtonLabel;
  final String? backwardButtonLabel;
  final Color? firstPageBackwardButtonColor;
  final Color? lastPageForwardButtonColor;
  final Color? forwardButtonColor;
  final Color? backwardButtonColor;
  final Color? backgroundColor;
  final List<Widget> pages;
  final PageController pageController;
  final EdgeInsetsGeometry? dotIndicatorPadding;

  @override
  State<CreatorBottomNavigation> createState() =>
      _CreatorBottomNavigationState();
}

class _CreatorBottomNavigationState extends State<CreatorBottomNavigation>
    with WidgetsBindingObserver {
  bool _isVisible = true;

  DateTime? _currentBackPressTime;

  void _exitOnDoubleTap() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 5)) {
      _currentBackPressTime = now;
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.back_to_exit_creator,
        isErrorMessage: true,
        showExitButton: true,
      );
    } else {
      Navigator.pop(context);
    }
  }

  // backward
  void _backward() {
    // first page
    if ((widget.pageController.page! + 0.5).toInt() == 0) {
      if (widget.firstPageBackwardButtonFunction == null) {
        Navigator.pop(context);
      } else {
        widget.firstPageBackwardButtonFunction!();
      }
      // other pages
    } else {
      widget.pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // fast backward
  void _fastBackward() {
    // first page
    if ((widget.pageController.page! + 0.5).toInt() == 0) {
      if (widget.firstPageBackwardButtonFunction == null) {
        Navigator.pop(context);
      } else {
        widget.firstPageBackwardButtonFunction!();
      }
      // other pages
    } else {
      widget.pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  IconData _getBackwardIcon() {
    // first page
    if (widget.pageController.page == null ||
        (widget.pageController.page! + 0.5).toInt() == 0) {
      return widget.firstPageBackwardButtonIconData ?? Icons.clear;
      // other pages
    } else {
      return widget.backwardButtonIconData;
    }
  }

  String _getBackwardLabel(BuildContext context) {
    // first page
    if (widget.pageController.page == null ||
        (widget.pageController.page! + 0.5).toInt() == 0) {
      return widget.firstPageBackwardButtonLabel ??
          AppLocalizations.of(context)!.cancel;
      // other pages
    } else {
      return widget.backwardButtonLabel ??
          AppLocalizations.of(context)!
              .user_profile_add_user_personal_data_back;
    }
  }

  Color _getBackwardColor() {
    // first page
    if (widget.pageController.page == null ||
        (widget.pageController.page! + 0.5).toInt() == 0) {
      return widget.firstPageBackwardButtonColor ?? Colors.grey;
      // other pages
    } else {
      return widget.backwardButtonColor ?? Colors.white;
    }
  }

  // forward
  void _forward() {
    // last page
    if ((widget.pageController.page! + 0.5).toInt() ==
        widget.pages.length - 1) {
      if (widget.lastPageForwardButtonFunction != null) {
        widget.lastPageForwardButtonFunction!();
      }
      // other pages
    } else {
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // fast forward
  void _fastForward() {
    // last page
    if ((widget.pageController.page! + 0.5).toInt() ==
        widget.pages.length - 1) {
      if (widget.lastPageForwardButtonFunction != null) {
        widget.lastPageForwardButtonFunction!();
      }
      // other pages
    } else {
      widget.pageController.animateToPage(
        widget.pages.length,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  IconData _getForwardIcon() {
    // last page
    if ((widget.pageController.page != null &&
            (widget.pageController.page! + 0.5).toInt() ==
                widget.pages.length - 1) ||
        widget.pages.length == 1) {
      return widget.lastPageForwardButtonIconData ?? Icons.save;
      // other pages
    } else {
      return widget.forwardButtonIconData;
    }
  }

  String _getForwardLabel(BuildContext context) {
    // last page
    if ((widget.pageController.page != null &&
            (widget.pageController.page! + 0.5).toInt() ==
                widget.pages.length - 1) ||
        widget.pages.length == 1) {
      return widget.lastPageForwardButtonLabel ??
          AppLocalizations.of(context)!
              .user_profile_add_user_personal_data_save;
      // other pages
    } else {
      return widget.forwardButtonLabel ??
          AppLocalizations.of(context)!.user_profile_add_user_next;
    }
  }

  Color _getForwardColor() {
    // last page
    if ((widget.pageController.page != null &&
            (widget.pageController.page! + 0.5).toInt() ==
                widget.pages.length - 1) ||
        widget.pages.length == 1) {
      return widget.lastPageForwardButtonColor ?? Colors.white;
      // other pages
    } else {
      return widget.forwardButtonColor ?? Colors.white;
    }
  }

  @override
  void initState() {
    widget.pageController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    final newValue = bottomInset == 0.0;
    if (newValue != _isVisible) {
      setState(() {
        _isVisible = newValue;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: kIsWeb
            ? EdgeInsets.symmetric(
                horizontal: ResponsiveValue(
                  context,
                  defaultValue: 32,
                  valueWhen: [
                    const Condition.largerThan(name: TABLET, value: 100)
                  ],
                ).value!.toDouble(),
              )
            : Platform.isIOS
                ? const EdgeInsets.only(bottom: 8)
                : null,
        height: _isVisible
            ? kIsWeb
                ? 100
                : Platform.isIOS
                    ? 53
                    : 45
            : 0,
        width: MediaQuery.of(context).size.width,
        color:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // back button
                widget.firstPageBackwardButtonFunction == null &&
                        (widget.pageController.page == null ||
                            (widget.pageController.page != null &&
                                (widget.pageController.page! + 0.5).toInt() ==
                                    0))
                    // first page and first page function is null
                    ? BackwardTextButton(
                        function: _exitOnDoubleTap,
                        onHoldFunction: () {},
                        icon: _getBackwardIcon(),
                        label: _getBackwardLabel(context),
                        color: _getBackwardColor(),
                      )
                    : BackwardTextButton(
                        function: _backward,
                        onHoldFunction: _fastBackward,
                        icon: _getBackwardIcon(),
                        label: _getBackwardLabel(context),
                        color: _getBackwardColor(),
                      ),

                // forward button
                widget.lastPageForwardButtonFunction == null &&
                        (widget.pageController.page != null &&
                            (widget.pageController.page! + 0.5).toInt() ==
                                widget.pages.length - 1)
                    // last page and last page function function is null
                    ? const SizedBox()
                    : ForwardTextButton(
                        function: _forward,
                        onHoldFunction: _fastForward,
                        icon: _getForwardIcon(),
                        label: _getForwardLabel(context),
                        color: _getForwardColor(),
                      ),
              ],
            ),
            Padding(
              padding: widget.dotIndicatorPadding ??
                  const EdgeInsets.symmetric(horizontal: 110),
              child: Row(
                children: [
                  // dot indicator
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: AnimatedSmoothIndicator(
                              activeIndex: widget.pageController.page == null
                                  ? 0
                                  : (widget.pageController.page! + 0.5).toInt(),
                              count: widget.pages.length,
                              effect: WormEffect(
                                activeDotColor: Theme.of(context).primaryColor,
                                dotHeight: 10,
                                dotWidth: 10,
                                type: WormType.thin,
                                paintStyle: PaintingStyle.stroke,
                              ),
                              // effect: JumpingDotEffect(
                              //   dotHeight: 10,
                              //   dotWidth: 10,
                              //   jumpScale: 2,
                              //   activeDotColor: Theme.of(context).primaryColor,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
