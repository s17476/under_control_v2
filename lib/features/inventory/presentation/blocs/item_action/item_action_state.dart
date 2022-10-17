part of 'item_action_bloc.dart';

abstract class ItemActionState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const ItemActionState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class ItemActionEmptyState extends ItemActionState {}

class ItemActionLoadingState extends ItemActionState {}

class ItemActionErrorState extends ItemActionState {
  const ItemActionErrorState({
    required super.message,
    super.error = true,
  });
}

class ItemActionLoadedState extends ItemActionState {
  final ItemActionsListModel allActions;
  final bool isAllItems;

  ItemActionLoadedState({
    required this.allActions,
    this.isAllItems = false,
  }) : super(properties: [allActions, isAllItems]);
}
