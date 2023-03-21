import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/passive_home_page/passive_dashboard.dart';
import 'package:under_control_v2/features/core/presentation/widgets/passive_home_page/passive_tasks_list.dart';

import '../../../tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart';
import '../../../tasks/utils/work_request_management_bloc_listener.dart';
import '../../utils/size_config.dart';
import '../widgets/home_page/app_bar_animated_icon.dart';
import '../widgets/home_page/main_drawer.dart';

class PassiveHomePage extends StatefulWidget {
  const PassiveHomePage({Key? key}) : super(key: key);

  static const routeName = '/home-passive';

  @override
  State<PassiveHomePage> createState() => _PassiveHomePageState();
}

class _PassiveHomePageState extends State<PassiveHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _pageIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _pageIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> appBarTitles = [
      AppLocalizations.of(context)!.bottom_bar_title_dashboard,
      AppLocalizations.of(context)!.bottom_bar_title_tasks,
    ];

    SizeConfig.init(context);
    DateTime preBackpress = DateTime.now();
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;

    return WillPopScope(
      onWillPop: () async {
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          // shows snack bar after first click
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.back_to_exit,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.black,
              ),
            );
          return false;
        } else {
          return true;
        }
      },
      child:
          BlocListener<WorkRequestManagementBloc, WorkRequestManagementState>(
        listener: (context, state) =>
            workRequestManagementBlocListener(context, state),
        child: Scaffold(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          // TODO showcase
          drawer: MainDrawer(drawerKey: GlobalKey()),
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: tabBarIconColor,
                    tabs: [
                      Icon(
                        Icons.home,
                        size: tabBarIconSize,
                        color: tabBarIconColor,
                      ),
                      Icon(
                        Icons.task_alt,
                        size: tabBarIconSize,
                        color: tabBarIconColor,
                      ),
                    ],
                  ),
                  Container(
                    height: 1.0,
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
            ),
            leading: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: AppBarAnimatedIcon(),
                  ),
                );
              },
            ),
            title: Text(
              appBarTitles[_pageIndex],
            ),
          ),
          // safe area
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/scaffold_background.png'),
                  fit: BoxFit.cover,
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: TabBarView(
                controller: _tabController,
                children: const [
                  PassiveDashboard(),
                  PassiveTasksList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
