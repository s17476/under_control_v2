import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/pages/add_company_page.dart';

import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../widgets/companies_list.dart';
import '../widgets/intro_card.dart';

class AssignCompanyPage extends StatefulWidget {
  const AssignCompanyPage({Key? key}) : super(key: key);

  @override
  State<AssignCompanyPage> createState() => _AssignCompanyPageState();
}

class _AssignCompanyPageState extends State<AssignCompanyPage> {
  List<Widget> _pages = [];

  final _pageController = PageController();

  @override
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime preBackpress = DateTime.now();
    _pages = [
      const IntroCard(),
      const CompaniesList(),
    ];

    return WillPopScope(
      // double click to exit the app
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.back_to_exit_creator,
            isErrorMessage: true,
          );
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
              controller: _pageController,
              children: _pages,
            ),
            CreatorBottomNavigation(
              lastPageForwardButtonFunction: () => Navigator.pushNamed(
                context,
                AddCompanyPage.routeName,
              ),
              lastPageForwardButtonLabel: AppLocalizations.of(context)!.add,
              lastPageForwardButtonIconData: Icons.add,
              pages: _pages,
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }
}
