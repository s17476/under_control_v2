import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchButton extends HookWidget {
  const SearchButton({
    Key? key,
    required this.isSearchBarExpanded,
    required this.toggleIsSearchBarExpanded,
  }) : super(key: key);

  final bool isSearchBarExpanded;
  final VoidCallback toggleIsSearchBarExpanded;

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    toggleState.value = isSearchBarExpanded;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: InkResponse(
        onTap: () => toggleIsSearchBarExpanded(),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? Icon(
                  Icons.search,
                  key: const ValueKey('expanded'),
                  color: Theme.of(context).primaryColor,
                )
              : const Icon(
                  Icons.search,
                  key: ValueKey('colapsed'),
                ),
        ),
      ),
    );
  }
}
