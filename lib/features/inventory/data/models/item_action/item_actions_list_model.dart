import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/item_action/item_action.dart';
import '../../../domain/entities/item_action/item_actions_list.dart';

import 'item_action_model.dart';

class ItemActionsListModel extends ItemActionsList {
  const ItemActionsListModel({required super.allItemActions});

  factory ItemActionsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<ItemAction> itemActionsList = [];
    itemActionsList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => ItemActionModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => b.date.compareTo(a.date),
      );
    return ItemActionsListModel(allItemActions: itemActionsList);
  }
}
