part of 'items_management_bloc.dart';

abstract class ItemsManagementState extends Equatable {
  final ItemsMessage message;
  final bool error;
  final List properties;

  const ItemsManagementState({
    this.message = ItemsMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ItemsManagementEmptyState extends ItemsManagementState {}

class ItemsManagementLoadingState extends ItemsManagementState {}

class ItemsManagementErrorState extends ItemsManagementState {
  ItemsManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class ItemsManagementSuccessState extends ItemsManagementState {
  ItemsManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
