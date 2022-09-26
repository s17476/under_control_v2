import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/core/utils/location_selection_helpers.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';

class MoveInsideItemSummaryCard extends StatefulWidget {
  const MoveInsideItemSummaryCard({
    Key? key,
    required this.pageController,
    required this.quantityTextEditingController,
    required this.descriptionTextEditingController,
    required this.dateTime,
    required this.selectedFromLocation,
    required this.selectedToLocation,
    required this.itemUnit,
    this.maxQuantity = 0,
    required this.addNewItem,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController quantityTextEditingController;

  final TextEditingController descriptionTextEditingController;

  final DateTime dateTime;

  final String selectedFromLocation;
  final String selectedToLocation;

  final String itemUnit;

  final double maxQuantity;

  final Function(BuildContext context) addNewItem;

  @override
  State<MoveInsideItemSummaryCard> createState() =>
      _MoveInsideItemSummaryCardState();
}

class _MoveInsideItemSummaryCardState extends State<MoveInsideItemSummaryCard> {
  double? _doubleQuantity;
  String _selectedFromLocation = '';
  String _selectedToLocation = '';
  String _dateTime = '';

  String _quantityString = '';

  @override
  void initState() {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    _dateTime = dateFormat.format(widget.dateTime);
    try {
      _doubleQuantity = double.parse(widget.quantityTextEditingController.text);
      setState(() {
        _quantityString = _doubleQuantity!.toStringWithFixedDecimal();
      });
    } catch (e) {
      _quantityString = widget.quantityTextEditingController.text;
      _doubleQuantity = null;
    }

    // gets from location name
    final locationState = context.read<LocationBloc>().state;
    try {
      if (widget.selectedFromLocation.isNotEmpty &&
          locationState is LocationLoadedState) {
        _selectedFromLocation = getBreadcrumbsForLocation(
          widget.selectedFromLocation,
          locationState.allLocations.allLocations,
        );
      }
    } catch (e) {
      _selectedFromLocation = '';
    }

    // get to location name
    try {
      if (widget.selectedToLocation.isNotEmpty &&
          locationState is LocationLoadedState) {
        _selectedToLocation = getBreadcrumbsForLocation(
          widget.selectedToLocation,
          locationState.allLocations.allLocations,
        );
      }
    } catch (e) {
      _selectedToLocation = '';
    }

    super.initState();
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        // from location
                        SummaryCard(
                          title: AppLocalizations.of(context)!
                              .item_subtract_from_location,
                          validator: () => _selectedFromLocation.isEmpty
                              ? AppLocalizations.of(context)!
                                  .validation_location_not_selected
                              : null,
                          child: Text(_selectedFromLocation),
                          pageController: widget.pageController,
                          onTapAnimateToPage: 0,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        // to location
                        SummaryCard(
                          title: AppLocalizations.of(context)!
                              .item_add_to_location,
                          validator: () => _selectedToLocation.isEmpty
                              ? AppLocalizations.of(context)!
                                  .validation_location_not_selected
                              : null,
                          child: Text(_selectedToLocation),
                          pageController: widget.pageController,
                          onTapAnimateToPage: 1,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        // quanity
                        SummaryCard(
                          title:
                              '${AppLocalizations.of(context)!.quantity} [${widget.itemUnit}]',
                          validator: () {
                            if (_doubleQuantity == null) {
                              return AppLocalizations.of(context)!
                                  .incorrect_number_format;
                            } else if (_doubleQuantity! <= 0) {
                              return AppLocalizations.of(context)!
                                  .incorrect_number_to_small;
                            } else if (widget.maxQuantity != 0 &&
                                _doubleQuantity! > widget.maxQuantity) {
                              return AppLocalizations.of(context)!
                                  .incorrect_number_to_big;
                            }
                            return null;
                          },
                          child: Text(_quantityString),
                          pageController: widget.pageController,
                          onTapAnimateToPage: 2,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        // date time
                        SummaryCard(
                          title: AppLocalizations.of(context)!.selected_date,
                          validator: () => _dateTime.isEmpty ? '' : null,
                          child: Text(_dateTime),
                          pageController: widget.pageController,
                          onTapAnimateToPage: 3,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        // description
                        SummaryCard(
                          title: AppLocalizations.of(context)!.description,
                          validator: () => description.length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                          child: Text(description),
                          pageController: widget.pageController,
                          onTapAnimateToPage: 3,
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
