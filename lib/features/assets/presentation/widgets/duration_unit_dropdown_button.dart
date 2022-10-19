import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/custom_dropdown_button.dart';
import '../../../core/utils/duration_unit.dart';
import '../../utils/get_localizad_duration_unit_name.dart';

class DurationUnitDropdownButton extends StatelessWidget {
  const DurationUnitDropdownButton({
    Key? key,
    required this.selectedUnit,
    required this.onSelected,
  }) : super(key: key);

  final String selectedUnit;
  final Function(String onSelected) onSelected;

  @override
  Widget build(BuildContext context) {
    final dropdownItems = DurationUnit.values
        .where((unit) => unit.name.isNotEmpty)
        .map<DropdownMenuItem<String>>(
          (unit) => DropdownMenuItem(
            value: unit.name,
            child: Text(
              getLocalizedDurationUnitName(context, unit),
            ),
          ),
        )
        .toList();
    // adds initial element
    if (selectedUnit.isEmpty) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(AppLocalizations.of(context)!.duration_unit_select),
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
