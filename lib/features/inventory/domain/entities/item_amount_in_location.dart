import 'package:equatable/equatable.dart';

class ItemAmountInLocation extends Equatable {
  final double amount;
  final String locationId;

  const ItemAmountInLocation({
    required this.amount,
    required this.locationId,
  });

  @override
  List<Object> get props => [amount, locationId];

  @override
  String toString() =>
      'ItemAmountInLocation(amount: $amount, locationId: $locationId)';
}
