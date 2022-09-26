import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/utils/location_selection_helpers.dart';

import '../../../../locations/domain/entities/location.dart';
import '../../../domain/entities/item.dart';
import '../../../../core/utils/double_apis.dart';

class QuantityLocationslistTile extends StatefulWidget {
  const QuantityLocationslistTile({
    Key? key,
    required this.location,
    required this.childrenLocations,
    required this.item,
  }) : super(key: key);

  final Location location;

  final Item item;

  final List<Location> childrenLocations;

  @override
  State<QuantityLocationslistTile> createState() =>
      _QuantityLocationslistTileState();
}

class _QuantityLocationslistTileState extends State<QuantityLocationslistTile> {
  final tileHeight = 50.0;

  bool isExpanded = false;

  late List<Location> directChildren;

  double amountInLocation = 0;
  double totalAmount = 0;

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        top: 4,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              height: tileHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: tileHeight,
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
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    height: tileHeight,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Column(
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
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          ),
          // sublocations container

          AnimatedSize(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: double.infinity,
              height: isExpanded ? null : 0,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  for (var child in directChildren)
                    // location card
                    QuantityLocationslistTile(
                      location: child,
                      childrenLocations: getSelectedLocationsChildren(
                        child,
                        widget.childrenLocations,
                      ),
                      item: widget.item,
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
