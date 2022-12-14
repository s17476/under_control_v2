import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'filter_icon.dart';

class FilterButton extends HookWidget {
  const FilterButton({
    Key? key,
    required this.isFilterExpanded,
    required this.toggleIsFilterExpanded,
    required this.isSearchBarExpanded,
    required this.toggleIsSearchBarExpanded,
    required this.isMenuVisible,
    required this.toggleIsMenuVisible,
  }) : super(key: key);

  final bool isFilterExpanded;
  final VoidCallback toggleIsFilterExpanded;
  final bool isSearchBarExpanded;
  final VoidCallback toggleIsSearchBarExpanded;
  final bool isMenuVisible;
  final VoidCallback toggleIsMenuVisible;

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    toggleState.value = isFilterExpanded;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: InkResponse(
        onTap: () {
          if (isMenuVisible) {
            toggleIsMenuVisible();
          }
          if (isSearchBarExpanded) {
            toggleIsSearchBarExpanded();
          }
          toggleIsFilterExpanded();
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? FilterIcon(
                  key: const ValueKey('expanded'),
                  isFilterExpanded: isFilterExpanded,
                )
              : FilterIcon(
                  key: const ValueKey('colapsed'),
                  isFilterExpanded: isFilterExpanded,
                ),
        ),
      ),
    );
  }
}
