import 'package:equatable/equatable.dart';

class ItemsCategoriesStream extends Equatable {
  final Stream allItemsCategories;

  const ItemsCategoriesStream({
    required this.allItemsCategories,
  });

  @override
  List<Object> get props => [allItemsCategories];

  @override
  String toString() =>
      'ItemsCategoriesStream(allItemsCategories: $allItemsCategories)';
}
