import 'package:equatable/equatable.dart';

import 'item.dart';

class ItemsList extends Equatable {
  final List<Item> allItems;

  const ItemsList({
    required this.allItems,
  });

  @override
  List<Object> get props => [allItems];

  @override
  String toString() => 'ItemsList(allItems: $allItems)';
}
