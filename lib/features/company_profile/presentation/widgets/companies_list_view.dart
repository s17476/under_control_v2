import 'package:flutter/material.dart';

import '../../domain/entities/company.dart';
import 'companies_list_tile.dart';

class CompaniesListView extends StatelessWidget {
  const CompaniesListView({
    Key? key,
    required this.companies,
  }) : super(key: key);

  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        // list item
        return CompaniesListTile(
          company: companies[index],
          key: Key(companies[index].id),
        );
      },
    );
  }
}
