import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/asset.dart';
import '../../domain/entities/assets_list.dart';
import 'asset_model.dart';

class AssetsListModel extends AssetsList {
  const AssetsListModel({required super.allAssets});

  factory AssetsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Asset> assetsList = [];
    assetsList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => AssetModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.model.toLowerCase().compareTo(
              b.model.toLowerCase(),
            ),
      );
    return AssetsListModel(allAssets: assetsList);
  }
}
