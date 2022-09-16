import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../locations/domain/entities/location.dart';
import '../../../domain/entities/item.dart';
import '../../../../core/utils/double_apis.dart';

class SelectableLocationslistTile extends StatelessWidget {
  const SelectableLocationslistTile({
    Key? key,
    required this.location,
    required this.selectedLocation,
    this.selectedFromLocation = '',
    required this.allLocations,
    this.isSubtract = false,
    required this.setLocation,
    required this.item,
  }) : super(key: key);

  final Location location;
  final Item item;

  final String selectedLocation;

  final String selectedFromLocation;

  final List<Location> allLocations;

  final bool isSubtract;

  final Function(String) setLocation;

  @override
  Widget build(BuildContext context) {
    final children = allLocations
        .where((element) => element.parentId == location.id)
        .toList();

    double amountInLocation = 0;

    final index = item.amountInLocations.indexWhere(
      (element) => element.locationId == location.id,
    );

    if (index >= 0) {
      amountInLocation = item.amountInLocations[index].amount;
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
            onTap: !isSubtract || (isSubtract && amountInLocation > 0)
                ? selectedFromLocation != location.id
                    ? () {
                        print('selectedFromLocation');
                        print(selectedFromLocation);
                        print('location.id');
                        print(location.id);
                        setLocation(location.id);
                      }
                    : () {
                        showSnackBar(
                          context: context,
                          message: AppLocalizations.of(context)!
                              .item_move_same_location,
                          isErrorMessage: true,
                        );
                      }
                : () {
                    showSnackBar(
                      context: context,
                      message: AppLocalizations.of(context)!
                          .item_subtract_no_items_in_location,
                      isErrorMessage: true,
                    );
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
                    child: children.isNotEmpty
                        ? const Icon(
                            Icons.keyboard_arrow_up,
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    // location name
                    child: Text(
                      location.name,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    amountInLocation.toStringWithFixedDecimal(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  // radio button
                  Radio<String>(
                    value: location.id,
                    groupValue: selectedLocation,
                    onChanged:
                        !isSubtract || (isSubtract && amountInLocation > 0)
                            ? (value) => setLocation(value as String)
                            : (_) {},
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          // sublocations
          if (children.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  for (var child in children)
                    SelectableLocationslistTile(
                      key: ValueKey(child.id),
                      location: child,
                      selectedLocation: selectedLocation,
                      selectedFromLocation: selectedFromLocation,
                      allLocations: allLocations,
                      setLocation: setLocation,
                      item: item,
                      isSubtract: isSubtract,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
