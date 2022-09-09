part of 'item_action_management_bloc.dart';

abstract class ItemActionManagementState extends Equatable {
  final ItemActionMessage message;
  final bool error;
  final List properties;

  const ItemActionManagementState({
    this.message = ItemActionMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ItemActionManagementEmptyState extends ItemActionManagementState {}

class ItemActionManagementLoadingState extends ItemActionManagementState {}

class ItemActionManagementErrorState extends ItemActionManagementState {
  ItemActionManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class ItemActionManagementSuccessState extends ItemActionManagementState {
  ItemActionManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
