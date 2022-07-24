import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/groups/data/models/feature_model.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

void main() {
  final tFeatureModel = FeatureModel(
    type: FeatureType.assets,
    create: true,
    read: true,
    edit: true,
    delete: true,
  );

  const Map<String, dynamic> tFeatureModelMap = {
    'type': 'assets',
    'create': true,
    'read': true,
    'edit': true,
    'delete': true,
  };

  group('Groups', () {
    test(
      'should be a subclass of [Feature] entity',
      () async {
        // assert
        expect(tFeatureModel, isA<Feature>());
      },
    );

    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = FeatureModel.fromMap(tFeatureModelMap);
        // assert
        expect(result, tFeatureModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tFeatureModel.toMap();
        // assert
        expect(result, tFeatureModelMap);
      },
    );
  });
}
