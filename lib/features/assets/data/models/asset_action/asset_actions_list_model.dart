import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/asset_action/asset_action.dart';
import '../../../domain/entities/asset_action/asset_actions_list.dart';

import 'asset_action_model.dart';

class AssetActionsListModel extends AssetActionsList {
  const AssetActionsListModel({required super.allAssetActions});

  factory AssetActionsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<AssetAction> assetActionsList = [];
    assetActionsList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => AssetActionModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList()
      ..sort(
        (a, b) => b.dateTime.compareTo(a.dateTime),
      );
    return AssetActionsListModel(allAssetActions: assetActionsList);
  }
}
