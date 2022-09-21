import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/home_page/app_bar_search_box.dart';
import 'package:under_control_v2/features/core/presentation/widgets/overlay_menu/overlay_menu.dart';

import '../../../assets/presentation/pages/assets_page.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../inventory/presentation/pages/inventory_page.dart';
import '../../../knowledge_base/presentation/pages/knowledge_base_page.dart';
import '../../../tasks/presentation/pages/tasks_page.dart';
import '../../utils/size_config.dart';
import '../widgets/home_page/home_bottom_navigation_bar.dart';
import '../../../filter/presentation/widgets/home_page_filter.dart';

import '../widgets/home_page/home_sliver_app_bar.dart';
import '../widgets/home_page/main_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // search box height
  final double searchBoxHeight = 70;

  // bottom navigation controls
  final PageController pageController = PageController(initialPage: 2);
  int pageIndex = 2;
  late CircularBottomNavigationController navigationController;

  bool isFilterExpanded = false;

  bool isInventorySearchBarExpanded = false;

  bool isAssetsSearchBarExpanded = false;

  bool isControlsVisible = true;

  bool isMenuVisible = false;

  final ScrollController scrollController = ScrollController();

  // inventory search
  final TextEditingController inventorySearchTextEditingController =
      TextEditingController();

  // assets search
  final TextEditingController assetsSearchTextEditingController =
      TextEditingController();

  double currentOffset = 0;

  // bottom navigation show/hide animation
  AnimationController? animationController;
  // Animation<Offset>? downSlideAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    navigationController = CircularBottomNavigationController(pageIndex);
    scrollController.addListener(() {
      if (isControlsVisible && scrollController.offset > currentOffset) {
        _hideControls();
      }
      if (!isControlsVisible && scrollController.offset < currentOffset) {
        _showControls();
      }
      currentOffset = scrollController.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    pageController.dispose();
    inventorySearchTextEditingController.dispose();
    assetsSearchTextEditingController.dispose();
    super.dispose();
  }

  // set page index
  void _setPageIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  // show BottomNavigationTabBar
  void _showControls() {
    if (!isControlsVisible) {
      animationController!.reverse();
      setState(() {
        isControlsVisible = true;
      });
    }
  }

  // hide BottomNavigationTabBar
  void _hideControls() {
    if (isControlsVisible) {
      animationController!.forward();
      setState(() {
        isControlsVisible = false;
      });
    }
  }

  // show/hide filter widget
  void _toggleIsFilterExpanded() {
    setState(() {
      isFilterExpanded = !isFilterExpanded;
    });
  }

  // show/hide search bar widget
  void _toggleIsSearchBarExpanded() {
    setState(() {
      if (pageIndex == 1) {
        isInventorySearchBarExpanded = !isInventorySearchBarExpanded;
      } else if (pageIndex == 3) {
        isAssetsSearchBarExpanded = !isAssetsSearchBarExpanded;
      }
    });
  }

  bool _getFlagForPageIndex(int index) {
    if (pageIndex == 1) {
      return isInventorySearchBarExpanded;
    } else {
      return isAssetsSearchBarExpanded;
    }
  }

  // show overlay menu
  void _toggleIsMenuVisible() {
    setState(() {
      isMenuVisible = !isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // hide filter widget if expanded
        if (isFilterExpanded) {
          _toggleIsFilterExpanded();
          return false;
        }
        if (isMenuVisible) {
          _toggleIsMenuVisible();
          return false;
        }
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.black,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        drawer: const MainDrawer(),
        body: SafeArea(
          child: NestedScrollView(
            controller: scrollController,
            physics: const NeverScrollableScrollPhysics(),
            // AppBar
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: HomeSliverAppBar(
                  pageIndex: pageIndex,
                  isFilterExpanded: isFilterExpanded,
                  toggleIsFilterExpanded: _toggleIsFilterExpanded,
                  isMenuVisible: isMenuVisible,
                  toggleIsMenuVisible: _toggleIsMenuVisible,
                  isSearchBarExpanded: _getFlagForPageIndex(pageIndex),
                  toggleIsSearchBarExpanded: _toggleIsSearchBarExpanded,
                ),
              )
            ],
            // body
            body: Stack(
              children: [
                // tabs
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    const TasksPage(),
                    InventoryPage(
                      searchBoxHeight: searchBoxHeight,
                      isSearchBoxExpanded: isInventorySearchBarExpanded,
                    ),
                    const DashboardPage(),
                    const AssetsPage(),
                    const KnowledgeBasePage(),
                  ],
                ),
                // bottom navigation bar
                HomeBottomNavigationBar(
                  animationController: animationController!,
                  navigationController: navigationController,
                  pageController: pageController,
                  setPageIndex: _setPageIndex,
                  toggleShowMenu: _toggleIsMenuVisible,
                ),
                // location and group selection filter
                HomePageFilter(
                  isFilterExpanded: isFilterExpanded,
                  onDismiss: _toggleIsFilterExpanded,
                ),
                OverlayMenu(
                  isVisible: isMenuVisible,
                  onDismiss: _toggleIsMenuVisible,
                  pageIndex: pageIndex,
                ),
                // inventory search box
                AppBarSearchBox(
                  searchBoxHeight: searchBoxHeight,
                  isSearchBoxExpanded: isInventorySearchBarExpanded,
                  onChanged: () {},
                  searchTextEditingController:
                      inventorySearchTextEditingController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
