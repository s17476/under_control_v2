import '../domain/entities/item.dart';

/// Calculates total quantity of given item in all locations.
///
/// Returns [double].
double getItemTotalQuantity(Item item) {
  double result = 0;

  for (var quantityInLocation in item.amountInLocations) {
    result += quantityInLocation.amount;
  }

  return result;
}
