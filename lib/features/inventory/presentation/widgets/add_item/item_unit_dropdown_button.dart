import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_dropdown_button.dart';
import '../../../domain/entities/item.dart';
import '../../../utils/get_localized_unit_name.dart';

class ItemUnitDropdownButton extends StatelessWidget {
  const ItemUnitDropdownButton({
    Key? key,
    required this.selectedUnit,
    required this.onSelected,
  }) : super(key: key);

  final String selectedUnit;
  final Function(String onSelected) onSelected;

  @override
  Widget build(BuildContext context) {
    final dropdownItems = ItemUnit.values
        .where((unit) => unit.name.isNotEmpty)
        .map<DropdownMenuItem<String>>(
          (unit) => DropdownMenuItem(
            value: unit.name,
            child: Text(
              getLocalizedUnitName(context, unit),
            ),
          ),
        )
        .toList();
    // adds initial element
    if (selectedUnit.isEmpty) {
      dropdownItems.add(
        DropdownMenuItem(
          value: '',
          child: Text(AppLocalizations.of(context)!.item_select_unit),
        ),
      );
    }

    return CustomDropdownButton(
      initialValue: selectedUnit,
      items: dropdownItems,
      selectedValue: selectedUnit,
      onSelected: onSelected,
      label: AppLocalizations.of(context)!.item_unit,
    );
  }
}
