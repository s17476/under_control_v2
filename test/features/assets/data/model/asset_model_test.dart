import 'package:cloud_firestore/cloud_firestore.dart';
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
    price: 0,
    isInUse: true,
    addDate: tDate,
    currentStatus: AssetStatus.ok,
    lastInspection: tDate,
    durationUnit: DurationUnit.day,
    duration: 1,
    images: const [],
    documents: const [],
    spareParts: const [],
    instructions: const [],
    currentParentId: 'currentParentId',
    isSparePart: true,
  );

  final tAssetToModelMap = {
    'producer': 'producer',
    'model': 'model',
    'description': 'description',
    'categoryId': 'categoryId',
    'locationId': 'locationId',
    'internalCode': 'internalCode',
    'internalCodeLowerCase': 'internalcode',
    'barCode': 'barCode',
    'price': 0.0,
    'isInUse': true,
    'addDate': tDate,
    'currentStatus': AssetStatus.ok.name,
    'lastInspection': tDate,
    'durationUnit': DurationUnit.day.name,
    'duration': 1,
    'images': const [],
    'documents': const [],
    'spareParts': const [],
    'instructions': const [],
    'currentParentId': 'currentParentId',
    'isSparePart': true,
  };

  final tAssetFromModelMap = {
    'producer': 'producer',
    'model': 'model',
    'description': 'description',
    'categoryId': 'categoryId',
    'locationId': 'locationId',
    'internalCode': 'internalCode',
    'internalCodeLowerCase': 'internalcode',
    'barCode': 'barCode',
    'price': 0.0,
    'isInUse': true,
    'addDate': Timestamp.fromDate(tDate),
    'currentStatus': AssetStatus.ok.name,
    'lastInspection': Timestamp.fromDate(tDate),
    'durationUnit': DurationUnit.day.name,
    'duration': 1,
    'images': const [],
    'documents': const [],
    'spareParts': const [],
    'instructions': const [],
    'currentParentId': 'currentParentId',
    'isSparePart': true,
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
      'should return a map containing proper data',
      () async {
        // act
        final result = tAssetModel.toMap();
        // assert
        expect(result, tAssetToModelMap);
      },
    );

    test(
      'should return valid model from a map',
      () async {
        // act
        final result = AssetModel.fromMap(tAssetFromModelMap, tId);
        // assert
        expect(result, tAssetModel);
      },
    );
  });
}
