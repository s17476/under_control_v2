part of 'item_action_bloc.dart';

abstract class ItemActionEvent extends Equatable {
  final List properties;
  const ItemActionEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetItemActionsEvent extends ItemActionEvent {
  final Item item;
  final String companyId;

  GetItemActionsEvent({
    required this.item,
    required this.companyId,
  }) : super(properties: [item, companyId]);
}

class GetLastFiveItemActionsEvent extends ItemActionEvent {
  final Item item;
  final String companyId;

  GetLastFiveItemActionsEvent({
    required this.item,
    required this.companyId,
  }) : super(properties: [item, companyId]);
}

class UpdateItemActionsListEvent extends ItemActionEvent {
  final QuerySnapshot<Object?> snapshot;

  UpdateItemActionsListEvent({required this.snapshot})
      : super(properties: [snapshot]);
}
