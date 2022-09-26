import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/utils/location_selection_helpers.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../locations/domain/entities/location.dart';
import '../../../domain/entities/item.dart';
import '../../../../core/utils/double_apis.dart';

class SelectableLocationslistTile extends StatefulWidget {
  const SelectableLocationslistTile({
    Key? key,
    required this.location,
    required this.selectedLocation,
    this.selectedFromLocation = '',
    required this.childrenLocations,
    this.isSubtract = false,
    required this.setLocation,
    required this.item,
  }) : super(key: key);

  final Location location;
  final Item item;

  final String selectedLocation;

  final String selectedFromLocation;

  final List<Location> childrenLocations;

  final bool isSubtract;

  final Function(String) setLocation;

  @override
  State<SelectableLocationslistTile> createState() =>
      _SelectableLocationslistTileState();
}

class _SelectableLocationslistTileState
    extends State<SelectableLocationslistTile> {
  bool isExpanded = false;
  bool isChildSelected = false;

  late List<Location> directChildren;

  double amountInLocation = 0;
  double totalAmount = 0;

  void _onSelect(BuildContext context, double amountInLocation) {
    if (!widget.isSubtract || (widget.isSubtract && amountInLocation > 0)) {
      if (widget.selectedFromLocation != widget.location.id) {
        widget.setLocation(widget.location.id);
      } else {
        showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.item_move_same_location,
          isErrorMessage: true,
        );
      }
    } else {
      showSnackBar(
        context: context,
        message:
            AppLocalizations.of(context)!.item_subtract_no_items_in_location,
        isErrorMessage: true,
      );
    }
  }

  @override
  void initState() {
    directChildren = widget.childrenLocations
        .where((element) => element.parentId == widget.location.id)
        .toList();

    final index = widget.item.amountInLocations.indexWhere(
      (element) => element.locationId == widget.location.id,
    );

    if (index >= 0) {
      amountInLocation = widget.item.amountInLocations[index].amount;
    }

    totalAmount = amountInLocation;
    for (var child in widget.childrenLocations) {
      final index = widget.item.amountInLocations.indexWhere(
        (element) => element.locationId == child.id,
      );

      if (index >= 0) {
        totalAmount += widget.item.amountInLocations[index].amount;
      }
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.childrenLocations
                .indexWhere((loc) => loc.id == widget.selectedLocation) >=
            0) ||
        widget.location.id == widget.selectedLocation) {
      setState(() {
        isChildSelected = true;
      });
    } else {
      setState(() {
        isChildSelected = false;
      });
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        top: 4,
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              if (directChildren.isEmpty) {
                _onSelect(context, amountInLocation);
              } else {
                setState(() {
                  isExpanded = !isExpanded;
                });
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    child: directChildren.isNotEmpty
                        ? Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    // location name
                    child: Text(
                      widget.location.name,
                      style: TextStyle(
                        color: isChildSelected
                            ? Colors.amber
                            // ? Theme.of(context).primaryColor
                            : Colors.grey.shade100,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (directChildren.isNotEmpty)
                        Text(
                          totalAmount.toStringWithFixedDecimal(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                      Text(
                        amountInLocation.toStringWithFixedDecimal(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  // radio button
                  Radio<String>(
                    value: widget.location.id,
                    groupValue: widget.selectedLocation,
                    onChanged: (_) => _onSelect(context, amountInLocation),
                    // activeColor: Theme.of(context).primaryColor,
                    activeColor: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
          // sublocations

          AnimatedSize(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: isExpanded ? null : 0,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  for (var child in directChildren)
                    SelectableLocationslistTile(
                      key: ValueKey(child.id),
                      location: child,
                      selectedLocation: widget.selectedLocation,
                      selectedFromLocation: widget.selectedFromLocation,
                      childrenLocations: getSelectedLocationsChildren(
                        child,
                        widget.childrenLocations,
                      ),
                      setLocation: widget.setLocation,
                      item: widget.item,
                      isSubtract: widget.isSubtract,
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
