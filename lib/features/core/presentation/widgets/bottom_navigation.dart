import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'backward_text_button.dart';
import 'forward_text_button.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    this.forwardButtonFunction,
    this.backwardButtonFunction,
    this.forwardButtonIconData,
    this.backwardButtonIconData,
    this.forwardButtonLabel,
    this.backwardButtonLabel,
    this.forwardButtonColor,
    this.backwardButtonColor,
    required this.lastPageForwardButtonFunction,
    required this.firstPageBackwardButtonFunction,
    required this.lastPageForwardButtonIconData,
    required this.firstPageBackwardButtonIconData,
    required this.lastPageForwardButtonLabel,
    required this.firstPageBackwardButtonLabel,
    required this.lastPageForwardButtonColor,
    required this.firstPageBackwardButtonColor,
    required this.pages,
  }) : super(key: key);

  final Function()? forwardButtonFunction;
  final Function() lastPageForwardButtonFunction;
  final Function()? backwardButtonFunction;
  final Function() firstPageBackwardButtonFunction;
  final IconData lastPageForwardButtonIconData;
  final IconData? forwardButtonIconData;
  final IconData? backwardButtonIconData;
  final IconData firstPageBackwardButtonIconData;
  final String? forwardButtonLabel;
  final String lastPageForwardButtonLabel;
  final String? backwardButtonLabel;
  final String firstPageBackwardButtonLabel;
  final Color? forwardButtonColor;
  final Color lastPageForwardButtonColor;
  final Color? backwardButtonColor;
  final Color firstPageBackwardButtonColor;
  final List<Widget> pages;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  PageController pageController = PageController();
  bool isFirstPage = true;
  bool isLastPage = false;
  int currentPage = 0;

  void backward({bool isSwipe = false}) {
    if (isFirstPage && !isSwipe) {
      widget.firstPageBackwardButtonFunction();
    } else if (!isFirstPage) {
      if (widget.backwardButtonFunction != null) {
        widget.backwardButtonFunction!();
      } else {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
      currentPage--;
      setState(() {
        if (currentPage == 0) {
          isFirstPage = true;
        } else {
          isFirstPage = false;
        }
        isLastPage = false;
      });
    }
  }

  void forward({bool isSwipe = false}) {
    if (isLastPage && !isSwipe) {
      widget.lastPageForwardButtonFunction();
    } else if (!isLastPage) {
      if (widget.forwardButtonFunction != null) {
        widget.forwardButtonFunction!();
      } else {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
      currentPage++;
      setState(() {
        if (currentPage == widget.pages.length - 1) {
          isLastPage = true;
        } else {
          isLastPage = false;
        }
        isFirstPage = false;
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                controller: pageController,
                children: widget.pages,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: widget.pages.length,
                  effect: JumpingDotEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    jumpScale: 2,
                    activeDotColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // back button
              Expanded(
                child: BackwardTextButton(
                  function: backward,
                  icon: isFirstPage
                      ? widget.firstPageBackwardButtonIconData
                      : widget.backwardButtonIconData ?? Icons.arrow_back_ios,
                  label: isFirstPage
                      ? widget.firstPageBackwardButtonLabel
                      : widget.backwardButtonLabel ??
                          AppLocalizations.of(context)!
                              .user_profile_add_user_personal_data_back,
                  color: isFirstPage
                      ? widget.firstPageBackwardButtonColor
                      : widget.backwardButtonColor ??
                          Theme.of(context).splashColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AnimatedSmoothIndicator(
                  activeIndex: currentPage,
                  count: widget.pages.length,
                  effect: JumpingDotEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    jumpScale: 2,
                    activeDotColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              // forward button
              Expanded(
                child: ForwardTextButton(
                  function: forward,
                  icon: isLastPage
                      ? widget.lastPageForwardButtonIconData
                      : widget.forwardButtonIconData ?? Icons.arrow_forward_ios,
                  label: isLastPage
                      ? widget.lastPageForwardButtonLabel
                      : widget.forwardButtonLabel ??
                          AppLocalizations.of(context)!
                              .user_profile_add_user_next,
                  color: isLastPage
                      ? widget.lastPageForwardButtonColor
                      : widget.forwardButtonColor ??
                          Theme.of(context).splashColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
