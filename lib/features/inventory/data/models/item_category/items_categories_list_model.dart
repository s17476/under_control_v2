import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/item_category/item_category.dart';
import '../../../domain/entities/item_category/items_categories_list.dart';
import 'item_category_model.dart';

class ItemsCategoriesListModel extends ItemsCategoriesList {
  const ItemsCategoriesListModel({required super.allItemsCategories});

  factory ItemsCategoriesListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<ItemCategory> itemsCategoriesList = [];
    itemsCategoriesList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => ItemCategoryModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    return ItemsCategoriesListModel(allItemsCategories: itemsCategoriesList);
  }
}
