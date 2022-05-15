import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/presentation/widgets/main_drawer.dart';
import 'package:under_control_v2/features/core/utils/custom_page_transition.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';

class HomePage extends StatelessWidget with CustomPageTransition {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    DateTime preBackpress = DateTime.now();
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
              content: const Text('Press Back button again to Exit'),
              duration: const Duration(seconds: 2),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset('assets/under_control_icon.png'),
            );
          }),
        ),
        drawer: const MainDrawer(),
        body: Center(child: Text('Home')),
      ),
    );
  }
}
