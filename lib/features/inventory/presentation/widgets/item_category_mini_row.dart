import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/core/presentation/widgets/icon_title_mini_row.dart';

import '../blocs/item_category/item_category_bloc.dart';

class ItemCategoryMiniRow extends StatelessWidget {
  const ItemCategoryMiniRow({
    Key? key,
    required this.categoryId,
    required this.searchQuery,
  }) : super(key: key);

  final String categoryId;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCategoryBloc, ItemCategoryState>(
      builder: (context, state) {
        if (state is ItemCategoryLoadedState) {
          final categoryName = state.getItemCategoryById(categoryId)?.name;
          return IconTitleMiniRow(
            title: categoryName ??
                AppLocalizations.of(context)!.item_details_category_not_found,
            icon: Icons.category,
            searchQuery: searchQuery,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
