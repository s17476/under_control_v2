import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/widgets/companies_list.dart';
import 'package:under_control_v2/features/company_profile/presentation/widgets/intro_card.dart';

import '../../../core/presentation/widgets/bottom_navigation.dart';
import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../blocs/company_management/company_management_bloc.dart';
import '../blocs/company_profile/company_profile_bloc.dart';

class AssignCompanyPage extends StatefulWidget {
  const AssignCompanyPage({Key? key}) : super(key: key);

  @override
  State<AssignCompanyPage> createState() => _AssignCompanyPageState();
}

class _AssignCompanyPageState extends State<AssignCompanyPage> {
  final pageController = PageController();

  List<Widget> pages = [];

  void assignCompany() {}

  void addCompany() {}

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      const IntroCard(),
      CompaniesList(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: pages,
            ),
          ),
          BottomNavigation(
            pageController: pageController,
            collectionLenght: pages.length,
            firstPageBackwardButtonFunction: () =>
                context.read<AuthenticationBloc>().add(SignoutEvent()),
            firstPageBackwardButtonLabel:
                AppLocalizations.of(context)!.user_profile_add_user_signout,
            firstPageBackwardButtonIconData: Icons.logout,
            firstPageBackwardButtonColor: Colors.black,
            lastPageForwardButtonFunction: assignCompany,
            lastPageForwardButtonLabel: AppLocalizations.of(context)!
                .user_profile_add_user_personal_data_save,
            lastPageForwardButtonIconData: Icons.check,
            lastPageForwardButtonColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
