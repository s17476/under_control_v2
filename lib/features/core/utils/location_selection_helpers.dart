import '../../locations/domain/entities/location.dart';

///Gets all sublocations of given location
///
///Returns a list containing all sublocations ids.
List<String> getSelectedLocationChildren(
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

///Gets location context in location tree.
///
///Returns a list containing locations ids.
List<String> updateContext(
  Location selectedLocation,
  List<Location> allLocations,
) {
  List<String> updatedContext = [];
  Location tmpLocation = selectedLocation;
  while (tmpLocation.parentId.isNotEmpty) {
    updatedContext.add(tmpLocation.id);
    tmpLocation = allLocations.firstWhere(
      (location) => location.id == tmpLocation.parentId,
    );
  }
  updatedContext.add(tmpLocation.id);
  return updatedContext;
}
