import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/item.dart';
import '../../domain/entities/items_list.dart';
import 'item_model.dart';

class ItemsListModel extends ItemsList {
  const ItemsListModel({required super.allItems});

  factory ItemsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Item> itemslist = [];
    itemslist = snapshot.docs
        .map(
          (DocumentSnapshot doc) => ItemModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    return ItemsListModel(allItems: itemslist);
  }
}
