import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/location.dart';
import '../../domain/entities/locations_list.dart';
import 'location_model.dart';

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
        .toList()
      ..sort(
        (a, b) => a.name.compareTo(b.name),
      );

    return LocationsListModel(allLocations: locationList);
  }
}
