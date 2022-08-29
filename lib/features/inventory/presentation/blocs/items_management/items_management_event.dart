part of 'items_management_bloc.dart';

abstract class ItemsManagementEvent extends Equatable {
  final Item item;
  final File? itemPhoto;
  const ItemsManagementEvent({
    required this.item,
    this.itemPhoto,
  });

  @override
  List<Object> get props => [item];
}

class AddItemEvent extends ItemsManagementEvent {
  const AddItemEvent({
    required super.item,
    super.itemPhoto,
  });
}

class DeleteItemEvent extends ItemsManagementEvent {
  const DeleteItemEvent({required super.item});
}

class UpdateItemEvent extends ItemsManagementEvent {
  const UpdateItemEvent({
    required super.item,
    super.itemPhoto,
  });
}
