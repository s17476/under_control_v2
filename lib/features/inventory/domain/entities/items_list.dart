import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/inventory/domain/entities/item.dart';

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
