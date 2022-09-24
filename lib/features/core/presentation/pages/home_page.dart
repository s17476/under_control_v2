import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/home_page/app_bar_search_box.dart';
import 'package:under_control_v2/features/core/presentation/widgets/overlay_menu/overlay_menu.dart';

import '../../../assets/presentation/pages/assets_page.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../inventory/presentation/blocs/items_management/items_management_bloc.dart';
import '../../../inventory/presentation/pages/inventory_page.dart';
import '../../../inventory/utils/item_management_bloc_listener.dart';
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

  String inventoryQuery = '';
  String assetsQuery = '';

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
      if (MediaQuery.of(context).viewInsets.bottom == 0 &&
          !isControlsVisible &&
          scrollController.offset < currentOffset) {
        _showControls();
      }
      currentOffset = scrollController.offset;
    });

    pageController.addListener(() {
      // closes search bar when page changes
      if (isInventorySearchBarExpanded || isAssetsSearchBarExpanded) {
        _toggleIsSearchBarExpanded();
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (MediaQuery.of(context).viewInsets.bottom == 0 && !isControlsVisible) {
      _showControls();
    } else if (MediaQuery.of(context).viewInsets.bottom != 0 &&
        isControlsVisible) {
      _hideControls();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    navigationController.dispose();
    scrollController.dispose();
    animationController?.dispose();
    pageController.dispose();
    inventorySearchTextEditingController.dispose();
    assetsSearchTextEditingController.dispose();
    super.dispose();
  }

  // search in inventory
  void _searchInInventory() {
    setState(() {
      inventoryQuery = inventorySearchTextEditingController.text;
    });
  }

  // search in assets
  void _searchInAssets() {
    setState(() {
      assetsQuery = assetsSearchTextEditingController.text;
    });
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
      // closes menu and filter
      if (isMenuVisible) {
        _toggleIsMenuVisible();
      }
      if (isFilterExpanded) {
        _toggleIsFilterExpanded();
      }

      // toggle inventory search
      if (isInventorySearchBarExpanded) {
        inventorySearchTextEditingController.text = '';
        _searchInInventory();
        isInventorySearchBarExpanded = false;
      } else if (!isInventorySearchBarExpanded && pageIndex == 1) {
        isInventorySearchBarExpanded = true;
      }

      // toggle assets search
      if (isAssetsSearchBarExpanded) {
        assetsSearchTextEditingController.text = '';
        _searchInAssets();
        isAssetsSearchBarExpanded = false;
      } else if (!isAssetsSearchBarExpanded && pageIndex == 3) {
        isAssetsSearchBarExpanded = true;
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<ItemsManagementBloc, ItemsManagementState>(
            listener: (context, state) =>
                itemManagementBlocListener(context, state),
          ),
        ],
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
                        searchQuery: inventoryQuery,
                        isSortedByCategory: false,
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
                    title: AppLocalizations.of(context)!.search_item,
                    searchBoxHeight: searchBoxHeight,
                    isSearchBoxExpanded: isInventorySearchBarExpanded,
                    onChanged: _searchInInventory,
                    searchTextEditingController:
                        inventorySearchTextEditingController,
                  ),
                  // assets search box
                  AppBarSearchBox(
                    title: AppLocalizations.of(context)!.search,
                    searchBoxHeight: searchBoxHeight,
                    isSearchBoxExpanded: isAssetsSearchBarExpanded,
                    onChanged: _searchInAssets,
                    searchTextEditingController:
                        assetsSearchTextEditingController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
