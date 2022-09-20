import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/keep_alive_page.dart';
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
  // bottom navigation controls
  final PageController pageController = PageController(initialPage: 2);
  int pageIndex = 2;
  late CircularBottomNavigationController navigationController;

  bool isFilterExpanded = false;

  bool isControlsVisible = true;

  bool isMenuVisible = false;

  final ScrollController scrollController = ScrollController();

  // inventory search
  final TextEditingController inventorySearchTextEditingController =
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
        hideControls();
      }
      if (!isControlsVisible && scrollController.offset < currentOffset) {
        showControls();
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
    super.dispose();
  }

  // set page index
  void setPageIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  // show BottomNavigationTabBar
  void showControls() {
    if (!isControlsVisible) {
      animationController!.reverse();
      setState(() {
        isControlsVisible = true;
      });
    }
  }

  // hide BottomNavigationTabBar
  void hideControls() {
    if (isControlsVisible) {
      animationController!.forward();
      setState(() {
        isControlsVisible = false;
      });
    }
  }

  // show/hide filter widget
  void toggleIsFilterExpanded() {
    setState(() {
      isFilterExpanded = !isFilterExpanded;
    });
  }

  // show overlay menu
  void toggleIsMenuVisible() {
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
          toggleIsFilterExpanded();
          return false;
        }
        if (isMenuVisible) {
          toggleIsMenuVisible();
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
        body: NestedScrollView(
          controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          // AppBar
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            HomeSliverAppBar(
              pageIndex: pageIndex,
              isFilterExpanded: isFilterExpanded,
              toggleIsFilterExpanded: toggleIsFilterExpanded,
              isMenuVisible: isMenuVisible,
              toggleIsMenuVisible: toggleIsMenuVisible,
            )
          ],
          // body
          body: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Stack(
              children: [
                // tabs
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    const TasksPage(),
                    KeepAlivePage(
                        child: InventoryPage(
                      inventorySearchTextEditingController:
                          inventorySearchTextEditingController,
                    )),
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
                  setPageIndex: setPageIndex,
                  toggleShowMenu: toggleIsMenuVisible,
                ),
                // location and group selection filter
                HomePageFilter(
                  isFilterExpanded: isFilterExpanded,
                  onDismiss: toggleIsFilterExpanded,
                ),
                OverlayMenu(
                  isVisible: isMenuVisible,
                  onDismiss: toggleIsMenuVisible,
                  pageIndex: pageIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
