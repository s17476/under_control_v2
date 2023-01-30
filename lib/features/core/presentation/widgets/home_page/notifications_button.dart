import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'notifications_icon.dart';

class NotificationsButton extends HookWidget {
  const NotificationsButton({
    Key? key,
    required this.isNotificationsExpanded,
    required this.toggleIsNotificationsExpanded,
    required this.isFilterExpanded,
    required this.toggleIsFilterExpanded,
    required this.isSearchBarExpanded,
    required this.toggleIsSearchBarExpanded,
    required this.isMenuVisible,
    required this.toggleIsMenuVisible,
  }) : super(key: key);

  final bool isNotificationsExpanded;
  final VoidCallback toggleIsNotificationsExpanded;
  final bool isFilterExpanded;
  final VoidCallback toggleIsFilterExpanded;
  final bool isSearchBarExpanded;
  final VoidCallback toggleIsSearchBarExpanded;
  final bool isMenuVisible;
  final VoidCallback toggleIsMenuVisible;

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    toggleState.value = isNotificationsExpanded;
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
          if (isFilterExpanded) {
            toggleIsFilterExpanded();
          }
          toggleIsNotificationsExpanded();
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? NotificationsIcon(
                  key: const ValueKey('expanded'),
                  isExpanded: isNotificationsExpanded,
                )
              : NotificationsIcon(
                  key: const ValueKey('colapsed'),
                  isExpanded: isNotificationsExpanded,
                ),
        ),
      ),
    );
  }
}
