import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart';

import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/get_user_permission.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/permission.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../../locations/domain/entities/location.dart';
import '../../../domain/entities/item.dart';

class SelectableItemLocationslistTile extends StatefulWidget {
  const SelectableItemLocationslistTile({
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
  State<SelectableItemLocationslistTile> createState() =>
      _SelectableItemLocationslistTileState();
}

class _SelectableItemLocationslistTileState
    extends State<SelectableItemLocationslistTile> {
  bool _isExpanded = false;
  bool _isChildSelected = false;
  bool _isAvailable = false;

  late List<Location> _directChildren;

  double _amountInLocation = 0;
  double _totalAmount = 0;

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
    _directChildren = widget.childrenLocations
        .where((element) => element.parentId == widget.location.id)
        .toList();

    final index = widget.item.amountInLocations.indexWhere(
      (element) => element.locationId == widget.location.id,
    );

    if (index >= 0) {
      double reservedQuantity = 0;
      final state = context.read<ReservedSparePartsBloc>().state;
      if (state is ReservedSparePartsActiveState) {
        reservedQuantity =
            state.getReservedQuantity(widget.item.id, widget.location.id);
      }
      _amountInLocation =
          widget.item.amountInLocations[index].amount - reservedQuantity;
    }

    _totalAmount = _amountInLocation;
    for (var child in widget.childrenLocations) {
      final index = widget.item.amountInLocations.indexWhere(
        (element) => element.locationId == child.id,
      );

      if (index >= 0) {
        double reservedQuantity = 0;
        final state = context.read<ReservedSparePartsBloc>().state;
        if (state is ReservedSparePartsActiveState) {
          reservedQuantity =
              state.getReservedQuantity(widget.item.id, child.id);
        }

        _totalAmount +=
            widget.item.amountInLocations[index].amount - reservedQuantity;
      }
    }
    _isAvailable = getUserPermission(
      context: context,
      featureType: FeatureType.inventory,
      permissionType: PermissionType.create,
      locationId: widget.location.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.childrenLocations
                .indexWhere((loc) => loc.id == widget.selectedLocation) >=
            0) ||
        widget.location.id == widget.selectedLocation) {
      setState(() {
        _isChildSelected = true;
      });
    } else {
      setState(() {
        _isChildSelected = false;
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
              if (_isAvailable && _directChildren.isEmpty) {
                _onSelect(context, _amountInLocation);
              } else if (_directChildren.isNotEmpty) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              } else {
                showSnackBar(
                  context: context,
                  message: AppLocalizations.of(context)!
                      .permission_no_write_in_location,
                  isErrorMessage: true,
                );
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
                    child: _directChildren.isNotEmpty
                        ? Icon(
                            _isExpanded
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
                        color: !_isAvailable
                            ? Colors.grey
                            : _isChildSelected
                                ? Colors.amber
                                // ? Theme.of(context).primaryColor
                                : Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_directChildren.isNotEmpty)
                        Text(
                          _totalAmount.toStringWithFixedDecimal(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                      Text(
                        _amountInLocation.toStringWithFixedDecimal(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  // radio button
                  Radio<String>(
                    value: widget.location.id,
                    groupValue: widget.selectedLocation,
                    onChanged: !_isAvailable
                        ? (_) {
                            showSnackBar(
                              context: context,
                              message: AppLocalizations.of(context)!
                                  .permission_no_write_in_location,
                              isErrorMessage: true,
                            );
                          }
                        : (_) => _onSelect(context, _amountInLocation),
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
              height: _isExpanded ? null : 0,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  for (var child in _directChildren)
                    SelectableItemLocationslistTile(
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
