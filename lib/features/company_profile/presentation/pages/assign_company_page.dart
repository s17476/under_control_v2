import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/companies_list.dart';
import '../widgets/intro_card.dart';

class AssignCompanyPage extends StatefulWidget {
  const AssignCompanyPage({Key? key}) : super(key: key);

  @override
  State<AssignCompanyPage> createState() => _AssignCompanyPageState();
}

class _AssignCompanyPageState extends State<AssignCompanyPage> {
  List<Widget> pages = [];

  final pageController = PageController();

  void addNewCompany(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    DateTime preBackpress = DateTime.now();
    pages = [
      IntroCard(pageController: pageController),
      CompaniesList(pageController: pageController),
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
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: pages,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  jumpScale: 2,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
