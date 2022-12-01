
import 'package:equatable/equatable.dart';

class SparePartItem extends Equatable {
  final String itemId;
  final double quantity;

  const SparePartItem({
    required this.itemId,
    required this.quantity,
  });

  @override
  List<Object> get props => [itemId, quantity];

  @override
  String toString() => 'SparePartItem(itemId: $itemId, quantity: $quantity)';
}
