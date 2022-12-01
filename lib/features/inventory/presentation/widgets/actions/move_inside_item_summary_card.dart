import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/location_selection_helpers.dart';
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
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController quantityTextEditingController;

  final TextEditingController descriptionTextEditingController;

  final DateTime dateTime;

  final String selectedFromLocation;
  final String selectedToLocation;

  final String itemUnit;

  final double maxQuantity;

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
                          pageController: widget.pageController,
                          onTapAnimateToPage: 0,
                          child: Text(_selectedFromLocation),
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
                          pageController: widget.pageController,
                          onTapAnimateToPage: 1,
                          child: Text(_selectedToLocation),
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
                          pageController: widget.pageController,
                          onTapAnimateToPage: 2,
                          child: Text(_quantityString),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        // date time
                        SummaryCard(
                          title: AppLocalizations.of(context)!.selected_date,
                          validator: () => _dateTime.isEmpty ? '' : null,
                          pageController: widget.pageController,
                          onTapAnimateToPage: 3,
                          child: Text(_dateTime),
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
                          pageController: widget.pageController,
                          onTapAnimateToPage: 3,
                          child: Text(description),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
