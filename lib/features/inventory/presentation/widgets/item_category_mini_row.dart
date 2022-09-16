import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/item_category/item_category_bloc.dart';

class ItemCategoryMiniRow extends StatelessWidget {
  const ItemCategoryMiniRow({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.category,
          size: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        BlocBuilder<ItemCategoryBloc, ItemCategoryState>(
          builder: (context, state) {
            if (state is ItemCategoryLoadedState) {
              final categoryName = state.getItemCategoryById(categoryId)?.name;
              return Text(
                categoryName ??
                    AppLocalizations.of(context)!
                        .item_details_category_not_found,
                style: Theme.of(context).textTheme.caption,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
