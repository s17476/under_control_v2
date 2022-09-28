import 'package:flutter/material.dart';

import '../../../../locations/domain/entities/location.dart';

class GroupDetailsLocationTile extends StatelessWidget {
  const GroupDetailsLocationTile({
    Key? key,
    required this.selectedLocations,
    required this.allLocations,
    required this.location,
  }) : super(key: key);

  final List<String> selectedLocations;
  final List<Location> allLocations;
  final Location location;

  @override
  Widget build(BuildContext context) {
    final _children = allLocations
        .where((element) => element.parentId == location.id)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        top: 4,
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    // color: widget.color,
                  ),
                  child: _children.isNotEmpty
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
                Container(
                  width: 32,
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    // color: widget.color,
                  ),
                  child: selectedLocations.contains(location.id)
                      ? const Icon(
                          Icons.done,
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
          if (_children.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  for (var child in _children)
                    // location card
                    GroupDetailsLocationTile(
                      selectedLocations: selectedLocations,
                      allLocations: allLocations,
                      location: child,
                      key: Key(child.id),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
