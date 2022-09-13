import 'package:flutter/material.dart';

import '../../../../locations/domain/entities/location.dart';
import '../../../domain/entities/item.dart';

class SelectableLocationslistTile extends StatelessWidget {
  const SelectableLocationslistTile({
    Key? key,
    required this.location,
    required this.selectedLocation,
    required this.allLocations,
    required this.setLocation,
    required this.item,
  }) : super(key: key);

  final Location location;
  final Item item;

  final String selectedLocation;

  final List<Location> allLocations;

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
            onTap: () => setLocation(location.id),
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
                    amountInLocation.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  // radio button
                  Radio<String>(
                    value: location.id,
                    groupValue: selectedLocation,
                    onChanged: (value) => setLocation(value as String),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          if (children.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  for (var child in children)
                    // location card
                    SelectableLocationslistTile(
                      location: child,
                      selectedLocation: selectedLocation,
                      allLocations: allLocations,
                      setLocation: setLocation,
                      item: item,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
