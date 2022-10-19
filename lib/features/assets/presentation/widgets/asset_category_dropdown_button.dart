import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/custom_dropdown_button.dart';
import '../../../core/presentation/widgets/shimmer_custom_dropdown_button.dart';
import '../blocs/asset_category/asset_category_bloc.dart';

class AssetCategoryDropdownButton extends StatelessWidget {
  const AssetCategoryDropdownButton({
    Key? key,
    required this.selectedValue,
    required this.onSelected,
  }) : super(key: key);

  final String selectedValue;
  final Function(String value) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetCategoryBloc, AssetCategoryState>(
      builder: (context, state) {
        if (state is AssetCategoryLoadedState) {
          final dropdownItems = state.allAssetsCategories.allAssetsCategories
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
                  AppLocalizations.of(context)!.category_select,
                ),
                value: '',
              ),
            );
          }
          return Column(
            children: [
              CustomDropdownButton(
                initialValue: selectedValue,
                items: dropdownItems,
                selectedValue: selectedValue,
                onSelected: onSelected,
                label: AppLocalizations.of(context)!.category,
              ),
            ],
          );
        } else {
          return const ShimmerCustomDropdownButton();
        }
      },
    );
  }
}
