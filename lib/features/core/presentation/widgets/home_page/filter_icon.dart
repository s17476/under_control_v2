import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';

class FilterIcon extends StatefulWidget {
  const FilterIcon({
    Key? key,
    required this.isFilterExpanded,
  }) : super(key: key);

  final bool isFilterExpanded;

  @override
  State<FilterIcon> createState() => _FilterIconState();
}

class _FilterIconState extends State<FilterIcon> {
  bool _isAnyGroupSelected = false;
  bool _isAllLocationsSelected = false;
  bool _isAnyLocationSelected = false;

  @override
  void didChangeDependencies() {
    final filterState = context.watch<FilterBloc>().state;
    final locationState = context.watch<LocationBloc>().state;
    if (filterState is FilterLoadedState) {
      if (filterState.isAdmin) {
        final selectedGroups = filterState.groups.where(
          (group) => filterState.allPossibleGroups.contains(group),
        );
        if (selectedGroups.isNotEmpty) {
          _isAnyGroupSelected = true;
        } else {
          _isAnyGroupSelected = false;
        }
      }
      if (locationState is LocationLoadedState) {
        if (const DeepCollectionEquality.unordered().equals(
          locationState.allLocations.allLocations,
          filterState.locations,
        )) {
          _isAllLocationsSelected = true;
        } else {
          _isAllLocationsSelected = false;
        }
      }
      if (filterState.locations.isNotEmpty) {
        _isAnyLocationSelected = true;
      } else {
        _isAnyLocationSelected = false;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.tune,
          color: widget.isFilterExpanded
              ? Theme.of(context).primaryColor
              : Theme.of(context).iconTheme.color,
        ),
        // group selection indicator
        if (_isAnyGroupSelected)
          const Positioned(
            top: 0,
            left: 0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 5,
            ),
          ),
        // locations selection indicator
        if (!_isAllLocationsSelected)
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: _isAnyLocationSelected
                  ? const Color.fromARGB(255, 28, 154, 97)
                  : Colors.amber,
              radius: 5,
            ),
          ),
      ],
    );
  }
}
