import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  final Animation<Offset> downSlideAnimation;
  final CircularBottomNavigationController navigationController;
  final PageController pageController;
  final Function setPageIndex;

  const HomeBottomNavigationBar({
    Key? key,
    required this.downSlideAnimation,
    required this.navigationController,
    required this.pageController,
    required this.setPageIndex,
  }) : super(key: key);

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  List<TabItem> tabItems = [];

  @override
  void didChangeDependencies() {
    const labelTextStyle = TextStyle(
      fontSize: 10,
    );
    tabItems = [
      TabItem(
        Icons.task_alt,
        AppLocalizations.of(context)!.bottom_bar_title_tasks,
        Colors.red,
        labelStyle: labelTextStyle,
      ),
      TabItem(
        Icons.auto_awesome_mosaic_outlined,
        AppLocalizations.of(context)!.bottom_bar_title_inventory,
        Colors.orange,
        labelStyle: labelTextStyle,
      ),
      TabItem(
        Icons.home,
        AppLocalizations.of(context)!.bottom_bar_title_dashboard,
        const Color.fromRGBO(0, 240, 130, 100),
        labelStyle: labelTextStyle,
      ),
      TabItem(
        Icons.precision_manufacturing_outlined,
        AppLocalizations.of(context)!.bottom_bar_title_assets,
        Colors.blue,
        labelStyle: labelTextStyle,
      ),
      TabItem(
        Icons.menu_book_outlined,
        AppLocalizations.of(context)!.bottom_bar_title_knowledge,
        Colors.deepPurple,
        labelStyle: labelTextStyle,
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SlideTransition(
        position: widget.downSlideAnimation,
        child: CircularBottomNavigation(
          tabItems,
          barBackgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
          barHeight: 44,
          iconsSize: 24,
          circleSize: 54,
          controller: widget.navigationController,
          selectedCallback: (index) => setState(() {
            // widget.pageIndex = index ?? 2;
            widget.setPageIndex(index ?? 2);
            widget.pageController.animateToPage(
              index ?? 2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
            );
          }),
        ),
      ),
    );
  }
}
