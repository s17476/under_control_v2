import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locations/domain/entities/location.dart';
import '../../../locations/presentation/blocs/bloc/location_bloc.dart';

class HomePageFilterLocationTile extends StatefulWidget {
  final List<Location> allLocations;
  final Location location;

  const HomePageFilterLocationTile({
    Key? key,
    required this.allLocations,
    required this.location,
  }) : super(key: key);

  @override
  State<HomePageFilterLocationTile> createState() =>
      _HomePageFilterLocationTileState();
}

class _HomePageFilterLocationTileState
    extends State<HomePageFilterLocationTile> {
  _HomePageFilterLocationTileState();
  bool isExpanded = false;
  bool isSelected = false;
  bool isContext = false;

  late Color color;

  @override
  void didChangeDependencies() {
    color = Theme.of(context).cardColor;
    final state = context.watch<LocationBloc>().state as LocationLoadedState;

    if (state.selectedLocations.contains(widget.location) ||
        state.children.contains(widget.location.id)) {
      isSelected = true;
    } else {
      isSelected = false;
    }
    isContext = state.context.contains(widget.location.id);

    super.didChangeDependencies();
  }

  void toggleColor(BuildContext context) {
    if (color == Theme.of(context).cardColor) {
      color = const Color.fromRGBO(0, 240, 130, 100);
    } else {
      color = Theme.of(context).cardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  color: color,
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
                                      isSelected
                                          ? context.read<LocationBloc>().add(
                                                UnselectLocationEvent(
                                                  location: widget.location,
                                                ),
                                              )
                                          : context.read<LocationBloc>().add(
                                                SelectLocationEvent(
                                                  location: widget.location,
                                                ),
                                              );
                                      setState(() {
                                        isSelected = value!;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          // AddressRow(location: widget.location),
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
                  HomePageFilterLocationTile(
                    allLocations: widget.allLocations,
                    location: location,
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
