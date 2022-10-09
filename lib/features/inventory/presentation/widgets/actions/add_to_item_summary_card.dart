import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/location_selection_helpers.dart';
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
    this.maxQuantity = 0,
    required this.addNewItem,
  }) : super(key: key);

  final PageController pageController;
  final TextEditingController quantityTextEditingController;
  final TextEditingController descriptionTextEditingController;
  final DateTime dateTime;
  final String selectedLocation;
  final String itemUnit;
  final double maxQuantity;
  final Function(BuildContext context) addNewItem;

  @override
  State<AddToItemSummaryCard> createState() => _AddToItemSummaryCardState();
}

class _AddToItemSummaryCardState extends State<AddToItemSummaryCard> {
  double? _doubleQuantity;
  String _selectedLocation = '';
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
    try {
      final locationState = context.read<LocationBloc>().state;
      if (widget.selectedLocation.isNotEmpty &&
          locationState is LocationLoadedState) {
        _selectedLocation = getBreadcrumbsForLocation(
          widget.selectedLocation,
          locationState.allLocations.allLocations,
        );
      }
    } catch (e) {
      _selectedLocation = '';
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
                        // location
                        SummaryCard(
                          title: AppLocalizations.of(context)!.location,
                          validator: () => _selectedLocation.isEmpty
                              ? AppLocalizations.of(context)!
                                  .validation_location_not_selected
                              : null,
                          child: Text(_selectedLocation),
                          pageController: widget.pageController,
                          onTapAnimateToPage: 0,
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
                          onTapAnimateToPage: 1,
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
                          onTapAnimateToPage: 2,
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
                          onTapAnimateToPage: 2,
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
