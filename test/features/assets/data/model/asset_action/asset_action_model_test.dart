import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/assets/data/models/asset_action/asset_action_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_action/asset_action.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';

void main() {
  final date = DateTime.now();

  final tAssetActionModel = AssetActionModel(
    id: 'id',
    assetId: 'assetId',
    dateTime: date,
    userId: 'userId',
    locationId: 'locationId',
    isAssetInUse: true,
    isCreate: false,
    assetStatus: AssetStatus.ok,
    connectedTask: 'connectedTask',
    connectedWorkOrder: 'connectedWorkOrder',
  );

  final tAssetActionToModelMap = {
    'assetId': 'assetId',
    'dateTime': date,
    'userId': 'userId',
    'locationId': 'locationId',
    'isAssetInUse': true,
    'isCreate': false,
    'assetStatus': AssetStatus.ok.name,
    'connectedTask': 'connectedTask',
    'connectedWorkOrder': 'connectedWorkOrder',
  };
  final tAssetActionFromModelMap = {
    'assetId': 'assetId',
    'dateTime': Timestamp.fromDate(date),
    'userId': 'userId',
    'locationId': 'locationId',
    'isAssetInUse': true,
    'isCreate': false,
    'assetStatus': AssetStatus.ok.name,
    'connectedTask': 'connectedTask',
    'connectedWorkOrder': 'connectedWorkOrder',
  };

  group('AssetActionModel', () {
    test(
      'should ba a subclass of [AssetAction] entity',
      () async {
        // assert
        expect(tAssetActionModel, isA<AssetAction>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = AssetActionModel.fromMap(tAssetActionFromModelMap, 'id');
        // assert
        expect(result, tAssetActionModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tAssetActionModel.toMap();
        // assert
        expect(result, tAssetActionToModelMap);
      },
    );
  });
}
