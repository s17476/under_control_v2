import 'package:flutter/material.dart';

import '../../../../locations/domain/entities/location.dart';

class LocationSelectionTile extends StatefulWidget {
  final List<Location> allLocations;
  final Location location;

  final List<Location> selectedLocations;
  final List<String> locationsChildren;
  final List<String> locationsContext;

  final Function(
    BuildContext context,
    Location location,
    bool isSelected,
  ) toggleLocationSelection;

  const LocationSelectionTile({
    Key? key,
    required this.allLocations,
    required this.location,
    required this.selectedLocations,
    required this.locationsChildren,
    required this.locationsContext,
    required this.toggleLocationSelection,
  }) : super(key: key);

  @override
  State<LocationSelectionTile> createState() => _LocationFilterTileState();
}

class _LocationFilterTileState extends State<LocationSelectionTile> {
  _LocationFilterTileState();
  bool isExpanded = false;
  bool isSelected = false;
  bool isContext = false;

  @override
  Widget build(BuildContext context) {
    if (widget.selectedLocations.contains(widget.location) ||
        widget.locationsChildren.contains(widget.location.id)) {
      isSelected = true;
    } else {
      isSelected = false;
    }
    isContext = widget.locationsContext.contains(widget.location.id);
    final children = widget.allLocations
        .where((location) => location.parentId == widget.location.id);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // card container
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).focusColor,
                ),
                child: Row(
                  children: [
                    // container with arrow icon on the left
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: children.isNotEmpty
                          ? Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                            )
                          : null,
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
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    activeColor: isContext
                                        ? isSelected
                                            ? Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.2)
                                            : Colors.grey.shade700
                                        : Theme.of(context).primaryColor,
                                    value: isSelected || isContext,
                                    onChanged: (bool? value) {
                                      widget.toggleLocationSelection(
                                        context,
                                        widget.location,
                                        isSelected,
                                      );
                                      setState(() {
                                        isSelected = value!;
                                      });
                                    }),
                              ],
                            ),
                          ),
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
            height: isExpanded ? null : 0,
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                for (var location in children)
                  // location card
                  LocationSelectionTile(
                    allLocations: widget.allLocations,
                    location: location,
                    locationsChildren: widget.locationsChildren,
                    locationsContext: widget.locationsContext,
                    selectedLocations: widget.selectedLocations,
                    toggleLocationSelection: widget.toggleLocationSelection,
                    key: Key(location.id),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
