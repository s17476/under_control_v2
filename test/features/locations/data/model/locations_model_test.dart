import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/data/models/locations_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations.dart';

void main() {
  final tLocation = LocationModel.initial();
  final tLocations =
      LocationsModel(allLocations: Stream.fromIterable([tLocation]));

  test(
    'should be a subclass of [Locations] entity',
    () async {
      // assert
      expect(tLocations, isA<Locations>());
    },
  );
}
