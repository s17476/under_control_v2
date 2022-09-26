import '../../locations/domain/entities/location.dart';

///Gets all sublocations id of given location
///
///Returns a list containing all sublocations ids.
List<String> getSelectedLocationsChildrenId(
  Location selectedLocation,
  List<Location> allLocations,
) {
  List<String> updatedChildren = [];
  List<Location> tmpLocations = [selectedLocation];
  while (tmpLocations.isNotEmpty) {
    Location tmpLocation = tmpLocations[0];
    final tmpList =
        allLocations.where((location) => location.parentId == tmpLocation.id);
    tmpLocations.addAll(tmpList);
    updatedChildren.add(tmpLocation.id);
    tmpLocations.remove(tmpLocation);
  }
  updatedChildren.remove(selectedLocation.id);
  return updatedChildren;
}

///Gets all sublocations of given location
///
///Returns a list containing all sublocations ids.
List<Location> getSelectedLocationsChildren(
  Location selectedLocation,
  List<Location> allLocations,
) {
  List<Location> updatedChildren = [];
  List<Location> tmpLocations = [selectedLocation];
  while (tmpLocations.isNotEmpty) {
    Location tmpLocation = tmpLocations[0];
    final tmpList =
        allLocations.where((location) => location.parentId == tmpLocation.id);
    tmpLocations.addAll(tmpList);
    updatedChildren.add(tmpLocation);
    tmpLocations.remove(tmpLocation);
  }
  updatedChildren.remove(selectedLocation);
  return updatedChildren;
}

///Gets breadcrumbs style location string
///
///Main location > sub > subsub
String getBreadcrumbsForLocation(String locationId, List<Location> locations) {
  final nameIndex = locations.indexWhere((loc) => loc.id == locationId);
  int index = nameIndex;
  if (index >= 0) {
    String result = locations[index].name;
    index = locations.indexWhere((loc) => loc.id == locations[index].parentId);
    while (index >= 0) {
      result = locations[index].name + ' > ' + result;
      index =
          locations.indexWhere((loc) => loc.id == locations[index].parentId);
    }
    return result;
  }
  return 'Error';
}

///Gets locations context in location tree.
///
///Returns a list containing locations ids.
List<String> getselectedLocationsContext(
  List<Location> selectedLocations,
  List<String> children,
  List<Location> allLocations,
) {
  List<String> locationsContext = [];

  for (var location in allLocations) {
    if (location.parentId.isNotEmpty &&
        !locationsContext.contains(location.parentId)) {
      Location tmpLocation = location;
      while (tmpLocation.parentId.isNotEmpty &&
          !locationsContext.contains(tmpLocation.parentId)) {
        final tmpChildren = allLocations
            .where((element) => element.parentId == tmpLocation.parentId);
        bool isContext = false;

        final parentLocation = allLocations
            .firstWhere((element) => element.id == tmpLocation.parentId);

        // check is at least one child is selected

        for (var child in tmpChildren) {
          if (selectedLocations.contains(child) ||
              children.contains(child.id) ||
              locationsContext.contains(child.id)) {
            isContext = true;
          }
        }

        // check if parent is selected
        if (!isContext) {
          if (selectedLocations.contains(parentLocation) ||
              children.contains(parentLocation.id)) {
            isContext = true;
          }
        } else {
          bool isAtLeastOneChildNotSelected = false;
          // check is at least one child is not selected
          for (var child in tmpChildren) {
            if ((!selectedLocations.contains(child) &&
                    !children.contains(child.id)) ||
                locationsContext.contains(child.id)) {
              isAtLeastOneChildNotSelected = true;
            }
          }
          isContext = isAtLeastOneChildNotSelected;

          // check if parent is selected
          if (!isAtLeastOneChildNotSelected) {
            if (!selectedLocations.contains(parentLocation) &&
                !children.contains(parentLocation.id)) {
              isContext = true;
            }
          }
        }

        if (isContext && !locationsContext.contains(parentLocation.id)) {
          locationsContext.add(parentLocation.id);
        }
        tmpLocation = allLocations
            .firstWhere((element) => element.id == tmpLocation.parentId);
      }
    }
  }

  return locationsContext;
}
