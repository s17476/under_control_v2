import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/custom_dropdown_button.dart';
import '../../utils/asset_status.dart';
import '../../utils/get_localizae_asset_status_name.dart';

class AssetStatusDropdownButton extends StatelessWidget {
  const AssetStatusDropdownButton({
    Key? key,
    required this.assetStatus,
    required this.onSelected,
  }) : super(key: key);

  final String assetStatus;
  final Function(String onSelected) onSelected;

  @override
  Widget build(BuildContext context) {
    final dropdownItems = AssetStatus.values
        .where((unit) => unit.name.isNotEmpty)
        .map<DropdownMenuItem<String>>(
          (unit) => DropdownMenuItem(
            value: unit.name,
            child: Text(
              getLocalizedAssetStatusName(context, unit),
            ),
          ),
        )
        .toList();
    // adds initial element
    if (assetStatus.isEmpty) {
      dropdownItems.add(
        DropdownMenuItem(
          value: '',
          child: Text(AppLocalizations.of(context)!.asset_status_select),
        ),
      );
    }

    return CustomDropdownButton(
      initialValue: assetStatus,
      items: dropdownItems,
      selectedValue: assetStatus,
      onSelected: onSelected,
      label: AppLocalizations.of(context)!.asset_status,
    );
  }
}
