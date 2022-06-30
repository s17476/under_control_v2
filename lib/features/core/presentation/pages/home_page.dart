import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.tune))],
          centerTitle: true,
        ),
        drawer: const MainDrawer(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.bottom_bar_title_tasks,
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
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          barBackgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
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
    );
  }
}
