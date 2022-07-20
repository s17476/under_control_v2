import 'dart:ui';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/home_bottom_navigation_bar.dart';

import '../../../assets/presentation/pages/assets_page.dart';
import '../widgets/home_sliver_app_bar.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../inventory/presentation/pages/inventory_page.dart';
import '../../../knowledge_base/presentation/pages/knowledge_base_page.dart';
import '../../../tasks/presentation/pages/tasks_page.dart';
import '../../utils/size_config.dart';
import '../widgets/filter.dart';
import '../widgets/main_drawer.dart';

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

  final ScrollController scrollController = ScrollController();

  double currentOffset = 0;

  // bottom navigation show/hide animation
  AnimationController? _animationController;
  Animation<Offset>? downSlideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    downSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1),
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.linear,
      ),
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
    super.dispose();
    _animationController!.dispose();
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
      _animationController!.reverse();
      isControlsVisible = true;
    }
  }

  // hide BottomNavigationTabBar
  void hideControls() {
    if (isControlsVisible) {
      _animationController!.forward();
      isControlsVisible = false;
    }
  }

  // show/hide filter widget
  void toggleIsFilterExpanded() {
    setState(() {
      isFilterExpanded = !isFilterExpanded;
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
                  children: const [
                    TasksPage(),
                    InventoryPage(),
                    DashboardPage(),
                    AssetsPage(),
                    KnowledgeBasePage(),
                  ],
                ),
                // bottom navigation bar
                HomeBottomNavigationBar(
                  downSlideAnimation: downSlideAnimation!,
                  navigationController: navigationController,
                  pageController: pageController,
                  setPageIndex: setPageIndex,
                ),
                // glass layer
                if (isFilterExpanded)
                  InkWell(
                    onTap: toggleIsFilterExpanded,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                // location and group selection filter
                Filter(isFilterExpanded: isFilterExpanded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
