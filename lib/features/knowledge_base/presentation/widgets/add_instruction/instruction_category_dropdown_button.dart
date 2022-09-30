import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_dropdown_button.dart';
import '../../blocs/instruction_category/instruction_category_bloc.dart';

class InstructionCategoryDropdownButton extends StatelessWidget {
  const InstructionCategoryDropdownButton({
    Key? key,
    required this.selectedValue,
    required this.onSelected,
  }) : super(key: key);

  final String selectedValue;
  final Function(String value) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructionCategoryBloc, InstructionCategoryState>(
      builder: (context, state) {
        if (state is InstructionCategoryLoadedState) {
          final dropdownItems =
              state.allInstructionsCategories.allInstructionsCategories
                  .map<DropdownMenuItem<String>>(
                    (cat) => DropdownMenuItem(
                      value: cat.id,
                      child: Text(cat.name),
                    ),
                  )
                  .toList();
          // adds initial element
          if (selectedValue.isEmpty) {
            dropdownItems.add(
              DropdownMenuItem(
                child: Text(
                  AppLocalizations.of(context)!.item_select_category,
                ),
                value: '',
              ),
            );
          }
          return CustomDropdownButton(
            initialValue: selectedValue,
            items: dropdownItems,
            selectedValue: selectedValue,
            onSelected: onSelected,
            label: AppLocalizations.of(context)!.item_category,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
