part of 'reserved_spare_parts_bloc.dart';

abstract class ReservedSparePartsState extends Equatable {
  final List<SparePartItemModel> spareParts;
  const ReservedSparePartsState({required this.spareParts});

  @override
  List<Object> get props => [spareParts];
}

class ReservedSparePartsEmptyState extends ReservedSparePartsState {
  const ReservedSparePartsEmptyState({super.spareParts = const []});
}

class ReservedSparePartsActiveState extends ReservedSparePartsState {
  const ReservedSparePartsActiveState({required super.spareParts});

  double getReservedQuantity(String itemId, String locationId) {
    double reservedQuantity = 0;
    final spareParts = this
        .spareParts
        .where((part) => part.itemId == itemId)
        .where((part) => part.locationId == locationId)
        .toList();
    for (var part in spareParts) {
      reservedQuantity += part.quantity;
    }
    return reservedQuantity;
  }
}
