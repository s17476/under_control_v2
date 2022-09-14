import 'package:flutter/material.dart';

import '../../../../locations/domain/entities/location.dart';
import '../../../domain/entities/item.dart';
import '../../../../core/utils/double_apis.dart';

class QuantityLocationslistTile extends StatelessWidget {
  const QuantityLocationslistTile({
    Key? key,
    required this.location,
    required this.allLocations,
    required this.item,
  }) : super(key: key);

  final Location location;

  final Item item;

  final List<Location> allLocations;

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
          Container(
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
                const SizedBox(
                  width: 16,
                )
              ],
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
                    QuantityLocationslistTile(
                      location: child,
                      allLocations: allLocations,
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
