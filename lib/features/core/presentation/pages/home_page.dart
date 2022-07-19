import 'dart:ui';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../locations/presentation/widgets/location_filter_tile.dart';
import '../../utils/size_config.dart';
import '../widgets/main_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 2);
  int pageIndex = 2;
  late CircularBottomNavigationController navigationController;

  List<TabItem> tabItems = [];

  bool isFilterExpanded = false;

  @override
  void initState() {
    navigationController = CircularBottomNavigationController(pageIndex);
    super.initState();
  }

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

  void toggleIsFilterExpanded() {
    setState(() {
      isFilterExpanded = !isFilterExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    DateTime preBackpress = DateTime.now();

    final List<String> appBarTitles = [
      AppLocalizations.of(context)!.bottom_bar_title_tasks,
      AppLocalizations.of(context)!.bottom_bar_title_inventory,
      AppLocalizations.of(context)!.bottom_bar_title_dashboard,
      AppLocalizations.of(context)!.bottom_bar_title_assets,
      AppLocalizations.of(context)!.bottom_bar_title_knowledge,
    ];

    return WillPopScope(
      // double click to exit the app
      onWillPop: () async {
        if (isFilterExpanded) {
          toggleIsFilterExpanded();
          return false;
        }
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
        appBar: AppBar(
          bottom: PreferredSize(
            child: Container(
              height: 3.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade700,
                  Colors.transparent,
                ],
              )),
            ),
            preferredSize: const Size.fromHeight(3.0),
          ),
          leading: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset('assets/under_control_menu_icon.png'),
              );
            },
          ),
          title: Text(appBarTitles[pageIndex]),
          actions: [
            IconButton(
              onPressed: toggleIsFilterExpanded,
              icon: Icon(
                Icons.tune,
                color: isFilterExpanded
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).iconTheme.color,
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0,
        ),
        drawer: const MainDrawer(),
        body: Stack(children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        for (var i in Iterable<int>.generate(100).toList())
                          Text(
                            AppLocalizations.of(context)!
                                .bottom_bar_title_tasks,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.bottom_bar_title_inventory,
                ),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.bottom_bar_title_dashboard,
                ),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.bottom_bar_title_assets,
                ),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.bottom_bar_title_knowledge,
                ),
              )
            ],
          ),
          // bottom navigation bar
          Positioned(
            bottom: 0,
            child: CircularBottomNavigation(
              tabItems,
              barBackgroundColor:
                  Theme.of(context).appBarTheme.backgroundColor!,
              barHeight: 44,
              iconsSize: 24,
              circleSize: 54,
              controller: navigationController,
              selectedCallback: (index) => setState(() {
                pageIndex = index ?? 2;
                pageController.animateToPage(
                  pageIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                );
              }),
            ),
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
          // location and group selection
          AnimatedSize(
            duration: const Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(bottom: 44),
                width: double.infinity,
                height: isFilterExpanded ? null : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppLocalizations.of(context)!
                            .home_screen_filter_select_locations,
                      ),
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoadedState) {
                          final topLevelItems = state.allLocations.allLocations
                              .where((location) => location.parentId.isEmpty)
                              .toList();
                          return Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: topLevelItems.length,
                                itemBuilder: (context, index) {
                                  if (topLevelItems.isEmpty) {
                                    return const SizedBox();
                                  } else {
                                    return LocationFilterTile(
                                      key: Key(topLevelItems[index].id),
                                      allLocations:
                                          state.allLocations.allLocations,
                                      location: topLevelItems[index],
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppLocalizations.of(context)!
                            .home_screen_filter_select_group,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
