import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../domain/entities/item.dart';

class AlarmRow extends StatelessWidget {
  const AlarmRow({
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
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.grey.shade300,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.alert_quantity,
            titleFontSize: 16,
          ),
        ),
        Text(
          item!.alertQuantity!.toString(),
        ),
      ],
    );
  }
}
