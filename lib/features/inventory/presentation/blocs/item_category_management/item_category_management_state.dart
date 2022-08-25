part of 'item_category_management_bloc.dart';

abstract class ItemCategoryManagementState extends Equatable {
  final ItemCategoryMessage message;
  final bool error;
  final List properties;

  const ItemCategoryManagementState({
    this.message = ItemCategoryMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ItemCategoryManagementEmptyState extends ItemCategoryManagementState {}

class ItemCategoryManagementLoadingState extends ItemCategoryManagementState {}

class ItemCategoryManagementErrorState extends ItemCategoryManagementState {
  ItemCategoryManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class ItemCategoryManagementSuccessState extends ItemCategoryManagementState {
  ItemCategoryManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
