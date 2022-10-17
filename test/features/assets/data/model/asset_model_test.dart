import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

void main() {
  final tDate = DateTime.now();

  const tId = 'id';

  final tAssetModel = AssetModel(
    id: tId,
    producer: 'producer',
    model: 'model',
    description: 'description',
    categoryId: 'categoryId',
    locationId: 'locationId',
    internalCode: 'internalCode',
    barCode: 'barCode',
    isInUse: true,
    addDate: tDate,
    currentStatus: AssetStatus.ok,
    lastInspection: tDate,
    durationUnit: DurationUnit.day,
    duration: 1,
    images: const [],
    doucments: const [],
    spareParts: const [],
    currentParentId: 'currentParentId',
    possibleParents: const [],
  );

  final tAssetModelMap = {
    'producer': 'producer',
    'model': 'model',
    'description': 'description',
    'categoryId': 'categoryId',
    'locationId': 'locationId',
    'internalCode': 'internalCode',
    'barCode': 'barCode',
    'isInUse': true,
    'addDate': tDate.toIso8601String(),
    'currentStatus': AssetStatus.ok.name,
    'lastInspection': tDate.toIso8601String(),
    'durationUnit': DurationUnit.day.name,
    'duration': 1,
    'images': const [],
    'doucments': const [],
    'spareParts': const [],
    'currentParentId': 'currentParentId',
    'possibleParents': const [],
  };

  group('AssetModel', () {
    test(
      'should be a subclass of [Asset] entity',
      () async {
        // assert
        expect(tAssetModel, isA<Asset>());
      },
    );

    test(
      'should return a map containing propre data',
      () async {
        // act
        final result = tAssetModel.toMap();
        // assert
        expect(result, tAssetModelMap);
      },
    );

    test(
      'should return valid model from a map',
      () async {
        // act
        final result = AssetModel.fromMap(tAssetModelMap, tId);
        // assert
        expect(result, tAssetModel);
      },
    );
  });
}
