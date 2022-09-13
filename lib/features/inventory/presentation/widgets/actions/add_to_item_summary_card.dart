import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../domain/entities/item.dart';
import '../../../utils/get_localized_unit_name.dart';
import '../../blocs/item_category/item_category_bloc.dart';

class AddToItemSummaryCard extends StatelessWidget {
  const AddToItemSummaryCard({
    Key? key,
    required this.pageController,
    required this.quantityTextEditingController,
    required this.selectedLocation,
    required this.itemUnit,
    required this.addNewItem,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController quantityTextEditingController;

  final String selectedLocation;

  final String itemUnit;

  final Function(BuildContext context) addNewItem;

  @override
  Widget build(BuildContext context) {
    // category name
    String _selectedLocation = '';
    final locationState = context.read<LocationBloc>().state;
    if (_selectedLocation.isNotEmpty && locationState is LocationLoadedState) {
      _selectedLocation = locationState.allLocations.allLocations
          .firstWhere((loc) => loc.id == selectedLocation)
          .name;
    }

    double? doubleQuantity;
    try {
      doubleQuantity = double.parse(quantityTextEditingController.text);
    } catch (e) {
      doubleQuantity = null;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          // vertical: 4,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.summary,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    // item name
                    InkWell(
                      onTap: () async => pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  validator: (val) {
                                    if (doubleQuantity == null) {
                                      return AppLocalizations.of(context)!
                                          .incorrect_number_format;
                                    } else if (doubleQuantity <= 0) {
                                      return AppLocalizations.of(context)!
                                          .incorrect_number_to_small;
                                    }
                                    return null;
                                  },
                                  controller: quantityTextEditingController,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    labelText:
                                        AppLocalizations.of(context)!.quantity,
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: (doubleQuantity == null) ||
                                              (doubleQuantity <= 0)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              (doubleQuantity == null) || (doubleQuantity <= 0)
                                  ? const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color: Colors.grey.shade100,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
            // bottom navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackwardTextButton(
                    icon: Icons.arrow_back_ios_new,
                    color: Theme.of(context).textTheme.headline5!.color!,
                    label: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_back,
                    function: () => pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                  ForwardTextButton(
                    color: Theme.of(context).textTheme.headline5!.color!,
                    label: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_save,
                    function: () {
                      addNewItem(context);
                    },
                    icon: Icons.save,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
