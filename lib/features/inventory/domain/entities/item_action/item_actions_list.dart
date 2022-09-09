import 'package:equatable/equatable.dart';

import 'item_action.dart';

class ItemActionsList extends Equatable {
  final List<ItemAction> allItemActions;

  const ItemActionsList({
    required this.allItemActions,
  });

  @override
  List<Object> get props => [allItemActions];

  @override
  String toString() => 'ItemActionsList(allItemActions: $allItemActions)';
}
