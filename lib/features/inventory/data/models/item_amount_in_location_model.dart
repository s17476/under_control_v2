import '../../domain/entities/item_amount_in_location.dart';

class ItemAmountInLocationModel extends ItemAmountInLocation {
  const ItemAmountInLocationModel({
    required super.amount,
    required super.locationId,
  });

  ItemAmountInLocationModel copyWith({
    double? amount,
    String? locationId,
  }) {
    return ItemAmountInLocationModel(
      amount: amount ?? this.amount,
      locationId: locationId ?? this.locationId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'amount': amount});
    result.addAll({'locationId': locationId});

    return result;
  }

  factory ItemAmountInLocationModel.fromMap(Map<String, dynamic> map) {
    return ItemAmountInLocationModel(
      amount: map['amount']?.toDouble() ?? 0.0,
      locationId: map['locationId'] ?? '',
    );
  }
}
