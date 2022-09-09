import 'package:equatable/equatable.dart';

class ItemActionsStream extends Equatable {
  final Stream allItemActions;

  const ItemActionsStream({
    required this.allItemActions,
  });

  @override
  List<Object> get props => [allItemActions];

  @override
  String toString() => 'ItemActionsStream(allItemActions: $allItemActions)';
}
