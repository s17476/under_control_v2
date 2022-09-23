part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const ItemsState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ItemsEmptyState extends ItemsState {}

class ItemsLoadingState extends ItemsState {}

class ItemsErrorState extends ItemsState {
  const ItemsErrorState({
    super.message,
    super.error = true,
  });
}

class ItemsLoadedState extends ItemsState {
  final ItemsListModel allItems;
  ItemsLoadedState({
    required this.allItems,
  }) : super(properties: [allItems]);

  Item? getItemById(String id) {
    final index = allItems.allItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      return allItems.allItems[index];
    }
    return null;
  }
}
