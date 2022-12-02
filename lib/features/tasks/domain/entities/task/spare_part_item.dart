import 'package:equatable/equatable.dart';

class SparePartItem extends Equatable {
  final String itemId;
  final String locationId;
  final double quantity;

  const SparePartItem({
    required this.itemId,
    required this.locationId,
    required this.quantity,
  });

  @override
  List<Object> get props => [itemId, locationId, quantity];

  @override
  String toString() =>
      'SparePartItem(itemId: $itemId, locationId: $locationId, quantity: $quantity)';
}
