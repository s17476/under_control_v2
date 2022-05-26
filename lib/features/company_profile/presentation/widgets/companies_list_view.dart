import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/company.dart';
import 'companies_list_tile.dart';

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({
    Key? key,
    required this.companies,
  }) : super(key: key);

  final List<Company> companies;

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
    print(searchString);
    filteredCompanies = widget.companies
        .where(
          (company) => company.name.toLowerCase().contains(searchString),
        )
        .toList();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
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
                hintText: AppLocalizations.of(context)!
                    .user_profile_add_user_personal_data_first_name,
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
        ],
      ),
    );
  }
}
