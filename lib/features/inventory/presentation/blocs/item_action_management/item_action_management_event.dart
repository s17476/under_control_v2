part of 'item_action_management_bloc.dart';

abstract class ItemActionManagementEvent extends Equatable {
  final ItemModel item;
  final ItemActionModel itemAction;
  const ItemActionManagementEvent({
    required this.item,
    required this.itemAction,
  });

  @override
  List<Object> get props => [item, itemAction];
}

class AddItemActionEvent extends ItemActionManagementEvent {
  const AddItemActionEvent({required super.item, required super.itemAction});
}

class UpdateItemActionEvent extends ItemActionManagementEvent {
  const UpdateItemActionEvent({required super.item, required super.itemAction});
}

class DeleteItemActionEvent extends ItemActionManagementEvent {
  const DeleteItemActionEvent({required super.item, required super.itemAction});
}
