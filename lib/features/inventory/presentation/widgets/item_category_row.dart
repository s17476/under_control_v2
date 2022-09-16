import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../domain/entities/item.dart';
import '../blocs/item_category/item_category_bloc.dart';

class ItemCategoryRow extends StatelessWidget {
  const ItemCategoryRow({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item? item;

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
        const SizedBox(
          width: 4,
        ),
        BlocBuilder<ItemCategoryBloc, ItemCategoryState>(
          builder: (context, state) {
            if (state is ItemCategoryLoadedState) {
              final categoryName =
                  state.getItemCategoryById(item!.category)?.name;

              if (categoryName != null) {
                return Text(
                  categoryName,
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
