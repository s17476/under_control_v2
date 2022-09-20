import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../domain/entities/item.dart';

class InternalCodeRow extends StatelessWidget {
  const InternalCodeRow({
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
            icon: Icons.numbers,
            iconColor: Colors.grey.shade300,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.item_internal_code,
            titleFontSize: 16,
          ),
        ),
        Text(item!.itemCode),
      ],
    );
  }
}
