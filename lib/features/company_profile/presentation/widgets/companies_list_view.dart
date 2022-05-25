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
    return Stack(
      children: [
        ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            // list item
            return CompaniesListTile(
              company: companies[index],
              key: Key(companies[index].id),
            );
          },
        ),
        Positioned(
          bottom: 12,
          right: 8,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
