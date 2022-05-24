import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'backward_elevated_button.dart';
import 'forward_elevated_button.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    required this.pageController,
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
    required this.collectionLenght,
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
  final PageController pageController;
  final int collectionLenght;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool firstPage = true;
  bool lastPage = false;
  int currentPage = 0;

  void backward() {
    if (firstPage) {
      widget.firstPageBackwardButtonFunction();
    } else {
      if (widget.backwardButtonFunction != null) {
        widget.backwardButtonFunction!();
      } else {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
      currentPage--;
      setState(() {
        if (currentPage == 0) {
          firstPage = true;
        } else {
          firstPage = false;
        }
        lastPage = false;
      });
    }
  }

  void forward() {
    if (lastPage) {
      widget.lastPageForwardButtonFunction();
    } else {
      if (widget.forwardButtonFunction != null) {
        widget.forwardButtonFunction!();
      } else {
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
      currentPage++;
      setState(() {
        if (currentPage == widget.collectionLenght - 1) {
          lastPage = true;
        } else {
          lastPage = false;
        }
        firstPage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child: BackwardElevatedButton(
              function: backward,
              icon: firstPage
                  ? widget.firstPageBackwardButtonIconData
                  : widget.backwardButtonIconData ?? Icons.arrow_back_ios,
              child: firstPage
                  ? widget.firstPageBackwardButtonLabel
                  : widget.backwardButtonLabel ??
                      AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_back,
              color: firstPage
                  ? widget.firstPageBackwardButtonColor
                  : widget.backwardButtonColor ?? Theme.of(context).splashColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AnimatedSmoothIndicator(
              activeIndex: currentPage,
              count: widget.collectionLenght,
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
            child: ForwardElevatedButton(
              function: forward,
              icon: lastPage
                  ? widget.lastPageForwardButtonIconData
                  : widget.forwardButtonIconData ?? Icons.arrow_forward_ios,
              child: lastPage
                  ? widget.lastPageForwardButtonLabel
                  : widget.forwardButtonLabel ??
                      AppLocalizations.of(context)!.user_profile_add_user_next,
              color: lastPage
                  ? widget.lastPageForwardButtonColor
                  : widget.forwardButtonColor ?? Theme.of(context).splashColor,
            ),
          ),
        ],
      ),
    );
  }
}
