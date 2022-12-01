import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/custom_dropdown_button.dart';
import '../../../core/utils/duration_unit.dart';

class DurationDropdownButton extends StatelessWidget {
  const DurationDropdownButton({
    Key? key,
    required this.durationUnit,
    required this.duration,
    required this.onSelected,
  }) : super(key: key);

  final String durationUnit;
  final int duration;
  final Function(String onSelected) onSelected;

  List<DropdownMenuItem<String>> buildDropdownValues(
      DurationUnit durationUnit) {
    List<DropdownMenuItem<String>> values = [];
    int valuesCount = 0;
    switch (durationUnit) {
      case DurationUnit.hour:
        valuesCount = 23;
        break;
      case DurationUnit.day:
        valuesCount = 30;
        break;
      case DurationUnit.week:
        valuesCount = 4;
        break;
      case DurationUnit.month:
        valuesCount = 11;
        break;
      case DurationUnit.year:
        valuesCount = 5;
        break;
      default:
        valuesCount = 0;
    }
    for (int i = 1; i <= valuesCount; i++) {
      values.add(
        DropdownMenuItem(
          value: i.toString(),
          child: Text(i.toString()),
        ),
      );
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> dropdownItems =
        buildDropdownValues(DurationUnit.fromString(durationUnit));

    // adds initial element
    if (duration == 0) {
      dropdownItems.add(
        DropdownMenuItem(
          value: '',
          child: Text(AppLocalizations.of(context)!.duration_select),
        ),
      );
    }

    return CustomDropdownButton(
      initialValue: duration == 0 ? '' : duration.toString(),
      items: dropdownItems,
      selectedValue: duration == 0 ? '' : duration.toString(),
      onSelected: onSelected,
      label: AppLocalizations.of(context)!.duration,
    );
  }
}
