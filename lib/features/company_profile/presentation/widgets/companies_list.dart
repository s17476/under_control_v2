import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/size_config.dart';
import '../blocs/company_management/company_management_bloc.dart';
import 'companies_list_view.dart';

class CompaniesList extends StatelessWidget {
  const CompaniesList({
    Key? key,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocBuilder<CompanyManagementBloc, CompanyManagementState>(
      builder: (context, state) {
        // data loaded
        switch (state.runtimeType) {
          case CompanyManagementCompaniesLoaded:
            return CompaniesListView(
              pageController: pageController,
              companies: (state as CompanyManagementCompaniesLoaded)
                  .companies
                  .allCompanies,
            );
          case CompanyManagementLoading:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 16,
                ),
                Text(AppLocalizations.of(context)!.assign_company_list_loading),
              ],
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
