import 'package:equatable/equatable.dart';

import 'item_category.dart';

class ItemsCategoriesList extends Equatable {
  final List<ItemCategory> allItemsCategories;

  const ItemsCategoriesList({
    required this.allItemsCategories,
  });

  @override
  List<Object> get props => [allItemsCategories];

  @override
  String toString() =>
      'ItemsCategoriesList(allItemsCategories: $allItemsCategories)';
}
