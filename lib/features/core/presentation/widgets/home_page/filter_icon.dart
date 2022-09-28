import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool isAnyGroupSelected = false;

  @override
  void didChangeDependencies() {
    final filterState = context.watch<FilterBloc>().state;
    if (filterState is FilterLoadedState && filterState.isAdmin) {
      final selectedGroups = filterState.groups.where(
        (group) => filterState.allPossibleGroups.contains(group),
      );
      if (selectedGroups.isNotEmpty) {
        isAnyGroupSelected = true;
      } else {
        isAnyGroupSelected = false;
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
        if (isAnyGroupSelected)
          const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 5,
          ),
      ],
    );
  }
}
