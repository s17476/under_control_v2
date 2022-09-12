import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../domain/entities/item.dart';
import '../blocs/item_category/item_category_bloc.dart';

class ItemCategoryRow extends StatelessWidget {
  const ItemCategoryRow({
    Key? key,
    required Item? item,
  })  : _item = item,
        super(key: key);

  final Item? _item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconTitleRow(
            icon: Icons.category,
            iconColor: Colors.grey.shade300,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.item_details_category,
            titleFontSize: 16,
          ),
        ),
        BlocBuilder<ItemCategoryBloc, ItemCategoryState>(
          builder: (context, state) {
            if (state is ItemCategoryLoadedState) {
              final categoryIdex = state.allItemsCategories.allItemsCategories
                  .indexWhere((element) => element.id == _item!.category);
              if (categoryIdex >= 0) {
                return Text(
                  state
                      .allItemsCategories.allItemsCategories[categoryIdex].name,
                  style: const TextStyle(fontSize: 16),
                );
              } else {
                return Text(
                  AppLocalizations.of(context)!.item_details_category_not_found,
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
