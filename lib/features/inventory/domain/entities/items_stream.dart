import 'package:equatable/equatable.dart';

class ItemsStream extends Equatable {
  final Stream allItems;

  const ItemsStream({
    required this.allItems,
  });

  @override
  List<Object> get props => [allItems];

  @override
  String toString() => 'ItemsStream(allItems: $allItems)';
}
