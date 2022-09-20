import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../domain/entities/item.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item? item;

  @override
  Widget build(BuildContext context) {
    String currency = '';
    final companyState = context.read<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      currency = companyState.company.currency;
    }

    return Row(
      children: [
        Expanded(
          child: IconTitleRow(
            icon: Icons.attach_money,
            iconColor: Colors.grey.shade300,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.item_unit_price,
            titleFontSize: 16,
          ),
        ),
        Text('${item!.price.toString()} $currency'),
      ],
    );
  }
}
