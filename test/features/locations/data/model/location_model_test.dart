import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/location.dart';

void main() {
  const tLocationModel = LocationModel(
    id: 'id',
    name: 'name',
    parentId: 'parentId',
    children: ['children'],
  );

  const Map<String, dynamic> tLocationModelMap = {
    'name': 'name',
    'parentId': 'parentId',
    'children': ['children'],
  };

  group('[LocationModel]', () {
    test('should be a subclass of [location] entity', () async {
      // assert
      expect(tLocationModel, isA<Location>());
    });

    test(
      'should return a valid model from a map',
      () async {
        // act
        final result =
            LocationModel.fromMap(tLocationModelMap, tLocationModel.id);
        // assert
        expect(result, tLocationModel);
      },
    );

    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tLocationModel.toMap();
        // assert
        expect(result, tLocationModelMap);
      },
    );
  });
}
