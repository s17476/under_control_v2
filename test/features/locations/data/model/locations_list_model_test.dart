import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/data/models/locations_list_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations_list.dart';

void main() {
  const tLocationModel = LocationModel(
    id: 'id',
    name: 'name',
    parentId: 'parentId',
    children: ['children'],
  );

  const tLocationsList = LocationsListModel(allLocations: [tLocationModel]);

  group('[LocationsListModel]', () {
    test('should be a subclass of [LocationsList] entity', () async {
      // assert
      expect(tLocationsList, isA<LocationsList>());
    });
  });
}
