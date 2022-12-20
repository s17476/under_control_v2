import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/location_selection_helpers.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../locations/domain/entities/location.dart';

class SelectableLocationsListTile extends StatefulWidget {
  const SelectableLocationsListTile({
    Key? key,
    required this.location,
    required this.selectedLocation,
    required this.childrenLocations,
    required this.setLocation,
  }) : super(key: key);

  final Location location;
  final String selectedLocation;
  final List<Location> childrenLocations;
  final Function(String) setLocation;

  @override
  State<SelectableLocationsListTile> createState() =>
      _SelectableLocationsListTileState();
}

class _SelectableLocationsListTileState
    extends State<SelectableLocationsListTile> {
  bool _isExpanded = false;
  bool _isChildSelected = false;
  bool _isAvailable = false;

  late List<Location> _directChildren;

  @override
  void initState() {
    _directChildren = widget.childrenLocations
        .where((element) => element.parentId == widget.location.id)
        .toList();

    _isAvailable = getUserPermission(
      context: context,
      featureType: FeatureType.assets,
      permissionType: PermissionType.create,
      locationId: widget.location.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.childrenLocations
                .indexWhere((loc) => loc.id == widget.selectedLocation) >=
            0) ||
        widget.location.id == widget.selectedLocation) {
      setState(() {
        _isChildSelected = true;
      });
    } else {
      setState(() {
        _isChildSelected = false;
      });
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        top: 4,
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              if (_isAvailable && _directChildren.isEmpty) {
                widget.setLocation(widget.location.id);
              } else if (_directChildren.isNotEmpty) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              } else {
                showSnackBar(
                  context: context,
                  message: AppLocalizations.of(context)!
                      .permission_no_write_in_location,
                  isErrorMessage: true,
                );
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    child: _directChildren.isNotEmpty
                        ? Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    // location name
                    child: Text(
                      widget.location.name,
                      style: TextStyle(
                        color: !_isAvailable
                            ? Colors.grey
                            : _isChildSelected
                                ? Colors.amber
                                // ? Theme.of(context).primaryColor
                                : Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // radio button
                  Radio<String>(
                    value: widget.location.id,
                    groupValue: widget.selectedLocation,
                    onChanged: !_isAvailable
                        ? (_) {
                            showSnackBar(
                              context: context,
                              message: AppLocalizations.of(context)!
                                  .permission_no_write_in_location,
                              isErrorMessage: true,
                            );
                          }
                        : (_) => widget.setLocation(widget.location.id),
                    // activeColor: Theme.of(context).primaryColor,
                    activeColor: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
          // sublocations
          AnimatedSize(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: _isExpanded ? null : 0,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  for (var child in _directChildren)
                    SelectableLocationsListTile(
                      key: ValueKey(child.id),
                      location: child,
                      selectedLocation: widget.selectedLocation,
                      childrenLocations: getSelectedLocationsChildren(
                        child,
                        widget.childrenLocations,
                      ),
                      setLocation: widget.setLocation,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
