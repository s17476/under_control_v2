import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/asset_category/asset_category.dart';
import '../../../domain/entities/asset_category/assets_categories_list.dart';
import 'asset_category_model.dart';

class AssetsCategoriesListModel extends AssetsCategoriesList {
  const AssetsCategoriesListModel({required super.allAssetsCategories});

  factory AssetsCategoriesListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<AssetCategory> assetsCategoriesList = [];
    assetsCategoriesList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => AssetCategoryModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    return AssetsCategoriesListModel(
      allAssetsCategories: assetsCategoriesList,
    );
  }
}
