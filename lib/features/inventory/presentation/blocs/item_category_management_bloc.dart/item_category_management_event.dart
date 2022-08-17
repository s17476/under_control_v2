part of 'item_category_management_bloc.dart';

abstract class ItemCategoryManagementEvent extends Equatable {
  final ItemCategory itemCategory;
  const ItemCategoryManagementEvent({
    required this.itemCategory,
  });

  @override
  List<Object> get props => [itemCategory];
}

class AddItemCategoryEvent extends ItemCategoryManagementEvent {
  const AddItemCategoryEvent({required super.itemCategory});
}

class UpdateItemCategoryEvent extends ItemCategoryManagementEvent {
  const UpdateItemCategoryEvent({required super.itemCategory});
}

class DeleteItemCategoryEvent extends ItemCategoryManagementEvent {
  const DeleteItemCategoryEvent({required super.itemCategory});
}
