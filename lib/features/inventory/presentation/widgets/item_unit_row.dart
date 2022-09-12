import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../domain/entities/item.dart';
import '../../utils/get_localized_unit_name.dart';

class ItemUnitRow extends StatelessWidget {
  const ItemUnitRow({
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
            icon: Icons.balance,
            iconColor: Colors.grey.shade300,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.item_unit,
            titleFontSize: 16,
          ),
        ),
        Text(
          getLocalizedUnitName(
            context,
            item!.itemUnit,
          ),
        ),
      ],
    );
  }
}
