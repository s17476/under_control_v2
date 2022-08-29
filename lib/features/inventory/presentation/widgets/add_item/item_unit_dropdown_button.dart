import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/custom_dropdown_button.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/get_localized_unit_name.dart';

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
          child: Text(AppLocalizations.of(context)!.item_select_unit),
          value: '',
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
