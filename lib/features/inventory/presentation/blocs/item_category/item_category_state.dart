part of 'item_category_bloc.dart';

abstract class ItemCategoryState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const ItemCategoryState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ItemCategoryEmptyState extends ItemCategoryState {}

class ItemCategoryLoadingState extends ItemCategoryState {}

class ItemCategoryErrorState extends ItemCategoryState {
  const ItemCategoryErrorState({
    super.message,
    super.error = true,
  });
}

class ItemCategoryLoadedState extends ItemCategoryState {
  final ItemsCategoriesListModel allItemsCategories;
  ItemCategoryLoadedState({
    required this.allItemsCategories,
  }) : super(properties: [allItemsCategories]);
}
