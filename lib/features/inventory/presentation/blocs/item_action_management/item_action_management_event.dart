part of 'item_action_management_bloc.dart';

abstract class ItemActionManagementEvent extends Equatable {
  final ItemModel item;
  final ItemActionModel itemAction;
  final ItemActionModel? oldItemAction;
  const ItemActionManagementEvent({
    required this.item,
    required this.itemAction,
    this.oldItemAction,
  });

  @override
  List<Object> get props => [item, itemAction];
}

class AddItemActionEvent extends ItemActionManagementEvent {
  const AddItemActionEvent({required super.item, required super.itemAction});
}

class UpdateItemActionEvent extends ItemActionManagementEvent {
  const UpdateItemActionEvent({
    required super.item,
    required super.itemAction,
    required super.oldItemAction,
  });
}

class MoveItemActionEvent extends ItemActionManagementEvent {
  const MoveItemActionEvent({
    required super.item,
    required super.itemAction,
    required super.oldItemAction,
  });
}

class DeleteItemActionEvent extends ItemActionManagementEvent {
  const DeleteItemActionEvent({required super.item, required super.itemAction});
}
