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
  bool _isExpanded = false;
  bool _isSelected = false;
  bool _isContext = false;

  late Color _color;

  @override
  void didChangeDependencies() {
    _color = Theme.of(context).cardColor;
    final state = context.watch<LocationBloc>().state as LocationLoadedState;

    if (state.selectedLocations.contains(widget.location) ||
        state.children.contains(widget.location.id)) {
      _isSelected = true;
    } else {
      _isSelected = false;
    }
    _isContext = state.context.contains(widget.location.id);

    super.didChangeDependencies();
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
                _isExpanded = !_isExpanded;
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
                  color: _color,
                ),
                child: Row(
                  children: [
                    // container with arrow icon on the left
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: children.isNotEmpty
                          ? Icon(
                              _isExpanded
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
                                    activeColor: _isContext
                                        ? _isSelected
                                            ? Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.2)
                                            : Colors.grey.shade700
                                        : Theme.of(context).primaryColor,
                                    value: _isSelected || _isContext,
                                    onChanged: (bool? value) {
                                      _isSelected
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
                                        _isSelected = value!;
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
            height: _isExpanded ? null : 0,
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
