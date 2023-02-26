import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/assets_overlay_menu_items.dart';

import '../../../../dashboard/presentation/widgets/dashboard_overlay_menu_items.dart';
import '../../../../inventory/utils/inventory_overlay_menu_items.dart';
import '../../../../knowledge_base/utils/knowledge_base_overlay_menu_items.dart';
import '../../../../tasks/utils/tasks_overlay_menu_items.dart';
import '../../../utils/responsive_size.dart';
import '../animated_floating_menu.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  final AnimationController animationController;
  final CircularBottomNavigationController navigationController;
  // final PageController pageController;
  final Function setPageIndex;
  final Function toggleShowMenu;

  const HomeBottomNavigationBar({
    Key? key,
    required this.animationController,
    required this.navigationController,
    // required this.pageController,
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

  List<SpeedDialChild> getMenuItems() {
    switch (widget.navigationController.value) {
      case 0:
        return tasksOverlayMenuSpeedDialItems(context);
      case 1:
        return inventoryOverlayMenuSpeedDialItems(context);
      case 2:
        return dashboardOverlayMenuSpeedDialItems(context);
      case 3:
        return assetsOverlayMenuSpeedDialItems(context);
      case 4:
        return knowledgeBaseOverlayMenuSpeedDialItems(context);
      default:
        return [];
    }
  }

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
              child: SpeedDial(
                icon: Icons.menu,
                activeIcon: Icons.close,
                overlayOpacity: 0.85,
                spacing: 3,
                childPadding: const EdgeInsets.all(5),
                spaceBetweenChildren: 4,
                backgroundColor: _floatingButtonBackgroundColor,
                buttonSize: const Size(50, 50),
                // renderOverlay: true,
                activeBackgroundColor: Colors.black,
                elevation: 8.0,
                animationCurve: Curves.elasticInOut,
                isOpenOnStart: false,
                children: getMenuItems(),
                childrenButtonSize: const Size(60, 60),
                childMargin: const EdgeInsets.only(right: 0),
                animationDuration: const Duration(milliseconds: 300),
              ),
              // child: AnimatedFloatingMenu(
              //   backgroundColor: _floatingButtonBackgroundColor,
              //   onPressed: widget.toggleShowMenu,
              // ),
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
