import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';

class AddToItemSummaryCard extends StatefulWidget {
  const AddToItemSummaryCard({
    Key? key,
    required this.pageController,
    required this.quantityTextEditingController,
    required this.descriptionTextEditingController,
    required this.dateTime,
    required this.selectedLocation,
    required this.itemUnit,
    required this.addNewItem,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController quantityTextEditingController;

  final TextEditingController descriptionTextEditingController;

  final DateTime dateTime;

  final String selectedLocation;

  final String itemUnit;

  final Function(BuildContext context) addNewItem;

  @override
  State<AddToItemSummaryCard> createState() => _AddToItemSummaryCardState();
}

class _AddToItemSummaryCardState extends State<AddToItemSummaryCard> {
  double? _doubleQuantity;
  String _selectedLocation = '';
  String _dateTime = '';

  final _quantityTextEditingController = TextEditingController();

  @override
  void initState() {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    _dateTime = dateFormat.format(widget.dateTime);
    try {
      _doubleQuantity = double.parse(widget.quantityTextEditingController.text);
      setState(() {
        _quantityTextEditingController.text =
            _doubleQuantity!.toStringWithFixedDecimal();
      });
    } catch (e) {
      _quantityTextEditingController.text =
          widget.quantityTextEditingController.text;
      _doubleQuantity = null;
    }
    try {
      final locationState = context.read<LocationBloc>().state;
      if (widget.selectedLocation.isNotEmpty &&
          locationState is LocationLoadedState) {
        _selectedLocation = locationState.allLocations.allLocations
            .firstWhere((loc) => loc.id == widget.selectedLocation)
            .name;
      }
    } catch (e) {
      _selectedLocation = '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.descriptionTextEditingController.text.trim();

    return SafeArea(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // location
                        InkWell(
                          onTap: () async =>
                              widget.pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: TextEditingController(
                                    text: _selectedLocation,
                                  ),
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    labelText:
                                        AppLocalizations.of(context)!.location,
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: _selectedLocation.isEmpty
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              _selectedLocation.isEmpty
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
                        ),
                        // quanity
                        InkWell(
                          onTap: () async =>
                              widget.pageController.animateToPage(
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
                                        if (_doubleQuantity == null) {
                                          return AppLocalizations.of(context)!
                                              .incorrect_number_format;
                                        } else if (_doubleQuantity! <= 0) {
                                          return AppLocalizations.of(context)!
                                              .incorrect_number_to_small;
                                        }
                                        return null;
                                      },
                                      controller:
                                          _quantityTextEditingController,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            const TextStyle(color: Colors.red),
                                        labelText: AppLocalizations.of(context)!
                                            .quantity,
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                          color: (_doubleQuantity == null) ||
                                                  (_doubleQuantity != null &&
                                                      _doubleQuantity! <= 0)
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  (_doubleQuantity == null) ||
                                          (_doubleQuantity != null &&
                                              _doubleQuantity! <= 0)
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
                        // date time
                        InkWell(
                          onTap: () async =>
                              widget.pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: TextEditingController(
                                    text: _dateTime,
                                  ),
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    labelText: AppLocalizations.of(context)!
                                        .selected_date,
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: _dateTime.isEmpty
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              _dateTime.isEmpty
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
                        ),
                        // description
                        InkWell(
                          onTap: () async =>
                              widget.pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller:
                                      widget.descriptionTextEditingController,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    labelText: AppLocalizations.of(context)!
                                        .description,
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: description.length < 2
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.trim().length < 2) {
                                      return AppLocalizations.of(context)!
                                          .validation_min_two_characters;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              description.length < 2
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
                  function: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_save,
                  function: () {
                    widget.addNewItem(context);
                  },
                  icon: Icons.save,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
