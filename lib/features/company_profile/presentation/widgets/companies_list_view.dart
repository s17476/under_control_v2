import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/pages/add_company_page.dart';

import '../../../core/presentation/widgets/backward_text_button.dart';
import '../../../core/presentation/widgets/forward_text_button.dart';
import '../../domain/entities/company.dart';
import '../blocs/company_management/company_management_bloc.dart';
import 'companies_list_tile.dart';

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({
    Key? key,
    required this.companies,
    required this.pageController,
  }) : super(key: key);

  final List<Company> companies;
  final PageController pageController;

  @override
  State<CompaniesListView> createState() => _CompaniesListViewState();
}

class _CompaniesListViewState extends State<CompaniesListView> {
  final controller = TextEditingController();

  String searchString = '';
  List<Company> filteredCompanies = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    filteredCompanies = widget.companies
        .where(
          (company) => company.name.toLowerCase().contains(searchString),
        )
        .toList();
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async =>
            context.read<CompanyManagementBloc>().add(FetchAllCompaniesEvent()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
                bottom: 2,
              ),
              child: TextFormField(
                controller: controller,
                key: const ValueKey('search'),
                keyboardType: TextInputType.name,
                cursorColor: Theme.of(context).textTheme.headline5!.color,
                decoration: InputDecoration(
                  suffixIcon: controller.text.isEmpty
                      ? const Icon(
                          Icons.search,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              controller.text = '';
                              searchString = '';
                            });
                          },
                          icon: const Icon(Icons.cancel),
                          color: Theme.of(context).textTheme.headline5!.color,
                        ),
                  floatingLabelStyle: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                  hintText: AppLocalizations.of(context)!.search,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCompanies.length,
                itemBuilder: (context, index) {
                  // list item
                  return CompaniesListTile(
                    company: filteredCompanies[index],
                    key: Key(filteredCompanies[index].id),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackwardTextButton(
                    icon: Icons.arrow_back_ios,
                    color: Theme.of(context).textTheme.headline4!.color!,
                    label: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_back,
                    function: () => widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                  ),
                  ForwardTextButton(
                    color: Theme.of(context).textTheme.headline5!.color!,
                    label: AppLocalizations.of(context)!.add,
                    function: () =>
                        Navigator.pushNamed(context, AddCompanyPage.routeName),
                    icon: Icons.add,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
