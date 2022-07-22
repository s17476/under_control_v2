import 'package:flutter/material.dart';

import '../../../domain/entities/location.dart';
import 'add_location_card.dart';
import 'address_row.dart';
import 'bottom_modal_sheet.dart';
import 'show_delete_dialog.dart';

class LocationTile extends StatefulWidget {
  final List<Location> allLocations;
  final Location location;
  final Color color;
  const LocationTile({
    Key? key,
    required this.allLocations,
    required this.location,
    required this.color,
  }) : super(key: key);

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  _LocationTileState();
  bool expanded = false;
  bool locationContainAddress = false;

  @override
  void initState() {
    locationContainAddress = (widget.location.address!.isNotEmpty ||
        widget.location.city!.isNotEmpty ||
        widget.location.postCode!.isNotEmpty ||
        widget.location.country!.isNotEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // gets locations without parent - top level locations
    final children = widget.allLocations
        .where((location) => location.parentId == widget.location.id);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // card container
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: (expanded && locationContainAddress) ? 80 : 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: Row(
                  children: [
                    // container with arrow icon on the left
                    Container(
                      width: 32,
                      height: (expanded && locationContainAddress) ? 80 : 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: widget.color,
                      ),
                      child: Icon(
                        expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    // card body
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  // location name
                                  child: Text(
                                    widget.location.name,
                                    style: TextStyle(
                                      color: Colors.grey.shade200,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // action buttons
                                Row(
                                  children: [
                                    // edit button
                                    IconButton(
                                      onPressed: () {
                                        showAddLocationModalBottomSheet(
                                          context: context,
                                          currentLocation: widget.location,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    // delete button
                                    IconButton(
                                      onPressed: () {
                                        showDeleteDialog(
                                          context: context,
                                          location: widget.location,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey.shade200,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // location address
                          if (expanded && locationContainAddress)
                            AddressRow(location: widget.location),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // sublocations container
        AnimatedSize(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: double.infinity,
            height: expanded ? null : 0,
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                for (var location in children)
                  // location card
                  LocationTile(
                    allLocations: widget.allLocations,
                    location: location,
                    color: widget.color,
                    key: Key(location.id),
                  ),
                // add new location card
                AddLocationCard(
                  parentLocation: widget.location,
                  key: Key(
                    '${widget.location.id}add',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
