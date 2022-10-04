import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/responsive_size.dart';
import '../animated_floating_menu.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  final AnimationController animationController;
  final CircularBottomNavigationController navigationController;
  final PageController pageController;
  final Function setPageIndex;
  final Function toggleShowMenu;

  const HomeBottomNavigationBar({
    Key? key,
    required this.animationController,
    required this.navigationController,
    required this.pageController,
    required this.setPageIndex,
    required this.toggleShowMenu,
  }) : super(key: key);

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar>
    with ResponsiveSize {
  List<TabItem> _tabItems = [];
  Animation<Offset>? _tabBarSlideAnimation;
  Animation<Offset>? _buttonSlideAnimation;
  Animation<double>? _fadeAnimation;
  Color _floatingButtonBackgroundColor = const Color.fromRGBO(0, 240, 130, 100);
  double _floatingActionButtonPosition = 0;
  final double _floatingActionButtonPositionTop = 85;
  final double _floatingActionButtonPositionBottom = 55;

  @override
  void initState() {
    _tabBarSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1),
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.linear,
      ),
    );
    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 2),
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.linear,
      ),
    );
    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.bounceIn,
      ),
    );
    _floatingActionButtonPosition = _floatingActionButtonPositionBottom;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    const labelTextStyle = TextStyle(
      fontSize: 10,
    );
    _tabItems = [
      TabItem(
        Icons.task_alt,
        AppLocalizations.of(context)!.bottom_bar_title_tasks,
        Colors.red,
        labelStyle: labelTextStyle,
      ),
      TabItem(
        Icons.apps,
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
    return Stack(
      children: [
        // floating action button
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.elasticInOut,
          bottom: _floatingActionButtonPosition,
          right: responsiveSizePct(small: 10) - 24,
          child: SlideTransition(
            position: _buttonSlideAnimation!,
            child: FadeTransition(
              opacity: _fadeAnimation!,
              child: AnimatedFloatingMenu(
                backgroundColor: _floatingButtonBackgroundColor,
                onPressed: widget.toggleShowMenu,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // bottom tab bar
              SlideTransition(
                position: _tabBarSlideAnimation!,
                child: CircularBottomNavigation(
                  _tabItems,
                  barBackgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor!,
                  barHeight: 44,
                  iconsSize: 24,
                  circleSize: 54,
                  controller: widget.navigationController,
                  selectedCallback: (index) {
                    setState(() {
                      if (index == 4) {
                        _floatingActionButtonPosition =
                            _floatingActionButtonPositionTop;
                      } else if (_floatingActionButtonPosition ==
                          _floatingActionButtonPositionTop) {
                        _floatingActionButtonPosition =
                            _floatingActionButtonPositionBottom;
                      }
                      _floatingButtonBackgroundColor =
                          _tabItems[index ?? 2].circleColor;
                      widget.setPageIndex(index ?? 2);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
