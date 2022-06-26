import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/location.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations_list.dart';

class LocationsListModel extends LocationsList {
  const LocationsListModel({required super.allLocations});

  factory LocationsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Location> locationList = [];
    locationList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => LocationModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();

    return LocationsListModel(allLocations: locationList);
  }
}
