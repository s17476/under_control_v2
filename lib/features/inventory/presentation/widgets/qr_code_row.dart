import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';

class QrCodeRow extends StatelessWidget {
  const QrCodeRow({
    Key? key,
    required this.code,
  }) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconTitleRow(
            icon: Icons.qr_code,
            iconColor: Colors.grey.shade300,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.item_bar_code,
            titleFontSize: 16,
          ),
        ),
        Flexible(
          child: Text(
            code,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
